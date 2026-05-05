-- Schema for Domain: metering | Business: Power and Utilities | Version: v1_mvm
-- Generated on: 2026-04-29 23:12:57

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `power_and_utilities`.`metering` COMMENT 'Owns all AMI/AMR meter asset records, smart meter deployment data, interval read collection, and meter data validation/estimation/editing (VEE) workflows. Serves as the SSOT for meter inventory, meter-to-premise associations, interval energy consumption data (kWh, MCF), and demand readings (kW/MW). Integrates with MDMS (Oracle Utilities MDMS / Itron Analytics) and feeds billing and demand response domains.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `power_and_utilities`.`metering`.`meter` (
    `meter_id` BIGINT COMMENT 'Unique system identifier for the meter asset. Primary key for the meter product. Serves as the authoritative reference for all meter-related transactions and associations across metering, billing, and distribution domains.',
    `rate_schedule_id` BIGINT COMMENT 'Foreign key linking to billing.rate_schedule. Business justification: Meters are configured for specific rate schedules to determine billing calculations. Rate schedule drives multiplier application, demand interval settings, and TOU configuration. Critical for accurate',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Meters incur ongoing O&M costs (maintenance, testing, reading) that must be allocated to cost centers for FERC Form 1 regulatory reporting, budget variance analysis, and rate case cost studies. Standa',
    `master_id` BIGINT COMMENT 'Foreign key linking to asset.asset_master. Business justification: Meters are physical assets with lifecycle management requirements (installation, testing, maintenance, replacement). This FK enables tracking meters through the enterprise asset management system. The',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Meters are inventory items with material numbers in ERP systems. Critical for procurement planning, standardization, inventory valuation, and MRP. Utilities manage meters as materials with reorder poi',
    `participant_registration_id` BIGINT COMMENT 'Foreign key linking to market.participant_registration. Business justification: Utility-owned generation meters and DR program meters must link to RTO/ISO participant registrations for market settlement, compliance reporting, and authorized market participation validation.',
    `pricing_node_id` BIGINT COMMENT 'Foreign key linking to market.pricing_node. Business justification: Generation meters and large C&I meters are associated with specific pricing nodes for LMP-based settlement, nodal pricing billing, and congestion cost allocation in wholesale markets.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Meters are procured through the supply chain system. This FK enables tracking of meter procurement, warranty management, and vendor performance. The meter table currently has purchase_order_number as ',
    `tariff_schedule_id` BIGINT COMMENT 'Foreign key linking to regulatory.tariff_schedule. Business justification: Meters are configured to collect data according to approved tariff rate structures (TOU periods, demand tiers, multipliers). FK enables validation that meter configuration aligns with tariff requireme',
    `accuracy_class` STRING COMMENT 'Meter accuracy rating as defined by ANSI standards. Common classes include 0.2, 0.5, 1.0, and 2.0, representing the maximum percentage error under specified conditions. Higher accuracy classes (lower numbers) are required for revenue metering and large commercial customers.',
    `communication_module_type` STRING COMMENT 'Technology used by the meter to transmit data to the utilitys MDMS. RF Mesh uses radio frequency mesh networks. PLC (Power Line Carrier) transmits data over electric distribution lines. Cellular uses mobile networks. Zigbee and Wi-Fi are used for home area networks. None indicates manual-read meters.. Valid values are `RF Mesh|PLC|Cellular|Zigbee|Wi-Fi|None`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this meter record was first created in the MDMS or enterprise asset management system. Used for data lineage, audit trails, and record lifecycle tracking. Distinct from manufacture date or installation date.',
    `current_rating` DECIMAL(18,2) COMMENT 'Maximum continuous current in amperes that the meter can accurately measure without damage. Typical ratings include 100A, 200A, 320A for residential and small commercial, and higher ratings for large commercial and industrial customers. Used to ensure meter capacity matches service load.',
    `demand_capable` BOOLEAN COMMENT 'Indicates whether the meter can measure and record peak demand (kW or MW) in addition to energy consumption (kWh or MWh). Demand-capable meters are required for commercial and industrial customers subject to demand charges. Essential for rate application and billing.',
    `encryption_enabled` BOOLEAN COMMENT 'Indicates whether the meter encrypts data transmissions to the MDMS. Encryption protects customer usage data and prevents unauthorized access or tampering. Required for compliance with NIST cybersecurity guidelines for smart grid devices.',
    `expected_useful_life_years` STRING COMMENT 'Estimated operational lifespan of the meter in years, based on manufacturer specifications and utility experience. Typical values are 15-20 years for AMI meters, 30-40 years for electromechanical meters. Used for depreciation calculations and replacement planning.',
    `firmware_version` STRING COMMENT 'Version identifier of the embedded software running on the meter. Critical for security patch management, feature enablement, and compatibility with MDMS systems. Firmware updates may be deployed over-the-air for AMI meters.',
    `form_factor` STRING COMMENT 'Physical configuration and wiring arrangement of the meter. For electric meters, examples include Form 2S (single-phase), Form 4S (three-wire network), Form 9S (three-phase delta), Form 12S (three-phase wye), Form 16S (three-phase four-wire delta). Determines installation requirements and service compatibility.',
    `fuel_type` STRING COMMENT 'Type of energy commodity measured by this meter. Electric meters measure kilowatt-hours (kWh) and demand (kW). Gas meters measure volume in thousand cubic feet (MCF) or therms. Determines applicable rate schedules and billing calculations.. Valid values are `Electric|Gas`',
    `installation_date` DATE COMMENT 'Date when the meter was physically installed at the current service point. Used to calculate meter age, warranty expiration, and calibration due dates. Critical for asset lifecycle management and depreciation calculations.',
    `installation_status` STRING COMMENT 'Current physical deployment state of the meter. Installed indicates the meter is actively deployed at a service point. Removed indicates the meter has been taken out of service. In-Stock indicates the meter is in warehouse inventory. In-Transit indicates the meter is being shipped. Retired indicates the meter is permanently out of service. Failed indicates the meter has malfunctioned.. Valid values are `Installed|Removed|In-Stock|In-Transit|Retired|Failed`',
    `interval_length_minutes` STRING COMMENT 'Duration in minutes of each interval data recording period. Common values are 15, 30, or 60 minutes. AMI meters typically record 15-minute intervals. Used to determine data granularity for load profiling, demand response, and time-of-use billing.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this meter record was most recently updated. Used to track data currency, support change data capture (CDC) processes, and identify records requiring synchronization across systems.',
    `last_test_date` DATE COMMENT 'Date of the most recent accuracy test or calibration performed on the meter. Regulatory requirements typically mandate periodic testing (e.g., every 10-15 years for electric meters). Used to schedule future testing and ensure measurement accuracy for billing.',
    `lifecycle_state` STRING COMMENT 'Operational lifecycle stage of the meter asset. Active indicates the meter is in service and collecting data. Inactive indicates the meter is not currently in use but may be redeployed. Testing indicates the meter is undergoing validation or calibration. Decommissioned indicates the meter has been permanently removed from inventory.. Valid values are `Active|Inactive|Testing|Decommissioned`',
    `manufacture_date` DATE COMMENT 'Date when the meter was manufactured by the vendor. Used to determine warranty coverage, expected lifespan, and compliance with regulatory standards in effect at time of manufacture. May differ significantly from installation date for meters held in inventory.',
    `manufacturer` STRING COMMENT 'Name of the company that manufactured the meter device. Examples include Itron, Landis+Gyr, Sensus, Elster, Aclara. Used for vendor management, warranty claims, and firmware compatibility tracking.',
    `meter_type` STRING COMMENT 'Classification of the meter based on its technology and data collection capability. AMI (Advanced Metering Infrastructure) supports two-way communication and remote disconnect. AMR (Automated Meter Reading) supports one-way read-only communication. Electromechanical meters require manual reads. Determines data collection frequency and operational capabilities.. Valid values are `AMI|AMR|Electromechanical|Electronic|Smart|Interval`',
    `model_number` STRING COMMENT 'Manufacturer-specific model designation identifying the meters design, capabilities, and specifications. Used to determine compatible firmware versions, communication protocols, and operational parameters.',
    `multiplier` DECIMAL(18,2) COMMENT 'Scaling factor applied to meter register readings to calculate actual consumption. Used when current transformers (CTs) or potential transformers (PTs) are installed. For example, a multiplier of 40 means each register unit represents 40 kWh. Essential for accurate billing of high-load customers.',
    `net_metering_capable` BOOLEAN COMMENT 'Indicates whether the meter can measure and record bi-directional energy flow (both consumption and generation). Required for customers with distributed energy resources (DER) such as rooftop solar. Supports net energy metering (NEM) programs and renewable energy credit (REC) tracking.',
    `next_test_due_date` DATE COMMENT 'Scheduled date for the next required accuracy test or calibration. Calculated based on last test date and regulatory testing intervals. Used to generate preventive maintenance work orders and ensure compliance with PUC testing requirements.',
    `notes` STRING COMMENT 'Free-text field for recording additional information about the meter, such as special installation requirements, known issues, field service observations, or historical context. Used by field technicians and asset managers for operational reference.',
    `number_of_dials` STRING COMMENT 'Count of register dials on electromechanical meters, typically 4 or 5 dials. Determines the maximum reading capacity before rollover. Not applicable to electronic or AMI meters which use digital displays. Used for manual meter reading validation.',
    `outage_detection_capable` BOOLEAN COMMENT 'Indicates whether the meter can detect and report power outages and restoration events. AMI meters with this capability send last-gasp messages during outages and first-breath messages upon restoration. Feeds the Outage Management System (OMS) for improved outage response.',
    `ownership_type` STRING COMMENT 'Indicates whether the meter is owned by the utility or the customer. Utility-owned meters are maintained and replaced by the utility. Customer-owned meters (common for large industrial customers) are maintained by the customer but must meet utility standards. Affects maintenance responsibility and capital asset accounting.. Valid values are `Utility-Owned|Customer-Owned`',
    `register_count` STRING COMMENT 'Number of independent measurement registers in the meter. Single-register meters measure total consumption. Multi-register meters can track time-of-use (TOU) periods, demand intervals, or separate rate schedules. Used to support complex rate structures and demand response programs.',
    `remote_disconnect_capable` BOOLEAN COMMENT 'Indicates whether the meter includes a service switch that can be remotely controlled to connect or disconnect service. Enables remote service activation for move-ins, disconnection for non-payment, and reconnection after payment. Common feature of modern AMI meters.',
    `removal_date` DATE COMMENT 'Date when the meter was physically removed from service. Used to close out meter-to-premise associations, finalize billing periods, and track meter inventory movements. Null for meters currently in service.',
    `serial_number` STRING COMMENT 'Manufacturer-assigned unique serial number physically stamped or labeled on the meter device. Used for field identification, warranty tracking, and asset reconciliation. Must be unique across the entire meter inventory.. Valid values are `^[A-Z0-9]{8,20}$`',
    `tamper_detection_capable` BOOLEAN COMMENT 'Indicates whether the meter can detect and report physical tampering, meter cover removal, magnetic interference, or reverse energy flow. Tamper events trigger alerts in MDMS for investigation. Critical for revenue protection and theft detection.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Purchase price paid for this meter unit in US dollars. Used for capital asset valuation, depreciation calculations, and cost-benefit analysis of meter deployment programs. Confidential business information.',
    `voltage_class` STRING COMMENT 'Rated voltage level for which the meter is designed. Common classes include 120V, 240V, 480V for distribution, and higher voltages for transmission-level metering. Must match the service point voltage to ensure accurate measurement and safety.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturers warranty coverage ends. Used to determine whether repair or replacement costs are covered by the vendor. Calculated from manufacture date or installation date based on warranty terms. Critical for asset management and budgeting.',
    CONSTRAINT pk_meter PRIMARY KEY(`meter_id`)
) COMMENT 'Master record for every physical meter asset deployed across the AMI/AMR network — electric and gas. Captures meter serial number, manufacturer, model, meter type (AMI/AMR/electromechanical), fuel type (electric/gas), form factor, voltage class, current rating, multiplier, number of dials, communication module type (RF/PLC/cellular), firmware version, ownership (utility-owned vs customer-owned), installation status, and lifecycle state. Serves as the SSOT for meter inventory within the metering domain, sourced from Oracle Utilities MDMS / Itron Analytics and cross-referenced with the enterprise asset register in the asset domain.';

CREATE OR REPLACE TABLE `power_and_utilities`.`metering`.`meter_premise` (
    `meter_premise_id` BIGINT COMMENT 'Unique identifier for the meter-to-premise association record. Primary key for this entity.',
    `account_id` BIGINT COMMENT 'The billing account responsible for charges associated with consumption at this meter-premise association. Links to the customer billing domain.',
    `meter_id` BIGINT COMMENT 'Unique identifier of the meter device installed at the premise. Links to the meter asset inventory in the metering domain.',
    `work_order_id` BIGINT COMMENT 'Reference to the field work order that authorized and documented the meter installation at this premise. Links to the work management system.',
    `read_cycle_id` BIGINT COMMENT 'Foreign key linking to metering.read_cycle. Business justification: Meter-to-premise associations are assigned to read cycles for scheduling purposes. The meter_premise table currently has read_cycle_code (STRING) which is a denormalized reference to read_cycle.cycle_',
    `service_point_id` BIGINT COMMENT 'Unique identifier of the service point (premise/delivery point) where the meter is installed. Represents the physical location where energy is delivered to the customer.',
    `ami_enabled_flag` BOOLEAN COMMENT 'Indicates whether this meter is an AMI smart meter capable of remote reading and two-way communication. True for AMI meters; false for legacy Automated Meter Reading (AMR) or manual-read meters.',
    `association_status` STRING COMMENT 'Current lifecycle status of the meter-premise association. Active indicates the meter is currently serving the premise; inactive indicates historical association; pending indicates scheduled future installation; removed indicates meter has been physically removed; suspended indicates temporary service interruption.. Valid values are `active|inactive|pending|removed|suspended`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this meter-premise association record was first created in the system. Used for audit and data lineage tracking.',
    `demand_metering_flag` BOOLEAN COMMENT 'Indicates whether this meter measures peak demand (kW or MW) in addition to energy consumption (kWh or MWh). True for commercial/industrial customers with demand charges; false for energy-only metering.',
    `effective_end_timestamp` TIMESTAMP COMMENT 'The precise timestamp when this meter-premise association ceased to be effective for billing and data collection. Null if currently active.',
    `effective_start_timestamp` TIMESTAMP COMMENT 'The precise timestamp when this meter-premise association became effective for billing and data collection purposes. May differ from physical installation_date if backdated.',
    `final_register_read` DECIMAL(18,2) COMMENT 'The meter register reading recorded at the time of removal from this premise. Used to calculate final consumption and close out the billing period. Null if meter is still active.',
    `initial_register_read` DECIMAL(18,2) COMMENT 'The meter register reading (cumulative energy consumption) recorded at the time of installation at this premise. Used to establish the starting point for consumption calculation.',
    `installation_date` DATE COMMENT 'The date when the meter was physically installed at the service point. Marks the beginning of the meter-premise association.',
    `installation_reason_code` STRING COMMENT 'The business reason for installing the meter at this premise. New service for first-time installations; meter upgrade for technology refresh; meter failure for replacement of defective units; AMI deployment for smart meter rollout; customer request for customer-initiated changes; move-in for tenant changes.. Valid values are `new_service|meter_upgrade|meter_failure|ami_deployment|customer_request|move_in`',
    `installation_technician_code` BIGINT COMMENT 'Identifier of the field technician who performed the meter installation. Used for quality tracking and accountability.',
    `interval_data_collection_flag` BOOLEAN COMMENT 'Indicates whether this meter collects interval consumption data (typically 15-minute or hourly intervals) rather than cumulative register reads only. True for AMI meters and large commercial customers; false for basic meters.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this meter-premise association record was most recently modified. Used for audit and change tracking.',
    `meter_accessibility` STRING COMMENT 'Indicates the accessibility of the meter for reading and maintenance. Accessible for unrestricted access; restricted for limited access requiring appointment; locked for secured locations requiring key; inside for interior locations requiring customer presence; outside for exterior locations.. Valid values are `accessible|restricted|locked|inside|outside`',
    `meter_location_description` STRING COMMENT 'Free-text description of the physical location of the meter at the premise (e.g., basement northwest corner, exterior wall rear, utility room). Used by field technicians to locate the meter.',
    `meter_position` STRING COMMENT 'The functional role of the meter at the service point. Main meters are primary billing meters; sub-meters measure individual circuits or tenants; check meters validate main meter accuracy; totalizing meters aggregate multiple feeds; backup meters provide redundancy.. Valid values are `main|sub|check|totalizing|backup`',
    `net_metering_flag` BOOLEAN COMMENT 'Indicates whether this meter-premise association is enrolled in a Net Energy Metering program for customer-owned Distributed Energy Resources (DER) such as rooftop solar. True for NEM participants; false otherwise.',
    `rate_schedule_code` STRING COMMENT 'The tariff rate schedule applied to consumption measured by this meter. Determines pricing for energy usage (e.g., residential, commercial, industrial, Time-of-Use).',
    `read_sequence_number` STRING COMMENT 'The order in which this meter is read within its read cycle route. Used to optimize field technician routing and scheduling.',
    `register_multiplier` DECIMAL(18,2) COMMENT 'The multiplier applied to meter register readings to calculate actual consumption. Used for Current Transformer (CT) and Potential Transformer (PT) ratios in high-voltage installations. Default is 1.0 for direct-connected meters.',
    `register_unit_of_measure` STRING COMMENT 'The unit of measure for the meter register readings. kWh and MWh for electric energy; MCF and Therm for gas volume/energy; kW and MW for demand.. Valid values are `kWh|MWh|MCF|Therm|kW|MW`',
    `remote_disconnect_capable_flag` BOOLEAN COMMENT 'Indicates whether this meter has remote service disconnect/reconnect capability. True for meters with integrated service switch; false otherwise. Used for non-payment disconnection and reconnection without field visits.',
    `removal_date` DATE COMMENT 'The date when the meter was physically removed from the service point. Marks the end of the meter-premise association. Null if the meter is currently active at the premise.',
    `removal_reason_code` STRING COMMENT 'The business reason for removing the meter from this premise. Service termination for account closure; meter upgrade for technology refresh; meter failure for defective unit replacement; AMI deployment for smart meter rollout; customer request for customer-initiated changes; move-out for tenant changes. Null if meter is still active.. Valid values are `service_termination|meter_upgrade|meter_failure|ami_deployment|customer_request|move_out`',
    `removal_technician_code` BIGINT COMMENT 'Identifier of the field technician who performed the meter removal. Null if meter is still active.',
    `seal_number` STRING COMMENT 'The unique identifier of the tamper-evident seal applied to the meter at installation. Used for security and tamper detection. Multiple seals may be recorded as comma-separated values.',
    `service_phase` STRING COMMENT 'The electrical phase configuration of the service. Single-phase for residential and small commercial; three-phase for large commercial and industrial. Not applicable for gas meters.. Valid values are `single|three`',
    `service_voltage` STRING COMMENT 'The voltage level at which electric service is delivered to this premise. 120V and 240V for residential; 277V and 480V for commercial; primary for high-voltage direct feed; secondary for transformer-stepped service. Not applicable for gas meters.. Valid values are `120V|240V|277V|480V|primary|secondary`',
    `source_system` STRING COMMENT 'The name of the operational system that is the authoritative source for this meter-premise association record (e.g., Oracle Utilities MDMS, Oracle CC&B, SAP IS-U). Used for data lineage and reconciliation.',
    `source_system_record_reference` STRING COMMENT 'The unique identifier of this meter-premise association record in the source operational system. Used for traceability and reconciliation back to the system of record.',
    `time_of_use_flag` BOOLEAN COMMENT 'Indicates whether this meter-premise association is on a Time-of-Use rate schedule requiring interval data collection for peak/off-peak pricing. True for TOU customers; false for flat-rate customers.',
    CONSTRAINT pk_meter_premise PRIMARY KEY(`meter_premise_id`)
) COMMENT 'Authoritative association record linking a meter to a service premise (service point / delivery point) for a defined effective date range. Tracks meter-to-premise installation date, removal date, meter position (main/sub/check), seal number, initial and final register reads at install/removal, and the technician work order reference. Supports move-in/move-out workflows and ensures billing domain can resolve which meter served a premise during any billing period. Sourced from Oracle Utilities MDMS and Oracle CC&B / SAP IS-U service point records.';

CREATE OR REPLACE TABLE `power_and_utilities`.`metering`.`ami_endpoint` (
    `ami_endpoint_id` BIGINT COMMENT 'Unique system identifier for the AMI communication endpoint record. Primary key for the AMI endpoint entity. This is the surrogate key assigned by the MDMS or head-end system to track each network-layer endpoint registration.',
    `meter_id` BIGINT COMMENT 'Foreign key reference to the physical meter asset record in the metering domain. Links this AMI endpoint to the physical meter device it represents. One meter may have one endpoint; this relationship enables correlation of network-layer data with physical meter inventory.',
    `service_point_id` BIGINT COMMENT 'Foreign key reference to the service point (premise delivery location) that this endpoint serves. Links the AMI endpoint to the physical location where energy is delivered and consumed. Used for outage correlation, geographic analysis, and customer billing integration.',
    `authentication_method` STRING COMMENT 'Method used to authenticate the endpoint during communication sessions with the head-end system. CERTIFICATE = X.509 digital certificate; SHARED_KEY = pre-shared symmetric key; TOKEN = dynamic token-based authentication; NONE = no authentication (legacy systems only).. Valid values are `CERTIFICATE|SHARED_KEY|TOKEN|NONE`',
    `battery_level_percent` DECIMAL(18,2) COMMENT 'Current battery charge level as a percentage (0-100) for battery-powered communication modules (common in gas AMR/AMI and some electric endpoints). Null for line-powered endpoints. Used to schedule battery replacement field work before communication failure.',
    `collector_node_code` STRING COMMENT 'Identifier of the parent collector, concentrator, or access point node in the AMI network hierarchy to which this endpoint is currently associated. Used in mesh and hierarchical network topologies to manage network routing, load balancing, and troubleshooting. Null for direct cellular or POTS endpoints.',
    `commissioning_timestamp` TIMESTAMP COMMENT 'Timestamp when the endpoint was successfully registered and commissioned in the AMI head-end system. Marks the moment the endpoint became operational and began transmitting meter data. Distinct from installation_date which is the physical installation event.',
    `communication_module_serial` STRING COMMENT 'Manufacturer-assigned serial number of the physical AMI communication module (NIC card, radio module, or cellular modem) installed in or attached to the smart meter. Used for warranty tracking, firmware management, and field service operations.',
    `communication_status` STRING COMMENT 'Current operational status of the AMI endpoint communication link. ACTIVE = regular successful communication; INACTIVE = no recent communication but endpoint is registered; INTERMITTENT = sporadic communication failures; FAILED = persistent communication failure requiring field service; COMMISSIONED = newly installed and registered; DECOMMISSIONED = removed from service.. Valid values are `ACTIVE|INACTIVE|INTERMITTENT|FAILED|COMMISSIONED|DECOMMISSIONED`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this AMI endpoint record was first created in the MDMS or data warehouse. Used for data lineage tracking and audit trail. Distinct from installation_date and commissioning_timestamp which represent physical and operational events.',
    `data_retention_days` STRING COMMENT 'Number of days of interval meter data stored locally on the endpoint before being overwritten. Used for data recovery after communication outages and for backfill operations. Typical range: 35-90 days depending on memory capacity and interval frequency.',
    `decommissioning_timestamp` TIMESTAMP COMMENT 'Timestamp when the endpoint was decommissioned and removed from active service in the AMI head-end system. Null for active endpoints. Used for lifecycle tracking, asset retirement reporting, and historical analysis of network evolution.',
    `encryption_enabled_flag` BOOLEAN COMMENT 'Boolean flag indicating whether end-to-end encryption is enabled for communication between this endpoint and the head-end system. True = encrypted communication (AES-128 or higher); False = plaintext or legacy unencrypted communication. Critical for cybersecurity compliance and NERC CIP audit.',
    `endpoint_eui` STRING COMMENT '64-bit Extended Unique Identifier (EUI-64) assigned to the AMI communication module. This is the globally unique MAC-layer address used for network registration and device authentication in the AMI head-end system. Serves as the primary network identity for the endpoint.. Valid values are `^[0-9A-F]{16}$`',
    `firmware_version` STRING COMMENT 'Current firmware version installed on the AMI communication module. Used for firmware upgrade planning, security patch management, and troubleshooting communication issues. Format varies by vendor (e.g., 3.2.1, v4.5.0-build2023).',
    `head_end_system_code` STRING COMMENT 'Identifier of the AMI head-end system (MDMS instance or vendor platform) that manages this endpoint. Used in multi-vendor or multi-region deployments where different head-end systems manage different endpoint populations. Examples: Itron Analytics instance ID, Oracle Utilities MDMS cluster name.',
    `installation_date` DATE COMMENT 'Date the AMI communication module was physically installed and commissioned in the field. Used for warranty tracking, lifecycle management, and calculating mean time between failures (MTBF) for network reliability analysis.',
    `ip_address` STRING COMMENT 'IP address (IPv4 or IPv6) assigned to the AMI endpoint for IP-based communication networks (cellular, fixed network, or IP-over-PLC). Used for direct addressing, remote diagnostics, and firmware updates. Null for non-IP networks (legacy RF mesh, POTS).. Valid values are `^(?:[0-9]{1,3}.){3}[0-9]{1,3}$|^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$`',
    `last_firmware_update_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent firmware update applied to the communication module. Used to track firmware deployment progress, identify endpoints requiring security patches, and troubleshoot post-upgrade issues.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this AMI endpoint record was most recently updated in the MDMS or data warehouse. Used for change tracking, data synchronization, and incremental ETL processing.',
    `last_successful_communication_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful bidirectional communication session between the endpoint and the head-end system. Used to detect stale endpoints, identify communication outages, and trigger field service work orders for non-communicating meters.',
    `last_tamper_event_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent tamper event detected by the endpoint. Null if no tamper has ever been detected. Used for revenue protection investigations, pattern analysis of theft activity, and field service prioritization.',
    `manufacturer_name` STRING COMMENT 'Name of the manufacturer of the AMI communication module hardware. Examples: Itron, Landis+Gyr, Sensus, Aclara, Trilliant. Used for vendor performance analysis, warranty claims, and procurement planning.',
    `model_number` STRING COMMENT 'Manufacturer model number or part number of the AMI communication module. Used for firmware compatibility checks, spare parts inventory management, and technical support escalation.',
    `network_hop_count` STRING COMMENT 'Number of network hops (intermediate nodes) between this endpoint and the head-end system or primary collector in mesh network topologies. Lower hop counts indicate better network position and more reliable communication. Null for direct cellular or POTS endpoints.',
    `network_type` STRING COMMENT 'Type of communication network technology used by this endpoint to transmit meter data to the utility head-end. RF_MESH = radio frequency mesh network; PLC = power line carrier; CELLULAR = cellular (LTE/5G); POTS = plain old telephone service; FIXED_NETWORK = fiber or Ethernet; HYBRID = combination of technologies.. Valid values are `RF_MESH|PLC|CELLULAR|POTS|FIXED_NETWORK|HYBRID`',
    `outage_detection_enabled_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this endpoint is configured to send last-gasp and first-breath messages for power outage detection. True = outage detection enabled and integrated with OMS; False = disabled or not supported by hardware. Critical for outage management system integration.',
    `port_number` STRING COMMENT 'TCP or UDP port number used for communication sessions with the endpoint. Typically standardized per vendor or protocol (e.g., port 4059 for ANSI C12.22, port 8883 for MQTT over TLS). Used for firewall configuration and network security management.',
    `read_interval_minutes` STRING COMMENT 'Configured interval in minutes at which the endpoint transmits meter read data to the head-end system. Common values: 15, 30, 60 minutes for interval data; 1440 minutes (daily) for daily reads. Used for data volume planning and network bandwidth management.',
    `remote_disconnect_capable_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this endpoint supports remote service disconnect/reconnect commands. True = endpoint has integrated disconnect switch controllable via AMI network; False = manual field service required for disconnect. Used for credit management and demand response programs.',
    `signal_strength_baseline_dbm` DECIMAL(18,2) COMMENT 'Baseline signal strength measurement in decibels relative to one milliwatt (dBm) recorded during endpoint commissioning or last successful communication. Used to monitor network health, identify degraded links, and prioritize field maintenance. Typical range: -110 to -30 dBm for RF networks.',
    `tamper_detection_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the endpoint has detected physical or electronic tampering. True = tamper event detected (cover removal, magnetic interference, communication jamming); False = no tamper detected. Triggers field investigation and potential revenue protection action.',
    `time_sync_source` STRING COMMENT 'Source used by the endpoint to synchronize its internal clock for accurate timestamping of meter reads and events. GPS = GPS receiver; NTP = Network Time Protocol; NETWORK = head-end system time sync; INTERNAL = internal oscillator (least accurate); MANUAL = manually set. Critical for interval data accuracy and event correlation.. Valid values are `GPS|NTP|NETWORK|INTERNAL|MANUAL`',
    CONSTRAINT pk_ami_endpoint PRIMARY KEY(`ami_endpoint_id`)
) COMMENT 'Master record for each AMI communication endpoint (smart meter head-end registration) within the Advanced Metering Infrastructure network. Captures endpoint EUI/MAC address, communication module serial, head-end system identifier, network type (RF mesh / PLC / cellular), firmware version, signal strength baseline, last successful communication timestamp, communication status, and assigned collector/concentrator node. Distinct from the physical meter record — one meter may have one endpoint; this entity tracks the network-layer identity managed by the AMI head-end system (Itron Analytics / Oracle Utilities MDMS).';

CREATE OR REPLACE TABLE `power_and_utilities`.`metering`.`interval_read` (
    `interval_read_id` BIGINT COMMENT 'Unique identifier for each interval read record. Primary key for the interval read table.',
    `meter_channel_id` BIGINT COMMENT 'Foreign key linking to metering.meter_channel. Business justification: Interval reads are captured per meter channel. The interval_read table currently has channel_number (INT) which is a denormalized reference. Since meter_channel has a surrogate PK (meter_channel_id), ',
    `meter_id` BIGINT COMMENT 'Identifier of the AMI or AMR meter that generated this interval read. Links to the meter asset record in the metering domain.',
    `ppa_contract_id` BIGINT COMMENT 'Foreign key linking to market.ppa_contract. Business justification: Hourly interval data from PPA generation meters must tie to contracts for energy settlement, pricing validation, and contract performance reporting required by wholesale power purchase agreements.',
    `pricing_node_id` BIGINT COMMENT 'Foreign key linking to market.pricing_node. Business justification: Hourly interval reads at nodal locations required for LMP settlement, congestion revenue allocation, and transmission cost recovery in RTO/ISO markets.',
    `read_cycle_id` BIGINT COMMENT 'Foreign key linking to metering.read_cycle. Business justification: Interval reads are collected and organized within scheduled read cycles for billing alignment. This FK enables grouping interval reads by cycle for billing and VEE processing. The read_cycle defines t',
    `service_point_id` BIGINT COMMENT 'Identifier of the service point (premise delivery location) where this meter is installed. Links to the distribution service point entity. Used to associate interval data with customer accounts and geographic network locations.',
    `tariff_schedule_id` BIGINT COMMENT 'Foreign key linking to regulatory.tariff_schedule. Business justification: Interval reads are classified by tariff rate periods (peak/off-peak/super-off-peak) for billing. Replaces denormalized rate_schedule_code with proper FK to enable rate application validation and suppo',
    `tou_schedule_id` BIGINT COMMENT 'Foreign key linking to metering.tou_schedule. Business justification: Each interval read is classified into a TOU tier (peak/off-peak/shoulder) based on a TOU schedule. Currently interval_read has tou_tier (string) which is a denormalized classification result. The tou_',
    `baseline_consumption_value` DECIMAL(18,2) COMMENT 'Calculated baseline consumption for this interval, representing expected usage without demand response participation. Used to measure load reduction during DR events and calculate customer incentive payments. Null for non-DR participants.',
    `billing_determinant_flag` BOOLEAN COMMENT 'Boolean indicator that this interval read is used as a billing determinant for the current billing cycle. True when the interval contributes to demand charges, TOU energy charges, or other rate components. Used to identify billable intervals for revenue assurance.',
    `collection_timestamp` TIMESTAMP COMMENT 'Timestamp when the interval read was collected from the meter or head-end system and ingested into MDMS. Distinct from the interval timestamps, which represent the measurement period. Used for data latency analysis and SLA monitoring.',
    `consumption_uom` STRING COMMENT 'Unit of measure for the consumption value. Standard units include kWh (kilowatt-hour) for electric, MCF (thousand cubic feet) or Therm for gas, CCF (hundred cubic feet) for gas distribution.. Valid values are `kWh|MWh|MCF|Therm|CCF`',
    `consumption_value` DECIMAL(18,2) COMMENT 'Raw energy consumption value for the interval. For electric meters, measured in kWh (kilowatt-hours). For gas meters, measured in MCF (thousand cubic feet) or therms. This is the primary measured quantity before VEE processing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this interval read record was first created in the MDMS database. Used for data lineage tracking and audit purposes. Distinct from collection_timestamp, which represents when the data was received from the meter.',
    `data_source` STRING COMMENT 'Origin system or method that produced this interval read. Values include AMI (Advanced Metering Infrastructure head-end), AMR (Automated Meter Reading drive-by), manual (field-entered), estimated (VEE-generated), SCADA (real-time grid system), historian (OSIsoft PI or similar).. Valid values are `AMI|AMR|manual|estimated|SCADA|historian`',
    `demand_uom` STRING COMMENT 'Unit of measure for the demand value. Standard units include kW (kilowatt), MW (megawatt), kVA (kilovolt-ampere), MVA (megavolt-ampere) for apparent power.. Valid values are `kW|MW|kVA|MVA`',
    `demand_value` DECIMAL(18,2) COMMENT 'Peak demand value recorded during the interval period. For electric meters, measured in kW (kilowatts) or MW (megawatts). Represents the maximum instantaneous power draw within the interval. Null for gas meters or meters not configured for demand measurement.',
    `dr_event_flag` BOOLEAN COMMENT 'Boolean indicator that a demand response event was active during this interval period. True when the customer was participating in a DR program curtailment event. Used for DR baseline calculation, settlement, and program evaluation.',
    `dst_flag` BOOLEAN COMMENT 'Boolean indicator that this interval occurred during daylight saving time. Used to handle spring-forward (23-hour day) and fall-back (25-hour day) transitions in interval data processing and billing calculations.',
    `estimation_method` STRING COMMENT 'Algorithm or method used to estimate the interval value when actual meter data is missing or invalid. Methods include linear interpolation, load profile substitution, similar day matching, regression analysis, or manual entry. Null for actual reads.. Valid values are `none|linear|profile|similar_day|regression|manual`',
    `exception_flag` BOOLEAN COMMENT 'Boolean indicator that this interval read triggered a VEE exception or quality alert. True when the read failed validation thresholds, exhibited anomalous patterns, or requires manual review. Used to prioritize data quality investigations.',
    `exception_reason` STRING COMMENT 'Textual description of why the interval read was flagged as an exception. Examples include consumption spike exceeds threshold, negative demand value, missing data gap, meter clock drift detected. Null when exception_flag is false.',
    `interval_duration_minutes` STRING COMMENT 'Duration of the interval period in minutes. Typical values are 15 minutes (standard AMI interval) or 60 minutes (hourly reads). May vary for special meter configurations or during clock changes.',
    `interval_end_timestamp` TIMESTAMP COMMENT 'Timestamp marking the end of the interval period. Represents the real-world time when the meter completed accumulating energy for this interval.',
    `interval_start_timestamp` TIMESTAMP COMMENT 'Timestamp marking the beginning of the interval period. Represents the real-world time when the meter began accumulating energy for this interval.',
    `load_research_flag` BOOLEAN COMMENT 'Boolean indicator that this meter is part of a load research sample. True when the meter is selected for statistical load profiling, rate design studies, or regulatory reporting. Used to identify sample meters for load research analysis.',
    `net_consumption_value` DECIMAL(18,2) COMMENT 'Net energy consumption for the interval, calculated as delivered energy minus received energy. Used for net energy metering (NEM) billing calculations. Positive values indicate net consumption, negative values indicate net generation.',
    `power_factor` DECIMAL(18,2) COMMENT 'Power factor measured during the interval period, expressed as a decimal between 0 and 1. Represents the ratio of real power to apparent power. Used for power quality analysis and reactive power billing. Null for gas meters or meters not configured for power factor measurement.',
    `power_outage_flag` BOOLEAN COMMENT 'Boolean indicator that a power outage occurred during this interval period. True when the meter recorded a loss of service event. Used to correlate interval data with outage events from OMS and adjust billing for service interruptions.',
    `reactive_energy_value` DECIMAL(18,2) COMMENT 'Reactive energy consumption during the interval period, measured in kVARh (kilovolt-ampere reactive hours). Used for power factor correction billing and grid voltage support analysis. Null for gas meters or single-phase residential meters.',
    `read_quality_code` STRING COMMENT 'Quality classification of the interval read. Indicates whether the value is an actual meter reading, an estimated value generated by VEE algorithms, a substituted value from a similar profile, missing data, or rejected due to validation failure.. Valid values are `actual|estimated|substituted|missing|rejected`',
    `reverse_flow_flag` BOOLEAN COMMENT 'Boolean indicator that energy flowed in the reverse direction during this interval (customer generation exported to grid). True for net metering scenarios with solar, wind, or other distributed energy resources. Used for NEM billing and DER integration analysis.',
    `temperature_uom` STRING COMMENT 'Unit of measure for temperature value. F for Fahrenheit, C for Celsius.. Valid values are `F|C`',
    `temperature_value` DECIMAL(18,2) COMMENT 'Ambient temperature at the meter location during the interval period, measured in degrees Fahrenheit or Celsius. Used for weather normalization, load forecasting, and demand response baseline adjustments. Sourced from weather stations or meter-integrated sensors.',
    `time_zone_code` STRING COMMENT 'IANA time zone identifier for the meter location (e.g., America/New_York, America/Chicago). Used to correctly interpret interval timestamps during daylight saving time transitions and for multi-region utilities.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this interval read record was last modified in the MDMS database. Updated when VEE processing changes the read quality, estimation method, or consumption value. Used for change tracking and data quality audit trails.',
    `validation_rule_code` STRING COMMENT 'Code identifying the VEE validation rule that processed this interval read. References the specific business rule or algorithm applied during validation (e.g., range check, spike detection, consistency check). Used for audit and troubleshooting.',
    `validation_timestamp` TIMESTAMP COMMENT 'Timestamp when the interval read completed VEE validation processing. Null for raw reads that have not yet been validated. Used to track VEE processing latency and audit data quality workflows.',
    `vee_status` STRING COMMENT 'Current status of the interval read in the VEE workflow. Tracks whether the read is raw (unprocessed), validated (passed quality checks), estimated (calculated by VEE engine), edited (manually corrected), approved (finalized for billing), or rejected (failed validation).. Valid values are `raw|validated|estimated|edited|approved|rejected`',
    `voltage_value` DECIMAL(18,2) COMMENT 'Average voltage measured at the meter during the interval period, in volts. Used for power quality monitoring, voltage regulation analysis, and grid reliability studies. Null for gas meters.',
    CONSTRAINT pk_interval_read PRIMARY KEY(`interval_read_id`)
) COMMENT 'High-volume transactional table storing raw and validated interval energy consumption readings collected from AMI/AMR meters. Each record represents one interval period (typically 15-min or 60-min) for one meter channel, capturing: meter identifier, channel number, read timestamp (interval start/end), interval duration in minutes, raw kWh or MCF value, demand kW value (where applicable), read quality code (actual/estimated/substituted), VEE status flag, data source (AMI head-end / manual / estimated), and collection timestamp. This is the foundational dataset for billing interval data, TOU rate application, demand response baselines, and load research. Sourced from Oracle Utilities MDMS / Itron Analytics.';

CREATE OR REPLACE TABLE `power_and_utilities`.`metering`.`register_read` (
    `register_read_id` BIGINT COMMENT 'Unique identifier for the register read record. Primary key for the register read transaction.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Register reads (non-AMI) are the traditional billing determinant. Invoices must reference the specific reads used for billing calculations to support dispute resolution, audit requirements, and regula',
    `meter_channel_id` BIGINT COMMENT 'Foreign key linking to metering.meter_channel. Business justification: Each register read captures a scalar value from a specific meter channel/register. The meter_channel entity defines the channel configuration (channel_number, channel_type, measurement_direction, mult',
    `meter_id` BIGINT COMMENT 'Identifier of the meter from which this register read was captured. Links to the meter asset inventory.',
    `read_cycle_id` BIGINT COMMENT 'Foreign key linking to metering.read_cycle. Business justification: Register reads are captured at scheduled read cycles. The register_read table currently has read_cycle_code (STRING) which is a denormalized reference to read_cycle.cycle_code. This should be normaliz',
    `service_point_id` BIGINT COMMENT 'Identifier of the service point (premise delivery location) associated with this meter read. Links to the service point where energy is delivered.',
    `tou_schedule_id` BIGINT COMMENT 'Foreign key linking to metering.tou_schedule. Business justification: Register reads captured during TOU-enabled read cycles are classified by TOU period. Currently register_read has time_of_use_period (string) which is a denormalized classification. The tou_schedule en',
    `billing_determinant_flag` BOOLEAN COMMENT 'Indicates whether this register read is the primary billing determinant for the associated service point and billing period. True when this read drives invoice calculation; false for supplementary or informational reads.',
    `consumption_delta` DECIMAL(18,2) COMMENT 'The difference between the current consumption value and the previous consumption value, representing the energy or volume consumed during the read period. This is the primary input to billing calculations.',
    `consumption_value` DECIMAL(18,2) COMMENT 'The multiplier-applied consumption value calculated as raw_register_value multiplied by the meter multiplier. This is the billable quantity for the read period.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this register read record was first created in the MDMS or CIS system. Used for audit trail and data lineage tracking.',
    `demand_reset_date` DATE COMMENT 'The date on which the demand register was last reset to zero. Applicable only to demand registers (kW, MW) that track peak demand within a billing period. Null for energy registers.',
    `dial_count` STRING COMMENT 'The number of dials or digits on the meter register. Used for validation of register rollover events and maximum register capacity calculations.',
    `estimation_method` STRING COMMENT 'The algorithm used to estimate consumption when an actual read was not obtained. Historical-average uses recent consumption patterns; same-day-last-year uses year-over-year comparison; pro-rata uses daily average; regression uses statistical modeling; none indicates actual read obtained.. Valid values are `historical-average|same-day-last-year|pro-rata|regression|none`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this register read record was last updated. Captures VEE corrections, status changes, or data quality adjustments.',
    `multiplier` DECIMAL(18,2) COMMENT 'The multiplier factor applied to the raw register value to calculate actual consumption. Used when current transformers (CT) or potential transformers (PT) are installed, or when meter gearing requires scaling. A multiplier of 1.0 indicates no transformation.',
    `pressure_compensation_factor` DECIMAL(18,2) COMMENT 'Adjustment factor applied to gas volume reads to normalize for pressure variations. Gas volume varies with pressure; this factor converts measured volume to standard pressure conditions. Null for electric meters.',
    `previous_read_date` DATE COMMENT 'The date of the immediately preceding read event for this register. Used to determine the consumption period length.',
    `previous_read_value` DECIMAL(18,2) COMMENT 'The raw register value from the immediately preceding read event for this register. Used to calculate consumption delta between reads.',
    `raw_register_value` DECIMAL(18,2) COMMENT 'The cumulative scalar value displayed on the meter register dial at the time of read, before any multiplier or conversion is applied. This is the raw odometer-style reading from the meter.',
    `read_by_user_code` STRING COMMENT 'Identifier of the field technician, system user, or automated process that captured or entered this read. Used for audit trail and quality assurance.',
    `read_date` DATE COMMENT 'The calendar date on which the meter register was read. Used for billing cycle alignment and consumption period determination.',
    `read_method` STRING COMMENT 'The method by which the register read was obtained. AMI (Advanced Metering Infrastructure) indicates automated remote read via two-way communication; AMR (Automated Meter Reading) indicates one-way automated read; manual indicates field technician read; estimated indicates calculated value when actual read unavailable; customer-provided indicates self-reported read.. Valid values are `AMI|AMR|manual|estimated|customer-provided`',
    `read_note` STRING COMMENT 'Free-text field for field technician or system comments regarding read exceptions, site conditions, or data quality issues. Examples include inaccessible meter, customer refused entry, meter damaged, or unusual consumption pattern.',
    `read_quality_code` STRING COMMENT 'Indicator of the read data quality and reliability. Actual indicates a verified meter read; estimated indicates a calculated value due to read failure or inaccessibility; customer-read indicates self-reported value; prorated indicates adjusted value for partial period; missing indicates no read obtained; suspect indicates read flagged for validation review.. Valid values are `actual|estimated|customer-read|prorated|missing|suspect`',
    `read_sequence_number` STRING COMMENT 'Sequential counter of reads for this meter register, used to detect missing reads and ensure chronological ordering in the read history.',
    `read_source_system` STRING COMMENT 'The operational system from which this read record originated. MDMS (Meter Data Management System) for processed reads; CIS (Customer Information System) for billing-cycle reads; AMI-Head-End for direct AMI network reads; Field-Device for handheld meter reader uploads; Manual-Entry for exception handling.. Valid values are `MDMS|CIS|AMI-Head-End|Field-Device|Manual-Entry`',
    `read_status` STRING COMMENT 'Current lifecycle status of the read record in the validation-estimation-editing (VEE) workflow. Valid indicates passed all validation rules; pending-validation indicates awaiting VEE processing; failed-validation indicates rule violations detected; corrected indicates manual adjustment applied; voided indicates read superseded or cancelled.. Valid values are `valid|pending-validation|failed-validation|corrected|voided`',
    `read_timestamp` TIMESTAMP COMMENT 'The precise date and time when the meter register read was captured. Critical for interval boundary alignment and time-of-use rate application.',
    `read_type` STRING COMMENT 'Classification of the read event purpose. Scheduled reads occur at regular billing cycles; on-demand reads are requested for specific business needs; move-in/move-out reads support customer transitions; special reads address exceptions or investigations. [ENUM-REF-CANDIDATE: scheduled|on-demand|move-in|move-out|special|final|initial|investigative — 8 candidates stripped; promote to reference product]',
    `rollover_flag` BOOLEAN COMMENT 'Indicates whether the meter register rolled over (returned to zero after reaching maximum capacity) during this read period. True when rollover detected; false otherwise. Critical for accurate consumption calculation.',
    `temperature_compensation_factor` DECIMAL(18,2) COMMENT 'Adjustment factor applied to gas volume reads to normalize for temperature variations. Gas volume expands and contracts with temperature; this factor converts measured volume to standard conditions (typically 60°F or 15°C). Null for electric meters.',
    `unit_of_measure` STRING COMMENT 'The unit in which the register value is expressed. kWh (kilowatt-hour) and MWh (megawatt-hour) for electric energy; kW and MW for electric demand; MCF (thousand cubic feet), Therm, and CCF (hundred cubic feet) for gas volume and energy; kVAh for apparent energy; kVArh for reactive energy. [ENUM-REF-CANDIDATE: kWh|MWh|kW|MW|MCF|Therm|CCF|kVAh|kVArh — 9 candidates stripped; promote to reference product]',
    `validation_rule_failures` STRING COMMENT 'Comma-separated list of validation rule codes that this read failed during VEE processing. Examples include high-usage, negative-consumption, zero-consumption, out-of-range, or meter-stopped. Empty when all validation rules passed.',
    CONSTRAINT pk_register_read PRIMARY KEY(`register_read_id`)
) COMMENT 'Transactional record of scalar (cumulative) meter register reads captured at scheduled read cycles or on-demand. Stores meter identifier, register number, read date, read time, read type (scheduled/on-demand/move-in/move-out/special), read method (AMR/AMI/manual/estimated), raw register value, unit of measure (kWh/MCF/Therm/kW), multiplier-applied consumption value, previous read value, consumption delta, and read quality indicator. Feeds billing domain for non-interval rate schedules and serves as the fallback read source when interval data is unavailable. Sourced from Oracle Utilities MDMS and Oracle CC&B / SAP IS-U.';

CREATE OR REPLACE TABLE `power_and_utilities`.`metering`.`vee_event` (
    `vee_event_id` BIGINT COMMENT 'Unique identifier for the VEE event record. Primary key for the VEE event transaction.',
    `bill_cycle_id` BIGINT COMMENT 'Identifier of the billing cycle affected by this VEE event, if applicable.',
    `bill_dispute_id` BIGINT COMMENT 'Foreign key linking to billing.bill_dispute. Business justification: VEE events (validation/estimation/editing) are primary evidence in billing disputes. Dispute investigation requires tracing to specific VEE corrections that affected billed amounts. Essential for disp',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to asset.work_order. Business justification: VEE exceptions with high variance or persistent validation failures trigger field investigations requiring formal work orders for meter testing, seal inspection, or CT/PT verification. Critical for da',
    `meter_channel_id` BIGINT COMMENT 'Foreign key linking to metering.meter_channel. Business justification: VEE events validate/estimate/edit data for specific meter channels. The vee_event table currently has channel_number (INT) which is a denormalized reference. This should be normalized to a proper FK m',
    `meter_id` BIGINT COMMENT 'Identifier of the meter whose interval or register read data was subject to VEE processing.',
    `rate_case_id` BIGINT COMMENT 'Foreign key linking to regulatory.rate_case. Business justification: VEE events during rate case test years require special audit trails for prudency reviews. Utilities must demonstrate data quality and estimation practices during test year periods. FK enables regulato',
    `read_cycle_id` BIGINT COMMENT 'Foreign key linking to metering.read_cycle. Business justification: VEE (Validation, Estimation, Editing) processing is organized by read cycle - each cycle triggers VEE batch processing for all interval/register reads collected in that cycle. The read_cycle defines t',
    `service_point_id` BIGINT COMMENT 'Identifier of the service point associated with the meter at the time of the VEE event.',
    `vee_rule_set_id` BIGINT COMMENT 'Foreign key linking to metering.vee_rule_set. Business justification: Each VEE event is generated by applying a specific VEE rule set. Currently vee_event has vee_rule_code (string) which is a denormalized reference. The vee_rule_set entity is the authoritative source f',
    `analyst_override_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a human analyst manually overrode the automated VEE processing result.',
    `billing_impact_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this VEE event resulted in a change to billable consumption or demand data.',
    `comments` STRING COMMENT 'Free-text comments or notes related to the VEE event, used for additional context or audit trail documentation.',
    `corrected_value` DECIMAL(18,2) COMMENT 'Corrected or estimated value after VEE processing. This is the value used for billing and reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the VEE event record was first created in the MDMS system.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Overall data quality score (0-100) for the read after VEE processing, used for MDMS data governance and quality monitoring.',
    `estimation_confidence_score` DECIMAL(18,2) COMMENT 'Confidence score (0-100) indicating the reliability of the estimated value based on the estimation method and available data quality.',
    `estimation_method` STRING COMMENT 'Algorithm or method used to estimate the corrected value (e.g., regression, weather-normalized, profile-based, historical average, similar day, linear interpolation, manual). [ENUM-REF-CANDIDATE: regression|weather_normalized|profile_based|historical_average|similar_day|linear_interpolation|manual|none — 8 candidates stripped; promote to reference product]',
    `interval_duration_minutes` STRING COMMENT 'Duration of the read interval in minutes (e.g., 15, 30, 60) for interval data, or null for register reads.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the VEE event record was last modified or updated.',
    `measurement_type` STRING COMMENT 'Type of measurement affected by the VEE event (e.g., consumption, demand, voltage, power factor).. Valid values are `consumption|demand|voltage|power_factor|var|reactive_power`',
    `original_raw_value` DECIMAL(18,2) COMMENT 'Original raw meter read value before VEE processing was applied. Null if no read was received.',
    `override_analyst_code` STRING COMMENT 'User ID or employee identifier of the analyst who performed the manual override.',
    `override_justification` STRING COMMENT 'Free-text justification provided by the analyst for manually overriding the automated VEE result. Required when analyst_override_flag is true.',
    `override_timestamp` TIMESTAMP COMMENT 'Timestamp when the analyst override was applied.',
    `read_end_timestamp` TIMESTAMP COMMENT 'End timestamp of the interval or register read period affected by the VEE event.',
    `read_quality_code` STRING COMMENT 'Quality code assigned to the read after VEE processing, indicating the reliability level (e.g., actual, estimated, questionable, rejected).',
    `read_start_timestamp` TIMESTAMP COMMENT 'Start timestamp of the interval or register read period affected by the VEE event.',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this VEE event must be included in regulatory reporting to PUC or FERC.',
    `source_system` STRING COMMENT 'Source system that provided the original raw read data (e.g., MDMS, AMI Head End, Manual Entry, SCADA, Historian).. Valid values are `MDMS|AMI_Head_End|Manual_Entry|SCADA|Historian`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the read value affected by the VEE event (e.g., kWh, MWh, kW, MW, MCF, Therm). [ENUM-REF-CANDIDATE: kWh|MWh|kW|MW|MCF|Therm|kVAR|Volts — 8 candidates stripped; promote to reference product]',
    `validation_exception_code` STRING COMMENT 'Code identifying the specific validation exception or data quality issue detected (e.g., spike, dropout, missing, negative, sum-check-fail, high-limit, low-limit).',
    `validation_exception_description` STRING COMMENT 'Detailed description of the validation exception or data quality issue that triggered the VEE event.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Absolute difference between the original raw value and the corrected value (corrected_value - original_raw_value).',
    `variance_percentage` DECIMAL(18,2) COMMENT 'Percentage variance between the original raw value and the corrected value, calculated as (variance_amount / original_raw_value) * 100.',
    `vee_batch_reference` STRING COMMENT 'Identifier of the VEE processing batch or job that generated this event, used for grouping and audit trail.',
    `vee_event_number` STRING COMMENT 'Business-facing unique identifier or reference number for the VEE event, used for audit trail and regulatory reporting.',
    `vee_processing_timestamp` TIMESTAMP COMMENT 'Timestamp when the VEE processing was executed and the event record was created.',
    `vee_rule_description` STRING COMMENT 'Human-readable description of the VEE rule that was applied, explaining the validation or estimation logic.',
    `vee_status` STRING COMMENT 'Current status of the VEE event indicating the outcome of the validation, estimation, or editing process.. Valid values are `validated|estimated|edited|rejected|pending|manual_review`',
    CONSTRAINT pk_vee_event PRIMARY KEY(`vee_event_id`)
) COMMENT 'Transactional record capturing each Validation, Estimation, and Editing (VEE) action applied to interval or register read data within the MDMS. Records the affected meter, read period, VEE rule triggered (spike/dropout/missing/negative/sum-check), original raw value, corrected/estimated value, estimation algorithm used (regression/weather-normalized/profile-based), VEE status (validated/estimated/edited/rejected), analyst override flag, override justification, and processing timestamp. Provides the full audit trail for read quality assurance required for regulatory billing accuracy compliance and MDMS data governance. Sourced from Oracle Utilities MDMS / Itron Analytics VEE engine.';

CREATE OR REPLACE TABLE `power_and_utilities`.`metering`.`meter_event` (
    `meter_event_id` BIGINT COMMENT 'Unique identifier for the meter event record. Primary key for the meter event log.',
    `ami_endpoint_id` BIGINT COMMENT 'Unique identifier of the AMI communication endpoint or module attached to the meter that transmitted the event to the head-end system.',
    `compliance_event_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_event. Business justification: Meter events (tampering, sustained outages, voltage violations) can trigger regulatory compliance events (service quality violations, NERC CIP events). FK enables regulatory incident tracking, penalty',
    `credit_adjustment_id` BIGINT COMMENT 'Foreign key linking to billing.credit_adjustment. Business justification: Meter events (outages, tamper, power quality) trigger billing adjustments. Credit adjustments must reference the specific event that justified the adjustment for audit trails, regulatory compliance, a',
    `account_id` BIGINT COMMENT 'Identifier of the customer account associated with the service point and meter. Used for customer notification and billing impact analysis.',
    `meter_id` BIGINT COMMENT 'Identifier of the AMI or AMR meter that generated this event. Links to the physical meter asset.',
    `service_point_id` BIGINT COMMENT 'Identifier of the service point (premise delivery location) associated with the meter that generated this event. Links event to customer location.',
    `work_order_id` BIGINT COMMENT 'Identifier of the work order created for field investigation or corrective action. Null if no work order generated.',
    `acknowledged_by` STRING COMMENT 'User ID or system identifier of the person or automated process that acknowledged the event. Null if unacknowledged.',
    `acknowledged_timestamp` TIMESTAMP COMMENT 'Date and time when the event was acknowledged. Null if the event has not been acknowledged.',
    `acknowledgment_status` STRING COMMENT 'Indicates whether the event has been acknowledged by operations staff or automatically cleared by the system. Tracks event lifecycle state.. Valid values are `acknowledged|unacknowledged|auto_cleared|manually_cleared`',
    `battery_level_percent` DECIMAL(18,2) COMMENT 'Remaining battery charge level as a percentage for battery-powered endpoints or meters. Used for low battery event analysis and maintenance scheduling.',
    `current_reading` DECIMAL(18,2) COMMENT 'Current measurement in amperes captured at the time of the event, if applicable. Used for tamper detection and reverse flow analysis.',
    `event_code` STRING COMMENT 'Raw event code or alarm identifier as transmitted by the meter or endpoint. Vendor-specific code that maps to the event type.',
    `event_description` STRING COMMENT 'Human-readable description of the event, providing additional context beyond the event type and code. May include device-generated diagnostic messages.',
    `event_resolution_notes` STRING COMMENT 'Free-text notes documenting the investigation findings, corrective actions taken, and event resolution details. Entered by operations or field staff.',
    `event_severity` STRING COMMENT 'Severity level assigned to the event based on operational impact and urgency. Used for prioritization and escalation workflows.. Valid values are `critical|high|medium|low|informational`',
    `event_source_system` STRING COMMENT 'Name of the head-end system or MDMS platform that received and processed the event from the meter endpoint (e.g., Itron Analytics, Oracle Utilities MDMS).',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the event occurred at the meter or endpoint, as recorded by the device clock. This is the business event time, distinct from system receipt time.',
    `event_type` STRING COMMENT 'Classification of the meter event. Indicates the nature of the operational event or alarm reported by the device. [ENUM-REF-CANDIDATE: tamper|outage|restoration|power_quality|low_battery|reverse_flow|tilt|cover_removal|communication_loss|demand_threshold|voltage_sag|voltage_swell — 12 candidates stripped; promote to reference product]',
    `field_investigation_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether this event requires field crew investigation or site visit. True if investigation required, False otherwise.',
    `forwarded_to_oms_flag` BOOLEAN COMMENT 'Boolean indicator of whether this event was forwarded to the Outage Management System for outage correlation and crew dispatch. True if forwarded, False otherwise.',
    `frequency_hz` DECIMAL(18,2) COMMENT 'Electrical frequency in hertz measured at the time of the event. Used for grid stability and power quality analysis.',
    `notification_channel` STRING COMMENT 'Communication channel used to send the event notification to the customer or operations staff. Null if no notification sent.. Valid values are `email|sms|ivr|mobile_app|none`',
    `notification_sent_flag` BOOLEAN COMMENT 'Boolean indicator of whether a customer or operations notification was sent for this event. True if notification sent, False otherwise.',
    `oms_incident_reference` STRING COMMENT 'Identifier of the outage incident created in the OMS as a result of this meter event. Null if not forwarded or no incident created.',
    `outage_duration_minutes` STRING COMMENT 'Duration of the outage in minutes, calculated from outage event to restoration event. Used for SAIDI and SAIFI reliability index calculations.',
    `power_factor` DECIMAL(18,2) COMMENT 'Power factor measurement (ratio of real power to apparent power) at the time of the event. Used for power quality monitoring and analysis.',
    `processed_timestamp` TIMESTAMP COMMENT 'Date and time when the event was processed and validated by the MDMS or event management system. Used for event processing latency analysis.',
    `received_timestamp` TIMESTAMP COMMENT 'Date and time when the event was received by the head-end system or MDMS. May differ from event_timestamp due to communication latency.',
    `resolved_by` STRING COMMENT 'User ID or system identifier of the person or automated process that resolved and closed the event. Null if unresolved.',
    `resolved_timestamp` TIMESTAMP COMMENT 'Date and time when the event was marked as resolved or closed. Null for open or unresolved events.',
    `restoration_timestamp` TIMESTAMP COMMENT 'Date and time when power was restored following an outage event. Null for non-outage events or unresolved outages.',
    `signal_strength_dbm` DECIMAL(18,2) COMMENT 'Communication signal strength in decibels-milliwatts at the time of the event. Used for communication loss event diagnosis and network optimization.',
    `tamper_count` STRING COMMENT 'Cumulative count of tamper events detected by the meter since last reset. Used for theft investigation and fraud detection.',
    `voltage_reading` DECIMAL(18,2) COMMENT 'Voltage measurement in volts captured at the time of the event, if applicable. Used for power quality events such as voltage sag or swell.',
    CONSTRAINT pk_meter_event PRIMARY KEY(`meter_event_id`)
) COMMENT 'Transactional log of operational events and alarms reported by AMI smart meters and endpoints to the head-end system. Captures event type (tamper/outage/restoration/power-quality/low-battery/reverse-flow/tilt/cover-removal/communication-loss), event timestamp, meter identifier, endpoint identifier, event severity, raw event code from the device, acknowledgment status, and downstream notification flag (e.g., forwarded to OMS for outage correlation). Supports outage detection, theft/tamper investigation, power quality monitoring, and field crew dispatch. Sourced from Itron Analytics / Oracle Utilities MDMS event stream.';

CREATE OR REPLACE TABLE `power_and_utilities`.`metering`.`read_cycle` (
    `read_cycle_id` BIGINT COMMENT 'Unique system identifier for the meter reading cycle. Primary key for the read cycle entity.',
    `replacement_cycle_read_cycle_id` BIGINT COMMENT 'Reference to the successor reading cycle that replaced this cycle when it was retired. Used to track cycle evolution and support meter reassignment during cycle consolidation or restructuring.',
    `vee_rule_set_id` BIGINT COMMENT 'FK to metering.vee_rule_set',
    `ami_collection_window_end` TIMESTAMP COMMENT 'Timestamp marking the end of the automated interval data collection window for AMI smart meters. Collection jobs must complete before this time to allow VEE processing and billing cycle close.',
    `ami_collection_window_start` TIMESTAMP COMMENT 'Timestamp marking the beginning of the automated interval data collection window for AMI smart meters assigned to this cycle. Typically set to midnight or early morning hours to minimize network load.',
    `billing_cycle_alignment` STRING COMMENT 'Indicates whether this read cycle is synchronized with billing cycle processing. Aligned cycles trigger billing immediately after reads; offset cycles allow time for validation; independent cycles are not tied to billing.. Valid values are `aligned|offset|independent`',
    `billing_cycle_day_offset` STRING COMMENT 'Number of days between the scheduled read day and the billing cycle close date. Allows time for meter data validation, estimation, and editing (VEE) before invoices are generated. Typically 1-5 days for monthly cycles.',
    `collection_method` STRING COMMENT 'Primary method used to collect meter reads for this cycle. AMI automated uses smart meter network; AMR drive-by uses mobile collection units; manual methods require field personnel.. Valid values are `ami_automated|amr_drive_by|manual_handheld|manual_visual|remote_optical`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this read cycle record was first created in the MDMS or CIS system. Used for audit trail and data lineage tracking.',
    `customer_class` STRING COMMENT 'Primary customer class or rate class served by this cycle. Used to segment cycles by customer type for billing, rate application, and regulatory reporting purposes.. Valid values are `residential|commercial|industrial|agricultural|municipal|street_lighting`',
    `cycle_code` STRING COMMENT 'Business identifier code for the reading cycle used in operational systems and billing processes. Typically a short alphanumeric code (e.g., C01, CYC-A, M15) that uniquely identifies the cycle within the utilitys service territory.. Valid values are `^[A-Z0-9]{2,10}$`',
    `cycle_name` STRING COMMENT 'Human-readable descriptive name for the reading cycle (e.g., North Region Monthly Cycle, Downtown Daily AMI Collection, Residential Bi-Monthly Route 5). Used for display and reporting purposes.',
    `cycle_type` STRING COMMENT 'Classification of the reading cycle purpose. Billing cycles drive invoice generation; operational cycles support grid monitoring; on-demand cycles handle ad-hoc requests; special cycles support events like meter exchanges or audits.. Valid values are `billing|operational|on_demand|special`',
    `demand_response_eligible` BOOLEAN COMMENT 'Indicates whether meters in this cycle are eligible for Demand Response (DR) programs and curtailment events. True for AMI cycles with 15-minute or hourly interval collection supporting peak shaving and load management.',
    `effective_end_date` DATE COMMENT 'Date on which this reading cycle was retired or replaced. Null for currently active cycles. Used to maintain historical cycle configurations for audit and regulatory compliance.',
    `effective_start_date` DATE COMMENT 'Date on which this reading cycle became active and available for meter assignment and read scheduling. Used to track cycle history and support regulatory reporting of billing cycle changes.',
    `estimated_meter_count` STRING COMMENT 'Approximate number of meters assigned to this reading cycle. Used for workforce planning, collection job sizing, and performance monitoring. Updated periodically as meters are added or removed from the cycle.',
    `geographic_zone_code` STRING COMMENT 'Code identifying the geographic service territory, district, or region to which this cycle applies. Used to group cycles by operational area and align with distribution system topology.. Valid values are `^[A-Z0-9]{2,6}$`',
    `interval_length_minutes` STRING COMMENT 'Length of each interval data collection period in minutes for AMI meters in this cycle. Common values are 15, 30, or 60 minutes. Null for cycles collecting only monthly register reads.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this read cycle record. Tracks configuration changes, status updates, and cycle parameter adjustments.',
    `notes` STRING COMMENT 'Free-text field for operational notes, special instructions, or comments related to this reading cycle. May include information about route changes, seasonal adjustments, or coordination with field operations.',
    `read_cycle_status` STRING COMMENT 'Current operational status of the reading cycle. Active cycles are in use for scheduling and collection; inactive cycles are temporarily disabled; suspended cycles are on hold pending review; archived cycles are retained for historical reference only.. Valid values are `active|inactive|suspended|archived`',
    `read_frequency` STRING COMMENT 'Scheduled frequency at which meters assigned to this cycle are read. Monthly is standard for residential billing; daily for AMI interval collection; bi-monthly for certain gas customers; on-demand for special reads. [ENUM-REF-CANDIDATE: daily|weekly|bi_weekly|monthly|bi_monthly|quarterly|on_demand — 7 candidates stripped; promote to reference product]',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether reads from this cycle are included in regulatory reports submitted to state Public Utility Commissions (PUCs) or FERC. True for billing cycles used in rate case cost studies and revenue reporting.',
    `route_sequence_number` STRING COMMENT 'Numeric ordering of this cycle within a geographic route grouping. Used to optimize meter reader travel paths and schedule field workforce. Null for AMI-only cycles that do not require manual reading.',
    `scheduled_read_day` STRING COMMENT 'Target day of the month (1-31) when meters in this cycle should be read. Used for monthly and bi-monthly cycles to schedule meter reader routes and AMI collection jobs. Null for daily or on-demand cycles.',
    `service_type` STRING COMMENT 'Type of utility service (commodity) for which this cycle collects meter reads. Electric cycles measure kWh/kW; gas cycles measure MCF/Therms; multi-commodity cycles support dual-fuel meters.. Valid values are `electric|gas|water|multi_commodity`',
    `target_read_completion_hours` DECIMAL(18,2) COMMENT 'Target number of hours within which all meters in this cycle should be read after the scheduled read day. Used to measure field workforce productivity and AMI collection performance. Typically 24-48 hours for monthly cycles.',
    `time_of_use_enabled` BOOLEAN COMMENT 'Indicates whether this cycle collects interval data for Time-of-Use (TOU) rate application. True for AMI cycles serving customers on TOU tariffs; false for standard monthly register read cycles.',
    `vee_processing_required` BOOLEAN COMMENT 'Indicates whether meter reads collected in this cycle must undergo automated validation, estimation, and editing (VEE) processing before being released to billing. True for billing cycles; may be false for operational monitoring cycles.',
    CONSTRAINT pk_read_cycle PRIMARY KEY(`read_cycle_id`)
) COMMENT 'Master reference entity defining scheduled meter reading cycles used to organize meter reads for billing and data collection. Captures cycle code, cycle name, read frequency (monthly/bi-monthly/daily/on-demand), scheduled read day-of-month, billing cycle alignment, geographic route grouping, AMI collection window start/end times, and active status. Drives the scheduling of both AMI automated collection jobs and manual meter reading routes. Referenced by register_read and interval_read to associate reads with their originating cycle. Managed within Oracle Utilities MDMS and Oracle CC&B / SAP IS-U.';

CREATE OR REPLACE TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` (
    `meter_program_enrollment_id` BIGINT COMMENT 'Unique identifier for the meter program enrollment record. Primary key for this entity. Represents a single instance of a meter being enrolled in a utility program requiring specific metering configuration or data collection.',
    `account_id` BIGINT COMMENT 'Reference to the customer account that triggered or is associated with this meter program enrollment. Links to the customer account master in the customer domain.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Program enrollments (net metering, demand response, TOU) affect billing calculations. Invoices must reference active enrollments for accurate charge application, incentive tracking, and regulatory com',
    `meter_id` BIGINT COMMENT 'Reference to the physical or logical meter asset enrolled in the program. Links to the meter inventory master record in the metering domain.',
    `participant_registration_id` BIGINT COMMENT 'Foreign key linking to market.participant_registration. Business justification: Demand response and wholesale market program enrollments require validation against RTO/ISO participant registration status for eligibility verification and settlement authorization.',
    `ppa_contract_id` BIGINT COMMENT 'Foreign key linking to market.ppa_contract. Business justification: Customer-sited generation programs (net metering, community solar) often operate under PPA structures requiring enrollment tracking for contract compliance, incentive calculation, and regulatory repor',
    `service_point_id` BIGINT COMMENT 'Reference to the service point (premise delivery location) where the enrolled meter is installed. Links to the distribution domain service point entity.',
    `tariff_schedule_id` BIGINT COMMENT 'Foreign key linking to regulatory.tariff_schedule. Business justification: Program enrollments (net metering, TOU, demand response) are governed by specific approved tariff schedules. Replaces denormalized rate_schedule_code with proper FK to enable tariff compliance validat',
    `tou_schedule_id` BIGINT COMMENT 'Identifier for the specific TOU time-block schedule applied to this meter. Defines on-peak, mid-peak, off-peak periods and seasonal variations. Applicable only for TOU and CPP program enrollments.',
    `cis_program_reference` STRING COMMENT 'External reference identifier linking this metering-domain enrollment to the corresponding customer-level program participation record in the CIS (Oracle CC&B or SAP IS-U). Supports coordination between metering configuration and billing rate application.',
    `compliance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the meter and customer are in compliance with program requirements. False indicates non-compliance issues such as missing data, configuration errors, or customer behavior violations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this enrollment record was first created in the lakehouse silver layer. Represents the data ingestion event, not the business enrollment request date.',
    `data_collection_requirement` STRING COMMENT 'Level of data collection required for this program enrollment. Standard indicates normal AMI interval reads; Enhanced indicates additional channels or higher frequency; Real-time indicates continuous streaming; On-demand indicates event-triggered collection.. Valid values are `standard|enhanced|real_time|on_demand`',
    `demand_threshold_kw` DECIMAL(18,2) COMMENT 'Demand threshold in kilowatts (kW) that triggers program-specific actions or billing. Used in demand response and critical peak pricing programs to define curtailment or penalty thresholds.',
    `enrollment_activation_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the meter configuration changes were applied and the enrollment became operationally active in the MDMS (Meter Data Management System). Records the actual system activation event.',
    `enrollment_approval_date` DATE COMMENT 'Date when the program enrollment was approved by utility operations or automated validation. Applicable for programs requiring eligibility verification or technical feasibility review.',
    `enrollment_channel` STRING COMMENT 'Channel or interface through which the enrollment was initiated. Distinguishes self-service digital enrollments from assisted or batch enrollments.. Valid values are `web_portal|mobile_app|call_center|field_service|bulk_import`',
    `enrollment_effective_date` DATE COMMENT 'Date when the meter program enrollment becomes active and the meter configuration changes take effect. Determines when program-specific data collection and rate application begin.',
    `enrollment_end_date` DATE COMMENT 'Date when the meter program enrollment ends or is scheduled to end. Nullable for open-ended enrollments. Determines when program-specific meter configuration and data collection cease.',
    `enrollment_request_date` DATE COMMENT 'Date when the program enrollment was requested or initiated. May differ from enrollment_effective_date due to processing time, approval workflows, or scheduled future start dates.',
    `enrollment_source` STRING COMMENT 'Origin or trigger of the meter program enrollment. Customer request indicates opt-in; Utility initiative indicates utility-driven enrollment; Regulatory mandate indicates compliance-driven; Automatic enrollment indicates default assignment; Pilot program indicates test/trial participation.. Valid values are `customer_request|utility_initiative|regulatory_mandate|automatic_enrollment|pilot_program`',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the meter program enrollment. Pending indicates enrollment request submitted but not yet activated; Active indicates meter is configured and collecting program data; Suspended indicates temporary hold; Terminated indicates program completion; Cancelled indicates enrollment withdrawn before activation.. Valid values are `pending|active|suspended|terminated|cancelled`',
    `export_channel_enabled_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the meter export channel (reverse energy flow measurement) is activated for this enrollment. True for NEM (Net Energy Metering) and DER (Distributed Energy Resource) programs where customer generation is measured.',
    `incentive_payment_status` STRING COMMENT 'Status of the program incentive payment associated with this enrollment. Tracks the lifecycle of incentive disbursement from eligibility determination through payment completion.. Valid values are `pending|approved|paid|denied|cancelled`',
    `interval_collection_frequency_minutes` STRING COMMENT 'Frequency in minutes at which interval meter data is collected for this program enrollment. Common values include 15, 30, or 60 minutes. Defines the granularity of energy consumption data required by the program.',
    `last_compliance_check_date` DATE COMMENT 'Date of the most recent compliance validation check for this enrollment. Used to track periodic audits of program participation requirements and meter data quality.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this enrollment record was most recently modified in the lakehouse silver layer. Tracks data refresh and change propagation from source systems.',
    `mdms_enrollment_reference` STRING COMMENT 'External reference identifier for this enrollment in the source MDMS (Oracle Utilities MDMS or Itron Analytics). Enables cross-system reconciliation and audit trail back to the operational system of record.',
    `meter_configuration_profile` STRING COMMENT 'Identifier or description of the meter configuration profile applied for this program enrollment. Defines register mappings, channel activations, TOU bin assignments, and other meter firmware settings required by the program.',
    `notes` STRING COMMENT 'Free-text field for operational notes, special instructions, or case-specific details related to this meter program enrollment. Used by MDMS operators and field service personnel for context and troubleshooting.',
    `program_code` STRING COMMENT 'Standardized code identifying the utility program type. Examples include TOU (Time-of-Use), CPP (Critical Peak Pricing), NEM (Net Energy Metering), DR (Demand Response), EV (Electric Vehicle) charging programs, and EE (Energy Efficiency) monitoring programs.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `program_incentive_amount` DECIMAL(18,2) COMMENT 'Monetary incentive amount in USD associated with this program enrollment. Applicable for DR, EE, and EV programs that offer enrollment bonuses, rebates, or participation payments. Null for rate-only programs.',
    `program_name` STRING COMMENT 'Full descriptive name of the utility program. Provides human-readable identification of the program for reporting and customer communication purposes.',
    `termination_date` DATE COMMENT 'Date when the program enrollment was terminated or cancelled. Populated only for enrollments with status terminated or cancelled. Marks the end of program-specific meter configuration and data collection.',
    `termination_reason_code` STRING COMMENT 'Standardized code indicating the reason for enrollment termination. Customer request indicates opt-out; Program ended indicates utility discontinued program; Non-compliance indicates customer failed to meet program requirements; Meter removed indicates physical meter change; Account closed or Moved out indicate service discontinuation.. Valid values are `customer_request|program_ended|non_compliance|meter_removed|account_closed|moved_out`',
    `termination_reason_description` STRING COMMENT 'Free-text description providing additional context or details about the enrollment termination. Supplements the termination_reason_code with case-specific information.',
    CONSTRAINT pk_meter_program_enrollment PRIMARY KEY(`meter_program_enrollment_id`)
) COMMENT 'Transactional record tracking a meters enrollment in utility programs that require metering configuration changes or special data collection — including TOU (Time-of-Use), CPP (Critical Peak Pricing), NEM (Net Energy Metering), DR (Demand Response), EV charging programs, and EE (Energy Efficiency) interval monitoring programs. Captures meter identifier, program code, enrollment effective date, end date, program-specific meter configuration requirements (e.g., TOU rate schedule, demand threshold, export channel activation), enrollment status, and the triggering customer account reference. This entity owns the metering-domain impact of program enrollment — the meter configuration changes, channel activations, and data collection requirements. Customer-level program participation and billing rate application are owned by the customer and billing domains respectively. Managed within Oracle Utilities MDMS and coordinated with Oracle CC&B / SAP IS-U.';

CREATE OR REPLACE TABLE `power_and_utilities`.`metering`.`remote_service_action` (
    `remote_service_action_id` BIGINT COMMENT 'Unique identifier for the remote service action record. Primary key for this transactional log of remote commands issued to Advanced Metering Infrastructure (AMI) capable meters.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Remote service actions (connect/disconnect/load limit) are customer service operations initiated from account context for collections enforcement, move-in/move-out processing, and payment arrangement ',
    `ami_endpoint_id` BIGINT COMMENT 'Unique identifier of the Advanced Metering Infrastructure (AMI) communication endpoint or module attached to the meter. Used by the head-end system to route commands to the specific device.',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: Remote disconnects and load limiting are subject to regulatory moratorium rules (winter/summer protections, medical certificate holds, payment plan protections). FK enables pre-execution compliance ve',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Remote connect/disconnect operations incur system and labor costs that must be allocated to cost centers for operational efficiency tracking, cost-benefit analysis of AMI investments, and rate case ju',
    `demand_response_event_id` BIGINT COMMENT 'Identifier of the demand response event that triggered the remote service action, if applicable. Links load control actions to specific Demand Response (DR) or Demand-Side Management (DSM) program events.',
    `dispatch_award_id` BIGINT COMMENT 'Foreign key linking to market.dispatch_award. Business justification: Remote disconnect/reconnect actions for DR resources must tie to dispatch awards for automated dispatch execution, performance verification, and settlement validation in demand response programs.',
    `distribution_outage_event_id` BIGINT COMMENT 'Identifier of the outage event that prompted the remote service action, if applicable. Links remote connect actions to service restoration workflows managed by the Outage Management System (OMS).',
    `meter_id` BIGINT COMMENT 'Identifier of the physical meter device to which the remote service action was directed. Links to the meter asset inventory in the metering domain.',
    `service_point_id` BIGINT COMMENT 'Identifier of the service delivery point (premise location) associated with the meter receiving the remote action. Links to the distribution service point entity.',
    `action_subtype` STRING COMMENT 'Detailed subtype or variant of the remote action, providing additional granularity beyond the primary action type. For example, disconnect may have subtypes such as non-payment, safety, or emergency.',
    `action_type` STRING COMMENT 'Type of remote service action commanded to the meter. Connect and disconnect support billing collections and safety workflows; load limit enables demand response; on-demand read supports billing validation; firmware update maintains device security and functionality. [ENUM-REF-CANDIDATE: connect|disconnect|load_limit|ping|on_demand_read|firmware_update|time_sync|configuration_change — 8 candidates stripped; promote to reference product]',
    `authorization_code` STRING COMMENT 'Security authorization or approval code required to execute the remote service action, particularly for high-risk actions such as disconnect or firmware update. Used for audit and compliance verification.',
    `billing_cycle_code` STRING COMMENT 'Billing cycle identifier associated with the service point at the time the remote action was executed. Used to correlate remote actions with billing periods for revenue assurance and dispute resolution.',
    `command_number` STRING COMMENT 'Business-facing reference number or tracking identifier for the remote service action command, used for customer service inquiries and audit trails.',
    `command_timestamp` TIMESTAMP COMMENT 'Date and time when the remote service action command was issued by the head-end system or Meter Data Management System (MDMS) to the meter endpoint. Represents the business event time of command initiation.',
    `communication_protocol` STRING COMMENT 'Network communication protocol used to transmit the remote service action command to the meter endpoint. Examples include RF mesh, cellular, PLC (power line carrier), or Wi-Fi.',
    `completion_timestamp` TIMESTAMP COMMENT 'Date and time when the remote service action workflow was fully completed, including all confirmations, callbacks, and downstream system updates. Represents the end of the action lifecycle.',
    `configuration_profile` STRING COMMENT 'Name or identifier of the configuration profile or parameter set applied to the meter when the action type is configuration change. Null for non-configuration actions.',
    `customer_notification_sent` BOOLEAN COMMENT 'Indicates whether a customer notification (email, SMS, or postal mail) was sent prior to or following the remote service action, as required by regulatory or business policy. True if notification was sent.',
    `execution_timestamp` TIMESTAMP COMMENT 'Date and time when the meter endpoint confirmed successful execution of the remote service action. Null if the action has not yet executed or failed before execution.',
    `failure_reason_code` STRING COMMENT 'Standardized code indicating the reason for command failure, if applicable. Examples include communication failure, meter offline, command rejected by meter, invalid command parameters, or security authentication failure. Null if the action succeeded.',
    `failure_reason_description` STRING COMMENT 'Human-readable description of the failure reason, providing additional context beyond the failure reason code. Used for troubleshooting and customer service inquiries.',
    `firmware_version` STRING COMMENT 'Version identifier of the firmware package deployed to the meter when the action type is firmware update. Null for non-firmware-update actions.',
    `initiating_process` STRING COMMENT 'Name or identifier of the automated business process, workflow, or batch job that triggered the remote service action. Populated when the action was system-initiated rather than user-initiated.',
    `initiating_system` STRING COMMENT 'Source system or application that originated the remote service action request. Customer Information System (CIS) for account-driven actions, Outage Management System (OMS) for restoration, Demand Response Management System (DRMS) for load control, or manual for operator-initiated commands. [ENUM-REF-CANDIDATE: cis|billing|field_ops|oms|mdms|drms|manual — 7 candidates stripped; promote to reference product]',
    `initiating_user` STRING COMMENT 'Username or employee identifier of the person who authorized or triggered the remote service action. Null if the action was triggered by an automated process or system rule.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the remote service action record was last modified in the source system. Used for incremental data ingestion and change data capture workflows.',
    `load_limit_duration_minutes` STRING COMMENT 'Duration in minutes for which the load limit is to remain in effect. Null if the load limit is indefinite or the action type is not load limit.',
    `load_limit_kw` DECIMAL(18,2) COMMENT 'Maximum power demand limit in kilowatts (kW) applied to the meter when the action type is load limit. Used for demand response programs and customer payment plan enforcement. Null for non-load-limit actions.',
    `moratorium_override_reason` STRING COMMENT 'Justification or authorization code for overriding a disconnection moratorium or regulatory protection when executing a disconnect action. Required for audit and regulatory reporting when regulatory compliance flag is true.',
    `notification_timestamp` TIMESTAMP COMMENT 'Date and time when the customer notification was sent. Null if no notification was sent or required.',
    `priority_level` STRING COMMENT 'Priority classification of the remote service action, determining queue position and retry behavior. Critical priority is used for safety disconnections and emergency load control; high priority for billing collections; normal for routine operations.. Valid values are `critical|high|normal|low`',
    `rate_schedule_code` STRING COMMENT 'Rate schedule or tariff code applicable to the service point at the time of the remote action. Used to ensure compliance with rate-specific service rules, such as Time-of-Use (TOU) or Critical Peak Pricing (CPP) program requirements.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether the remote service action was subject to regulatory compliance review or override, such as disconnection moratorium periods, medical baseline protections, or Public Utility Commission (PUC) mandated customer protections. True if compliance rules were applied or overridden.',
    `response_time_seconds` DECIMAL(18,2) COMMENT 'Elapsed time in seconds between command transmission and receipt of acknowledgment or execution confirmation from the meter endpoint. Used to measure network and meter performance.',
    `result_status` STRING COMMENT 'Outcome status of the remote service action command. Success indicates the meter executed the command as requested; failed indicates the command could not be executed; pending indicates the command is queued or in progress; timeout indicates no response was received within the expected window; cancelled indicates the command was aborted before execution.. Valid values are `success|failed|pending|timeout|cancelled|partial`',
    `retry_count` STRING COMMENT 'Number of times the head-end system attempted to execute the remote service action command after initial failure. Used to track communication reliability and meter responsiveness.',
    `scheduled_execution_timestamp` TIMESTAMP COMMENT 'Date and time when the remote action was scheduled to execute at the meter. May differ from command timestamp if the action was queued for future execution. Null if the action was intended for immediate execution.',
    `signal_strength_dbm` DECIMAL(18,2) COMMENT 'Measured signal strength in decibel-milliwatts (dBm) of the communication link between the head-end system and the meter endpoint at the time of command transmission. Used to diagnose communication failures.',
    `source_record_reference` STRING COMMENT 'Primary key or unique identifier of the remote service action record in the source operational system. Used for data lineage and reconciliation between the lakehouse and source systems.',
    `source_system` STRING COMMENT 'Name or identifier of the operational system of record that generated the remote service action log entry. Typically the Meter Data Management System (MDMS) such as Oracle Utilities MDMS or Itron Analytics.',
    `work_order_number` STRING COMMENT 'Reference to the field work order or service order that prompted the remote action, if applicable. Used to link remote commands to physical field activities such as move-in, move-out, or service restoration.',
    CONSTRAINT pk_remote_service_action PRIMARY KEY(`remote_service_action_id`)
) COMMENT 'Transactional record of remote connect/disconnect and load control commands issued to AMI-capable meters via the head-end system. Captures action type (connect/disconnect/load-limit/ping/on-demand-read/firmware-update), initiating system (CIS/billing/field-ops), command timestamp, execution timestamp, result status (success/failed/pending/timeout), failure reason code, meter identifier, endpoint identifier, authorized user or automated process reference, and regulatory compliance flag (e.g., disconnection moratorium override). Supports billing collections workflows, safety disconnections, and demand response load control. Sourced from Itron Analytics / Oracle Utilities MDMS remote command log.';

CREATE OR REPLACE TABLE `power_and_utilities`.`metering`.`meter_test` (
    `meter_test_id` BIGINT COMMENT 'Unique identifier for the meter test record. Primary key for the meter test transaction.',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: Meter testing schedules are driven by regulatory accuracy testing obligations (state PUC meter testing rules, ANSI standards). FK enables compliance tracking, audit evidence generation, and automated ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Meter testing incurs labor, facility, and equipment costs that must be allocated to cost centers for regulatory compliance cost tracking, annual budget reconciliation, and FERC reporting of meter accu',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Test expenses must post to specific GL accounts (typically FERC 920-935 Customer Accounts/Service expenses) for financial statement preparation, regulatory reporting, and audit trail compliance. Direc',
    `master_id` BIGINT COMMENT 'Identifier of the test bench, calibration equipment, or portable test device used to conduct the meter test. Critical for traceability and ensuring test equipment is within its own calibration validity period.',
    `meter_id` BIGINT COMMENT 'Identifier of the meter that was tested. Links to the meter asset record in the metering domain.',
    `work_order_id` BIGINT COMMENT 'Identifier of the work order or service request that triggered the meter test. Links the test to the broader work management context, such as a meter exchange, customer complaint investigation, or preventive maintenance program.',
    `as_found_accuracy_percent` DECIMAL(18,2) COMMENT 'Percentage error of the meter at the start of the test, before any adjustments or calibration. Represents the meters accuracy in its as-installed or as-received condition. Positive values indicate the meter is reading high (over-registration); negative values indicate the meter is reading low (under-registration).',
    `as_left_accuracy_percent` DECIMAL(18,2) COMMENT 'Percentage error of the meter at the conclusion of the test, after any adjustments or calibration. Represents the meters accuracy in its final state before being returned to service or condemned. Positive values indicate over-registration; negative values indicate under-registration.',
    `compliance_cycle_code` STRING COMMENT 'Identifier of the regulatory compliance testing cycle or program under which this test was conducted. Used to group tests for regulatory reporting to PUCs and to track compliance with mandated testing frequencies.',
    `corrective_action_taken` STRING COMMENT 'The remediation action performed as a result of the test. None indicates the meter passed without intervention; adjusted indicates the meter was recalibrated to meet standards; replaced indicates the meter was removed from service and a new meter installed; condemned indicates the meter was permanently removed from inventory; repaired indicates the meter underwent maintenance or component replacement.. Valid values are `none|adjusted|replaced|condemned|repaired`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this meter test record was first created in the system. Audit field for data lineage and record lifecycle tracking.',
    `demand_register_accuracy_percent` DECIMAL(18,2) COMMENT 'Percentage error of the demand register, which measures peak kilowatt (kW) or megawatt (MW) consumption over defined intervals. Critical for commercial and industrial customers billed on demand charges.',
    `full_load_accuracy_percent` DECIMAL(18,2) COMMENT 'Percentage error measured at full rated load (100% of meter capacity). Critical accuracy test point for validating meter performance under maximum demand conditions.',
    `light_load_accuracy_percent` DECIMAL(18,2) COMMENT 'Percentage error measured at light load (typically 10% of meter capacity). Critical accuracy test point for validating meter performance under low consumption conditions, which is common in residential applications.',
    `power_factor_test_result` STRING COMMENT 'Result of the power factor accuracy test for electric meters. Validates that the meter accurately measures energy under varying power factor conditions (lagging and leading). Not applicable for gas meters.. Valid values are `pass|fail|not-applicable`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this test was conducted to fulfill a regulatory compliance obligation mandated by state Public Utility Commissions (PUCs) or other governing bodies. True indicates the test is part of a regulatory compliance program; false indicates the test was conducted for operational or customer service reasons.',
    `source_system` STRING COMMENT 'Identifier of the operational system from which this meter test record originated. Typically Oracle WAM, IBM Maximo, or a specialized meter testing application. Used for data lineage and troubleshooting.',
    `technician_code` STRING COMMENT 'Identifier of the technician or engineer who performed the meter test. Used for quality assurance, training evaluation, and audit traceability.',
    `test_current_amperes` DECIMAL(18,2) COMMENT 'Current level (in amperes) at which the electric meter test was conducted. Used to calculate load percentage relative to meter rating. Not applicable for gas meters.',
    `test_date` DATE COMMENT 'The calendar date on which the meter test was performed. Principal business event timestamp for the test transaction.',
    `test_duration_minutes` STRING COMMENT 'Total elapsed time in minutes from test start to test completion. Used for labor cost allocation, productivity analysis, and scheduling optimization.',
    `test_facility_code` STRING COMMENT 'Identifier of the specific testing facility, laboratory, or service center where the test was conducted. Used for traceability and quality assurance.',
    `test_flow_rate` DECIMAL(18,2) COMMENT 'Gas flow rate (typically in cubic feet per hour or cubic meters per hour) at which the gas meter test was conducted. Used to calculate load percentage relative to meter capacity. Not applicable for electric meters.',
    `test_humidity_percent` DECIMAL(18,2) COMMENT 'Relative humidity percentage during the test. Humidity can affect electronic meter components and is recorded to validate test conditions were within acceptable ranges.',
    `test_location` STRING COMMENT 'Physical location category where the test was performed. Field tests occur at the installed service point; laboratory and shop tests occur in controlled testing facilities; customer-premise tests are conducted on-site during service calls; warehouse tests validate inventory before distribution.. Valid values are `field|laboratory|shop|customer-premise|warehouse`',
    `test_notes` STRING COMMENT 'Free-text field for technician observations, anomalies, special conditions, or additional context about the test. May include details about physical meter condition, environmental factors, or deviations from standard test procedures.',
    `test_number` STRING COMMENT 'Business identifier for the test event. Externally-known unique test reference number assigned by the testing system or laboratory.',
    `test_result` STRING COMMENT 'Overall outcome of the meter test. Pass indicates the meter met all accuracy and performance criteria; fail indicates the meter did not meet standards and requires corrective action; adjusted indicates the meter was recalibrated during testing and now meets standards; conditional indicates the meter passed with minor observations or limitations.. Valid values are `pass|fail|adjusted|conditional`',
    `test_standard_applied` STRING COMMENT 'The industry or regulatory standard used as the basis for the test procedure and acceptance criteria. Common standards include ANSI C12.20 for North American electric meter accuracy classes, IEC 62052-11 and IEC 62053-series for international electric meter compliance, and AGA Report No. 7 for gas meter accuracy.',
    `test_status` STRING COMMENT 'Current lifecycle state of the test transaction. Tracks the test workflow from scheduling through completion or cancellation.. Valid values are `scheduled|in-progress|completed|cancelled|failed`',
    `test_temperature` DECIMAL(18,2) COMMENT 'Ambient temperature (in degrees Celsius or Fahrenheit) during the test. Temperature can affect meter accuracy and is recorded for quality assurance and to validate test conditions were within acceptable ranges.',
    `test_timestamp` TIMESTAMP COMMENT 'Precise date and time when the meter test was conducted. Provides granular event timing for audit and sequencing purposes.',
    `test_type` STRING COMMENT 'Classification of the test based on the business trigger and context. In-service tests are conducted on meters while installed at customer premises; shop tests are performed in a controlled laboratory environment; acceptance tests validate new meter inventory before deployment; complaint-driven tests respond to customer billing disputes; periodic tests fulfill regulatory compliance schedules; calibration tests adjust meter accuracy to standard.. Valid values are `in-service|shop|acceptance|complaint-driven|periodic|calibration`',
    `test_voltage` DECIMAL(18,2) COMMENT 'Voltage level (in volts) at which the electric meter test was conducted. Must match the meters rated voltage for valid test results. Not applicable for gas meters.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this meter test record was last modified. Audit field for change tracking and data quality monitoring.',
    CONSTRAINT pk_meter_test PRIMARY KEY(`meter_test_id`)
) COMMENT 'Transactional record of accuracy and performance tests conducted on meters — both in-field and in-laboratory settings. Captures test type (in-service/shop/acceptance/complaint-driven), test date, test location (field/lab), meter identifier, test standard applied (ANSI C12.20 accuracy class for North American deployments; IEC 62052-11/62053-series for international compliance), test result (pass/fail/adjusted), percentage error at full load and light load, power factor test result, demand register accuracy, as-found and as-left accuracy readings, technician identifier, and corrective action taken (adjusted/replaced/condemned). Supports regulatory accuracy compliance reporting to PUCs (state commissions) and drives meter replacement decisions. Sourced from Oracle WAM / IBM Maximo meter test records.';

CREATE OR REPLACE TABLE `power_and_utilities`.`metering`.`daily_usage_summary` (
    `daily_usage_summary_id` BIGINT COMMENT 'Unique identifier for the daily usage summary record. Primary key for this derived entity generated by the MDMS daily aggregation process.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Daily usage summaries are billing-ready consumption aggregations that drive invoice generation, rate schedule application, budget billing calculations, and customer portal usage displays. Direct accou',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Daily summaries aggregate interval data for billing. Invoices reference these pre-aggregated summaries for performance and auditability. Essential for billing systems to trace invoice amounts back to ',
    `meter_id` BIGINT COMMENT 'Reference to the meter asset for which this daily usage summary was generated. Links to the meter inventory master data.',
    `ppa_contract_id` BIGINT COMMENT 'Foreign key linking to market.ppa_contract. Business justification: Daily aggregated generation data from PPA facilities needed for contract performance monitoring, forecasting, and monthly settlement preparation against contracted capacity and energy terms.',
    `pricing_node_id` BIGINT COMMENT 'Foreign key linking to market.pricing_node. Business justification: Daily nodal load summaries support load forecasting, congestion management, and market operations planning required by RTO/ISO for day-ahead and real-time market operations.',
    `read_cycle_id` BIGINT COMMENT 'Foreign key linking to metering.read_cycle. Business justification: Daily usage summaries are organized by read cycle for billing alignment. The summary aggregates interval data for a specific meter on a specific date, and read cycles define the billing period boundar',
    `service_point_id` BIGINT COMMENT 'Reference to the service point (premise) where the meter is installed. Links to the distribution domain service point entity.',
    `tou_schedule_id` BIGINT COMMENT 'Foreign key linking to metering.tou_schedule. Business justification: Daily usage summaries include TOU period breakdowns (on_peak_consumption, off_peak_consumption, super_off_peak_consumption) calculated using a specific TOU schedule. The tou_schedule defines the peak/',
    `actual_interval_count` STRING COMMENT 'The number of valid interval reads actually received and validated for the summary date. Used to calculate data completeness percentage and identify data quality issues.',
    `aggregation_job_reference` STRING COMMENT 'The unique identifier of the MDMS batch job that generated this summary record. Used for operational troubleshooting and reprocessing scenarios.',
    `aggregation_timestamp` TIMESTAMP COMMENT 'The date and time when this daily summary record was generated by the MDMS aggregation process. Represents the processing time, not the business event time (which is summary_date).',
    `average_temperature_f` DECIMAL(18,2) COMMENT 'The average ambient temperature in Fahrenheit for the service point location on the summary date. Used for weather normalization and load forecasting. Sourced from weather data integration.',
    `baseline_consumption` DECIMAL(18,2) COMMENT 'The calculated baseline consumption for this meter and date, used for demand response program performance measurement. Represents expected consumption absent a DR event. Expressed in the same unit as total_consumption.',
    `billing_ready_flag` BOOLEAN COMMENT 'Indicates whether this daily summary has passed all validation checks and is approved for use in billing calculations. True means the data is billing-ready; False means it requires review or correction.',
    `commodity_type` STRING COMMENT 'The type of energy commodity measured by this meter: electric or gas. Determines the applicable unit of measure and demand calculation rules.. Valid values are `electric|gas`',
    `data_completeness_percentage` DECIMAL(18,2) COMMENT 'The ratio of actual valid intervals to expected intervals, expressed as a percentage (0.00 to 100.00). Calculated as (actual_interval_count / expected_interval_count) * 100. Values below 95% typically trigger data quality alerts.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'A composite data quality score (0.00 to 100.00) calculated by the MDMS based on completeness, consistency, and validation rule pass rate. Scores below 80 typically trigger manual review.',
    `data_source_system` STRING COMMENT 'The name of the upstream MDMS or historian system that provided the interval data for this summary (e.g., Oracle Utilities MDMS, Itron Analytics, OSIsoft PI). Used for data lineage and troubleshooting.',
    `dr_event_flag` BOOLEAN COMMENT 'Indicates whether this meter participated in a demand response event on the summary date. True if a DR event occurred; False otherwise. Used to trigger load reduction calculation.',
    `estimated_interval_count` STRING COMMENT 'The number of interval reads that were estimated by the VEE (Validation, Estimation, and Editing) process due to missing or invalid raw reads. Indicates data quality and estimation reliance.',
    `expected_interval_count` STRING COMMENT 'The number of interval reads expected for the summary date based on the meters configured interval length (e.g., 96 for 15-minute intervals, 24 for hourly intervals). Used to calculate data completeness percentage.',
    `generation_kwh` DECIMAL(18,2) COMMENT 'The total energy generated and exported to the grid by customer-owned DER (e.g., rooftop solar) on the summary date. Null for non-NEM meters. Used for NEM credit calculation and REC tracking.',
    `load_reduction_kwh` DECIMAL(18,2) COMMENT 'The calculated energy reduction achieved during demand response events, measured as baseline_consumption minus total_consumption. Null if dr_event_flag is False. Used for DR program settlement.',
    `meter_read_source` STRING COMMENT 'The source system or method by which the interval data was collected: AMI (Advanced Metering Infrastructure), AMR (Automated Meter Reading), manual field read, estimated by system, or customer-provided read.. Valid values are `AMI|AMR|manual|estimated|customer_provided`',
    `net_consumption_kwh` DECIMAL(18,2) COMMENT 'The net energy consumption calculated as total_consumption minus generation_kwh for NEM meters. Represents the billable consumption after accounting for customer generation. Null for non-NEM meters.',
    `net_metering_flag` BOOLEAN COMMENT 'Indicates whether this meter is enrolled in a Net Energy Metering program (typically for solar or other DER). True if NEM-enrolled; False otherwise. Affects consumption calculation and billing logic.',
    `off_peak_consumption` DECIMAL(18,2) COMMENT 'Total consumption during off-peak hours as defined by the applicable Time-of-Use (TOU) rate schedule. Null for non-TOU meters. Expressed in the same unit as total_consumption.',
    `on_peak_consumption` DECIMAL(18,2) COMMENT 'Total consumption during on-peak hours as defined by the applicable Time-of-Use (TOU) rate schedule. Null for non-TOU meters. Expressed in the same unit as total_consumption.',
    `outage_duration_minutes` STRING COMMENT 'The total duration in minutes of all outage events affecting this meter on the summary date. Null if outage_flag is False. Used for reliability index calculation and customer credit processing.',
    `outage_flag` BOOLEAN COMMENT 'Indicates whether an outage event was recorded for this meter on the summary date. True if an outage occurred; False otherwise. Used to correlate consumption gaps with known outage events.',
    `peak_demand_kw` DECIMAL(18,2) COMMENT 'The maximum instantaneous demand in kilowatts recorded during the summary date for demand-metered accounts. Null for non-demand meters or gas meters. Used for demand billing and capacity planning.',
    `peak_demand_timestamp` TIMESTAMP COMMENT 'The precise date and time when the peak demand occurred during the summary date. Null if peak_demand_kw is null. Used for load profile analysis and demand response event correlation.',
    `power_factor` DECIMAL(18,2) COMMENT 'The average power factor (ratio of real power to apparent power) for the summary date, typically measured for commercial and industrial meters. Range 0.000 to 1.000. Used for power quality monitoring and penalty billing.',
    `rate_schedule_code` STRING COMMENT 'The tariff rate schedule code applicable to this meter on the summary date. Determines TOU period definitions, demand billing rules, and pricing structure. Links to regulatory tariff schedules.',
    `reactive_energy_kvarh` DECIMAL(18,2) COMMENT 'The total reactive energy in kilovolt-ampere reactive hours for the summary date. Measured for commercial and industrial meters to assess power quality and calculate reactive power charges.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this record was first inserted into the lakehouse silver layer. Represents the data platform ingestion time, distinct from aggregation_timestamp.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this record was last updated in the lakehouse silver layer. Used to track reprocessing and late-arriving data corrections.',
    `summary_date` DATE COMMENT 'The calendar date for which this daily consumption summary was calculated. Represents the business day of energy usage, not the aggregation processing date.',
    `super_off_peak_consumption` DECIMAL(18,2) COMMENT 'Total consumption during super off-peak hours (typically overnight) as defined by advanced TOU rate schedules. Null for meters without super off-peak pricing. Expressed in the same unit as total_consumption.',
    `temperature_adjusted_flag` BOOLEAN COMMENT 'Indicates whether the consumption values have been adjusted for temperature normalization (degree-day adjustment). Typically used for gas consumption and weather-sensitive electric loads.',
    `total_consumption` DECIMAL(18,2) COMMENT 'The total validated energy consumption for the summary date, aggregated from all interval reads. Value is expressed in the unit specified in unit_of_measure. This is the billing-ready daily total.',
    `unit_of_measure` STRING COMMENT 'The unit in which total_consumption is expressed. For electric meters: kWh (Kilowatt-Hour) or MWh (Megawatt-Hour). For gas meters: MCF (Thousand Cubic Feet) or Therm. For demand: kW or MW.. Valid values are `kWh|MWh|MCF|Therm|kW|MW`',
    `vee_rule_set_version` STRING COMMENT 'The version identifier of the VEE rule set applied during the aggregation and validation process. Used for audit trail and to track changes in validation logic over time.',
    `vee_status` STRING COMMENT 'The overall Validation, Estimation, and Editing (VEE) processing status for this daily summary. Indicates whether the data passed validation, required estimation, was manually edited, failed VEE rules, or is pending processing.. Valid values are `validated|estimated|edited|failed|pending`',
    CONSTRAINT pk_daily_usage_summary PRIMARY KEY(`daily_usage_summary_id`)
) COMMENT 'Derived daily-level consumption summary aggregated from validated interval reads for each meter, providing a billing-ready and analytics-ready daily kWh, MCF, or Therm total per meter per day. This is a computed/derived entity — not a source-of-truth transactional record — generated by the MDMS daily aggregation process. Captures meter identifier, summary date, total consumption value, unit of measure, peak demand kW (for demand-metered accounts), on-peak/off-peak/super-off-peak consumption buckets (for TOU meters), data completeness percentage (ratio of valid intervals to expected intervals), and summary generation timestamp. Serves as the primary feed to the billing domain for monthly bill calculation and to the demand response domain for baseline computation. Sourced from Oracle Utilities MDMS daily aggregation process.';

CREATE OR REPLACE TABLE `power_and_utilities`.`metering`.`meter_configuration` (
    `meter_configuration_id` BIGINT COMMENT 'Unique identifier for the meter configuration record. Primary key for this entity. Each configuration change creates a new version with a new ID.',
    `meter_id` BIGINT COMMENT 'Reference to the physical meter asset that this configuration applies to. Links to the meter asset master record in the metering domain.',
    `tariff_schedule_id` BIGINT COMMENT 'Foreign key linking to regulatory.tariff_schedule. Business justification: Meter configurations (TOU schedules, demand intervals, multipliers, loss compensation factors) must align with approved tariff structures. FK enables configuration compliance validation and supports t',
    `tou_schedule_id` BIGINT COMMENT 'Identifier of the Time-of-Use rate schedule programmed into the meter. Defines on-peak, off-peak, and shoulder periods for TOU billing. Null for flat-rate meters.',
    `vee_rule_set_id` BIGINT COMMENT 'Identifier of the VEE rule set applied to interval reads from this meter configuration. Determines which validation checks, estimation algorithms, and editing rules are applied in MDMS before data is released to billing.',
    `channel_count` STRING COMMENT 'Total number of measurement channels configured on this meter. Typically 1-4 for residential meters, more for commercial/industrial installations with multiple services or Net Energy Metering (NEM) export channels.',
    `communication_protocol` STRING COMMENT 'Protocol used for meter-to-MDMS communication. Determines data collection method and interval read retrieval mechanism.. Valid values are `ansi_c12.18|ansi_c12.22|dlms_cosem|zigbee|cellular|plc|rf_mesh`',
    `configuration_source` STRING COMMENT 'Origin of this configuration record. Indicates whether the configuration was manually entered, auto-discovered from AMI network, generated by MDMS automation, or created from a field work order.. Valid values are `manual|ami_discovery|mdms_auto|field_order|meter_exchange`',
    `configuration_status` STRING COMMENT 'Current lifecycle status of this configuration record. Active indicates the configuration is currently deployed and operational in the field.. Valid values are `active|pending|superseded|retired|failed`',
    `configuration_type` STRING COMMENT 'Classification of the meter configuration based on its primary measurement and billing capabilities. Determines which MDMS validation and estimation rules apply.. Valid values are `standard|tou|demand|interval|nem|prepay`',
    `configuration_version` STRING COMMENT 'Sequential version number for this meters configuration history. Increments with each configuration change to track evolution over time.',
    `configured_by_user_code` STRING COMMENT 'Identifier of the MDMS user or system process that created or last modified this configuration record. Used for audit trail and troubleshooting configuration issues.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this configuration record was first created in MDMS. Audit field for tracking configuration history and troubleshooting data quality issues.',
    `demand_interval_minutes` STRING COMMENT 'Length of the demand measurement interval in minutes. Common values are 15, 30, or 60 minutes. Determines the granularity of peak demand (kW/MW) calculations for billing and load analysis.',
    `demand_reset_day` STRING COMMENT 'Day of the month (1-31) when the meters demand register resets. Aligns with billing cycle start date to capture peak demand for the billing period. Critical for accurate demand charge calculation.',
    `deployment_timestamp` TIMESTAMP COMMENT 'Exact date and time when this configuration was successfully deployed to the physical meter in the field. May differ from effective_date if deployment was scheduled in advance.',
    `effective_date` DATE COMMENT 'Date when this meter configuration became active and operational in the field. Used to determine which configuration applies to interval reads at a given point in time.',
    `end_date` DATE COMMENT 'Date when this meter configuration was superseded or retired. Null for the currently active configuration. Critical for historical read interpretation.',
    `export_channel_number` STRING COMMENT 'Channel number designated for measuring energy exported to the grid. Null for non-NEM meters. Typically channel 2 or 3 for residential solar installations.',
    `firmware_version` STRING COMMENT 'Version of the firmware running on the meter at the time this configuration was deployed. Critical for troubleshooting read anomalies and ensuring compatibility with MDMS communication protocols.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this configuration record was last updated in MDMS. Tracks configuration change history and supports audit requirements.',
    `loss_compensation_factor` DECIMAL(18,2) COMMENT 'Adjustment factor applied to meter readings to compensate for energy losses in service transformers and secondary conductors. Typically 1.01 to 1.05 for residential services. Value of 1.0000 indicates no loss compensation.',
    `multiplier` DECIMAL(18,2) COMMENT 'Scaling factor applied to raw meter readings to convert to engineering units. Represents the Current Transformer (CT) and Potential Transformer (PT) ratio for high-voltage installations. Value of 1.0 for direct-connected residential meters.',
    `net_metering_enabled_flag` BOOLEAN COMMENT 'Indicates whether this meter is configured for Net Energy Metering with bidirectional measurement. True for customers with Distributed Energy Resources (DER) such as rooftop solar that export energy to the grid.',
    `notes` STRING COMMENT 'Free-text field for capturing additional context about this configuration. May include reason for configuration change, special billing instructions, or field technician observations.',
    `pulse_weight_kwh` DECIMAL(18,2) COMMENT 'Energy quantity represented by each pulse output from the meter. Used to convert pulse counts to kWh for legacy Automated Meter Reading (AMR) systems. Null for Advanced Metering Infrastructure (AMI) meters that transmit engineering units directly.',
    `read_frequency_hours` STRING COMMENT 'Scheduled frequency for automated meter reads in hours. Common values are 1 (hourly), 4 (every 4 hours), or 24 (daily). Determines how often MDMS polls the meter for interval data.',
    `register_read_resolution` STRING COMMENT 'Smallest increment the meter can measure and record, expressed in watt-hours. Typical values are 1, 10, or 100 Wh. Determines the precision of interval data and cumulative register reads.',
    `service_phase` STRING COMMENT 'Electrical phase configuration of the service. Single-phase for most residential; three-phase for commercial and industrial customers. Determines channel configuration and power calculation methods.. Valid values are `single_phase|three_phase_wye|three_phase_delta`',
    `service_voltage` STRING COMMENT 'Nominal service voltage at the meter installation point. Common values are 120, 240, 277, 480, or higher for commercial/industrial services. Used for power quality analysis and configuration validation.',
    `transformer_loss_corrected_flag` BOOLEAN COMMENT 'Indicates whether this meter configuration includes automatic correction for transformer losses. True means the meter applies loss compensation internally; False means correction is applied in MDMS or billing.',
    `validation_error_code` STRING COMMENT 'Code identifying the specific validation rule that failed, if validation_status is validation_failed. Null for validated configurations. Used for troubleshooting and configuration correction workflows.',
    `validation_status` STRING COMMENT 'Status of automated validation checks performed on this configuration. Validated indicates all business rules passed; validation_failed indicates configuration anomalies requiring review.. Valid values are `validated|pending_validation|validation_failed|override_approved`',
    CONSTRAINT pk_meter_configuration PRIMARY KEY(`meter_configuration_id`)
) COMMENT 'Master record capturing the active and historical programmed configurations of a meter as deployed in the field — distinct from the physical meter asset record and versioned over time as configurations change. Stores meter identifier, configuration effective date, configuration end date, number of channels, multiplier (CT/PT ratio), demand interval length (minutes), demand reset day, TOU schedule programmed into the meter, loss compensation factor, transformer-loss-corrected flag, net metering export channel flag, and configuration version. Note: individual channel definitions (type, UOM, direction, multiplier per channel) are owned by the meter_channel entity — this entity captures the meter-level configuration envelope and versioning. Each configuration change (e.g., adding NEM export channel, changing TOU schedule) creates a new version. Critical for ensuring MDMS reads are correctly scaled and interpreted for billing — the active configuration at the time of a read determines how raw pulse counts translate to engineering units. Managed within Oracle Utilities MDMS / Itron Analytics device configuration module.';

CREATE OR REPLACE TABLE `power_and_utilities`.`metering`.`meter_channel` (
    `meter_channel_id` BIGINT COMMENT 'Unique system identifier for the meter channel record. Primary key for the meter channel entity.',
    `meter_id` BIGINT COMMENT 'Reference to the physical meter device on which this measurement channel is configured. Links to the meter master record.',
    `service_point_id` BIGINT COMMENT 'Reference to the service point (premise delivery location) served by the meter containing this channel. Links channel data to customer account and billing context.',
    `tou_schedule_id` BIGINT COMMENT 'Reference to the TOU schedule applied to this channel for rate period segmentation. Null if TOU is not applicable.',
    `derived_from_meter_channel_id` BIGINT COMMENT 'Self-referencing FK on meter_channel (derived_from_meter_channel_id)',
    `accuracy_class` STRING COMMENT 'Metrological accuracy classification of the channel measurement capability, expressed as maximum percentage error under reference conditions. Lower values indicate higher precision.. Valid values are `0.1|0.2|0.5|1.0|2.0`',
    `activation_date` DATE COMMENT 'Date on which this channel was activated and began collecting measurement data. Used to determine the valid date range for interval and register reads.',
    `billing_determinant_flag` BOOLEAN COMMENT 'Indicates whether readings from this channel are used directly in billing calculations. When true, data quality and validation are subject to enhanced scrutiny.',
    `channel_name` STRING COMMENT 'Human-readable descriptive name for the measurement channel, such as Delivered Energy, Received Energy, Reactive Power, or Demand.',
    `channel_number` STRING COMMENT 'Sequential numeric identifier for this channel within the meter device. Typically ranges from 1 to the maximum number of channels supported by the meter model.',
    `channel_status` STRING COMMENT 'Current operational status of the meter channel. Only active channels participate in data collection and billing processes.. Valid values are `active|inactive|suspended|testing|decommissioned`',
    `channel_type` STRING COMMENT 'Classification of the measurement quantity captured by this channel. Determines the nature of the data collected and how it is used in billing and analytics. [ENUM-REF-CANDIDATE: energy|demand|reactive|power_factor|voltage|current|gas_volume|temperature — 8 candidates stripped; promote to reference product]',
    `collection_mode` STRING COMMENT 'Method by which data is collected from this channel. Interval mode captures time-series data at regular intervals; cumulative mode captures running totals; register mode captures periodic snapshots.. Valid values are `interval|cumulative|register|on_demand`',
    `commodity_type` STRING COMMENT 'Type of utility commodity measured by this channel. Determines applicable regulatory requirements and billing rules.. Valid values are `electric|gas|water|steam`',
    `configuration_timestamp` TIMESTAMP COMMENT 'Date and time when the current channel configuration was applied. Critical for correlating configuration changes with data quality issues.',
    `configuration_version` STRING COMMENT 'Version identifier for the channel configuration. Incremented when channel parameters are modified. Enables tracking of configuration changes over time.',
    `configured_by_user_code` STRING COMMENT 'Identifier of the system user or technician who last configured or modified this channel. Supports audit trail and accountability requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this meter channel record was first created in the Meter Data Management System (MDMS). Supports data lineage and audit requirements.',
    `data_quality_threshold_percent` DECIMAL(18,2) COMMENT 'Minimum acceptable data quality score percentage for readings from this channel. Readings below this threshold trigger VEE processing or manual review.',
    `deactivation_date` DATE COMMENT 'Date on which this channel was deactivated and ceased collecting measurement data. Null for currently active channels.',
    `demand_interval_minutes` STRING COMMENT 'Length of the demand measurement interval in minutes for demand channels. Common values are 15, 30, or 60 minutes. Null for non-demand channels.',
    `demand_response_eligible_flag` BOOLEAN COMMENT 'Indicates whether consumption measured by this channel is eligible for demand response program participation and curtailment event tracking.',
    `interval_length_minutes` STRING COMMENT 'Duration in minutes of each interval data collection period for interval-based channels. Typical values are 5, 15, 30, or 60 minutes for Advanced Metering Infrastructure (AMI) systems.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this meter channel record was most recently updated. Enables change tracking and data synchronization across systems.',
    `load_profile_enabled_flag` BOOLEAN COMMENT 'Indicates whether this channel participates in load profiling and load research studies. When true, interval data is retained for extended periods for analytical purposes.',
    `loss_compensation_factor` DECIMAL(18,2) COMMENT 'Adjustment factor applied to channel readings to compensate for energy losses in service transformers or distribution equipment. Used when meter is located upstream of loss-producing equipment.',
    `measurement_direction` STRING COMMENT 'Direction of energy or commodity flow measured by this channel. Critical for Net Energy Metering (NEM) applications where delivered and received energy must be tracked separately.. Valid values are `delivered|received|net|bidirectional`',
    `multiplier` DECIMAL(18,2) COMMENT 'Scaling factor applied to raw meter readings to calculate actual consumption or demand. Accounts for Current Transformer (CT) and Potential Transformer (PT) ratios in high-voltage installations.',
    `net_metering_flag` BOOLEAN COMMENT 'Indicates whether this channel is part of a Net Energy Metering configuration where customer-owned generation is netted against consumption for billing purposes.',
    `notes` STRING COMMENT 'Free-form text field for recording additional information about the channel configuration, special handling requirements, or operational considerations.',
    `phase_configuration` STRING COMMENT 'Electrical phase configuration for electric meter channels. Determines voltage and current measurement methodology and multiplier calculations.. Valid values are `single_phase|three_phase_wye|three_phase_delta|two_phase`',
    `pressure_compensation_enabled_flag` BOOLEAN COMMENT 'Indicates whether pressure compensation is applied to gas volume measurements from this channel. Required for accurate gas billing when pressure varies significantly from standard conditions.',
    `pulse_weight` DECIMAL(18,2) COMMENT 'Energy or volume quantity represented by each pulse output from the meter channel. Used for pulse-based Automated Meter Reading (AMR) systems.',
    `rate_schedule_code` STRING COMMENT 'Code identifying the tariff rate schedule applied to consumption measured by this channel. Determines pricing structure and billing calculation method.',
    `register_multiplier` DECIMAL(18,2) COMMENT 'Additional scaling factor applied to register readings for this channel. May differ from the CT/PT multiplier when register configuration requires separate adjustment.',
    `remote_disconnect_capable_flag` BOOLEAN COMMENT 'Indicates whether this channel is associated with a meter that supports remote service disconnection and reconnection commands. Relevant for credit management and demand response programs.',
    `temperature_compensation_enabled_flag` BOOLEAN COMMENT 'Indicates whether temperature compensation is applied to gas volume measurements from this channel. Required for accurate gas billing when temperature varies significantly from standard conditions.',
    `time_of_use_applicable_flag` BOOLEAN COMMENT 'Indicates whether this channel participates in Time-of-Use rate calculations. When true, interval reads from this channel are segmented by TOU period for billing.',
    `unit_of_measure` STRING COMMENT 'Standard unit in which the channel measurement is expressed. Essential for accurate billing calculations and data validation. [ENUM-REF-CANDIDATE: kWh|MWh|kW|MW|kVAR|MVAR|MCF|Therm|CCF|Volt|Amp — 11 candidates stripped; promote to reference product]',
    `vee_rule_set_code` STRING COMMENT 'Code identifying the VEE rule set applied to readings from this channel. Determines which validation, estimation, and editing rules are executed during meter data processing.',
    `voltage_class` STRING COMMENT 'Nominal voltage level at which this channel measures electric service. Critical for determining appropriate CT/PT ratios and safety protocols. [ENUM-REF-CANDIDATE: 120V|240V|480V|4160V|12470V|34500V|69000V|138000V|230000V|345000V|500000V — 11 candidates stripped; promote to reference product]',
    CONSTRAINT pk_meter_channel PRIMARY KEY(`meter_channel_id`)
) COMMENT 'Master record defining each measurement channel configured on a meter — the fundamental unit of metered data collection. Each channel represents a distinct quantity being measured (e.g., delivered kWh, received kWh, reactive kVAR, demand kW, gas MCF). Captures meter identifier, channel number, channel type (energy/demand/reactive/power-factor/voltage/current), direction (delivered/received/net), unit of measure (kWh/kW/kVAR/MCF/Therm), multiplier (CT/PT ratio applied to this channel), demand interval length (for demand channels), pulse weight, register multiplier, cumulative vs interval collection mode, TOU applicability flag, and active status. Serves as the master reference for interval_read and register_read records, ensuring each read can be traced to a defined measurement channel with known UOM and scaling. Essential for net energy metering (NEM) where delivered and received channels must be tracked separately. Managed within Oracle Utilities MDMS / Itron Analytics device configuration.';

CREATE OR REPLACE TABLE `power_and_utilities`.`metering`.`tou_schedule` (
    `tou_schedule_id` BIGINT COMMENT 'Primary key for tou_schedule',
    `superseded_by_schedule_id` BIGINT COMMENT 'Reference to the TOU schedule that replaces this schedule when it is retired or superseded. Null if this is the current active schedule.',
    `superseded_tou_schedule_id` BIGINT COMMENT 'Self-referencing FK on tou_schedule (superseded_tou_schedule_id)',
    `ami_required` BOOLEAN COMMENT 'Indicates whether an AMI smart meter is required for customers to be enrolled in this TOU schedule.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this TOU schedule record was first created in the system.',
    `critical_peak_enabled` BOOLEAN COMMENT 'Indicates whether this TOU schedule includes critical peak pricing events that can be triggered during extreme demand or supply conditions.',
    `critical_peak_max_events_per_year` STRING COMMENT 'Maximum number of critical peak pricing events that can be called in a calendar year under this TOU schedule. Null if critical peak pricing is not enabled.',
    `critical_peak_max_hours_per_event` STRING COMMENT 'Maximum duration in hours for a single critical peak pricing event. Null if critical peak pricing is not enabled.',
    `demand_window_minutes` STRING COMMENT 'Rolling window length in minutes used to calculate peak demand under this TOU schedule.',
    `effective_end_date` DATE COMMENT 'Date when this TOU schedule expires or is superseded by a new schedule. Null indicates an open-ended schedule.',
    `effective_start_date` DATE COMMENT 'Date when this TOU schedule becomes active and applicable for billing and rate calculations.',
    `holiday_treatment` STRING COMMENT 'Defines how holidays are treated in the TOU schedule, whether they follow off-peak rates, standard weekday rates, weekend rates, or a custom definition.',
    `interval_length_minutes` STRING COMMENT 'Length of the metering interval in minutes for which this TOU schedule is designed, typically 15, 30, or 60 minutes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this TOU schedule record was last updated or modified.',
    `notes` STRING COMMENT 'Additional notes or comments about this TOU schedule, including special conditions, exceptions, or implementation guidance.',
    `off_peak_period_definition` STRING COMMENT 'Textual definition of the off-peak period hours and days when the lowest rates apply under this TOU schedule.',
    `opt_in_required` BOOLEAN COMMENT 'Indicates whether customers must explicitly opt in to this TOU schedule or if it is the default schedule for the rate class.',
    `peak_period_definition` STRING COMMENT 'Textual definition of the peak demand period hours and days when the highest rates apply under this TOU schedule.',
    `rate_class` STRING COMMENT 'Customer rate class to which this TOU schedule applies, determining eligibility for the schedule.',
    `regulatory_approval_date` DATE COMMENT 'Date on which the regulatory authority approved this TOU schedule for implementation.',
    `regulatory_approval_number` STRING COMMENT 'Reference number of the regulatory filing or approval authorizing this TOU schedule, issued by the governing public utility commission.',
    `schedule_code` STRING COMMENT 'Business identifier code for the TOU schedule used in billing and rate systems. Externally-known unique code referenced in tariff documents and customer communications.',
    `schedule_description` STRING COMMENT 'Detailed description of the TOU schedule including its purpose, applicable customer segments, and rate structure overview.',
    `schedule_name` STRING COMMENT 'Human-readable name of the TOU schedule for display and reporting purposes.',
    `schedule_type` STRING COMMENT 'Classification of the TOU schedule structure indicating whether it varies by season, is year-round, or includes dynamic or critical peak pricing components.',
    `season_definition` STRING COMMENT 'Textual definition of seasonal periods if the TOU schedule varies by season, including summer, winter, and transition periods with their date ranges.',
    `service_type` STRING COMMENT 'Type of utility service for which this TOU schedule is defined, either electric or gas.',
    `shoulder_period_definition` STRING COMMENT 'Textual definition of the shoulder or mid-peak period hours and days when intermediate rates apply. Null if the schedule does not include a shoulder period.',
    `tou_schedule_status` STRING COMMENT 'Current lifecycle status of the TOU schedule indicating whether it is in use, pending approval, or has been retired.',
    `tariff_reference` STRING COMMENT 'Reference to the tariff document section or schedule number where this TOU schedule is published and documented.',
    `time_zone` STRING COMMENT 'Time zone in which the TOU schedule periods are defined, using standard time zone abbreviations.',
    `version_number` STRING COMMENT 'Version number of this TOU schedule, incremented when the schedule is revised or updated.',
    `voltage_level` STRING COMMENT 'Voltage level at which service is delivered under this TOU schedule. Applicable only for electric service.',
    `weekend_treatment` STRING COMMENT 'Defines how weekends are treated in the TOU schedule, whether they follow off-peak rates, standard rates, or a custom definition.',
    CONSTRAINT pk_tou_schedule PRIMARY KEY(`tou_schedule_id`)
) COMMENT 'Master reference table for tou_schedule. Referenced by tou_schedule_id.';

CREATE OR REPLACE TABLE `power_and_utilities`.`metering`.`vee_rule_set` (
    `vee_rule_set_id` BIGINT COMMENT 'Primary key for vee_rule_set',
    `parent_rule_set_id` BIGINT COMMENT 'Reference to the parent rule set if this rule set is a specialized variant or child of another rule set. Null for top-level rule sets.',
    `parent_vee_rule_set_id` BIGINT COMMENT 'Self-referencing FK on vee_rule_set (parent_vee_rule_set_id)',
    `applies_to_customer_class` STRING COMMENT 'Customer class this rule set applies to: residential, commercial, industrial, or all customer classes.',
    `applies_to_meter_type` STRING COMMENT 'Type of utility meters this rule set applies to: electric meters, gas meters, water meters, or all meter types.',
    `applies_to_rate_schedule` STRING COMMENT 'Specific rate schedule codes this rule set applies to. Null indicates the rule set applies to all rate schedules.',
    `approved_by` STRING COMMENT 'User identifier of the supervisor or manager who approved this VEE rule set for production use.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this VEE rule set was approved for production deployment.',
    `audit_trail_enabled` BOOLEAN COMMENT 'Indicates whether detailed audit logging is enabled for all data modifications made by this rule set.',
    `auto_correction_enabled` BOOLEAN COMMENT 'Indicates whether this rule set is authorized to automatically correct meter data without manual review.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this VEE rule set record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when this VEE rule set is retired and no longer applied to meter data processing. Null indicates the rule set is open-ended.',
    `effective_start_date` DATE COMMENT 'Date when this VEE rule set becomes active and begins being applied to meter data processing workflows.',
    `error_code_prefix` STRING COMMENT 'Prefix used for error codes generated when this rule set identifies data quality issues.',
    `estimation_method` STRING COMMENT 'Algorithm used for estimating missing or invalid meter data: linear interpolation, historical average, similar day profile, regression analysis, zero fill, or last known value.',
    `execution_sequence` STRING COMMENT 'Order in which this rule set is executed within its priority level during VEE processing workflows.',
    `last_modified_by` STRING COMMENT 'User identifier of the person who last modified this VEE rule set configuration.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this VEE rule set record was last updated.',
    `lookback_period_days` STRING COMMENT 'Number of days of historical data used for validation comparisons and estimation calculations.',
    `manual_review_required` BOOLEAN COMMENT 'Indicates whether data processed by this rule set requires manual analyst review before being released to billing systems.',
    `mdms_system_code` STRING COMMENT 'External identifier for this rule set in the source MDMS platform (Oracle Utilities MDMS or Itron Analytics).',
    `minimum_data_quality_score` DECIMAL(18,2) COMMENT 'Minimum acceptable data quality score (0-100) for meter data processed by this rule set. Data below this threshold is flagged for review.',
    `notes` STRING COMMENT 'Free-form notes and comments about this rule set including business rationale, special handling instructions, or known limitations.',
    `priority_level` STRING COMMENT 'Execution priority of the rule set when multiple rule sets are applicable. Lower numbers indicate higher priority.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this rule set is required for regulatory compliance with state public utility commission or federal energy regulatory requirements.',
    `rule_logic_expression` STRING COMMENT 'Technical expression or pseudocode defining the validation, estimation, or editing logic implemented by this rule set.',
    `rule_set_category` STRING COMMENT 'Business category of the rule set based on the type of meter data it processes: interval consumption data, register reads, demand measurements, power quality events, outage detection, or tamper detection.',
    `rule_set_code` STRING COMMENT 'Business identifier code for the VEE rule set used in meter data management systems and operational workflows.',
    `rule_set_description` STRING COMMENT 'Detailed description of the VEE rule set including its validation logic, estimation algorithms, and editing procedures.',
    `rule_set_name` STRING COMMENT 'Human-readable name of the VEE rule set describing its purpose and application context.',
    `rule_set_type` STRING COMMENT 'Classification of the rule set by its primary function: validation (data quality checks), estimation (missing data inference), editing (data correction), or composite (multiple functions).',
    `vee_rule_set_status` STRING COMMENT 'Current lifecycle status of the VEE rule set indicating whether it is actively applied to meter data processing workflows.',
    `validation_threshold_percent` DECIMAL(18,2) COMMENT 'Percentage threshold for validation rules. Data variance exceeding this threshold triggers validation failure flags.',
    `version_number` STRING COMMENT 'Semantic version number of the rule set following major.minor.patch format to track rule set evolution and changes.',
    `created_by` STRING COMMENT 'User identifier of the person who created this VEE rule set configuration.',
    CONSTRAINT pk_vee_rule_set PRIMARY KEY(`vee_rule_set_id`)
) COMMENT 'Master reference table for vee_rule_set. Referenced by vee_rule_set_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` ADD CONSTRAINT `fk_metering_meter_premise_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `power_and_utilities`.`metering`.`meter`(`meter_id`);
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` ADD CONSTRAINT `fk_metering_meter_premise_read_cycle_id` FOREIGN KEY (`read_cycle_id`) REFERENCES `power_and_utilities`.`metering`.`read_cycle`(`read_cycle_id`);
ALTER TABLE `power_and_utilities`.`metering`.`ami_endpoint` ADD CONSTRAINT `fk_metering_ami_endpoint_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `power_and_utilities`.`metering`.`meter`(`meter_id`);
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ADD CONSTRAINT `fk_metering_interval_read_meter_channel_id` FOREIGN KEY (`meter_channel_id`) REFERENCES `power_and_utilities`.`metering`.`meter_channel`(`meter_channel_id`);
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ADD CONSTRAINT `fk_metering_interval_read_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `power_and_utilities`.`metering`.`meter`(`meter_id`);
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ADD CONSTRAINT `fk_metering_interval_read_read_cycle_id` FOREIGN KEY (`read_cycle_id`) REFERENCES `power_and_utilities`.`metering`.`read_cycle`(`read_cycle_id`);
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ADD CONSTRAINT `fk_metering_interval_read_tou_schedule_id` FOREIGN KEY (`tou_schedule_id`) REFERENCES `power_and_utilities`.`metering`.`tou_schedule`(`tou_schedule_id`);
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ADD CONSTRAINT `fk_metering_register_read_meter_channel_id` FOREIGN KEY (`meter_channel_id`) REFERENCES `power_and_utilities`.`metering`.`meter_channel`(`meter_channel_id`);
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ADD CONSTRAINT `fk_metering_register_read_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `power_and_utilities`.`metering`.`meter`(`meter_id`);
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ADD CONSTRAINT `fk_metering_register_read_read_cycle_id` FOREIGN KEY (`read_cycle_id`) REFERENCES `power_and_utilities`.`metering`.`read_cycle`(`read_cycle_id`);
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ADD CONSTRAINT `fk_metering_register_read_tou_schedule_id` FOREIGN KEY (`tou_schedule_id`) REFERENCES `power_and_utilities`.`metering`.`tou_schedule`(`tou_schedule_id`);
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ADD CONSTRAINT `fk_metering_vee_event_meter_channel_id` FOREIGN KEY (`meter_channel_id`) REFERENCES `power_and_utilities`.`metering`.`meter_channel`(`meter_channel_id`);
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ADD CONSTRAINT `fk_metering_vee_event_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `power_and_utilities`.`metering`.`meter`(`meter_id`);
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ADD CONSTRAINT `fk_metering_vee_event_read_cycle_id` FOREIGN KEY (`read_cycle_id`) REFERENCES `power_and_utilities`.`metering`.`read_cycle`(`read_cycle_id`);
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ADD CONSTRAINT `fk_metering_vee_event_vee_rule_set_id` FOREIGN KEY (`vee_rule_set_id`) REFERENCES `power_and_utilities`.`metering`.`vee_rule_set`(`vee_rule_set_id`);
ALTER TABLE `power_and_utilities`.`metering`.`meter_event` ADD CONSTRAINT `fk_metering_meter_event_ami_endpoint_id` FOREIGN KEY (`ami_endpoint_id`) REFERENCES `power_and_utilities`.`metering`.`ami_endpoint`(`ami_endpoint_id`);
ALTER TABLE `power_and_utilities`.`metering`.`meter_event` ADD CONSTRAINT `fk_metering_meter_event_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `power_and_utilities`.`metering`.`meter`(`meter_id`);
ALTER TABLE `power_and_utilities`.`metering`.`read_cycle` ADD CONSTRAINT `fk_metering_read_cycle_replacement_cycle_read_cycle_id` FOREIGN KEY (`replacement_cycle_read_cycle_id`) REFERENCES `power_and_utilities`.`metering`.`read_cycle`(`read_cycle_id`);
ALTER TABLE `power_and_utilities`.`metering`.`read_cycle` ADD CONSTRAINT `fk_metering_read_cycle_vee_rule_set_id` FOREIGN KEY (`vee_rule_set_id`) REFERENCES `power_and_utilities`.`metering`.`vee_rule_set`(`vee_rule_set_id`);
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ADD CONSTRAINT `fk_metering_meter_program_enrollment_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `power_and_utilities`.`metering`.`meter`(`meter_id`);
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ADD CONSTRAINT `fk_metering_meter_program_enrollment_tou_schedule_id` FOREIGN KEY (`tou_schedule_id`) REFERENCES `power_and_utilities`.`metering`.`tou_schedule`(`tou_schedule_id`);
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ADD CONSTRAINT `fk_metering_remote_service_action_ami_endpoint_id` FOREIGN KEY (`ami_endpoint_id`) REFERENCES `power_and_utilities`.`metering`.`ami_endpoint`(`ami_endpoint_id`);
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ADD CONSTRAINT `fk_metering_remote_service_action_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `power_and_utilities`.`metering`.`meter`(`meter_id`);
ALTER TABLE `power_and_utilities`.`metering`.`meter_test` ADD CONSTRAINT `fk_metering_meter_test_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `power_and_utilities`.`metering`.`meter`(`meter_id`);
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ADD CONSTRAINT `fk_metering_daily_usage_summary_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `power_and_utilities`.`metering`.`meter`(`meter_id`);
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ADD CONSTRAINT `fk_metering_daily_usage_summary_read_cycle_id` FOREIGN KEY (`read_cycle_id`) REFERENCES `power_and_utilities`.`metering`.`read_cycle`(`read_cycle_id`);
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ADD CONSTRAINT `fk_metering_daily_usage_summary_tou_schedule_id` FOREIGN KEY (`tou_schedule_id`) REFERENCES `power_and_utilities`.`metering`.`tou_schedule`(`tou_schedule_id`);
ALTER TABLE `power_and_utilities`.`metering`.`meter_configuration` ADD CONSTRAINT `fk_metering_meter_configuration_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `power_and_utilities`.`metering`.`meter`(`meter_id`);
ALTER TABLE `power_and_utilities`.`metering`.`meter_configuration` ADD CONSTRAINT `fk_metering_meter_configuration_tou_schedule_id` FOREIGN KEY (`tou_schedule_id`) REFERENCES `power_and_utilities`.`metering`.`tou_schedule`(`tou_schedule_id`);
ALTER TABLE `power_and_utilities`.`metering`.`meter_configuration` ADD CONSTRAINT `fk_metering_meter_configuration_vee_rule_set_id` FOREIGN KEY (`vee_rule_set_id`) REFERENCES `power_and_utilities`.`metering`.`vee_rule_set`(`vee_rule_set_id`);
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ADD CONSTRAINT `fk_metering_meter_channel_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `power_and_utilities`.`metering`.`meter`(`meter_id`);
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ADD CONSTRAINT `fk_metering_meter_channel_tou_schedule_id` FOREIGN KEY (`tou_schedule_id`) REFERENCES `power_and_utilities`.`metering`.`tou_schedule`(`tou_schedule_id`);
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ADD CONSTRAINT `fk_metering_meter_channel_derived_from_meter_channel_id` FOREIGN KEY (`derived_from_meter_channel_id`) REFERENCES `power_and_utilities`.`metering`.`meter_channel`(`meter_channel_id`);
ALTER TABLE `power_and_utilities`.`metering`.`tou_schedule` ADD CONSTRAINT `fk_metering_tou_schedule_superseded_by_schedule_id` FOREIGN KEY (`superseded_by_schedule_id`) REFERENCES `power_and_utilities`.`metering`.`tou_schedule`(`tou_schedule_id`);
ALTER TABLE `power_and_utilities`.`metering`.`tou_schedule` ADD CONSTRAINT `fk_metering_tou_schedule_superseded_tou_schedule_id` FOREIGN KEY (`superseded_tou_schedule_id`) REFERENCES `power_and_utilities`.`metering`.`tou_schedule`(`tou_schedule_id`);
ALTER TABLE `power_and_utilities`.`metering`.`vee_rule_set` ADD CONSTRAINT `fk_metering_vee_rule_set_parent_rule_set_id` FOREIGN KEY (`parent_rule_set_id`) REFERENCES `power_and_utilities`.`metering`.`vee_rule_set`(`vee_rule_set_id`);
ALTER TABLE `power_and_utilities`.`metering`.`vee_rule_set` ADD CONSTRAINT `fk_metering_vee_rule_set_parent_vee_rule_set_id` FOREIGN KEY (`parent_vee_rule_set_id`) REFERENCES `power_and_utilities`.`metering`.`vee_rule_set`(`vee_rule_set_id`);

-- ========= TAGS =========
ALTER SCHEMA `power_and_utilities`.`metering` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `power_and_utilities`.`metering` SET TAGS ('dbx_domain' = 'metering');
ALTER TABLE `power_and_utilities`.`metering`.`meter` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`metering`.`meter` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Identifier (ID)');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Rate Schedule Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Master Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `participant_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Participant Registration Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `pricing_node_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Node Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `tariff_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Schedule Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `accuracy_class` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Class');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `communication_module_type` SET TAGS ('dbx_business_glossary_term' = 'Communication Module Type');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `communication_module_type` SET TAGS ('dbx_value_regex' = 'RF Mesh|PLC|Cellular|Zigbee|Wi-Fi|None');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `current_rating` SET TAGS ('dbx_business_glossary_term' = 'Current Rating (Amperes)');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `demand_capable` SET TAGS ('dbx_business_glossary_term' = 'Demand Capable');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `encryption_enabled` SET TAGS ('dbx_business_glossary_term' = 'Encryption Enabled');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `expected_useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Expected Useful Life (Years)');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `form_factor` SET TAGS ('dbx_business_glossary_term' = 'Meter Form Factor');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `fuel_type` SET TAGS ('dbx_value_regex' = 'Electric|Gas');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `installation_status` SET TAGS ('dbx_business_glossary_term' = 'Installation Status');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `installation_status` SET TAGS ('dbx_value_regex' = 'Installed|Removed|In-Stock|In-Transit|Retired|Failed');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `interval_length_minutes` SET TAGS ('dbx_business_glossary_term' = 'Interval Length (Minutes)');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `last_test_date` SET TAGS ('dbx_business_glossary_term' = 'Last Test Date');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `lifecycle_state` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle State');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `lifecycle_state` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Testing|Decommissioned');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `manufacture_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacture Date');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Meter Manufacturer');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `meter_type` SET TAGS ('dbx_business_glossary_term' = 'Meter Type');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `meter_type` SET TAGS ('dbx_value_regex' = 'AMI|AMR|Electromechanical|Electronic|Smart|Interval');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Meter Model Number');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `multiplier` SET TAGS ('dbx_business_glossary_term' = 'Meter Multiplier');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `net_metering_capable` SET TAGS ('dbx_business_glossary_term' = 'Net Metering Capable');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `next_test_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Test Due Date');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `number_of_dials` SET TAGS ('dbx_business_glossary_term' = 'Number of Dials');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `outage_detection_capable` SET TAGS ('dbx_business_glossary_term' = 'Outage Detection Capable');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'Utility-Owned|Customer-Owned');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `register_count` SET TAGS ('dbx_business_glossary_term' = 'Register Count');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `remote_disconnect_capable` SET TAGS ('dbx_business_glossary_term' = 'Remote Disconnect Capable');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `removal_date` SET TAGS ('dbx_business_glossary_term' = 'Removal Date');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Meter Serial Number');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `serial_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `tamper_detection_capable` SET TAGS ('dbx_business_glossary_term' = 'Tamper Detection Capable');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost (USD)');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `voltage_class` SET TAGS ('dbx_business_glossary_term' = 'Voltage Class');
ALTER TABLE `power_and_utilities`.`metering`.`meter` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` ALTER COLUMN `meter_premise_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Premise ID');
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account ID');
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter ID');
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Installation Work Order ID');
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` ALTER COLUMN `read_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Read Cycle Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` ALTER COLUMN `service_point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point ID');
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` ALTER COLUMN `ami_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Advanced Metering Infrastructure (AMI) Enabled Flag');
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` ALTER COLUMN `association_status` SET TAGS ('dbx_business_glossary_term' = 'Meter-Premise Association Status');
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` ALTER COLUMN `association_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|removed|suspended');
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` ALTER COLUMN `demand_metering_flag` SET TAGS ('dbx_business_glossary_term' = 'Demand Metering Flag');
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` ALTER COLUMN `effective_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective End Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` ALTER COLUMN `effective_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` ALTER COLUMN `final_register_read` SET TAGS ('dbx_business_glossary_term' = 'Final Register Read');
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` ALTER COLUMN `initial_register_read` SET TAGS ('dbx_business_glossary_term' = 'Initial Register Read');
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation Date');
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` ALTER COLUMN `installation_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Installation Reason Code');
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` ALTER COLUMN `installation_reason_code` SET TAGS ('dbx_value_regex' = 'new_service|meter_upgrade|meter_failure|ami_deployment|customer_request|move_in');
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` ALTER COLUMN `installation_technician_code` SET TAGS ('dbx_business_glossary_term' = 'Installation Technician ID');
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` ALTER COLUMN `interval_data_collection_flag` SET TAGS ('dbx_business_glossary_term' = 'Interval Data Collection Flag');
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` ALTER COLUMN `meter_accessibility` SET TAGS ('dbx_business_glossary_term' = 'Meter Accessibility');
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` ALTER COLUMN `meter_accessibility` SET TAGS ('dbx_value_regex' = 'accessible|restricted|locked|inside|outside');
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` ALTER COLUMN `meter_location_description` SET TAGS ('dbx_business_glossary_term' = 'Meter Location Description');
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` ALTER COLUMN `meter_position` SET TAGS ('dbx_business_glossary_term' = 'Meter Position');
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` ALTER COLUMN `meter_position` SET TAGS ('dbx_value_regex' = 'main|sub|check|totalizing|backup');
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` ALTER COLUMN `net_metering_flag` SET TAGS ('dbx_business_glossary_term' = 'Net Energy Metering (NEM) Flag');
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` ALTER COLUMN `rate_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Code');
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` ALTER COLUMN `read_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Read Sequence Number');
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` ALTER COLUMN `register_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Register Multiplier');
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` ALTER COLUMN `register_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Register Unit of Measure');
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` ALTER COLUMN `register_unit_of_measure` SET TAGS ('dbx_value_regex' = 'kWh|MWh|MCF|Therm|kW|MW');
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` ALTER COLUMN `remote_disconnect_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Remote Disconnect Capable Flag');
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` ALTER COLUMN `removal_date` SET TAGS ('dbx_business_glossary_term' = 'Meter Removal Date');
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` ALTER COLUMN `removal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Removal Reason Code');
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` ALTER COLUMN `removal_reason_code` SET TAGS ('dbx_value_regex' = 'service_termination|meter_upgrade|meter_failure|ami_deployment|customer_request|move_out');
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` ALTER COLUMN `removal_technician_code` SET TAGS ('dbx_business_glossary_term' = 'Removal Technician ID');
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Meter Seal Number');
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` ALTER COLUMN `service_phase` SET TAGS ('dbx_business_glossary_term' = 'Service Phase');
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` ALTER COLUMN `service_phase` SET TAGS ('dbx_value_regex' = 'single|three');
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` ALTER COLUMN `service_voltage` SET TAGS ('dbx_business_glossary_term' = 'Service Voltage');
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` ALTER COLUMN `service_voltage` SET TAGS ('dbx_value_regex' = '120V|240V|277V|480V|primary|secondary');
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` ALTER COLUMN `source_system_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` ALTER COLUMN `time_of_use_flag` SET TAGS ('dbx_business_glossary_term' = 'Time-of-Use (TOU) Flag');
ALTER TABLE `power_and_utilities`.`metering`.`ami_endpoint` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`metering`.`ami_endpoint` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `power_and_utilities`.`metering`.`ami_endpoint` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Advanced Metering Infrastructure (AMI) Endpoint Identifier');
ALTER TABLE `power_and_utilities`.`metering`.`ami_endpoint` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Identifier');
ALTER TABLE `power_and_utilities`.`metering`.`ami_endpoint` ALTER COLUMN `service_point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point Identifier');
ALTER TABLE `power_and_utilities`.`metering`.`ami_endpoint` ALTER COLUMN `authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Authentication Method');
ALTER TABLE `power_and_utilities`.`metering`.`ami_endpoint` ALTER COLUMN `authentication_method` SET TAGS ('dbx_value_regex' = 'CERTIFICATE|SHARED_KEY|TOKEN|NONE');
ALTER TABLE `power_and_utilities`.`metering`.`ami_endpoint` ALTER COLUMN `battery_level_percent` SET TAGS ('dbx_business_glossary_term' = 'Battery Level Percentage');
ALTER TABLE `power_and_utilities`.`metering`.`ami_endpoint` ALTER COLUMN `collector_node_code` SET TAGS ('dbx_business_glossary_term' = 'Collector Node Identifier');
ALTER TABLE `power_and_utilities`.`metering`.`ami_endpoint` ALTER COLUMN `commissioning_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Commissioning Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`ami_endpoint` ALTER COLUMN `communication_module_serial` SET TAGS ('dbx_business_glossary_term' = 'Communication Module Serial Number');
ALTER TABLE `power_and_utilities`.`metering`.`ami_endpoint` ALTER COLUMN `communication_module_serial` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`metering`.`ami_endpoint` ALTER COLUMN `communication_module_serial` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `power_and_utilities`.`metering`.`ami_endpoint` ALTER COLUMN `communication_status` SET TAGS ('dbx_business_glossary_term' = 'Communication Status');
ALTER TABLE `power_and_utilities`.`metering`.`ami_endpoint` ALTER COLUMN `communication_status` SET TAGS ('dbx_value_regex' = 'ACTIVE|INACTIVE|INTERMITTENT|FAILED|COMMISSIONED|DECOMMISSIONED');
ALTER TABLE `power_and_utilities`.`metering`.`ami_endpoint` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`ami_endpoint` ALTER COLUMN `data_retention_days` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Data Retention Period (Days)');
ALTER TABLE `power_and_utilities`.`metering`.`ami_endpoint` ALTER COLUMN `decommissioning_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Decommissioning Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`ami_endpoint` ALTER COLUMN `encryption_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Encryption Enabled Flag');
ALTER TABLE `power_and_utilities`.`metering`.`ami_endpoint` ALTER COLUMN `endpoint_eui` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Extended Unique Identifier (EUI)');
ALTER TABLE `power_and_utilities`.`metering`.`ami_endpoint` ALTER COLUMN `endpoint_eui` SET TAGS ('dbx_value_regex' = '^[0-9A-F]{16}$');
ALTER TABLE `power_and_utilities`.`metering`.`ami_endpoint` ALTER COLUMN `endpoint_eui` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`metering`.`ami_endpoint` ALTER COLUMN `endpoint_eui` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `power_and_utilities`.`metering`.`ami_endpoint` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Communication Module Firmware Version');
ALTER TABLE `power_and_utilities`.`metering`.`ami_endpoint` ALTER COLUMN `head_end_system_code` SET TAGS ('dbx_business_glossary_term' = 'Head-End System Identifier');
ALTER TABLE `power_and_utilities`.`metering`.`ami_endpoint` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Installation Date');
ALTER TABLE `power_and_utilities`.`metering`.`ami_endpoint` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `power_and_utilities`.`metering`.`ami_endpoint` ALTER COLUMN `ip_address` SET TAGS ('dbx_value_regex' = '^(?:[0-9]{1,3}.){3}[0-9]{1,3}$|^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$');
ALTER TABLE `power_and_utilities`.`metering`.`ami_endpoint` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`metering`.`ami_endpoint` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `power_and_utilities`.`metering`.`ami_endpoint` ALTER COLUMN `last_firmware_update_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Firmware Update Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`ami_endpoint` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`ami_endpoint` ALTER COLUMN `last_successful_communication_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Successful Communication Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`ami_endpoint` ALTER COLUMN `last_tamper_event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Tamper Event Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`ami_endpoint` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Communication Module Manufacturer Name');
ALTER TABLE `power_and_utilities`.`metering`.`ami_endpoint` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Communication Module Model Number');
ALTER TABLE `power_and_utilities`.`metering`.`ami_endpoint` ALTER COLUMN `network_hop_count` SET TAGS ('dbx_business_glossary_term' = 'Network Hop Count');
ALTER TABLE `power_and_utilities`.`metering`.`ami_endpoint` ALTER COLUMN `network_type` SET TAGS ('dbx_business_glossary_term' = 'Advanced Metering Infrastructure (AMI) Network Type');
ALTER TABLE `power_and_utilities`.`metering`.`ami_endpoint` ALTER COLUMN `network_type` SET TAGS ('dbx_value_regex' = 'RF_MESH|PLC|CELLULAR|POTS|FIXED_NETWORK|HYBRID');
ALTER TABLE `power_and_utilities`.`metering`.`ami_endpoint` ALTER COLUMN `outage_detection_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Outage Detection Enabled Flag');
ALTER TABLE `power_and_utilities`.`metering`.`ami_endpoint` ALTER COLUMN `port_number` SET TAGS ('dbx_business_glossary_term' = 'Communication Port Number');
ALTER TABLE `power_and_utilities`.`metering`.`ami_endpoint` ALTER COLUMN `read_interval_minutes` SET TAGS ('dbx_business_glossary_term' = 'Meter Read Interval (Minutes)');
ALTER TABLE `power_and_utilities`.`metering`.`ami_endpoint` ALTER COLUMN `remote_disconnect_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Remote Disconnect Capable Flag');
ALTER TABLE `power_and_utilities`.`metering`.`ami_endpoint` ALTER COLUMN `signal_strength_baseline_dbm` SET TAGS ('dbx_business_glossary_term' = 'Signal Strength Baseline (dBm)');
ALTER TABLE `power_and_utilities`.`metering`.`ami_endpoint` ALTER COLUMN `tamper_detection_flag` SET TAGS ('dbx_business_glossary_term' = 'Tamper Detection Flag');
ALTER TABLE `power_and_utilities`.`metering`.`ami_endpoint` ALTER COLUMN `time_sync_source` SET TAGS ('dbx_business_glossary_term' = 'Time Synchronization Source');
ALTER TABLE `power_and_utilities`.`metering`.`ami_endpoint` ALTER COLUMN `time_sync_source` SET TAGS ('dbx_value_regex' = 'GPS|NTP|NETWORK|INTERNAL|MANUAL');
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` SET TAGS ('dbx_subdomain' = 'consumption_operations');
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ALTER COLUMN `interval_read_id` SET TAGS ('dbx_business_glossary_term' = 'Interval Read ID');
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ALTER COLUMN `meter_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Channel Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter ID');
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ALTER COLUMN `ppa_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Ppa Contract Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ALTER COLUMN `pricing_node_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Node Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ALTER COLUMN `read_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Read Cycle Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ALTER COLUMN `service_point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point ID');
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ALTER COLUMN `tariff_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Schedule Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ALTER COLUMN `tou_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Tou Schedule Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ALTER COLUMN `baseline_consumption_value` SET TAGS ('dbx_business_glossary_term' = 'Baseline Consumption Value');
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ALTER COLUMN `billing_determinant_flag` SET TAGS ('dbx_business_glossary_term' = 'Billing Determinant Flag');
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ALTER COLUMN `collection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Collection Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ALTER COLUMN `consumption_uom` SET TAGS ('dbx_business_glossary_term' = 'Consumption Unit of Measure (UOM)');
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ALTER COLUMN `consumption_uom` SET TAGS ('dbx_value_regex' = 'kWh|MWh|MCF|Therm|CCF');
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ALTER COLUMN `consumption_value` SET TAGS ('dbx_business_glossary_term' = 'Consumption Value');
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'AMI|AMR|manual|estimated|SCADA|historian');
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ALTER COLUMN `demand_uom` SET TAGS ('dbx_business_glossary_term' = 'Demand Unit of Measure (UOM)');
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ALTER COLUMN `demand_uom` SET TAGS ('dbx_value_regex' = 'kW|MW|kVA|MVA');
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ALTER COLUMN `demand_value` SET TAGS ('dbx_business_glossary_term' = 'Demand Value');
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ALTER COLUMN `dr_event_flag` SET TAGS ('dbx_business_glossary_term' = 'Demand Response (DR) Event Flag');
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ALTER COLUMN `dst_flag` SET TAGS ('dbx_business_glossary_term' = 'Daylight Saving Time (DST) Flag');
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ALTER COLUMN `estimation_method` SET TAGS ('dbx_business_glossary_term' = 'Estimation Method');
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ALTER COLUMN `estimation_method` SET TAGS ('dbx_value_regex' = 'none|linear|profile|similar_day|regression|manual');
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ALTER COLUMN `exception_flag` SET TAGS ('dbx_business_glossary_term' = 'Exception Flag');
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ALTER COLUMN `exception_reason` SET TAGS ('dbx_business_glossary_term' = 'Exception Reason');
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ALTER COLUMN `interval_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Interval Duration (Minutes)');
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ALTER COLUMN `interval_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Interval End Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ALTER COLUMN `interval_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Interval Start Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ALTER COLUMN `load_research_flag` SET TAGS ('dbx_business_glossary_term' = 'Load Research Flag');
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ALTER COLUMN `net_consumption_value` SET TAGS ('dbx_business_glossary_term' = 'Net Consumption Value');
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ALTER COLUMN `power_factor` SET TAGS ('dbx_business_glossary_term' = 'Power Factor');
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ALTER COLUMN `power_outage_flag` SET TAGS ('dbx_business_glossary_term' = 'Power Outage Flag');
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ALTER COLUMN `reactive_energy_value` SET TAGS ('dbx_business_glossary_term' = 'Reactive Energy Value');
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ALTER COLUMN `read_quality_code` SET TAGS ('dbx_business_glossary_term' = 'Read Quality Code');
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ALTER COLUMN `read_quality_code` SET TAGS ('dbx_value_regex' = 'actual|estimated|substituted|missing|rejected');
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ALTER COLUMN `reverse_flow_flag` SET TAGS ('dbx_business_glossary_term' = 'Reverse Flow Flag');
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ALTER COLUMN `temperature_uom` SET TAGS ('dbx_business_glossary_term' = 'Temperature Unit of Measure (UOM)');
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ALTER COLUMN `temperature_uom` SET TAGS ('dbx_value_regex' = 'F|C');
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ALTER COLUMN `temperature_value` SET TAGS ('dbx_business_glossary_term' = 'Temperature Value');
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ALTER COLUMN `time_zone_code` SET TAGS ('dbx_business_glossary_term' = 'Time Zone Code');
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ALTER COLUMN `validation_rule_code` SET TAGS ('dbx_business_glossary_term' = 'Validation Rule Code');
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ALTER COLUMN `vee_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Estimation and Editing (VEE) Status');
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ALTER COLUMN `vee_status` SET TAGS ('dbx_value_regex' = 'raw|validated|estimated|edited|approved|rejected');
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ALTER COLUMN `voltage_value` SET TAGS ('dbx_business_glossary_term' = 'Voltage Value');
ALTER TABLE `power_and_utilities`.`metering`.`register_read` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities`.`metering`.`register_read` SET TAGS ('dbx_subdomain' = 'consumption_operations');
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ALTER COLUMN `register_read_id` SET TAGS ('dbx_business_glossary_term' = 'Register Read ID');
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ALTER COLUMN `meter_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Channel Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter ID');
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ALTER COLUMN `read_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Read Cycle Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ALTER COLUMN `service_point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point ID');
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ALTER COLUMN `tou_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Tou Schedule Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ALTER COLUMN `billing_determinant_flag` SET TAGS ('dbx_business_glossary_term' = 'Billing Determinant Flag');
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ALTER COLUMN `consumption_delta` SET TAGS ('dbx_business_glossary_term' = 'Consumption Delta');
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ALTER COLUMN `consumption_value` SET TAGS ('dbx_business_glossary_term' = 'Consumption Value');
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ALTER COLUMN `demand_reset_date` SET TAGS ('dbx_business_glossary_term' = 'Demand Reset Date');
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ALTER COLUMN `dial_count` SET TAGS ('dbx_business_glossary_term' = 'Dial Count');
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ALTER COLUMN `estimation_method` SET TAGS ('dbx_business_glossary_term' = 'Estimation Method');
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ALTER COLUMN `estimation_method` SET TAGS ('dbx_value_regex' = 'historical-average|same-day-last-year|pro-rata|regression|none');
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ALTER COLUMN `multiplier` SET TAGS ('dbx_business_glossary_term' = 'Meter Multiplier');
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ALTER COLUMN `pressure_compensation_factor` SET TAGS ('dbx_business_glossary_term' = 'Pressure Compensation Factor');
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ALTER COLUMN `pressure_compensation_factor` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ALTER COLUMN `pressure_compensation_factor` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ALTER COLUMN `previous_read_date` SET TAGS ('dbx_business_glossary_term' = 'Previous Read Date');
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ALTER COLUMN `previous_read_value` SET TAGS ('dbx_business_glossary_term' = 'Previous Read Value');
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ALTER COLUMN `raw_register_value` SET TAGS ('dbx_business_glossary_term' = 'Raw Register Value');
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ALTER COLUMN `read_by_user_code` SET TAGS ('dbx_business_glossary_term' = 'Read By User ID');
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ALTER COLUMN `read_by_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ALTER COLUMN `read_by_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ALTER COLUMN `read_date` SET TAGS ('dbx_business_glossary_term' = 'Read Date');
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ALTER COLUMN `read_method` SET TAGS ('dbx_business_glossary_term' = 'Read Method');
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ALTER COLUMN `read_method` SET TAGS ('dbx_value_regex' = 'AMI|AMR|manual|estimated|customer-provided');
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ALTER COLUMN `read_note` SET TAGS ('dbx_business_glossary_term' = 'Read Note');
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ALTER COLUMN `read_quality_code` SET TAGS ('dbx_business_glossary_term' = 'Read Quality Code');
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ALTER COLUMN `read_quality_code` SET TAGS ('dbx_value_regex' = 'actual|estimated|customer-read|prorated|missing|suspect');
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ALTER COLUMN `read_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Read Sequence Number');
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ALTER COLUMN `read_source_system` SET TAGS ('dbx_business_glossary_term' = 'Read Source System');
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ALTER COLUMN `read_source_system` SET TAGS ('dbx_value_regex' = 'MDMS|CIS|AMI-Head-End|Field-Device|Manual-Entry');
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ALTER COLUMN `read_status` SET TAGS ('dbx_business_glossary_term' = 'Read Status');
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ALTER COLUMN `read_status` SET TAGS ('dbx_value_regex' = 'valid|pending-validation|failed-validation|corrected|voided');
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ALTER COLUMN `read_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Read Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ALTER COLUMN `read_type` SET TAGS ('dbx_business_glossary_term' = 'Read Type');
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ALTER COLUMN `rollover_flag` SET TAGS ('dbx_business_glossary_term' = 'Rollover Flag');
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ALTER COLUMN `temperature_compensation_factor` SET TAGS ('dbx_business_glossary_term' = 'Temperature Compensation Factor');
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ALTER COLUMN `temperature_compensation_factor` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ALTER COLUMN `temperature_compensation_factor` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ALTER COLUMN `validation_rule_failures` SET TAGS ('dbx_business_glossary_term' = 'Validation Rule Failures');
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` SET TAGS ('dbx_subdomain' = 'consumption_operations');
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ALTER COLUMN `vee_event_id` SET TAGS ('dbx_business_glossary_term' = 'Validation Estimation and Editing (VEE) Event ID');
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ALTER COLUMN `bill_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle ID');
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ALTER COLUMN `bill_dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Dispute Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Field Investigation Work Order Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ALTER COLUMN `meter_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Channel Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter ID');
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ALTER COLUMN `rate_case_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ALTER COLUMN `read_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Read Cycle Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ALTER COLUMN `service_point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point ID');
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ALTER COLUMN `vee_rule_set_id` SET TAGS ('dbx_business_glossary_term' = 'Vee Rule Set Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ALTER COLUMN `analyst_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Analyst Override Flag');
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ALTER COLUMN `billing_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Billing Impact Flag');
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ALTER COLUMN `corrected_value` SET TAGS ('dbx_business_glossary_term' = 'Corrected Value');
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ALTER COLUMN `estimation_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Estimation Confidence Score');
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ALTER COLUMN `estimation_method` SET TAGS ('dbx_business_glossary_term' = 'Estimation Method');
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ALTER COLUMN `interval_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Interval Duration Minutes');
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ALTER COLUMN `measurement_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Type');
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ALTER COLUMN `measurement_type` SET TAGS ('dbx_value_regex' = 'consumption|demand|voltage|power_factor|var|reactive_power');
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ALTER COLUMN `original_raw_value` SET TAGS ('dbx_business_glossary_term' = 'Original Raw Value');
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ALTER COLUMN `override_analyst_code` SET TAGS ('dbx_business_glossary_term' = 'Override Analyst ID');
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ALTER COLUMN `override_justification` SET TAGS ('dbx_business_glossary_term' = 'Override Justification');
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ALTER COLUMN `override_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Override Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ALTER COLUMN `read_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Read End Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ALTER COLUMN `read_quality_code` SET TAGS ('dbx_business_glossary_term' = 'Read Quality Code');
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ALTER COLUMN `read_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Read Start Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'MDMS|AMI_Head_End|Manual_Entry|SCADA|Historian');
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ALTER COLUMN `validation_exception_code` SET TAGS ('dbx_business_glossary_term' = 'Validation Exception Code');
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ALTER COLUMN `validation_exception_description` SET TAGS ('dbx_business_glossary_term' = 'Validation Exception Description');
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ALTER COLUMN `vee_batch_reference` SET TAGS ('dbx_business_glossary_term' = 'VEE Batch ID');
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ALTER COLUMN `vee_event_number` SET TAGS ('dbx_business_glossary_term' = 'VEE Event Number');
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ALTER COLUMN `vee_processing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'VEE Processing Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ALTER COLUMN `vee_rule_description` SET TAGS ('dbx_business_glossary_term' = 'VEE Rule Description');
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ALTER COLUMN `vee_status` SET TAGS ('dbx_business_glossary_term' = 'VEE Status');
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ALTER COLUMN `vee_status` SET TAGS ('dbx_value_regex' = 'validated|estimated|edited|rejected|pending|manual_review');
ALTER TABLE `power_and_utilities`.`metering`.`meter_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities`.`metering`.`meter_event` SET TAGS ('dbx_subdomain' = 'consumption_operations');
ALTER TABLE `power_and_utilities`.`metering`.`meter_event` ALTER COLUMN `meter_event_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Event ID');
ALTER TABLE `power_and_utilities`.`metering`.`meter_event` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Endpoint ID');
ALTER TABLE `power_and_utilities`.`metering`.`meter_event` ALTER COLUMN `compliance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Event Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`metering`.`meter_event` ALTER COLUMN `credit_adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Adjustment Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`metering`.`meter_event` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `power_and_utilities`.`metering`.`meter_event` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter ID');
ALTER TABLE `power_and_utilities`.`metering`.`meter_event` ALTER COLUMN `service_point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point ID');
ALTER TABLE `power_and_utilities`.`metering`.`meter_event` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `power_and_utilities`.`metering`.`meter_event` ALTER COLUMN `acknowledged_by` SET TAGS ('dbx_business_glossary_term' = 'Acknowledged By');
ALTER TABLE `power_and_utilities`.`metering`.`meter_event` ALTER COLUMN `acknowledged_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledged Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`meter_event` ALTER COLUMN `acknowledgment_status` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Status');
ALTER TABLE `power_and_utilities`.`metering`.`meter_event` ALTER COLUMN `acknowledgment_status` SET TAGS ('dbx_value_regex' = 'acknowledged|unacknowledged|auto_cleared|manually_cleared');
ALTER TABLE `power_and_utilities`.`metering`.`meter_event` ALTER COLUMN `battery_level_percent` SET TAGS ('dbx_business_glossary_term' = 'Battery Level Percent');
ALTER TABLE `power_and_utilities`.`metering`.`meter_event` ALTER COLUMN `current_reading` SET TAGS ('dbx_business_glossary_term' = 'Current Reading');
ALTER TABLE `power_and_utilities`.`metering`.`meter_event` ALTER COLUMN `event_code` SET TAGS ('dbx_business_glossary_term' = 'Event Code');
ALTER TABLE `power_and_utilities`.`metering`.`meter_event` ALTER COLUMN `event_description` SET TAGS ('dbx_business_glossary_term' = 'Event Description');
ALTER TABLE `power_and_utilities`.`metering`.`meter_event` ALTER COLUMN `event_resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Event Resolution Notes');
ALTER TABLE `power_and_utilities`.`metering`.`meter_event` ALTER COLUMN `event_severity` SET TAGS ('dbx_business_glossary_term' = 'Event Severity');
ALTER TABLE `power_and_utilities`.`metering`.`meter_event` ALTER COLUMN `event_severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|informational');
ALTER TABLE `power_and_utilities`.`metering`.`meter_event` ALTER COLUMN `event_source_system` SET TAGS ('dbx_business_glossary_term' = 'Event Source System');
ALTER TABLE `power_and_utilities`.`metering`.`meter_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`meter_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `power_and_utilities`.`metering`.`meter_event` ALTER COLUMN `field_investigation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Field Investigation Required Flag');
ALTER TABLE `power_and_utilities`.`metering`.`meter_event` ALTER COLUMN `forwarded_to_oms_flag` SET TAGS ('dbx_business_glossary_term' = 'Forwarded to OMS (Outage Management System) Flag');
ALTER TABLE `power_and_utilities`.`metering`.`meter_event` ALTER COLUMN `frequency_hz` SET TAGS ('dbx_business_glossary_term' = 'Frequency (Hz)');
ALTER TABLE `power_and_utilities`.`metering`.`meter_event` ALTER COLUMN `notification_channel` SET TAGS ('dbx_business_glossary_term' = 'Notification Channel');
ALTER TABLE `power_and_utilities`.`metering`.`meter_event` ALTER COLUMN `notification_channel` SET TAGS ('dbx_value_regex' = 'email|sms|ivr|mobile_app|none');
ALTER TABLE `power_and_utilities`.`metering`.`meter_event` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `power_and_utilities`.`metering`.`meter_event` ALTER COLUMN `oms_incident_reference` SET TAGS ('dbx_business_glossary_term' = 'OMS (Outage Management System) Incident ID');
ALTER TABLE `power_and_utilities`.`metering`.`meter_event` ALTER COLUMN `outage_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Outage Duration (Minutes)');
ALTER TABLE `power_and_utilities`.`metering`.`meter_event` ALTER COLUMN `power_factor` SET TAGS ('dbx_business_glossary_term' = 'Power Factor');
ALTER TABLE `power_and_utilities`.`metering`.`meter_event` ALTER COLUMN `processed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Processed Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`meter_event` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Received Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`meter_event` ALTER COLUMN `resolved_by` SET TAGS ('dbx_business_glossary_term' = 'Resolved By');
ALTER TABLE `power_and_utilities`.`metering`.`meter_event` ALTER COLUMN `resolved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolved Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`meter_event` ALTER COLUMN `restoration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Restoration Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`meter_event` ALTER COLUMN `signal_strength_dbm` SET TAGS ('dbx_business_glossary_term' = 'Signal Strength (dBm)');
ALTER TABLE `power_and_utilities`.`metering`.`meter_event` ALTER COLUMN `tamper_count` SET TAGS ('dbx_business_glossary_term' = 'Tamper Count');
ALTER TABLE `power_and_utilities`.`metering`.`meter_event` ALTER COLUMN `voltage_reading` SET TAGS ('dbx_business_glossary_term' = 'Voltage Reading');
ALTER TABLE `power_and_utilities`.`metering`.`read_cycle` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `power_and_utilities`.`metering`.`read_cycle` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `power_and_utilities`.`metering`.`read_cycle` ALTER COLUMN `read_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Read Cycle Identifier (ID)');
ALTER TABLE `power_and_utilities`.`metering`.`read_cycle` ALTER COLUMN `replacement_cycle_read_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Cycle Identifier (ID)');
ALTER TABLE `power_and_utilities`.`metering`.`read_cycle` ALTER COLUMN `vee_rule_set_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `power_and_utilities`.`metering`.`read_cycle` ALTER COLUMN `ami_collection_window_end` SET TAGS ('dbx_business_glossary_term' = 'Advanced Metering Infrastructure (AMI) Collection Window End Time');
ALTER TABLE `power_and_utilities`.`metering`.`read_cycle` ALTER COLUMN `ami_collection_window_start` SET TAGS ('dbx_business_glossary_term' = 'Advanced Metering Infrastructure (AMI) Collection Window Start Time');
ALTER TABLE `power_and_utilities`.`metering`.`read_cycle` ALTER COLUMN `billing_cycle_alignment` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Alignment');
ALTER TABLE `power_and_utilities`.`metering`.`read_cycle` ALTER COLUMN `billing_cycle_alignment` SET TAGS ('dbx_value_regex' = 'aligned|offset|independent');
ALTER TABLE `power_and_utilities`.`metering`.`read_cycle` ALTER COLUMN `billing_cycle_day_offset` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Day Offset');
ALTER TABLE `power_and_utilities`.`metering`.`read_cycle` ALTER COLUMN `collection_method` SET TAGS ('dbx_business_glossary_term' = 'Collection Method');
ALTER TABLE `power_and_utilities`.`metering`.`read_cycle` ALTER COLUMN `collection_method` SET TAGS ('dbx_value_regex' = 'ami_automated|amr_drive_by|manual_handheld|manual_visual|remote_optical');
ALTER TABLE `power_and_utilities`.`metering`.`read_cycle` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`read_cycle` ALTER COLUMN `customer_class` SET TAGS ('dbx_business_glossary_term' = 'Customer Class');
ALTER TABLE `power_and_utilities`.`metering`.`read_cycle` ALTER COLUMN `customer_class` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|agricultural|municipal|street_lighting');
ALTER TABLE `power_and_utilities`.`metering`.`read_cycle` ALTER COLUMN `cycle_code` SET TAGS ('dbx_business_glossary_term' = 'Cycle Code');
ALTER TABLE `power_and_utilities`.`metering`.`read_cycle` ALTER COLUMN `cycle_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `power_and_utilities`.`metering`.`read_cycle` ALTER COLUMN `cycle_name` SET TAGS ('dbx_business_glossary_term' = 'Cycle Name');
ALTER TABLE `power_and_utilities`.`metering`.`read_cycle` ALTER COLUMN `cycle_type` SET TAGS ('dbx_business_glossary_term' = 'Cycle Type');
ALTER TABLE `power_and_utilities`.`metering`.`read_cycle` ALTER COLUMN `cycle_type` SET TAGS ('dbx_value_regex' = 'billing|operational|on_demand|special');
ALTER TABLE `power_and_utilities`.`metering`.`read_cycle` ALTER COLUMN `demand_response_eligible` SET TAGS ('dbx_business_glossary_term' = 'Demand Response (DR) Eligible Flag');
ALTER TABLE `power_and_utilities`.`metering`.`read_cycle` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `power_and_utilities`.`metering`.`read_cycle` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `power_and_utilities`.`metering`.`read_cycle` ALTER COLUMN `estimated_meter_count` SET TAGS ('dbx_business_glossary_term' = 'Estimated Meter Count');
ALTER TABLE `power_and_utilities`.`metering`.`read_cycle` ALTER COLUMN `geographic_zone_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Zone Code');
ALTER TABLE `power_and_utilities`.`metering`.`read_cycle` ALTER COLUMN `geographic_zone_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `power_and_utilities`.`metering`.`read_cycle` ALTER COLUMN `interval_length_minutes` SET TAGS ('dbx_business_glossary_term' = 'Interval Length in Minutes');
ALTER TABLE `power_and_utilities`.`metering`.`read_cycle` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`read_cycle` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Cycle Notes');
ALTER TABLE `power_and_utilities`.`metering`.`read_cycle` ALTER COLUMN `read_cycle_status` SET TAGS ('dbx_business_glossary_term' = 'Cycle Status');
ALTER TABLE `power_and_utilities`.`metering`.`read_cycle` ALTER COLUMN `read_cycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|archived');
ALTER TABLE `power_and_utilities`.`metering`.`read_cycle` ALTER COLUMN `read_frequency` SET TAGS ('dbx_business_glossary_term' = 'Read Frequency');
ALTER TABLE `power_and_utilities`.`metering`.`read_cycle` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `power_and_utilities`.`metering`.`read_cycle` ALTER COLUMN `route_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Route Sequence Number');
ALTER TABLE `power_and_utilities`.`metering`.`read_cycle` ALTER COLUMN `scheduled_read_day` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Read Day of Month');
ALTER TABLE `power_and_utilities`.`metering`.`read_cycle` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `power_and_utilities`.`metering`.`read_cycle` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'electric|gas|water|multi_commodity');
ALTER TABLE `power_and_utilities`.`metering`.`read_cycle` ALTER COLUMN `target_read_completion_hours` SET TAGS ('dbx_business_glossary_term' = 'Target Read Completion Hours');
ALTER TABLE `power_and_utilities`.`metering`.`read_cycle` ALTER COLUMN `time_of_use_enabled` SET TAGS ('dbx_business_glossary_term' = 'Time-of-Use (TOU) Enabled Flag');
ALTER TABLE `power_and_utilities`.`metering`.`read_cycle` ALTER COLUMN `vee_processing_required` SET TAGS ('dbx_business_glossary_term' = 'Validation Estimation and Editing (VEE) Processing Required Flag');
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` SET TAGS ('dbx_subdomain' = 'consumption_operations');
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ALTER COLUMN `meter_program_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Program Enrollment Identifier (ID)');
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Identifier (ID)');
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ALTER COLUMN `participant_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Participant Registration Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ALTER COLUMN `ppa_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Ppa Contract Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ALTER COLUMN `service_point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point Identifier (ID)');
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ALTER COLUMN `tariff_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Schedule Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ALTER COLUMN `tou_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Time-of-Use (TOU) Schedule Identifier (ID)');
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ALTER COLUMN `cis_program_reference` SET TAGS ('dbx_business_glossary_term' = 'Customer Information System (CIS) Program Reference');
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ALTER COLUMN `data_collection_requirement` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Requirement');
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ALTER COLUMN `data_collection_requirement` SET TAGS ('dbx_value_regex' = 'standard|enhanced|real_time|on_demand');
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ALTER COLUMN `demand_threshold_kw` SET TAGS ('dbx_business_glossary_term' = 'Demand Threshold Kilowatts (kW)');
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ALTER COLUMN `enrollment_activation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Activation Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ALTER COLUMN `enrollment_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Approval Date');
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Channel');
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_value_regex' = 'web_portal|mobile_app|call_center|field_service|bulk_import');
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ALTER COLUMN `enrollment_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Effective Date');
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ALTER COLUMN `enrollment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment End Date');
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ALTER COLUMN `enrollment_request_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Request Date');
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_value_regex' = 'customer_request|utility_initiative|regulatory_mandate|automatic_enrollment|pilot_program');
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'pending|active|suspended|terminated|cancelled');
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ALTER COLUMN `export_channel_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Export Channel Enabled Flag');
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ALTER COLUMN `incentive_payment_status` SET TAGS ('dbx_business_glossary_term' = 'Incentive Payment Status');
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ALTER COLUMN `incentive_payment_status` SET TAGS ('dbx_value_regex' = 'pending|approved|paid|denied|cancelled');
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ALTER COLUMN `interval_collection_frequency_minutes` SET TAGS ('dbx_business_glossary_term' = 'Interval Collection Frequency Minutes');
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ALTER COLUMN `last_compliance_check_date` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Check Date');
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ALTER COLUMN `mdms_enrollment_reference` SET TAGS ('dbx_business_glossary_term' = 'Meter Data Management System (MDMS) Enrollment Reference');
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ALTER COLUMN `meter_configuration_profile` SET TAGS ('dbx_business_glossary_term' = 'Meter Configuration Profile');
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Notes');
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ALTER COLUMN `program_incentive_amount` SET TAGS ('dbx_business_glossary_term' = 'Program Incentive Amount');
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ALTER COLUMN `program_incentive_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ALTER COLUMN `termination_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason Code');
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ALTER COLUMN `termination_reason_code` SET TAGS ('dbx_value_regex' = 'customer_request|program_ended|non_compliance|meter_removed|account_closed|moved_out');
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ALTER COLUMN `termination_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason Description');
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` SET TAGS ('dbx_subdomain' = 'consumption_operations');
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ALTER COLUMN `remote_service_action_id` SET TAGS ('dbx_business_glossary_term' = 'Remote Service Action ID');
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Endpoint ID');
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ALTER COLUMN `demand_response_event_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Response (DR) Event ID');
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ALTER COLUMN `dispatch_award_id` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Award Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ALTER COLUMN `distribution_outage_event_id` SET TAGS ('dbx_business_glossary_term' = 'Outage Event ID');
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter ID');
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ALTER COLUMN `service_point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point ID');
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ALTER COLUMN `action_subtype` SET TAGS ('dbx_business_glossary_term' = 'Action Subtype');
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Remote Action Type');
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ALTER COLUMN `authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Authorization Code');
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ALTER COLUMN `authorization_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ALTER COLUMN `billing_cycle_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Code');
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ALTER COLUMN `command_number` SET TAGS ('dbx_business_glossary_term' = 'Command Number');
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ALTER COLUMN `command_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Command Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_business_glossary_term' = 'Communication Protocol');
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ALTER COLUMN `configuration_profile` SET TAGS ('dbx_business_glossary_term' = 'Configuration Profile');
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ALTER COLUMN `customer_notification_sent` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Sent');
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ALTER COLUMN `execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Execution Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ALTER COLUMN `failure_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Failure Reason Code');
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ALTER COLUMN `failure_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Failure Reason Description');
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version');
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ALTER COLUMN `initiating_process` SET TAGS ('dbx_business_glossary_term' = 'Initiating Process');
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ALTER COLUMN `initiating_system` SET TAGS ('dbx_business_glossary_term' = 'Initiating System');
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ALTER COLUMN `initiating_user` SET TAGS ('dbx_business_glossary_term' = 'Initiating User');
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ALTER COLUMN `initiating_user` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ALTER COLUMN `load_limit_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Load Limit Duration Minutes');
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ALTER COLUMN `load_limit_kw` SET TAGS ('dbx_business_glossary_term' = 'Load Limit Kilowatts (kW)');
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ALTER COLUMN `moratorium_override_reason` SET TAGS ('dbx_business_glossary_term' = 'Moratorium Override Reason');
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ALTER COLUMN `notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ALTER COLUMN `rate_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Code');
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ALTER COLUMN `response_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Response Time Seconds');
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ALTER COLUMN `result_status` SET TAGS ('dbx_business_glossary_term' = 'Result Status');
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ALTER COLUMN `result_status` SET TAGS ('dbx_value_regex' = 'success|failed|pending|timeout|cancelled|partial');
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Retry Count');
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ALTER COLUMN `scheduled_execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Execution Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ALTER COLUMN `signal_strength_dbm` SET TAGS ('dbx_business_glossary_term' = 'Signal Strength Decibel-Milliwatts (dBm)');
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Record ID');
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `power_and_utilities`.`metering`.`meter_test` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities`.`metering`.`meter_test` SET TAGS ('dbx_subdomain' = 'consumption_operations');
ALTER TABLE `power_and_utilities`.`metering`.`meter_test` ALTER COLUMN `meter_test_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Test ID');
ALTER TABLE `power_and_utilities`.`metering`.`meter_test` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`metering`.`meter_test` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`metering`.`meter_test` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`metering`.`meter_test` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Test Equipment ID');
ALTER TABLE `power_and_utilities`.`metering`.`meter_test` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter ID');
ALTER TABLE `power_and_utilities`.`metering`.`meter_test` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `power_and_utilities`.`metering`.`meter_test` ALTER COLUMN `as_found_accuracy_percent` SET TAGS ('dbx_business_glossary_term' = 'As-Found Accuracy Percent');
ALTER TABLE `power_and_utilities`.`metering`.`meter_test` ALTER COLUMN `as_left_accuracy_percent` SET TAGS ('dbx_business_glossary_term' = 'As-Left Accuracy Percent');
ALTER TABLE `power_and_utilities`.`metering`.`meter_test` ALTER COLUMN `compliance_cycle_code` SET TAGS ('dbx_business_glossary_term' = 'Compliance Cycle ID');
ALTER TABLE `power_and_utilities`.`metering`.`meter_test` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `power_and_utilities`.`metering`.`meter_test` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_value_regex' = 'none|adjusted|replaced|condemned|repaired');
ALTER TABLE `power_and_utilities`.`metering`.`meter_test` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`meter_test` ALTER COLUMN `demand_register_accuracy_percent` SET TAGS ('dbx_business_glossary_term' = 'Demand Register Accuracy Percent');
ALTER TABLE `power_and_utilities`.`metering`.`meter_test` ALTER COLUMN `full_load_accuracy_percent` SET TAGS ('dbx_business_glossary_term' = 'Full Load Accuracy Percent');
ALTER TABLE `power_and_utilities`.`metering`.`meter_test` ALTER COLUMN `light_load_accuracy_percent` SET TAGS ('dbx_business_glossary_term' = 'Light Load Accuracy Percent');
ALTER TABLE `power_and_utilities`.`metering`.`meter_test` ALTER COLUMN `power_factor_test_result` SET TAGS ('dbx_business_glossary_term' = 'Power Factor (PF) Test Result');
ALTER TABLE `power_and_utilities`.`metering`.`meter_test` ALTER COLUMN `power_factor_test_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not-applicable');
ALTER TABLE `power_and_utilities`.`metering`.`meter_test` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `power_and_utilities`.`metering`.`meter_test` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities`.`metering`.`meter_test` ALTER COLUMN `technician_code` SET TAGS ('dbx_business_glossary_term' = 'Technician ID');
ALTER TABLE `power_and_utilities`.`metering`.`meter_test` ALTER COLUMN `test_current_amperes` SET TAGS ('dbx_business_glossary_term' = 'Test Current (Amperes)');
ALTER TABLE `power_and_utilities`.`metering`.`meter_test` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Test Date');
ALTER TABLE `power_and_utilities`.`metering`.`meter_test` ALTER COLUMN `test_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Test Duration (Minutes)');
ALTER TABLE `power_and_utilities`.`metering`.`meter_test` ALTER COLUMN `test_facility_code` SET TAGS ('dbx_business_glossary_term' = 'Test Facility ID');
ALTER TABLE `power_and_utilities`.`metering`.`meter_test` ALTER COLUMN `test_flow_rate` SET TAGS ('dbx_business_glossary_term' = 'Test Flow Rate');
ALTER TABLE `power_and_utilities`.`metering`.`meter_test` ALTER COLUMN `test_humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Test Humidity Percent');
ALTER TABLE `power_and_utilities`.`metering`.`meter_test` ALTER COLUMN `test_location` SET TAGS ('dbx_business_glossary_term' = 'Test Location');
ALTER TABLE `power_and_utilities`.`metering`.`meter_test` ALTER COLUMN `test_location` SET TAGS ('dbx_value_regex' = 'field|laboratory|shop|customer-premise|warehouse');
ALTER TABLE `power_and_utilities`.`metering`.`meter_test` ALTER COLUMN `test_notes` SET TAGS ('dbx_business_glossary_term' = 'Test Notes');
ALTER TABLE `power_and_utilities`.`metering`.`meter_test` ALTER COLUMN `test_number` SET TAGS ('dbx_business_glossary_term' = 'Test Number');
ALTER TABLE `power_and_utilities`.`metering`.`meter_test` ALTER COLUMN `test_result` SET TAGS ('dbx_business_glossary_term' = 'Test Result');
ALTER TABLE `power_and_utilities`.`metering`.`meter_test` ALTER COLUMN `test_result` SET TAGS ('dbx_value_regex' = 'pass|fail|adjusted|conditional');
ALTER TABLE `power_and_utilities`.`metering`.`meter_test` ALTER COLUMN `test_standard_applied` SET TAGS ('dbx_business_glossary_term' = 'Test Standard Applied');
ALTER TABLE `power_and_utilities`.`metering`.`meter_test` ALTER COLUMN `test_status` SET TAGS ('dbx_business_glossary_term' = 'Test Status');
ALTER TABLE `power_and_utilities`.`metering`.`meter_test` ALTER COLUMN `test_status` SET TAGS ('dbx_value_regex' = 'scheduled|in-progress|completed|cancelled|failed');
ALTER TABLE `power_and_utilities`.`metering`.`meter_test` ALTER COLUMN `test_temperature` SET TAGS ('dbx_business_glossary_term' = 'Test Temperature');
ALTER TABLE `power_and_utilities`.`metering`.`meter_test` ALTER COLUMN `test_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`meter_test` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type');
ALTER TABLE `power_and_utilities`.`metering`.`meter_test` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'in-service|shop|acceptance|complaint-driven|periodic|calibration');
ALTER TABLE `power_and_utilities`.`metering`.`meter_test` ALTER COLUMN `test_voltage` SET TAGS ('dbx_business_glossary_term' = 'Test Voltage');
ALTER TABLE `power_and_utilities`.`metering`.`meter_test` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` SET TAGS ('dbx_subdomain' = 'consumption_operations');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ALTER COLUMN `daily_usage_summary_id` SET TAGS ('dbx_business_glossary_term' = 'Daily Usage Summary ID');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter ID');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ALTER COLUMN `ppa_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Ppa Contract Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ALTER COLUMN `pricing_node_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Node Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ALTER COLUMN `read_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Read Cycle Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ALTER COLUMN `service_point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point ID');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ALTER COLUMN `tou_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Tou Schedule Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ALTER COLUMN `actual_interval_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Interval Count');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ALTER COLUMN `aggregation_job_reference` SET TAGS ('dbx_business_glossary_term' = 'Aggregation Job ID');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ALTER COLUMN `aggregation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Aggregation Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ALTER COLUMN `average_temperature_f` SET TAGS ('dbx_business_glossary_term' = 'Average Temperature (Fahrenheit)');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ALTER COLUMN `baseline_consumption` SET TAGS ('dbx_business_glossary_term' = 'Baseline Consumption');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ALTER COLUMN `billing_ready_flag` SET TAGS ('dbx_business_glossary_term' = 'Billing Ready Flag');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ALTER COLUMN `commodity_type` SET TAGS ('dbx_value_regex' = 'electric|gas');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ALTER COLUMN `data_completeness_percentage` SET TAGS ('dbx_business_glossary_term' = 'Data Completeness Percentage');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ALTER COLUMN `dr_event_flag` SET TAGS ('dbx_business_glossary_term' = 'Demand Response (DR) Event Flag');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ALTER COLUMN `estimated_interval_count` SET TAGS ('dbx_business_glossary_term' = 'Estimated Interval Count');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ALTER COLUMN `expected_interval_count` SET TAGS ('dbx_business_glossary_term' = 'Expected Interval Count');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ALTER COLUMN `generation_kwh` SET TAGS ('dbx_business_glossary_term' = 'Generation (kWh)');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ALTER COLUMN `load_reduction_kwh` SET TAGS ('dbx_business_glossary_term' = 'Load Reduction (kWh)');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ALTER COLUMN `meter_read_source` SET TAGS ('dbx_business_glossary_term' = 'Meter Read Source');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ALTER COLUMN `meter_read_source` SET TAGS ('dbx_value_regex' = 'AMI|AMR|manual|estimated|customer_provided');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ALTER COLUMN `net_consumption_kwh` SET TAGS ('dbx_business_glossary_term' = 'Net Consumption (kWh)');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ALTER COLUMN `net_metering_flag` SET TAGS ('dbx_business_glossary_term' = 'Net Energy Metering (NEM) Flag');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ALTER COLUMN `off_peak_consumption` SET TAGS ('dbx_business_glossary_term' = 'Off-Peak Consumption');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ALTER COLUMN `on_peak_consumption` SET TAGS ('dbx_business_glossary_term' = 'On-Peak Consumption');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ALTER COLUMN `outage_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Outage Duration (Minutes)');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ALTER COLUMN `outage_flag` SET TAGS ('dbx_business_glossary_term' = 'Outage Flag');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ALTER COLUMN `peak_demand_kw` SET TAGS ('dbx_business_glossary_term' = 'Peak Demand (kW)');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ALTER COLUMN `peak_demand_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Peak Demand Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ALTER COLUMN `power_factor` SET TAGS ('dbx_business_glossary_term' = 'Power Factor');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ALTER COLUMN `rate_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Code');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ALTER COLUMN `reactive_energy_kvarh` SET TAGS ('dbx_business_glossary_term' = 'Reactive Energy (kVArh)');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ALTER COLUMN `summary_date` SET TAGS ('dbx_business_glossary_term' = 'Summary Date');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ALTER COLUMN `super_off_peak_consumption` SET TAGS ('dbx_business_glossary_term' = 'Super Off-Peak Consumption');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ALTER COLUMN `temperature_adjusted_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Adjusted Flag');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ALTER COLUMN `total_consumption` SET TAGS ('dbx_business_glossary_term' = 'Total Consumption');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kWh|MWh|MCF|Therm|kW|MW');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ALTER COLUMN `vee_rule_set_version` SET TAGS ('dbx_business_glossary_term' = 'VEE Rule Set Version');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ALTER COLUMN `vee_status` SET TAGS ('dbx_business_glossary_term' = 'VEE Status');
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ALTER COLUMN `vee_status` SET TAGS ('dbx_value_regex' = 'validated|estimated|edited|failed|pending');
ALTER TABLE `power_and_utilities`.`metering`.`meter_configuration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`metering`.`meter_configuration` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `power_and_utilities`.`metering`.`meter_configuration` ALTER COLUMN `meter_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Configuration ID');
ALTER TABLE `power_and_utilities`.`metering`.`meter_configuration` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter ID');
ALTER TABLE `power_and_utilities`.`metering`.`meter_configuration` ALTER COLUMN `tariff_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Schedule Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`metering`.`meter_configuration` ALTER COLUMN `tou_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Time-of-Use (TOU) Schedule ID');
ALTER TABLE `power_and_utilities`.`metering`.`meter_configuration` ALTER COLUMN `vee_rule_set_id` SET TAGS ('dbx_business_glossary_term' = 'Validation Estimation and Editing (VEE) Rule Set ID');
ALTER TABLE `power_and_utilities`.`metering`.`meter_configuration` ALTER COLUMN `channel_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Channels');
ALTER TABLE `power_and_utilities`.`metering`.`meter_configuration` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_business_glossary_term' = 'Communication Protocol');
ALTER TABLE `power_and_utilities`.`metering`.`meter_configuration` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_value_regex' = 'ansi_c12.18|ansi_c12.22|dlms_cosem|zigbee|cellular|plc|rf_mesh');
ALTER TABLE `power_and_utilities`.`metering`.`meter_configuration` ALTER COLUMN `configuration_source` SET TAGS ('dbx_business_glossary_term' = 'Configuration Source');
ALTER TABLE `power_and_utilities`.`metering`.`meter_configuration` ALTER COLUMN `configuration_source` SET TAGS ('dbx_value_regex' = 'manual|ami_discovery|mdms_auto|field_order|meter_exchange');
ALTER TABLE `power_and_utilities`.`metering`.`meter_configuration` ALTER COLUMN `configuration_status` SET TAGS ('dbx_business_glossary_term' = 'Configuration Status');
ALTER TABLE `power_and_utilities`.`metering`.`meter_configuration` ALTER COLUMN `configuration_status` SET TAGS ('dbx_value_regex' = 'active|pending|superseded|retired|failed');
ALTER TABLE `power_and_utilities`.`metering`.`meter_configuration` ALTER COLUMN `configuration_type` SET TAGS ('dbx_business_glossary_term' = 'Configuration Type');
ALTER TABLE `power_and_utilities`.`metering`.`meter_configuration` ALTER COLUMN `configuration_type` SET TAGS ('dbx_value_regex' = 'standard|tou|demand|interval|nem|prepay');
ALTER TABLE `power_and_utilities`.`metering`.`meter_configuration` ALTER COLUMN `configuration_version` SET TAGS ('dbx_business_glossary_term' = 'Configuration Version Number');
ALTER TABLE `power_and_utilities`.`metering`.`meter_configuration` ALTER COLUMN `configured_by_user_code` SET TAGS ('dbx_business_glossary_term' = 'Configured By User ID');
ALTER TABLE `power_and_utilities`.`metering`.`meter_configuration` ALTER COLUMN `configured_by_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`metering`.`meter_configuration` ALTER COLUMN `configured_by_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities`.`metering`.`meter_configuration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`meter_configuration` ALTER COLUMN `demand_interval_minutes` SET TAGS ('dbx_business_glossary_term' = 'Demand Interval Length in Minutes');
ALTER TABLE `power_and_utilities`.`metering`.`meter_configuration` ALTER COLUMN `demand_reset_day` SET TAGS ('dbx_business_glossary_term' = 'Demand Reset Day of Month');
ALTER TABLE `power_and_utilities`.`metering`.`meter_configuration` ALTER COLUMN `deployment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Configuration Deployment Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`meter_configuration` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Configuration Effective Date');
ALTER TABLE `power_and_utilities`.`metering`.`meter_configuration` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Configuration End Date');
ALTER TABLE `power_and_utilities`.`metering`.`meter_configuration` ALTER COLUMN `export_channel_number` SET TAGS ('dbx_business_glossary_term' = 'Export Channel Number');
ALTER TABLE `power_and_utilities`.`metering`.`meter_configuration` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Meter Firmware Version');
ALTER TABLE `power_and_utilities`.`metering`.`meter_configuration` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`meter_configuration` ALTER COLUMN `loss_compensation_factor` SET TAGS ('dbx_business_glossary_term' = 'Loss Compensation Factor');
ALTER TABLE `power_and_utilities`.`metering`.`meter_configuration` ALTER COLUMN `loss_compensation_factor` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`metering`.`meter_configuration` ALTER COLUMN `loss_compensation_factor` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities`.`metering`.`meter_configuration` ALTER COLUMN `multiplier` SET TAGS ('dbx_business_glossary_term' = 'Meter Multiplier');
ALTER TABLE `power_and_utilities`.`metering`.`meter_configuration` ALTER COLUMN `net_metering_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Net Energy Metering (NEM) Enabled Flag');
ALTER TABLE `power_and_utilities`.`metering`.`meter_configuration` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Configuration Notes');
ALTER TABLE `power_and_utilities`.`metering`.`meter_configuration` ALTER COLUMN `pulse_weight_kwh` SET TAGS ('dbx_business_glossary_term' = 'Pulse Weight in Kilowatt-Hours (kWh)');
ALTER TABLE `power_and_utilities`.`metering`.`meter_configuration` ALTER COLUMN `read_frequency_hours` SET TAGS ('dbx_business_glossary_term' = 'Read Frequency in Hours');
ALTER TABLE `power_and_utilities`.`metering`.`meter_configuration` ALTER COLUMN `register_read_resolution` SET TAGS ('dbx_business_glossary_term' = 'Register Read Resolution in Watt-Hours');
ALTER TABLE `power_and_utilities`.`metering`.`meter_configuration` ALTER COLUMN `service_phase` SET TAGS ('dbx_business_glossary_term' = 'Service Phase Configuration');
ALTER TABLE `power_and_utilities`.`metering`.`meter_configuration` ALTER COLUMN `service_phase` SET TAGS ('dbx_value_regex' = 'single_phase|three_phase_wye|three_phase_delta');
ALTER TABLE `power_and_utilities`.`metering`.`meter_configuration` ALTER COLUMN `service_voltage` SET TAGS ('dbx_business_glossary_term' = 'Service Voltage in Volts');
ALTER TABLE `power_and_utilities`.`metering`.`meter_configuration` ALTER COLUMN `transformer_loss_corrected_flag` SET TAGS ('dbx_business_glossary_term' = 'Transformer Loss Corrected Flag');
ALTER TABLE `power_and_utilities`.`metering`.`meter_configuration` ALTER COLUMN `validation_error_code` SET TAGS ('dbx_business_glossary_term' = 'Validation Error Code');
ALTER TABLE `power_and_utilities`.`metering`.`meter_configuration` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Configuration Validation Status');
ALTER TABLE `power_and_utilities`.`metering`.`meter_configuration` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'validated|pending_validation|validation_failed|override_approved');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `meter_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Channel Identifier (ID)');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Identifier (ID)');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `service_point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point Identifier (ID)');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `tou_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Time-of-Use (TOU) Schedule Identifier (ID)');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `derived_from_meter_channel_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `accuracy_class` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Class');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `accuracy_class` SET TAGS ('dbx_value_regex' = '0.1|0.2|0.5|1.0|2.0');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Channel Activation Date');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `billing_determinant_flag` SET TAGS ('dbx_business_glossary_term' = 'Billing Determinant Flag');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `channel_name` SET TAGS ('dbx_business_glossary_term' = 'Channel Name');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `channel_number` SET TAGS ('dbx_business_glossary_term' = 'Channel Number');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `channel_status` SET TAGS ('dbx_business_glossary_term' = 'Channel Status');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `channel_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|testing|decommissioned');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Type');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `collection_mode` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Mode');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `collection_mode` SET TAGS ('dbx_value_regex' = 'interval|cumulative|register|on_demand');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `commodity_type` SET TAGS ('dbx_value_regex' = 'electric|gas|water|steam');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `configuration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Configuration Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `configuration_version` SET TAGS ('dbx_business_glossary_term' = 'Configuration Version');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `configured_by_user_code` SET TAGS ('dbx_business_glossary_term' = 'Configured By User Identifier (ID)');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `configured_by_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `configured_by_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `data_quality_threshold_percent` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Threshold Percentage');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Channel Deactivation Date');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `demand_interval_minutes` SET TAGS ('dbx_business_glossary_term' = 'Demand Interval Minutes');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `demand_response_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Demand Response (DR) Eligible Flag');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `interval_length_minutes` SET TAGS ('dbx_business_glossary_term' = 'Interval Length Minutes');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `load_profile_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Load Profile Enabled Flag');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `loss_compensation_factor` SET TAGS ('dbx_business_glossary_term' = 'Loss Compensation Factor');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `loss_compensation_factor` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `loss_compensation_factor` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `measurement_direction` SET TAGS ('dbx_business_glossary_term' = 'Measurement Direction');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `measurement_direction` SET TAGS ('dbx_value_regex' = 'delivered|received|net|bidirectional');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `multiplier` SET TAGS ('dbx_business_glossary_term' = 'Channel Multiplier');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `net_metering_flag` SET TAGS ('dbx_business_glossary_term' = 'Net Energy Metering (NEM) Flag');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Channel Notes');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `phase_configuration` SET TAGS ('dbx_business_glossary_term' = 'Phase Configuration');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `phase_configuration` SET TAGS ('dbx_value_regex' = 'single_phase|three_phase_wye|three_phase_delta|two_phase');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `pressure_compensation_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Pressure Compensation Enabled Flag');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `pressure_compensation_enabled_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `pressure_compensation_enabled_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `pulse_weight` SET TAGS ('dbx_business_glossary_term' = 'Pulse Weight');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `rate_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Code');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `register_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Register Multiplier');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `remote_disconnect_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Remote Disconnect Capable Flag');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `temperature_compensation_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Compensation Enabled Flag');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `temperature_compensation_enabled_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `temperature_compensation_enabled_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `time_of_use_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Time-of-Use (TOU) Applicable Flag');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `vee_rule_set_code` SET TAGS ('dbx_business_glossary_term' = 'Validation Estimation and Editing (VEE) Rule Set Code');
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ALTER COLUMN `voltage_class` SET TAGS ('dbx_business_glossary_term' = 'Voltage Class');
ALTER TABLE `power_and_utilities`.`metering`.`tou_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`metering`.`tou_schedule` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `power_and_utilities`.`metering`.`tou_schedule` ALTER COLUMN `tou_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Tou Schedule Identifier');
ALTER TABLE `power_and_utilities`.`metering`.`tou_schedule` ALTER COLUMN `superseded_tou_schedule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities`.`metering`.`vee_rule_set` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`metering`.`vee_rule_set` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `power_and_utilities`.`metering`.`vee_rule_set` ALTER COLUMN `vee_rule_set_id` SET TAGS ('dbx_business_glossary_term' = 'Vee Rule Set Identifier');
ALTER TABLE `power_and_utilities`.`metering`.`vee_rule_set` ALTER COLUMN `parent_vee_rule_set_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities`.`metering`.`vee_rule_set` ALTER COLUMN `approved_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`metering`.`vee_rule_set` ALTER COLUMN `approved_by` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `power_and_utilities`.`metering`.`vee_rule_set` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`metering`.`vee_rule_set` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `power_and_utilities`.`metering`.`vee_rule_set` ALTER COLUMN `created_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`metering`.`vee_rule_set` ALTER COLUMN `created_by` SET TAGS ('dbx_pii_identifier' = 'true');
