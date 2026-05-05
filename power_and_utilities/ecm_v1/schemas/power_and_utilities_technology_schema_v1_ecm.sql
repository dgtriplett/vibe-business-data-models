-- Schema for Domain: technology | Business: Power and Utilities | Version: v1_ecm
-- Generated on: 2026-05-05 03:11:20

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `power_and_utilities_v2`.`technology` COMMENT 'Manages IT and OT infrastructure, cybersecurity programs, network assets, SCADA/EMS system configurations, and digital platform lifecycle for the utility. Covers IT asset management, OT/IT convergence, application portfolio, and technology project delivery.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `power_and_utilities_v2`.`technology`.`it_asset` (
    `it_asset_id` BIGINT COMMENT 'System-generated unique identifier for the IT asset record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for capital budgeting: IT asset expenses are charged to a cost center for depreciation and financial reporting.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to property.facility. Business justification: IT Asset Management must know which building houses each server for security audits and physical access control.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: IT assets are capitalized as fixed assets to enable depreciation tracking and regulatory reporting.',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to property.parcel. Business justification: Regulatory compliance requires reporting of IT asset locations by land parcel for environmental and data‑privacy statutes.',
    `replaced_it_asset_id` BIGINT COMMENT 'Self-referencing FK on it_asset (replaced_it_asset_id)',
    `asset_class` STRING COMMENT 'High‑level classification of the asset (hardware, software, virtual, or service).. Valid values are `hardware|software|virtual|service`',
    `asset_compliance_status` STRING COMMENT 'Regulatory or internal compliance status of the asset.. Valid values are `compliant|non_compliant|exempt`',
    `asset_condition` STRING COMMENT 'Current physical condition of the asset.. Valid values are `new|good|fair|poor`',
    `asset_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the asset record was first created in the system.',
    `asset_description` STRING COMMENT 'Free‑form description of the assets purpose and characteristics.',
    `asset_name` STRING COMMENT 'Human‑readable name or label for the IT asset.',
    `asset_tag` STRING COMMENT 'Unique tag assigned to the asset for inventory tracking.',
    `asset_tags` STRING COMMENT 'Comma‑separated list of user‑defined tags for categorization.',
    `asset_type` STRING COMMENT 'Specific type of IT asset, such as server, workstation, laptop, network device, storage, or software application.. Valid values are `server|workstation|laptop|network_device|storage|software_application`',
    `asset_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the asset record.',
    `backup_status` STRING COMMENT 'Indicates whether the asset is included in backup processes.. Valid values are `backed_up|not_backed_up`',
    `cpu_spec` STRING COMMENT 'Processor model and speed details.',
    `current_book_value` DECIMAL(18,2) COMMENT 'Current accounting book value after depreciation.',
    `department` STRING COMMENT 'Organizational department responsible for the asset.',
    `deployment_date` DATE COMMENT 'Date the asset was first deployed into production.',
    `depreciation_method` STRING COMMENT 'Method used to calculate depreciation for the asset.. Valid values are `straight_line|declining_balance|units_of_production`',
    `depreciation_start_date` DATE COMMENT 'Date depreciation calculations began.',
    `disposal_date` DATE COMMENT 'Date the asset was physically disposed of.',
    `disposal_method` STRING COMMENT 'Method used to dispose of the asset (e.g., recycle, donate).',
    `encryption_status` STRING COMMENT 'Indicates whether data at rest on the asset is encrypted.. Valid values are `encrypted|not_encrypted`',
    `end_of_life_plan` STRING COMMENT 'Planned disposition approach for the asset at end of life.',
    `ip_address` STRING COMMENT 'Network IP address assigned to the asset.',
    `last_patch_date` DATE COMMENT 'Date the most recent security patch was applied.',
    `license_key` STRING COMMENT 'Software license key or entitlement identifier.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle stage of the asset.. Valid values are `ordered|deployed|in_service|retired|disposed`',
    `mac_address` STRING COMMENT 'Hardware MAC address of the network interface.',
    `maintenance_expiration_date` DATE COMMENT 'Date the assets maintenance contract expires.',
    `manufacturer` STRING COMMENT 'Company that produced the IT asset.',
    `memory_gb` STRING COMMENT 'Installed memory capacity in gigabytes.',
    `model` STRING COMMENT 'Model designation or number of the asset.',
    `operating_system` STRING COMMENT 'Operating system installed on the asset (if applicable).',
    `owner` STRING COMMENT 'Name of the person or team that owns the asset.',
    `purchase_date` DATE COMMENT 'Date the asset was purchased from the vendor.',
    `purchase_price` DECIMAL(18,2) COMMENT 'Original purchase price of the asset in USD.',
    `retirement_date` DATE COMMENT 'Date the asset was retired from service, if applicable.',
    `retirement_reason` STRING COMMENT 'Reason for retiring the asset from service.',
    `security_classification` STRING COMMENT 'Information security classification for the asset.. Valid values are `public|internal|confidential|restricted`',
    `serial_number` STRING COMMENT 'Manufacturer‑provided serial number of the hardware component.',
    `software_version` STRING COMMENT 'Version identifier of installed software (if applicable).',
    `storage_gb` STRING COMMENT 'Total storage capacity in gigabytes.',
    `warranty_expiration_date` DATE COMMENT 'Date the manufacturer or vendor warranty expires.',
    CONSTRAINT pk_it_asset PRIMARY KEY(`it_asset_id`)
) COMMENT 'Master record for every IT hardware and software asset owned or managed by the utility, including servers, workstations, laptops, network devices, storage arrays, and licensed software. Captures asset tag, serial number, manufacturer, model, asset class (hardware/software/virtual), lifecycle state (ordered, deployed, in-service, retired), assigned cost center, physical location, and warranty expiration. Serves as the SSOT for IT asset inventory distinct from the operational technology (OT) asset registry in the asset domain.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`technology`.`ot_asset` (
    `ot_asset_id` BIGINT COMMENT 'System-generated unique identifier for the OT asset record.',
    `location_id` BIGINT COMMENT 'Reference to the geographic location record where the asset is installed.',
    `scada_system_id` BIGINT COMMENT 'Identifier of the control system (e.g., DMS, EMS) that the OT asset belongs to.',
    `replaced_ot_asset_id` BIGINT COMMENT 'Self-referencing FK on ot_asset (replaced_ot_asset_id)',
    `asset_category` STRING COMMENT 'High‑level functional domain the OT asset supports.. Valid values are `generation|transmission|distribution|substation|control_center`',
    `asset_name` STRING COMMENT 'Human‑readable name of the OT device as used by operations staff.',
    `asset_status` STRING COMMENT 'Real‑time operational state of the OT device.. Valid values are `online|offline|faulted|maintenance`',
    `asset_tag` STRING COMMENT 'Unique tag or code assigned to the OT asset for inventory and tracking.',
    `asset_type` STRING COMMENT 'Category of OT device (e.g., SCADA server, RTU, PLC, IED, DCS controller, HMI workstation).. Valid values are `scada_server|rtu|plc|ied|dcs_controller|hmi_workstation`',
    `capacity_mw` DECIMAL(18,2) COMMENT 'Maximum power capacity of the device expressed in megawatts where applicable.',
    `commissioning_date` DATE COMMENT 'Date the asset became operational and was accepted into service.',
    `communication_protocol` STRING COMMENT 'Primary industrial communication protocol used by the device.. Valid values are `dnp3|modbus|iec61850|opcua|profinet`',
    `compliance_status` STRING COMMENT 'Current compliance posture with regulatory and cybersecurity standards.. Valid values are `compliant|non_compliant|exempt`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the OT asset record was first created in the system.',
    `criticality_rating` STRING COMMENT 'Business‑defined importance of the asset to grid reliability.. Valid values are `critical|high|medium|low`',
    `decommission_date` DATE COMMENT 'Date the asset was removed from service (null if still active).',
    `documentation_url` STRING COMMENT 'Link to technical manuals, schematics, or configuration documents.',
    `firmware_version` STRING COMMENT 'Version of the firmware currently installed on the OT device.',
    `geographic_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the asset location in decimal degrees.',
    `geographic_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the asset location in decimal degrees.',
    `hardware_version` STRING COMMENT 'Revision identifier for the hardware platform of the OT asset.',
    `installation_date` DATE COMMENT 'Date the OT device was installed at the field location.',
    `ip_address` STRING COMMENT 'Network IP address assigned to the OT device.. Valid values are `^((25[0-5]|2[0-4]d|[01]?dd?).){3}(25[0-5]|2[0-4]d|[01]?dd?)$`',
    `last_maintenance_date` DATE COMMENT 'Most recent date on which maintenance was performed.',
    `last_seen_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent communication received from the device.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle phase of the OT asset.. Valid values are `in_service|decommissioned|maintenance|retired|planned`',
    `mac_address` STRING COMMENT 'Hardware MAC address of the devices network interface.. Valid values are `^([0-9A-Fa-f]{2}:){5}[0-9A-Fa-f]{2}$`',
    `maintenance_window` STRING COMMENT 'Typical time window (e.g., 02:00‑04:00) allocated for maintenance on this asset.',
    `manufacturer` STRING COMMENT 'Company that built the OT device.',
    `model_number` STRING COMMENT 'Model designation provided by the manufacturer.',
    `nerc_cip_impact` STRING COMMENT 'NERC CIP impact level assigned to the asset for cybersecurity compliance.. Valid values are `high|medium|low|none`',
    `network_zone` STRING COMMENT 'Logical network segment where the OT device resides.. Valid values are `dmz|internal|restricted|untrusted`',
    `next_maintenance_date` DATE COMMENT 'Scheduled date for the next planned maintenance activity.',
    `notes` STRING COMMENT 'Free‑form field for additional remarks or observations.',
    `security_patch_level` STRING COMMENT 'Identifier of the latest security patch applied to the device.',
    `serial_number` STRING COMMENT 'Factory‑assigned serial number uniquely identifying the hardware unit.',
    `software_version` STRING COMMENT 'Version of the application software running on the OT device.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the OT asset record.',
    `voltage_kv` DECIMAL(18,2) COMMENT 'Nominal operating voltage level for the device in kilovolts.',
    `vulnerability_score` DECIMAL(18,2) COMMENT 'Risk score (e.g., CVSS) reflecting known vulnerabilities on the asset.',
    `warranty_expiration_date` DATE COMMENT 'Date the manufacturer or vendor warranty expires.',
    CONSTRAINT pk_ot_asset PRIMARY KEY(`ot_asset_id`)
) COMMENT 'Master record for operational technology (OT) assets managed under the IT/OT convergence program, including SCADA servers, RTUs, PLCs, IEDs, historian servers, DCS controllers, and HMI workstations. Captures OT asset identifier, asset type, firmware version, communication protocol (DNP3, Modbus, IEC 61850), associated control system, NERC CIP impact classification, network zone, and lifecycle state. Complements the physical infrastructure records in the asset domain by focusing on the OT device identity and cybersecurity posture.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`technology`.`application` (
    `application_id` BIGINT COMMENT 'Unique system-generated identifier for the application record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Application support costs are allocated to a cost center for budgeting and expense tracking per utility IT budgeting process.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Application expenses are posted to GL accounts for financial statements and cost allocation.',
    `parent_application_id` BIGINT COMMENT 'Self-referencing FK on application (parent_application_id)',
    `acquisition_date` DATE COMMENT 'Date the application was first procured or developed.',
    `api_exposure` STRING COMMENT 'Scope of API availability for the application.. Valid values are `internal|partner|public|none`',
    `application_description` STRING COMMENT 'Brief narrative describing the purpose and functionality of the application.',
    `application_name` STRING COMMENT 'Human‑readable name of the software application.',
    `application_tier` STRING COMMENT 'Logical tier of the application architecture (presentation, business logic, data, integration).. Valid values are `presentation|business_logic|data|integration`',
    `authentication_method` STRING COMMENT 'Primary authentication mechanism used by the application.. Valid values are `saml|oauth|ldap|kerberos|local`',
    `backup_frequency` STRING COMMENT 'Scheduled frequency for backing up application data.. Valid values are `daily|weekly|monthly|none`',
    `business_capability` STRING COMMENT 'Primary business capability or process that the application enables (e.g., billing, outage management).',
    `compliance_regulation` STRING COMMENT 'Regulatory framework(s) the application must satisfy.. Valid values are `NERC|FERC|PCI|HIPAA|ISO55000`',
    `compliance_status` STRING COMMENT 'Current compliance posture of the application.. Valid values are `compliant|non_compliant|pending`',
    `container_orchestration` STRING COMMENT 'Orchestration platform used for managing containers.. Valid values are `kubernetes|docker_swarm|none`',
    `cost_annual_usd` DECIMAL(18,2) COMMENT 'Total annual cost to operate the application, expressed in US dollars.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the application record was initially created.',
    `data_classification` STRING COMMENT 'Classification level of data processed or stored by the application.. Valid values are `restricted|confidential|internal|public`',
    `data_retention_policy` STRING COMMENT 'Policy governing how long data handled by the application is retained.',
    `deployment_model` STRING COMMENT 'How the application is deployed: on‑premise, cloud SaaS, or hybrid.. Valid values are `on_premise|cloud_saas|hybrid`',
    `documentation_url` STRING COMMENT 'Link to the primary technical or user documentation for the application.',
    `encryption_at_rest` BOOLEAN COMMENT 'Indicates if data stored by the application is encrypted at rest.',
    `encryption_in_transit` BOOLEAN COMMENT 'Indicates if data transmitted to/from the application is encrypted.',
    `hosting_environment` STRING COMMENT 'Physical or cloud environment where the application runs (e.g., data center name, AWS region).',
    `incident_history_count` STRING COMMENT 'Number of recorded incidents associated with the application.',
    `integration_dependencies` STRING COMMENT 'Comma‑separated list of other systems or services this application integrates with.',
    `is_cloud_native` BOOLEAN COMMENT 'Indicates whether the application was designed specifically for cloud environments.',
    `is_containerized` BOOLEAN COMMENT 'Indicates whether the application runs inside containers.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the application is considered critical to core utility operations.',
    `last_security_assessment_date` DATE COMMENT 'Date of the most recent security assessment or audit.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the application record.',
    `lifecycle_status` STRING COMMENT 'Current state of the application within its lifecycle.. Valid values are `active|sunset|decommissioned|planned|retired`',
    `owner_business_owner` STRING COMMENT 'Name of the primary business stakeholder for the application.',
    `owner_business_unit` STRING COMMENT 'Business unit that owns the application from a functional perspective.',
    `owner_it_department` STRING COMMENT 'IT department responsible for the application’s operation and maintenance.',
    `owner_it_owner` STRING COMMENT 'Name of the primary IT stakeholder responsible for the application.',
    `repository_url` STRING COMMENT 'Web address of the source code repository.',
    `retirement_date` DATE COMMENT 'Planned or actual date the application will be retired or decommissioned.',
    `risk_rating` STRING COMMENT 'Overall risk rating based on security, compliance, and operational impact.. Valid values are `low|medium|high|critical`',
    `sla_response_time_minutes` STRING COMMENT 'Target response time for support tickets, measured in minutes.',
    `sla_uptime_percent` DECIMAL(18,2) COMMENT 'Target availability percentage for the application (e.g., 99.95).',
    `source_code_repository` STRING COMMENT 'Version‑control system used for the application’s source code.. Valid values are `git|svn|mercurial|none`',
    `support_contact` STRING COMMENT 'Phone number or identifier for the application support team.',
    `support_contact_email` STRING COMMENT 'Email address for the application support team.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `vendor` STRING COMMENT 'Name of the external vendor or internal development team that provides the application.',
    `vendor_contact_email` STRING COMMENT 'Primary email address for the vendors support or account contact.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `version` STRING COMMENT 'Current released version or build identifier of the application.',
    CONSTRAINT pk_application PRIMARY KEY(`application_id`)
) COMMENT 'Master record for every enterprise application in the utilitys application portfolio, covering both commercial off-the-shelf (COTS) and custom-developed systems. Captures application name, vendor, version, deployment model (on-premise, cloud SaaS, hybrid), business capability supported, application tier (presentation, business logic, data), hosting environment, lifecycle status (active, sunset, decommissioned), business owner, IT owner, and integration dependencies. Serves as the SSOT for application portfolio management (APM).';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`technology`.`network_device` (
    `network_device_id` BIGINT COMMENT 'Unique surrogate key for the network device record.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to property.facility. Business justification: Facility Maintenance schedules inspections of network devices; FK ties each device to its host facility for work order generation.',
    `it_asset_id` BIGINT COMMENT 'Foreign key linking to technology.it_asset. Business justification: Network devices are IT assets; linking to it_asset normalizes asset data and removes duplicate IP/MAC/serial fields.',
    `procurement_contract_id` BIGINT COMMENT 'Identifier of the support contract covering the device.',
    `upstream_network_device_id` BIGINT COMMENT 'Self-referencing FK on network_device (upstream_network_device_id)',
    `alert_thresholds` STRING COMMENT 'Serialized representation of alert thresholds configured for the device (e.g., CPU>80%).',
    `asset_tag` STRING COMMENT 'Internal asset tag used for tracking within asset management system.',
    `compliance_status` STRING COMMENT 'Regulatory compliance status of the device per NERC CIP or other standards.. Valid values are `compliant|non_compliant|exempt|pending`',
    `config_version` STRING COMMENT 'Version identifier of the current device configuration.',
    `cpu_utilization_percent` DECIMAL(18,2) COMMENT 'Average CPU utilization over the last monitoring interval.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the network device record was created in the data lake.',
    `decommission_date` DATE COMMENT 'Date the device was removed from service, if applicable.',
    `device_role` STRING COMMENT 'Functional role of the device within the network architecture.. Valid values are `core|distribution|access|edge|management|monitoring`',
    `device_type` STRING COMMENT 'Category of the network device based on its primary function.. Valid values are `router|switch|firewall|load_balancer|wireless_ap|sdwan_appliance`',
    `firmware_version` STRING COMMENT 'Version of the device firmware currently installed.',
    `hostname` STRING COMMENT 'Fully qualified host name assigned to the network device.',
    `installation_date` DATE COMMENT 'Date the device was installed into service.',
    `last_audit_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent security audit performed on the device.',
    `last_config_change_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent configuration change.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent maintenance activity.',
    `maintenance_window` STRING COMMENT 'Scheduled maintenance frequency or window.. Valid values are `weekly|monthly|quarterly|annual|ad_hoc`',
    `management_protocol` STRING COMMENT 'Protocol used for remote management of the device.. Valid values are `ssh|telnet|snmp|https|api`',
    `memory_utilization_percent` DECIMAL(18,2) COMMENT 'Average memory utilization over the last monitoring interval.',
    `monitoring_status` STRING COMMENT 'Whether the device is actively monitored by the monitoring system.. Valid values are `enabled|disabled|error`',
    `network_device_status` STRING COMMENT 'Current operational status of the device.. Valid values are `in_service|out_of_service|maintenance|decommissioned|planned`',
    `network_segment` STRING COMMENT 'Higher-level network segment classification (e.g., core, distribution, access).',
    `network_zone` STRING COMMENT 'Logical network zone where the device resides.. Valid values are `corporate_lan|ot_dmz|control_network|field_network`',
    `power_supply_status` STRING COMMENT 'Current health status of the devices power supply.. Valid values are `normal|failed|degraded|unknown`',
    `redundancy_group` STRING COMMENT 'Identifier of the redundancy group the device belongs to for high availability.',
    `risk_rating` STRING COMMENT 'Risk rating based on vulnerability assessments and criticality.. Valid values are `low|medium|high|critical`',
    `security_patch_level` STRING COMMENT 'Latest security patch level applied to the device.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the network device record.',
    `uptime_seconds` BIGINT COMMENT 'Total seconds the device has been continuously operational since last reboot.',
    `vendor` STRING COMMENT 'Manufacturer of the network device.',
    `vlan_number` STRING COMMENT 'Virtual LAN identifier assigned to the device.',
    `warranty_expiration` DATE COMMENT 'Date when the device warranty expires.',
    CONSTRAINT pk_network_device PRIMARY KEY(`network_device_id`)
) COMMENT 'Master record for all network infrastructure devices including routers, switches, firewalls, load balancers, wireless access points, and SD-WAN appliances deployed across the utilitys IT and OT networks. Captures device hostname, IP address, MAC address, network zone (corporate LAN, OT DMZ, control network, field network), VLAN assignments, firmware version, management protocol, physical location, and network segment classification. Distinct from OT assets in that these are pure network infrastructure elements.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`technology`.`it_service` (
    `it_service_id` BIGINT COMMENT 'Unique system-generated identifier for each IT/OT service.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: IT service cost allocation to cost centers enables OPEX reporting and service chargeback in utility operations.',
    `employee_id` BIGINT COMMENT 'System identifier for the service owner.',
    `it_asset_id` BIGINT COMMENT 'Foreign key linking to technology.it_asset. Business justification: IT services run on underlying IT assets; linking provides asset context.',
    `person_id` BIGINT COMMENT 'System identifier for the service owner.',
    `parent_it_service_id` BIGINT COMMENT 'Self-referencing FK on it_service (parent_it_service_id)',
    `annual_budget_amount` DECIMAL(18,2) COMMENT 'Total budget approved for the service per fiscal year.',
    `availability_target_percent` DECIMAL(18,2) COMMENT 'Service availability commitment expressed as a percentage of uptime.',
    `budget_currency` STRING COMMENT 'ISO 4217 currency code for budget figures.. Valid values are `USD|EUR|GBP|CAD|JPY`',
    `change_management_process` STRING COMMENT 'Process governing changes to the service.',
    `compliance_certifications` STRING COMMENT 'Regulatory or industry certifications applicable to the service.',
    `cost_per_month` DECIMAL(18,2) COMMENT 'Recurring cost incurred each month for the service.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the service record was first created.',
    `criticality` STRING COMMENT 'Business impact rating of the service.. Valid values are `high|medium|low`',
    `delivery_model` STRING COMMENT 'Technology delivery model for the service.. Valid values are `cloud|on-prem|hybrid`',
    `dependencies` STRING COMMENT 'List of upstream services or components required for operation.',
    `deprecation_date` DATE COMMENT 'Future date when the service will be phased out.',
    `documentation_url` STRING COMMENT 'Link to the services technical or user documentation.',
    `escalation_path` STRING COMMENT 'Procedure or contacts for escalating service issues.',
    `incident_management_process` STRING COMMENT 'Process for handling service incidents.',
    `it_service_category` STRING COMMENT 'Broad category describing the nature of the service.. Valid values are `infrastructure|application|security|communications|ot_support`',
    `it_service_description` STRING COMMENT 'Detailed description of the service functionality and scope.',
    `it_service_name` STRING COMMENT 'Human‑readable name of the IT or OT service.',
    `it_service_status` STRING COMMENT 'Operational status of the service.. Valid values are `active|inactive|planned|retired|pending`',
    `last_review_date` DATE COMMENT 'Date the service was last reviewed for compliance or performance.',
    `maintenance_window` STRING COMMENT 'Scheduled time period for routine maintenance.',
    `next_review_date` DATE COMMENT 'Scheduled date for the upcoming service review.',
    `owner_group` STRING COMMENT 'Department or business unit that owns the service.',
    `owner_name` STRING COMMENT 'Name of the primary owner responsible for the service.',
    `request_fulfillment_process` STRING COMMENT 'Process for fulfilling service requests.',
    `security_classification` STRING COMMENT 'Data security level associated with the service.. Valid values are `restricted|confidential|internal|public`',
    `service_code` STRING COMMENT 'Unique business code that identifies the service across contracts and financial systems.',
    `service_end_date` DATE COMMENT 'Date the service was officially retired.',
    `service_region` STRING COMMENT 'ISO‑3 country code representing the primary service region.. Valid values are `^[A-Z]{3}$`',
    `service_start_date` DATE COMMENT 'Date the service was first made available.',
    `service_type` STRING COMMENT 'Specifies if the service is for internal use only or also offered to external customers.. Valid values are `internal|external`',
    `sla_resolution_time_minutes` STRING COMMENT 'Maximum time to resolve an incident, expressed in minutes.',
    `sla_response_time_minutes` STRING COMMENT 'Maximum time to acknowledge an incident, expressed in minutes.',
    `sla_tier` STRING COMMENT 'Tier of Service Level Agreement associated with the service.. Valid values are `gold|silver|bronze`',
    `subcategory` STRING COMMENT 'Fine‑grained classification used for reporting and routing.',
    `support_contact_email` STRING COMMENT 'Primary email address for service support.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `support_contact_phone` STRING COMMENT 'Primary phone number for service support.',
    `supported_processes` STRING COMMENT 'Business processes that rely on this service.',
    `technology_stack` STRING COMMENT 'Key technologies used to deliver the service.',
    `tier` STRING COMMENT 'Tier that defines the services priority, availability, and support commitments.. Valid values are `critical|standard|basic`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the service record.',
    `version` STRING COMMENT 'Current version or release identifier of the service.',
    CONSTRAINT pk_it_service PRIMARY KEY(`it_service_id`)
) COMMENT 'Master catalog of IT and OT services delivered by the technology organization to internal business units and field operations. Captures service name, service category (infrastructure, application, security, communications, OT support), service tier (critical, standard, basic), service owner, SLA tier, supported business processes, and service status. Serves as the SSOT for the IT service catalog used in ITSM workflows and service request routing.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` (
    `incident_ticket_id` BIGINT COMMENT 'Unique identifier for the incident ticket record.',
    `assigned_to_employee_id` BIGINT COMMENT 'Identifier of the individual technician or analyst assigned to resolve the incident.',
    `created_by_user_employee_id` BIGINT COMMENT 'System user who created the ticket record.',
    `employee_id` BIGINT COMMENT 'Identifier of the person (employee, contractor, or customer) who reported the incident.',
    `it_service_id` BIGINT COMMENT 'Foreign key linking to technology.it_service. Business justification: Incident tickets are raised against a specific IT service; FK replaces free‑text service field.',
    `location_id` BIGINT COMMENT 'Geographic location identifier where the incident originated or was observed.',
    `incident_id` BIGINT COMMENT 'Identifier of a related or parent incident ticket, if applicable.',
    `person_id` BIGINT COMMENT 'Identifier of the person (employee, contractor, or customer) who reported the incident.',
    `quaternary_incident_updated_by_user_person_id` BIGINT COMMENT 'System user who last modified the ticket record.',
    `tertiary_incident_created_by_user_person_id` BIGINT COMMENT 'System user who created the ticket record.',
    `updated_by_user_employee_id` BIGINT COMMENT 'System user who last modified the ticket record.',
    `parent_incident_ticket_id` BIGINT COMMENT 'Self-referencing FK on incident_ticket (parent_incident_ticket_id)',
    `acknowledgment_timestamp` TIMESTAMP COMMENT 'Date‑time when the incident was acknowledged by the support team.',
    `affected_business_unit` STRING COMMENT 'Organizational unit responsible for the impacted service.. Valid values are `operations|it|ot|customer_service|finance|regulatory`',
    `assigned_group` STRING COMMENT 'Team or group currently responsible for handling the incident.',
    `closed_timestamp` TIMESTAMP COMMENT 'Date‑time when the ticket was closed after verification.',
    `compliance_category` STRING COMMENT 'Regulatory or compliance framework applicable to the incident.. Valid values are `cip|ferc|nerc|iso|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the ticket record was created in the system.',
    `customer_impact` STRING COMMENT 'Effect of the incident on end‑customer service delivery.. Valid values are `outage|degraded|none|partial|unknown`',
    `detection_method` STRING COMMENT 'Method or mechanism that detected the incident.. Valid values are `alert|log|user_report|sensor|system|other`',
    `downtime_duration_minutes` DECIMAL(18,2) COMMENT 'Total minutes of service downtime attributable to the incident.',
    `escalation_level` STRING COMMENT 'Level to which the incident was escalated within the support hierarchy.. Valid values are `level1|level2|level3|level4`',
    `impact_area` STRING COMMENT 'Business domain or stakeholder area affected by the incident.. Valid values are `customer|business|safety|regulatory|environment|service`',
    `impact_severity` STRING COMMENT 'Severity of the incident impact on operations and customers.. Valid values are `critical|high|medium|low|informational`',
    `incident_source` STRING COMMENT 'Origin of the incident report (e.g., manual entry, automated alert).. Valid values are `manual|automated|monitoring|third_party`',
    `incident_ticket_category` STRING COMMENT 'High‑level classification of the incident type.. Valid values are `network|server|application|ot_scada|cybersecurity|other`',
    `incident_ticket_description` STRING COMMENT 'Detailed free‑text description of the incident as initially reported.',
    `incident_ticket_status` STRING COMMENT 'Current lifecycle state of the incident ticket.. Valid values are `open|in_progress|resolved|closed|cancelled`',
    `is_external` BOOLEAN COMMENT 'True if the incident was reported by an external customer or partner.',
    `is_sla_critical` BOOLEAN COMMENT 'True if the incident is classified as SLA‑critical for business continuity.',
    `mitigation_action` STRING COMMENT 'Planned or executed action to mitigate future occurrences.',
    `post_incident_review_completed` BOOLEAN COMMENT 'True when a formal post‑mortem review has been completed.',
    `priority` STRING COMMENT 'Business‑defined priority level indicating urgency (P1 highest).. Valid values are `P1|P2|P3|P4`',
    `regulatory_report_flag` BOOLEAN COMMENT 'Indicates whether the incident must be reported to a regulator (e.g., NERC, FERC).',
    `reported_timestamp` TIMESTAMP COMMENT 'Date‑time when the incident was first reported or detected.',
    `resolution_description` STRING COMMENT 'Narrative of how the incident was resolved.',
    `resolved_timestamp` TIMESTAMP COMMENT 'Date‑time when the incident was marked as resolved.',
    `review_timestamp` TIMESTAMP COMMENT 'Date‑time when the post‑incident review was finalized.',
    `risk_level` STRING COMMENT 'Assessed risk level of the incident to the organization.. Valid values are `high|medium|low|none`',
    `root_cause_category` STRING COMMENT 'Primary cause classification identified during investigation.. Valid values are `hardware|software|human_error|process|external|unknown`',
    `service_restoration_timestamp` TIMESTAMP COMMENT 'Date‑time when the affected service was fully restored.',
    `sla_actual_hours` DECIMAL(18,2) COMMENT 'Actual time (in hours) taken to resolve the incident.',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the incident breached its SLA target.',
    `sla_target_hours` DECIMAL(18,2) COMMENT 'Service‑level agreement target time (in hours) for resolution.',
    `system_affected` STRING COMMENT 'Specific operational system impacted by the incident.. Valid values are `scada|ems|dms|oms|mrm|other`',
    `ticket_number` STRING COMMENT 'Human‑readable identifier assigned to the incident ticket.',
    `ticket_type` STRING COMMENT 'Indicates whether the ticket pertains to IT, OT/SCADA, or cybersecurity.. Valid values are `it|ot|cybersecurity`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the ticket record.',
    `work_notes` STRING COMMENT 'Chronological free‑text log of actions taken during incident handling.',
    CONSTRAINT pk_incident_ticket PRIMARY KEY(`incident_ticket_id`)
) COMMENT 'ITSM incident record capturing every IT and OT service disruption, outage, or degradation reported by utility staff or detected by monitoring systems. Captures ticket number, incident category (network, server, application, OT/SCADA, cybersecurity), priority (P1–P4), affected service, affected business unit, reported datetime, acknowledged datetime, resolved datetime, root cause category, resolution description, and SLA breach flag. Distinct from safety incidents (owned by safety domain) and grid outage events (owned by gridops domain).';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`technology`.`change_request` (
    `change_request_id` BIGINT COMMENT 'System-generated unique identifier for the change request record.',
    `approver_employee_id` BIGINT COMMENT 'Identifier of the individual who approved the change request.',
    `employee_id` BIGINT COMMENT 'Identifier of the person or system that originated the change request.',
    `tech_project_id` BIGINT COMMENT 'Foreign key linking to technology.tech_project. Business justification: Change requests are scoped to a technology project; linking enables project‑level reporting.',
    `rollback_change_request_id` BIGINT COMMENT 'Self-referencing FK on change_request (rollback_change_request_id)',
    `actual_cost` DECIMAL(18,2) COMMENT 'Final recorded cost after change execution.',
    `affected_systems` STRING COMMENT 'Comma‑separated list of IT/OT systems impacted by the change.',
    `business_event_timestamp` TIMESTAMP COMMENT 'Timestamp when the change request was initially submitted by the business.',
    `change_category` STRING COMMENT 'Broad functional area impacted by the change (e.g., infrastructure, application, OT/SCADA, security, process).. Valid values are `infrastructure|application|ot_scada|security|process`',
    `change_category_detail` STRING COMMENT 'Additional free‑text detail clarifying the change category.',
    `change_description` STRING COMMENT 'Detailed narrative of what the change will modify.',
    `change_impact` STRING COMMENT 'Expected impact on operations, customers, or regulatory compliance.',
    `change_reason` STRING COMMENT 'Business justification for initiating the change.',
    `change_request_source` STRING COMMENT 'Origin of the change request (IT, OT, or both).. Valid values are `IT|OT|Both`',
    `change_request_status` STRING COMMENT 'Current lifecycle status of the change request. [ENUM-REF-CANDIDATE: draft|submitted|approved|rejected|scheduled|in_progress|completed|closed — 8 candidates stripped; promote to reference product]',
    `change_risk_assessment` STRING COMMENT 'Summary of risk analysis performed for the change.',
    `change_type` STRING COMMENT 'Classification of the change based on its urgency and process (standard, normal, or emergency).. Valid values are `standard|normal|emergency`',
    `change_type_detail` STRING COMMENT 'Additional free‑text detail clarifying the change type.',
    `change_window_duration_minutes` STRING COMMENT 'Planned duration of the change window expressed in minutes.',
    `change_window_end` TIMESTAMP COMMENT 'Scheduled end time for the change execution window.',
    `change_window_notes` STRING COMMENT 'Additional notes or constraints related to the change window.',
    `change_window_start` TIMESTAMP COMMENT 'Scheduled start time for the change execution window.',
    `change_window_timezone` STRING COMMENT 'Timezone identifier (e.g., America/New_York) for the scheduled change window.',
    `compliance_requirement` STRING COMMENT 'Regulatory or internal compliance standard that the change must satisfy (e.g., NERC CIP).',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for cost fields (e.g., USD).. Valid values are `^[A-Z]{3}$`',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Projected financial cost associated with implementing the change.',
    `implementation_status` STRING COMMENT 'Current execution status of the change implementation.. Valid values are `not_started|in_progress|completed|failed|rolled_back`',
    `origin` STRING COMMENT 'Whether the request was entered manually by a user or generated automatically.. Valid values are `manual|automated`',
    `post_implementation_review` STRING COMMENT 'Outcome and lessons learned after change execution.',
    `priority` STRING COMMENT 'Business‑assigned priority indicating how quickly the change should be addressed.. Valid values are `low|medium|high|critical`',
    `record_audit_created` TIMESTAMP COMMENT 'System timestamp when the change request record was first created in the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'System timestamp of the most recent update to the change request record.',
    `request_number` STRING COMMENT 'Human‑readable business identifier assigned to the change request (e.g., CR‑2024‑00123).',
    `risk_level` STRING COMMENT 'Assessed risk severity for the change request.. Valid values are `low|medium|high|critical`',
    `rollback_plan` STRING COMMENT 'Textual description of the plan to revert the change if needed.',
    `status_reason` STRING COMMENT 'Explanation for the current status (e.g., reason for rejection or hold).',
    CONSTRAINT pk_change_request PRIMARY KEY(`change_request_id`)
) COMMENT 'IT change management record for all planned changes to IT and OT infrastructure, applications, and configurations. Captures change request number, change type (standard, normal, emergency), change category (infrastructure, application, OT/SCADA, security), risk level, affected systems, change window start/end, approver, implementation status, rollback plan, and post-implementation review outcome. Supports NERC CIP change management requirements for BES Cyber Systems.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` (
    `service_request_ticket_id` BIGINT COMMENT 'Unique surrogate key for the service request ticket record.',
    `approver_employee_id` BIGINT COMMENT 'Identifier of the employee who approved the request.',
    `person_id` BIGINT COMMENT 'Identifier of the employee who approved the request.',
    `it_asset_id` BIGINT COMMENT 'Identifier of the asset (e.g., equipment, meter) related to the request.',
    `registry_id` BIGINT COMMENT 'Identifier of the asset (e.g., equipment, meter) related to the request.',
    `technician_id` BIGINT COMMENT 'Identifier of the technician or support staff assigned to fulfill the request.',
    `crew_member_id` BIGINT COMMENT 'Identifier of the technician or support staff assigned to fulfill the request.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or contractor who submitted the request.',
    `it_service_id` BIGINT COMMENT 'Foreign key linking to technology.it_service. Business justification: Service request tickets request a specific IT service; FK replaces generic service_type field.',
    `location_id` BIGINT COMMENT 'Identifier of the physical location where service is required.',
    `change_request_id` BIGINT COMMENT 'Identifier of a change request associated with this service request.',
    `incident_id` BIGINT COMMENT 'Identifier of an incident ticket linked to this service request, if any.',
    `vendor_id` BIGINT COMMENT 'Identifier of the external vendor selected for the request.',
    `work_order_id` BIGINT COMMENT 'Work order generated to execute the service request.',
    `originating_service_request_ticket_id` BIGINT COMMENT 'Self-referencing FK on service_request_ticket (originating_service_request_ticket_id)',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual date‑time when work completed.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date‑time when work began.',
    `approval_required` BOOLEAN COMMENT 'Indicates whether the request must be approved before work can begin.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the request received formal approval.',
    `business_unit` STRING COMMENT 'Organizational business unit responsible for the request.',
    `closure_timestamp` TIMESTAMP COMMENT 'Timestamp when the ticket was officially closed.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the request is subject to regulatory compliance review.',
    `cost_estimate_currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for the cost estimate.',
    `cost_estimate_gross` DECIMAL(18,2) COMMENT 'Estimated gross cost before taxes or discounts.',
    `cost_estimate_net` DECIMAL(18,2) COMMENT 'Estimated net cost after taxes and discounts.',
    `cost_estimate_tax` DECIMAL(18,2) COMMENT 'Estimated tax amount applicable to the service request.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the ticket record was first created in the system.',
    `department` STRING COMMENT 'Department within the business unit handling the request.',
    `external_vendor_required` BOOLEAN COMMENT 'True if external vendor involvement is needed to fulfill the request.',
    `fulfilled_timestamp` TIMESTAMP COMMENT 'Date‑time when the service request was marked as fulfilled.',
    `fulfillment_notes` STRING COMMENT 'Free‑text notes entered by the technician during or after fulfillment.',
    `fulfillment_sla` STRING COMMENT 'Classification of the SLA applied to this request.. Valid values are `standard|priority|custom`',
    `impact` STRING COMMENT 'Business impact rating of the request.. Valid values are `low|medium|high|critical`',
    `last_modified_by` STRING COMMENT 'User identifier of the person who performed the latest update.',
    `priority` STRING COMMENT 'Business‑defined priority level indicating urgency of fulfillment.. Valid values are `low|medium|high|critical`',
    `regulatory_review_status` STRING COMMENT 'Current status of any required regulatory review.. Valid values are `not_required|pending|approved|rejected`',
    `request_category` STRING COMMENT 'Primary classification of the service request type.. Valid values are `access_provisioning|hardware_request|software_install|account_management|ot_support`',
    `request_subcategory` STRING COMMENT 'Optional secondary classification providing more detail about the request.',
    `requested_timestamp` TIMESTAMP COMMENT 'Date‑time when the service request was submitted by the requester.',
    `requester_name` STRING COMMENT 'Full name of the requester for reference and communication.',
    `resolution_code` STRING COMMENT 'Standard code describing how the request was resolved.. Valid values are `resolved|cannot_reproduce|won_t_fix|deferred`',
    `scheduled_end_timestamp` TIMESTAMP COMMENT 'Planned end date‑time for the work.',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'Planned start date‑time for the work.',
    `service_request_ticket_description` STRING COMMENT 'Detailed free‑text description of the service request.',
    `service_request_ticket_status` STRING COMMENT 'Current lifecycle state of the service request ticket.. Valid values are `open|in_progress|fulfilled|closed|cancelled`',
    `sla_met` BOOLEAN COMMENT 'Indicates whether the fulfillment occurred within the SLA target.',
    `sla_target_hours` DECIMAL(18,2) COMMENT 'Service Level Agreement target duration (in hours) promised for fulfillment.',
    `ticket_number` STRING COMMENT 'Human‑readable identifier assigned to the service request ticket, e.g., SR‑20230001.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the ticket record.',
    `urgency` STRING COMMENT 'Urgency rating indicating how quickly the request should be addressed.. Valid values are `low|medium|high|critical`',
    CONSTRAINT pk_service_request_ticket PRIMARY KEY(`service_request_ticket_id`)
) COMMENT 'ITSM service request record for standard, pre-approved IT service fulfillment activities initiated by utility employees and contractors. Captures request number, request category (access provisioning, hardware request, software install, account management, OT support), requester, assigned technician, fulfillment SLA, requested datetime, fulfilled datetime, and fulfillment status. Distinct from incident_ticket (unplanned disruptions) and change_request (infrastructure changes).';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`technology`.`tech_project` (
    `tech_project_id` BIGINT COMMENT 'Unique surrogate key for the technology project record.',
    `tech_vendor_id` BIGINT COMMENT 'Foreign key linking to technology.tech_vendor. Business justification: Technology projects engage a primary vendor; linking captures vendor ownership.',
    `parent_tech_project_id` BIGINT COMMENT 'Self-referencing FK on tech_project (parent_tech_project_id)',
    `actual_duration_days` STRING COMMENT 'Actual total duration of the project in days, calculated after completion.',
    `actual_end_date` DATE COMMENT 'Calendar date when work actually finished.',
    `actual_roi_percent` DECIMAL(18,2) COMMENT 'Realized return on investment percentage after project closeout.',
    `actual_spend` DECIMAL(18,2) COMMENT 'Cumulative actual expenditures incurred to date.',
    `actual_start_date` DATE COMMENT 'Calendar date when work actually began.',
    `approval_date` DATE COMMENT 'Date on which the project received formal approval.',
    `approval_status` STRING COMMENT 'Current approval state of the project charter.. Valid values are `pending|approved|rejected`',
    `benefits_realization_status` STRING COMMENT 'State of benefit delivery (e.g., not_started, in_progress, realized, deferred).',
    `budget_amount` DECIMAL(18,2) COMMENT 'Approved monetary budget for the project.',
    `change_request_count` STRING COMMENT 'Total number of approved change requests submitted during the project.',
    `compliance_requirements` STRING COMMENT 'Free‑text list of regulatory or standards requirements applicable to the project.',
    `contract_number` STRING COMMENT 'Identifier of the contract governing external services for the project.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the project record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.. Valid values are `USD|CAD|EUR|GBP|JPY|CHF`',
    `data_classification` STRING COMMENT 'Classification level applied to project documentation and data.. Valid values are `public|internal|confidential|restricted`',
    `estimated_duration_days` STRING COMMENT 'Planned total duration of the project expressed in calendar days.',
    `expected_roi_percent` DECIMAL(18,2) COMMENT 'Projected return on investment expressed as a percentage.',
    `external_vendor` STRING COMMENT 'Name of the primary external vendor or contractor, if any.',
    `funding_source` STRING COMMENT 'Origin of the projects financial resources.. Valid values are `capex|opex|grant|internal|external`',
    `health_status` STRING COMMENT 'Current health indicator used in governance reporting.. Valid values are `green|yellow|red`',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the project is deemed critical to core operations.',
    `is_remote` BOOLEAN COMMENT 'Indicates whether the project team operates primarily remotely.',
    `last_review_date` DATE COMMENT 'Date of the most recent project health or governance review.',
    `milestone_count` STRING COMMENT 'Total number of defined project milestones.',
    `notes` STRING COMMENT 'Free‑form field for additional comments or observations.',
    `planned_end_date` DATE COMMENT 'Scheduled calendar date for project completion.',
    `planned_start_date` DATE COMMENT 'Scheduled calendar date for project commencement.',
    `priority` STRING COMMENT 'Business‑defined priority level indicating urgency and importance.. Valid values are `high|medium|low`',
    `project_code` STRING COMMENT 'Business‑assigned unique code for the project, used in reporting and external communications.',
    `project_manager` STRING COMMENT 'Name of the internal manager responsible for day‑to‑day execution.',
    `project_name` STRING COMMENT 'Human‑readable name of the technology project.',
    `project_phase` STRING COMMENT 'Current lifecycle phase of the project.. Valid values are `initiation|planning|execution|closeout`',
    `project_type` STRING COMMENT 'Category of the technology initiative (e.g., infrastructure upgrade, OT/SCADA modernization, cybersecurity program, digital platform, application development).. Valid values are `infrastructure|ot_scada|cybersecurity|digital|application`',
    `project_url` STRING COMMENT 'Link to the primary project workspace or documentation portal.',
    `regulatory_impact` STRING COMMENT 'Description of any regulatory implications or filings required.',
    `risk_rating` STRING COMMENT 'Overall risk assessment rating for the project.. Valid values are `high|medium|low|none`',
    `sponsor_business_unit` STRING COMMENT 'Organizational unit that sponsors and funds the project.',
    `stakeholder_count` STRING COMMENT 'Number of distinct stakeholder groups engaged with the project.',
    `strategic_program` STRING COMMENT 'Higher‑level strategic program or initiative to which the project contributes.',
    `tech_project_description` STRING COMMENT 'Detailed free‑text description of the projects scope, objectives, and deliverables.',
    `tech_project_status` STRING COMMENT 'Overall lifecycle status of the project.. Valid values are `active|inactive|completed|cancelled|on_hold`',
    `technology_stack` STRING COMMENT 'Key technologies, platforms, and tools used in the project.',
    `total_milestones_completed` STRING COMMENT 'Number of milestones that have been marked complete.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the project record.',
    CONSTRAINT pk_tech_project PRIMARY KEY(`tech_project_id`)
) COMMENT 'Master record for technology project delivery initiatives including IT infrastructure upgrades, OT modernization programs, AMI deployments, SCADA/EMS upgrades, cybersecurity programs, and digital platform implementations. Captures project name, project type (infrastructure, OT/SCADA, cybersecurity, digital, application), project phase (initiation, planning, execution, closeout), budget, actual spend, planned start/end dates, actual start/end dates, project manager, sponsoring business unit, and strategic program alignment. Distinct from capital expenditure projects in the finance domain.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`technology`.`project_milestone` (
    `project_milestone_id` BIGINT COMMENT 'System-generated unique identifier for the project milestone record.',
    `approved_by_employee_id` BIGINT COMMENT 'Identifier of the individual who approved the milestone completion or change.',
    `change_request_id` BIGINT COMMENT 'Identifier of any change request associated with this milestone.',
    `employee_id` BIGINT COMMENT 'Identifier of the person or team accountable for delivering the milestone.',
    `tech_project_id` BIGINT COMMENT 'Identifier of the technology project to which this milestone belongs.',
    `predecessor_project_milestone_id` BIGINT COMMENT 'Self-referencing FK on project_milestone (predecessor_project_milestone_id)',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual monetary cost incurred to achieve the milestone.',
    `actual_date` DATE COMMENT 'Date the milestone was actually completed.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the milestone was formally approved.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Planned monetary budget allocated for completing the milestone.',
    `completion_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the milestone was marked as achieved.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the milestone record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for budget and cost values.',
    `deliverable_description` STRING COMMENT 'Description of the tangible output or deliverable associated with the milestone.',
    `due_date` DATE COMMENT 'Final date by which the milestone should be achieved, used for schedule variance analysis.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the milestone is deemed critical to project success.',
    `milestone_code` STRING COMMENT 'Business-facing code or number assigned to the milestone for tracking and reporting.',
    `milestone_name` STRING COMMENT 'Descriptive name of the milestone as used in project plans and communications.',
    `milestone_type` STRING COMMENT 'Category of the milestone indicating its purpose within the technology project lifecycle.. Valid values are `gate_review|go_live|cutover|testing_complete|regulatory_submission|other`',
    `notes` STRING COMMENT 'Free‑form notes or comments captured by the owner or stakeholders.',
    `planned_date` DATE COMMENT 'Date the milestone is scheduled to be completed.',
    `priority` STRING COMMENT 'Business priority assigned to the milestone.. Valid values are `low|medium|high`',
    `project_milestone_description` STRING COMMENT 'Detailed narrative describing the purpose and scope of the milestone.',
    `project_milestone_status` STRING COMMENT 'Current lifecycle status of the milestone.. Valid values are `pending|achieved|missed|deferred`',
    `risk_level` STRING COMMENT 'Assessed risk severity for the milestone execution.. Valid values are `low|medium|high|critical`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the milestone record.',
    CONSTRAINT pk_project_milestone PRIMARY KEY(`project_milestone_id`)
) COMMENT 'Transactional record for each planned and completed milestone within a technology project. Captures milestone name, milestone type (gate review, go-live, cutover, testing complete, regulatory submission), planned date, actual date, milestone status (pending, achieved, missed, deferred), accountable owner, and associated deliverable description. Enables project schedule tracking and earned value management for technology delivery programs.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`technology`.`cyber_vulnerability` (
    `cyber_vulnerability_id` BIGINT COMMENT 'System-generated unique identifier for the vulnerability record.',
    `it_asset_id` BIGINT COMMENT 'Foreign key linking to technology.it_asset. Business justification: Vulnerabilities are tied to specific IT assets; FK replaces generic asset type descriptor.',
    `rediscovered_cyber_vulnerability_id` BIGINT COMMENT 'Self-referencing FK on cyber_vulnerability (rediscovered_cyber_vulnerability_id)',
    `affected_software_version` STRING COMMENT 'Specific software or firmware version(s) that are vulnerable.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the vulnerability record was first created in the system.',
    `cve_code` STRING COMMENT 'Standard CVE identifier assigned by MITRE for the vulnerability.',
    `cvss_score` DECIMAL(18,2) COMMENT 'Numeric severity score (0.0 – 10.0) calculated per CVSS v3.1.',
    `cyber_vulnerability_description` STRING COMMENT 'Detailed narrative describing the vulnerability, its impact, and context.',
    `discovery_date` DATE COMMENT 'Calendar date when the vulnerability was first discovered.',
    `discovery_method` STRING COMMENT 'Method by which the vulnerability was identified.. Valid values are `scanning|penetration_test|threat_intel|vendor_advisory|user_report`',
    `exploitability_score` DECIMAL(18,2) COMMENT 'CVSS sub‑score reflecting how easy it is to exploit the vulnerability.',
    `impact_score` DECIMAL(18,2) COMMENT 'CVSS sub‑score reflecting the potential impact on confidentiality, integrity, and availability.',
    `is_critical` BOOLEAN COMMENT 'True if the vulnerability is classified as critical for the utilitys risk posture.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the vulnerability record.',
    `nerc_cip_applicability` BOOLEAN COMMENT 'Indicates whether the vulnerability is subject to NERC CIP compliance requirements.',
    `patch_available` BOOLEAN COMMENT 'True if a vendor or internal patch exists for the vulnerability.',
    `patch_release_date` DATE COMMENT 'Date when the patch was released by the vendor or internally.',
    `references` STRING COMMENT 'Comma‑separated list of URLs or document identifiers that provide additional information.',
    `remediation_action` STRING COMMENT 'Planned or executed action to mitigate or fix the vulnerability.',
    `remediation_due_date` DATE COMMENT 'Target date by which remediation should be completed.',
    `remediation_status` STRING COMMENT 'Current state of remediation activities for the vulnerability.. Valid values are `not_started|in_progress|completed|deferred|not_applicable`',
    `severity` STRING COMMENT 'Categorized severity based on CVSS and business impact.. Valid values are `critical|high|medium|low|informational`',
    `vendor` STRING COMMENT 'Name of the product or system vendor that issued the advisory.',
    `vendor_advisory_reference` STRING COMMENT 'Vendor‑specific advisory or bulletin identifier.',
    `vulnerability_name` STRING COMMENT 'Human‑readable name or title describing the vulnerability.',
    `vulnerability_type` STRING COMMENT 'Classification of the vulnerability by its nature or origin.. Valid values are `software|hardware|configuration|network|application`',
    CONSTRAINT pk_cyber_vulnerability PRIMARY KEY(`cyber_vulnerability_id`)
) COMMENT 'Master record for cybersecurity vulnerabilities identified across IT and OT assets through vulnerability scanning, penetration testing, threat intelligence feeds, and vendor advisories. Captures CVE identifier, vulnerability name, CVSS score, severity (critical, high, medium, low), affected asset type, affected software/firmware version, discovery method, discovery date, remediation status, remediation due date, and NERC CIP applicability flag. Serves as the SSOT for vulnerability management program tracking.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`technology`.`cyber_incident` (
    `cyber_incident_id` BIGINT COMMENT 'Unique system-generated identifier for the cybersecurity incident record.',
    `it_asset_id` BIGINT COMMENT 'Identifier of the asset (IT/OT) associated with the incident.',
    `registry_id` BIGINT COMMENT 'Identifier of the asset (IT/OT) associated with the incident.',
    `cyber_vulnerability_id` BIGINT COMMENT 'Foreign key linking to technology.cyber_vulnerability. Business justification: Cyber incidents often stem from known vulnerabilities; linking enables root‑cause analysis.',
    `related_cyber_incident_id` BIGINT COMMENT 'Self-referencing FK on cyber_incident (related_cyber_incident_id)',
    `affected_systems` STRING COMMENT 'Comma‑separated list of IT/OT systems impacted by the incident.',
    `attack_vector` STRING COMMENT 'Method or pathway used by the adversary to deliver the attack.. Valid values are `email|web|usb|remote_exploit|credential_theft|social_engineering`',
    `containment_timestamp` TIMESTAMP COMMENT 'Date‑time when containment actions were completed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the incident record was first created in the system.',
    `detection_source` STRING COMMENT 'Origin of the detection signal.. Valid values are `siem|ids|user_report|log_analysis|threat_intel|other`',
    `detection_timestamp` TIMESTAMP COMMENT 'Date‑time when the incident was first detected.',
    `eradication_timestamp` TIMESTAMP COMMENT 'Date‑time when the root cause was removed from the environment.',
    `impact_estimate_usd` DECIMAL(18,2) COMMENT 'Monetary estimate of the financial impact of the incident.',
    `incident_description` STRING COMMENT 'Free‑text description of what occurred.',
    `incident_number` STRING COMMENT 'Human‑readable incident identifier used in reports and communications.. Valid values are `INC-[0-9]{4}-[0-9]{4}`',
    `incident_status` STRING COMMENT 'Current lifecycle state of the incident.. Valid values are `detected|contained|eradicated|recovered|closed|false_positive`',
    `incident_type` STRING COMMENT 'Category of the security event.. Valid values are `malware|phishing|ransomware|unauthorized_access|dos|insider_threat`',
    `lessons_learned` STRING COMMENT 'Narrative of insights and improvements derived from the incident.',
    `mitigation_actions` STRING COMMENT 'Actions taken to prevent recurrence.',
    `nerc_cip_reportable` BOOLEAN COMMENT 'Indicates whether the incident must be reported under NERC CIP requirements.',
    `recovery_timestamp` TIMESTAMP COMMENT 'Date‑time when normal operations were restored.',
    `regulatory_notification_status` STRING COMMENT 'Status of required regulatory notifications.. Valid values are `not_required|pending|notified|escalated`',
    `reported_by` STRING COMMENT 'Name or identifier of the person or system that reported the incident.',
    `reporting_department` STRING COMMENT 'Organizational department that owns the incident response.',
    `root_cause_analysis` STRING COMMENT 'Detailed description of the underlying cause of the incident.',
    `severity_level` STRING COMMENT 'Risk rating assigned to the incident based on impact and likelihood.. Valid values are `low|medium|high|critical`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the incident record.',
    CONSTRAINT pk_cyber_incident PRIMARY KEY(`cyber_incident_id`)
) COMMENT 'Cybersecurity incident record capturing confirmed or suspected security events including malware infections, unauthorized access attempts, phishing attacks, ransomware events, OT/SCADA intrusion attempts, and data breaches. Captures incident identifier, incident type, attack vector, affected systems, detection source (SIEM, IDS, user report), detection datetime, containment datetime, eradication datetime, recovery datetime, NERC CIP reportability flag, regulatory notification status, and lessons learned. Distinct from IT service incidents (incident_ticket) which cover non-security disruptions.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` (
    `access_entitlement_id` BIGINT COMMENT 'System-generated unique identifier for the access entitlement record.',
    `approver_employee_id` BIGINT COMMENT 'Identifier of the individual who approved the entitlement.',
    `cip_standard_id` BIGINT COMMENT 'Reference to the specific CIP control (e.g., "CIP‑006‑001") governing this entitlement.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee, contractor, or service account receiving the entitlement.',
    `person_id` BIGINT COMMENT 'Identifier of the individual who approved the entitlement.',
    `scada_system_id` BIGINT COMMENT 'Identifier of the IT/OT system or application to which the entitlement applies.',
    `derived_from_access_entitlement_id` BIGINT COMMENT 'Self-referencing FK on access_entitlement (derived_from_access_entitlement_id)',
    `access_entitlement_status` STRING COMMENT 'Current lifecycle state of the entitlement.. Valid values are `active|revoked|expired|pending|suspended`',
    `access_role` STRING COMMENT 'Permission level granted by the entitlement.. Valid values are `read|write|admin|privileged`',
    `audit_trail_notes` STRING COMMENT 'Free‑form notes captured during audit events related to the entitlement.',
    `business_justification` STRING COMMENT 'Narrative explaining why the entitlement is required for the principals duties.',
    `compliance_requirement` STRING COMMENT 'Regulatory or policy requirement that mandates this entitlement (e.g., "NERC CIP‑006").',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the entitlement record was first created in the system.',
    `entitlement_category` STRING COMMENT 'Broad classification of the entitlement domain.. Valid values are `IT|OT|Network|Application|Database`',
    `entitlement_code` STRING COMMENT 'Unique business code used to reference the entitlement in policies and audits.',
    `entitlement_description` STRING COMMENT 'Detailed description of what the entitlement permits.',
    `entitlement_name` STRING COMMENT 'Human‑readable name describing the entitlement (e.g., "SCADA Read‑Only").',
    `expiration_date` DATE COMMENT 'Date when the entitlement automatically expires; null if indefinite.',
    `grant_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the entitlement was granted.',
    `is_temporary` BOOLEAN COMMENT 'Indicates whether the entitlement is granted for a limited period.',
    `last_review_date` DATE COMMENT 'Date when the entitlement was last reviewed for continued necessity.',
    `nerc_cip_applicability` BOOLEAN COMMENT 'Indicates whether the entitlement falls under NERC CIP‑006 electronic access control requirements.',
    `permission_level` STRING COMMENT 'Numeric representation of the permission hierarchy (higher number = greater privilege).',
    `principal_type` STRING COMMENT 'Classification of the principal (person or service account).. Valid values are `employee|contractor|service_account`',
    `review_frequency_days` STRING COMMENT 'Number of days between mandatory entitlement reviews.',
    `revocation_date` DATE COMMENT 'Date on which the entitlement was revoked.',
    `revocation_reason` STRING COMMENT 'Reason why the entitlement was revoked or removed.',
    `risk_level` STRING COMMENT 'Risk rating associated with the entitlement based on access scope.. Valid values are `low|medium|high|critical`',
    `source_system` STRING COMMENT 'Name of the source system that originated the entitlement record (e.g., "Active Directory").',
    `source_system_code` STRING COMMENT 'Unique identifier of the entitlement in the source system.',
    `system_name` STRING COMMENT 'Descriptive name of the system or application (e.g., "GE PowerOn DMS").',
    `temporary_end_date` DATE COMMENT 'Expiration date for temporary entitlements; null if not temporary.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the entitlement record.',
    CONSTRAINT pk_access_entitlement PRIMARY KEY(`access_entitlement_id`)
) COMMENT 'Master record for logical access entitlements granted to utility employees, contractors, and service accounts across IT systems, OT networks, and critical infrastructure platforms. Captures entitlement identifier, user or service account, system or application, access role or permission level, access type (read, write, admin, privileged), grant date, expiration date, approver, business justification, and NERC CIP Electronic Access Control applicability. Supports identity and access management (IAM) governance and NERC CIP-006/CIP-007 compliance.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`technology`.`access_review` (
    `access_review_id` BIGINT COMMENT 'System-generated unique identifier for the access review record.',
    `access_entitlement_id` BIGINT COMMENT 'Identifier of the logical access entitlement being reviewed.',
    `employee_id` BIGINT COMMENT 'Identifier of the individual (manager or system owner) performing the review.',
    `person_id` BIGINT COMMENT 'Identifier of the individual (manager or system owner) performing the review.',
    `review_owner_employee_id` BIGINT COMMENT 'Identifier of the person accountable for the overall review cycle.',
    `prior_access_review_id` BIGINT COMMENT 'Self-referencing FK on access_review (prior_access_review_id)',
    `auto_review_flag` BOOLEAN COMMENT 'Indicates whether the review was performed automatically by a system.',
    `compliance_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) reflecting compliance level.',
    `compliance_status` STRING COMMENT 'Overall compliance result for the entitlement after review.. Valid values are `compliant|non_compliant|exception`',
    `decision` STRING COMMENT 'Outcome of the review for the entitlement.. Valid values are `certified|revoked|modified|exception`',
    `decision_reason` STRING COMMENT 'Free‑text explanation for the decision taken.',
    `entitlement_name` STRING COMMENT 'Human‑readable name of the entitlement (e.g., SCADA_Read, ERP_Admin).',
    `evidence_documentation` STRING COMMENT 'Reference (URL or file path) to supporting evidence attached to the review.',
    `notes` STRING COMMENT 'Additional comments entered by the reviewer.',
    `overall_status` STRING COMMENT 'Current lifecycle state of the review process.. Valid values are `pending|in_progress|completed|closed`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the review record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the review record.',
    `review_completion_timestamp` TIMESTAMP COMMENT 'Date‑time when the review was finalized.',
    `review_cycle_code` STRING COMMENT 'External code identifying the review cycle (e.g., Q1-2024, ANNUAL-2023).',
    `review_owner_name` STRING COMMENT 'Full name of the review owner.',
    `review_period_end` DATE COMMENT 'Last day of the period covered by the review.',
    `review_period_start` DATE COMMENT 'First day of the period for which access rights are being reviewed.',
    `review_start_timestamp` TIMESTAMP COMMENT 'Date‑time when the review activity began.',
    `review_type` STRING COMMENT 'Classification of the review frequency or purpose.. Valid values are `quarterly|annual|ad_hoc`',
    `reviewer_name` STRING COMMENT 'Full name of the reviewer.',
    `risk_level` STRING COMMENT 'Risk rating associated with the entitlement based on review findings.. Valid values are `low|medium|high|critical`',
    `total_certified` STRING COMMENT 'Number of entitlements that were certified as compliant.',
    `total_entitlements_reviewed` STRING COMMENT 'Count of distinct entitlements included in this review cycle.',
    `total_non_compliant` STRING COMMENT 'Number of entitlements found non‑compliant during the review.',
    CONSTRAINT pk_access_review PRIMARY KEY(`access_review_id`)
) COMMENT 'Periodic access certification and recertification review record for logical access entitlements. Captures review cycle identifier, review period, reviewer (manager or system owner), entitlement reviewed, review decision (certified, revoked, modified), review completion date, and compliance status. Supports quarterly and annual access recertification requirements under NERC CIP and SOX IT general controls.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`technology`.`scada_system` (
    `scada_system_id` BIGINT COMMENT 'Unique system-generated identifier for the SCADA/EMS/DMS control system record.',
    `site_id` BIGINT COMMENT 'Foreign key linking to property.site. Business justification: SCADA monitoring assignments are tied to specific utility sites for operational control and NERC‑CIP reporting.',
    `redundant_scada_system_id` BIGINT COMMENT 'Self-referencing FK on scada_system (redundant_scada_system_id)',
    `asset_tag` STRING COMMENT 'Physical tag or barcode identifier attached to the system hardware.',
    `audit_findings_summary` STRING COMMENT 'Brief summary of key findings and remediation actions from the last audit.',
    `average_response_time_ms` STRING COMMENT 'Mean time in milliseconds for the system to respond to a command or query.',
    `capital_expenditure_amount` DECIMAL(18,2) COMMENT 'Capital cost incurred for acquisition or major upgrades of the system.',
    `communication_architecture` STRING COMMENT 'Network topology used for data exchange between system components.. Valid values are `point_to_point|hub_spoke|bus|mesh`',
    `compliance_status` STRING COMMENT 'Current compliance posture with regulatory and cyber‑security standards.. Valid values are `compliant|non_compliant|pending`',
    `current_operational_state` STRING COMMENT 'Real‑time operational state of the system.. Valid values are `online|offline|degraded|maintenance`',
    `data_retention_period_days` STRING COMMENT 'Number of days operational data is retained in the historian for this system.',
    `decommission_date` DATE COMMENT 'Planned or actual date the system is retired from service.',
    `deployment_environment` STRING COMMENT 'Operational environment where the system is deployed.. Valid values are `production|dr|test|development`',
    `firmware_update_schedule` STRING COMMENT 'Planned cadence or window for firmware upgrades (e.g., "Quarterly – Q2").',
    `geographic_coverage` STRING COMMENT 'Geographic area or jurisdiction the system controls (e.g., "Western Region", "ISO‑NE").',
    `hostname` STRING COMMENT 'DNS hostname of the system.',
    `installation_date` DATE COMMENT 'Date the system was first placed into service.',
    `ip_address` STRING COMMENT 'Network IP address assigned to the systems primary interface.. Valid values are `^((25[0-5]|2[0-4]d|[01]?dd?).){3}(25[0-5]|2[0-4]d|[01]?dd?)$`',
    `last_audit_date` DATE COMMENT 'Date of the most recent compliance or security audit.',
    `last_firmware_update_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent firmware version applied.',
    `last_maintenance_date` DATE COMMENT 'Most recent date on which preventive or corrective maintenance was performed.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent record update.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle stage of the system.. Valid values are `in_service|retired|planned|decommissioned|maintenance`',
    `maintenance_window` STRING COMMENT 'Scheduled time window for routine maintenance (e.g., "Sundays 02:00‑04:00").',
    `max_concurrent_connections` STRING COMMENT 'Maximum number of simultaneous client connections the system can support.',
    `max_throughput_mbps` STRING COMMENT 'Maximum data throughput the system can handle.',
    `nerc_cip_bes_classification` STRING COMMENT 'Cyber‑security classification under NERC CIP for the Bulk Electric System.. Valid values are `critical|non_critical|unknown`',
    `notes` STRING COMMENT 'Additional free‑form remarks or observations about the system.',
    `operating_expenditure_amount` DECIMAL(18,2) COMMENT 'Ongoing operational cost for maintaining the system.',
    `power_consumption_kw` DECIMAL(18,2) COMMENT 'Average electrical power consumed by the system hardware.',
    `primary_function` STRING COMMENT 'Core purpose of the system (e.g., real‑time grid monitoring, outage management, demand response coordination).',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was initially created in the data lake.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the latest audit‑trail update to the record.',
    `redundancy_configuration` STRING COMMENT 'High‑availability setup for the control system.. Valid values are `active_active|active_passive|none`',
    `scada_system_description` STRING COMMENT 'Free‑form description of system capabilities, scope, and notable characteristics.',
    `security_certification` STRING COMMENT 'Security certifications held by the system (e.g., FIPS140-2, ISO27001, None).',
    `support_contact_email` STRING COMMENT 'Email address for the vendor or internal support team responsible for the system.',
    `support_contact_phone` STRING COMMENT 'Phone number for the support team.',
    `supported_protocols` STRING COMMENT 'Comma‑separated list of communication protocols (e.g., IEC 61850, DNP3, Modbus).',
    `system_code` STRING COMMENT 'Unique business code or tag used to reference the system across applications.',
    `system_name` STRING COMMENT 'Human‑readable name of the control system (e.g., "Western Interconnection SCADA").',
    `system_type` STRING COMMENT 'Classification of the control platform (e.g., SCADA, EMS, DMS, GMS, OMS, AMI head‑end, DERMS). [ENUM-REF-CANDIDATE: SCADA|EMS|DMS|GMS|OMS|AMI|DERMS — promote to reference product]',
    `vendor` STRING COMMENT 'Company that supplied or maintains the control system (e.g., GE, Siemens, ABB).',
    `version` STRING COMMENT 'Software version or release identifier of the control system.',
    CONSTRAINT pk_scada_system PRIMARY KEY(`scada_system_id`)
) COMMENT 'Master record for each SCADA, EMS, DMS, GMS, or OT control system platform deployed by the utility. Captures system name, system type (EMS, SCADA, DMS, GMS, OMS, AMI head-end, DERMS), vendor, version, deployment environment (production, DR, test), primary function, geographic coverage area, communication architecture, redundancy configuration, NERC CIP BES Cyber System classification, and lifecycle status. Serves as the SSOT for OT control system inventory distinct from individual OT device records.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` (
    `scada_configuration_id` BIGINT COMMENT 'System-generated unique identifier for each SCADA configuration baseline record.',
    `change_request_id` BIGINT COMMENT 'Identifier of the change request that triggered a configuration update.',
    `scada_system_id` BIGINT COMMENT 'Unique identifier of the SCADA/EMS control system to which the configuration applies.',
    `superseded_scada_configuration_id` BIGINT COMMENT 'Self-referencing FK on scada_configuration (superseded_scada_configuration_id)',
    `approved_by` STRING COMMENT 'Name of the individual or role that approved the configuration baseline.',
    `approved_date` DATE COMMENT 'Date when the configuration baseline was formally approved.',
    `approved_version` STRING COMMENT 'Version of the configuration that has been formally approved as the baseline.',
    `audit_findings` STRING COMMENT 'Summary of findings or observations from the latest audit.',
    `audit_status` STRING COMMENT 'Result of the most recent audit of this configuration.. Valid values are `passed|failed|pending|not‑applicable`',
    `authentication_method` STRING COMMENT 'Method used for authenticating access (e.g., password, certificate, token).',
    `baseline_status` STRING COMMENT 'Indicates whether the record reflects a baseline or a deviation.. Valid values are `baseline|deviation|exception`',
    `change_control_date` DATE COMMENT 'Date when the change control was logged.',
    `change_control_number` STRING COMMENT 'Unique identifier for the change control record associated with this configuration.',
    `change_control_status` STRING COMMENT 'Current status of the change control process.. Valid values are `open|in‑progress|closed|rejected`',
    `change_request_status` STRING COMMENT 'Current lifecycle status of the associated change request.. Valid values are `pending|approved|rejected|implemented|closed`',
    `comments` STRING COMMENT 'Free‑form notes or remarks about the configuration record.',
    `communication_port` STRING COMMENT 'Network port number used for communication with the control system.',
    `compliance_status` STRING COMMENT 'Current compliance status of the configuration with regulatory requirements.. Valid values are `compliant|non‑compliant|exempt|pending`',
    `configuration_category` STRING COMMENT 'High‑level category of the configuration (e.g., network, application, security).',
    `configuration_hash` STRING COMMENT 'Checksum or hash value of the configuration file for integrity verification.',
    `configuration_item_name` STRING COMMENT 'Descriptive name of the specific configuration item.',
    `configuration_item_type` STRING COMMENT 'Category of the configuration item (e.g., software, firmware, service, network).',
    `current_version` STRING COMMENT 'Version of the configuration currently deployed on the system.',
    `deviation_description` STRING COMMENT 'Narrative description of any deviation from the approved baseline.',
    `deviation_flag` BOOLEAN COMMENT 'Indicates whether the current configuration deviates from the approved baseline (True = deviation).',
    `effective_from` DATE COMMENT 'Date from which the approved configuration becomes operational.',
    `effective_until` DATE COMMENT 'Date after which the configuration is no longer valid (null if open‑ended).',
    `enabled_services` STRING COMMENT 'Comma‑separated list of services or modules enabled in the configuration.',
    `encryption_enabled` BOOLEAN COMMENT 'Indicates whether data encryption is enabled for this configuration.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the configuration is deemed critical to safe operation.',
    `last_audit_date` DATE COMMENT 'Date of the most recent audit performed on this configuration.',
    `last_modified_by` STRING COMMENT 'User or role that performed the most recent update to the record.',
    `last_verified_date` DATE COMMENT 'Date on which the configuration was last verified against the approved baseline.',
    `patch_date` DATE COMMENT 'Date on which the most recent patch was applied.',
    `patch_level` STRING COMMENT 'Identifier of the patch level applied to the configuration item.',
    `protocol` STRING COMMENT 'Network protocol used (e.g., TCP, UDP, IEC 61850).',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this configuration record was first created in the data lake.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this configuration record.',
    `regulatory_requirement` STRING COMMENT 'Regulatory standard or requirement that this configuration must satisfy (e.g., NERC CIP‑010).',
    `retention_period_days` STRING COMMENT 'Number of days the configuration record must be retained per policy.',
    `risk_rating` STRING COMMENT 'Risk rating assigned to the configuration based on vulnerability and impact analysis.. Valid values are `low|moderate|high|critical`',
    `security_setting` STRING COMMENT 'Security configuration applied (e.g., firewall rule set, access control list).',
    `source_system` STRING COMMENT 'Originating system that supplied the configuration data (e.g., GE PowerOn, OSIsoft PI).',
    `system_name` STRING COMMENT 'Human‑readable name of the SCADA/EMS control system.',
    `verification_method` STRING COMMENT 'Method used to verify the configuration (e.g., manual review, automated scan).',
    `verification_result` STRING COMMENT 'Outcome of the verification process (e.g., pass, fail, conditional).',
    CONSTRAINT pk_scada_configuration PRIMARY KEY(`scada_configuration_id`)
) COMMENT 'Configuration baseline record for SCADA, EMS, and OT control system platforms capturing approved software versions, patch levels, enabled services, communication port configurations, and security settings. Captures configuration snapshot date, system identifier, configuration item type, approved baseline value, current value, deviation flag, and last verified date. Supports NERC CIP-010 configuration change management and baseline monitoring requirements.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`technology`.`patch_deployment` (
    `patch_deployment_id` BIGINT COMMENT 'Unique surrogate key for each patch deployment record.',
    `employee_id` BIGINT COMMENT 'Internal user identifier who created the deployment record.',
    `it_asset_id` BIGINT COMMENT 'Identifier of the IT/OT asset to which the patch is applied.',
    `updated_by_user_employee_id` BIGINT COMMENT 'Internal user identifier who last modified the deployment record.',
    `superseded_patch_deployment_id` BIGINT COMMENT 'Self-referencing FK on patch_deployment (superseded_patch_deployment_id)',
    `applied_timestamp` TIMESTAMP COMMENT 'Actual date‑time when the patch was applied.',
    `asset_type` STRING COMMENT 'Classification of the asset category.. Valid values are `IT|OT|SCADA|EMS|DMS|Network`',
    `change_control_ticket` STRING COMMENT 'Reference to the ITIL change control ticket associated with the deployment.',
    `compliance_status` STRING COMMENT 'Result of compliance verification for the patch deployment.. Valid values are `compliant|non-compliant|exempt`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the deployment record was first created.',
    `cve_references` STRING COMMENT 'Comma‑separated list of CVE identifiers addressed by the patch.',
    `deferral_reason` STRING COMMENT 'Explanation provided when a deployment is deferred.',
    `deployment_code` STRING COMMENT 'External business identifier or code assigned to the deployment event.',
    `deployment_duration_seconds` STRING COMMENT 'Total time in seconds taken to complete the deployment.',
    `deployment_method` STRING COMMENT 'Technique used to apply the patch.. Valid values are `automated|manual|semi-automated`',
    `deployment_source` STRING COMMENT 'Origin of the patch information or advisory.. Valid values are `vendor_advisory|cisa_kev|internal|third_party`',
    `deployment_status` STRING COMMENT 'Current lifecycle status of the patch deployment.. Valid values are `scheduled|applied|failed|deferred|cancelled`',
    `nerc_cip_applicable` BOOLEAN COMMENT 'Indicates whether NERC CIP‑007 patch‑management requirements apply.',
    `patch_identifier` STRING COMMENT 'Vendor or internal identifier for the software/firmware patch.',
    `patch_size_mb` DECIMAL(18,2) COMMENT 'Size of the patch file in megabytes.',
    `patch_version` STRING COMMENT 'Version string of the patch (e.g., 1.2.3).',
    `rollback_required` BOOLEAN COMMENT 'Indicates whether a rollback was required after deployment.',
    `rollback_timestamp` TIMESTAMP COMMENT 'Timestamp when a rollback was performed, if applicable.',
    `scheduled_timestamp` TIMESTAMP COMMENT 'Planned date‑time for patch deployment.',
    `target_asset_name` STRING COMMENT 'Human‑readable name of the asset receiving the patch.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the deployment record.',
    CONSTRAINT pk_patch_deployment PRIMARY KEY(`patch_deployment_id`)
) COMMENT 'Transactional record for each software or firmware patch deployment applied to IT and OT assets. Captures patch identifier, CVE references addressed, target asset, patch source (vendor advisory, CISA KEV, internal), deployment method (automated, manual), deployment datetime, deployment status (scheduled, applied, failed, deferred), deferral justification, and NERC CIP patch management applicability. Supports NERC CIP-007 security patch management compliance tracking.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`technology`.`software_license` (
    `software_license_id` BIGINT COMMENT 'System-generated unique identifier for each software license record.',
    `application_id` BIGINT COMMENT 'Foreign key linking to technology.application. Business justification: Software licenses are issued for specific applications; FK ties license to its application.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Software license fees are allocated to cost centers for accurate OPEX budgeting.',
    `upgraded_from_software_license_id` BIGINT COMMENT 'Self-referencing FK on software_license (upgraded_from_software_license_id)',
    `annual_cost` DECIMAL(18,2) COMMENT 'Recurring cost charged each year for the license.',
    `compliance_last_checked` DATE COMMENT 'Date the license compliance was last verified.',
    `compliance_status` STRING COMMENT 'Result of the most recent software compliance audit.. Valid values are `compliant|non_compliant|pending_review`',
    `contract_reference` STRING COMMENT 'External reference number linking the license to its governing contract or agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the license record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for monetary amounts.. Valid values are `USD|CAD|EUR|GBP|JPY|CHF`',
    `effective_end_date` DATE COMMENT 'Date when the license expires or terminates; null for perpetual licenses.',
    `effective_start_date` DATE COMMENT 'Date when the license becomes legally binding and usable.',
    `license_key` STRING COMMENT 'Alphanumeric key that uniquely identifies the software entitlement as defined by the vendor.',
    `license_notes` STRING COMMENT 'Free‑form comments or special conditions related to the license.',
    `license_owner` STRING COMMENT 'Business unit or department responsible for the license.',
    `license_region` STRING COMMENT 'Geographic region or country code where the license is authorized for use. [ENUM-REF-CANDIDATE: US|CA|MX|EU|APAC|LATAM|MEA — promote to reference product]',
    `license_status` STRING COMMENT 'Current operational status of the license.. Valid values are `active|inactive|expired|suspended|pending`',
    `license_type` STRING COMMENT 'Classification of the license based on entitlement model.. Valid values are `perpetual|subscription|concurrent|named_user|site`',
    `maintenance_expiration_date` DATE COMMENT 'Date when contractual maintenance services cease.',
    `product_name` STRING COMMENT 'Official name of the software product covered by the license.',
    `purchase_date` DATE COMMENT 'Date the license was purchased or received by the utility.',
    `purchase_order_number` STRING COMMENT 'Internal purchase order identifier associated with the acquisition of the license.',
    `quantity_deployed` STRING COMMENT 'Actual number of units currently installed or in use.',
    `quantity_licensed` STRING COMMENT 'Number of units, seats, or concurrent users authorized by the license.',
    `renewal_date` DATE COMMENT 'Scheduled date for license renewal or re‑negotiation.',
    `renewal_term_months` STRING COMMENT 'Length of the renewal period expressed in months.',
    `support_expiration_date` DATE COMMENT 'Date when vendor support (e.g., help‑desk, patches) ends.',
    `total_cost` DECIMAL(18,2) COMMENT 'Aggregate monetary value of the license agreement over its full term.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the license record.',
    `usage_measure_date` DATE COMMENT 'Date on which the usage metric was recorded.',
    `usage_metric_percent` DECIMAL(18,2) COMMENT 'Percentage of licensed capacity currently utilized.',
    `vendor` STRING COMMENT 'Name of the external software vendor providing the licensed product.',
    CONSTRAINT pk_software_license PRIMARY KEY(`software_license_id`)
) COMMENT 'Master record for software license entitlements held by the utility covering enterprise agreements, perpetual licenses, subscription licenses, and open-source usage. Captures license identifier, software product name, vendor, license type (perpetual, subscription, concurrent, named user, site), licensed quantity, deployed quantity, license start/end dates, annual cost, contract reference, and compliance status. Supports software asset management (SAM) and audit readiness.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` (
    `telecom_circuit_id` BIGINT COMMENT 'Unique system-generated identifier for the telecom circuit record.',
    `backup_circuit_id` BIGINT COMMENT 'Reference to a secondary circuit that can serve as a fail‑over.',
    `network_device_id` BIGINT COMMENT 'Foreign key linking to technology.network_device. Business justification: Telecom circuits are provisioned on network devices; linking removes duplicate network identifiers.',
    `site_id` BIGINT COMMENT 'Foreign key linking to property.site. Business justification: Network Operations tracks circuit origin site for outage impact analysis; linking start_site_id to site.site_id enables accurate reporting.',
    `redundant_telecom_circuit_id` BIGINT COMMENT 'Self-referencing FK on telecom_circuit (redundant_telecom_circuit_id)',
    `bandwidth_mbps` DECIMAL(18,2) COMMENT 'Provisioned bandwidth capacity of the circuit in megabits per second.',
    `carrier` STRING COMMENT 'Service provider that owns or operates the circuit.',
    `circuit_code` STRING COMMENT 'External business identifier assigned by the carrier or internal system.',
    `circuit_tag` STRING COMMENT 'User‑defined tag for categorization or search.',
    `circuit_type` STRING COMMENT 'Physical or logical technology used for the circuit.. Valid values are `fiber|microwave|cellular|leased_line|mpls|satellite`',
    `compliance_requirements` STRING COMMENT 'Regulatory or internal compliance obligations applicable to the circuit.',
    `contract_number` STRING COMMENT 'External contract reference governing the circuit service.',
    `contract_term_months` STRING COMMENT 'Length of the service contract in months.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the circuit record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three‑letter currency code for monetary amounts.. Valid values are `^[A-Z]{3}$`',
    `effective_from` DATE COMMENT 'Date the circuit became operational or contractually effective.',
    `effective_until` DATE COMMENT 'Date the circuit contract expires or is scheduled to end (nullable).',
    `encryption_status` BOOLEAN COMMENT 'Indicates whether data traversing the circuit is encrypted.',
    `end_location_code` STRING COMMENT 'Internal code identifying the end location.',
    `end_site` STRING COMMENT 'Name of the terminating facility or location for the circuit.',
    `failure_count` STRING COMMENT 'Cumulative number of recorded failures since activation.',
    `is_primary` BOOLEAN COMMENT 'Indicates if this circuit is the primary link for its site.',
    `last_failure_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent failure event on the circuit.',
    `last_inspection_date` DATE COMMENT 'Date the circuit was last physically inspected.',
    `maintenance_window` STRING COMMENT 'Typical time window (e.g., 02:00‑04:00) allocated for maintenance.',
    `monitoring_enabled` BOOLEAN COMMENT 'Indicates if the circuit is actively monitored for performance and faults.',
    `monthly_cost` DECIMAL(18,2) COMMENT 'Recurring monthly charge for the circuit.',
    `network_layer` STRING COMMENT 'OSI layer at which the circuit operates.. Valid values are `L1|L2|L3`',
    `next_maintenance_date` DATE COMMENT 'Scheduled date for the next preventive maintenance activity.',
    `provisioning_status` STRING COMMENT 'Current provisioning state of the circuit.. Valid values are `provisioned|provisioning|failed`',
    `qos_profile` STRING COMMENT 'Quality‑of‑Service profile associated with the circuit.',
    `redundancy_flag` BOOLEAN COMMENT 'Indicates whether the circuit provides redundant connectivity.',
    `security_classification` STRING COMMENT 'Classification of the circuit data based on security requirements.. Valid values are `public|internal|confidential|restricted`',
    `service_class` STRING COMMENT 'Classification of the circuit based on its importance to utility operations.. Valid values are `operational_critical|business|backup`',
    `sla_latency_ms` STRING COMMENT 'Maximum latency guaranteed by the service level agreement, in milliseconds.',
    `sla_uptime_percent` DECIMAL(18,2) COMMENT 'Contracted availability percentage for the circuit.',
    `start_location_code` STRING COMMENT 'Internal code identifying the start location (e.g., substation or data center).',
    `technology` STRING COMMENT 'Specific technology standard used for the circuit.. Valid values are `GPON|DWDM|Ethernet|SDH|Microwave`',
    `telecom_circuit_description` STRING COMMENT 'Free‑form description providing additional context about the circuit.',
    `telecom_circuit_name` STRING COMMENT 'Human‑readable name or label for the circuit.',
    `telecom_circuit_status` STRING COMMENT 'Current lifecycle status of the circuit.. Valid values are `active|inactive|planned|decommissioned`',
    `termination_date` DATE COMMENT 'Actual date the circuit service was terminated.',
    `termination_reason` STRING COMMENT 'Reason for early termination or decommissioning of the circuit.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the circuit record.',
    CONSTRAINT pk_telecom_circuit PRIMARY KEY(`telecom_circuit_id`)
) COMMENT 'Master record for telecommunications circuits and wide-area network (WAN) connections used by the utility for operational communications, SCADA telemetry, AMI backhaul, and corporate connectivity. Captures circuit identifier, circuit type (fiber, microwave, cellular, leased line, MPLS, satellite), carrier, bandwidth, endpoints (substation, plant, office, data center), service class (operational critical, business, backup), monthly cost, contract term, and operational status. Covers both IT WAN circuits and OT communication links.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` (
    `disaster_recovery_plan_id` BIGINT COMMENT 'Unique identifier for the disaster recovery plan record.',
    `superseded_disaster_recovery_plan_id` BIGINT COMMENT 'Self-referencing FK on disaster_recovery_plan (superseded_disaster_recovery_plan_id)',
    `alternate_recovery_site` STRING COMMENT 'Backup location used if the primary site is unavailable.',
    `approved_by` STRING COMMENT 'Name of the individual or group that approved the plan.',
    `backup_strategy` STRING COMMENT 'Method used for data backup, e.g., snapshot, replication, cold storage.',
    `compliance_status` STRING COMMENT 'Current compliance status with applicable regulations.. Valid values are `compliant|non_compliant|exempt`',
    `contact_email` STRING COMMENT 'Email address for the plan owner or primary contact.',
    `contact_phone` STRING COMMENT 'Phone number for the plan owner or primary contact.',
    `covered_systems` STRING COMMENT 'Comma‑separated list of critical IT/OT systems covered by the plan.',
    `data_center_location` STRING COMMENT 'Geographic location of the primary data center used in recovery.',
    `disaster_recovery_plan_description` STRING COMMENT 'Narrative description of the plans purpose and scope.',
    `effective_from` DATE COMMENT 'Date when the plan becomes effective.',
    `effective_until` DATE COMMENT 'Date when the plan expires or is superseded; null if open-ended.',
    `last_tested_date` DATE COMMENT 'Date when the disaster recovery plan was last exercised.',
    `last_updated_date` DATE COMMENT 'Date of the most recent plan revision.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the plan.. Valid values are `draft|active|suspended|retired|archived`',
    `next_review_date` DATE COMMENT 'Date of the next scheduled review of the plan.',
    `plan_approval_date` DATE COMMENT 'Date when the plan received formal approval.',
    `plan_budget_usd` DECIMAL(18,2) COMMENT 'Allocated budget for plan development, testing, and maintenance, expressed in US dollars.',
    `plan_category` STRING COMMENT 'Category indicating the criticality level of the plan.. Valid values are `critical|non_critical|optional`',
    `plan_code` STRING COMMENT 'External business identifier or code for the plan.',
    `plan_cost_center_code` STRING COMMENT 'Internal cost center code associated with plan expenditures.',
    `plan_dependencies` STRING COMMENT 'List of other plans or systems that this plan depends on.',
    `plan_document_location` STRING COMMENT 'File path or URL where the official plan document is stored.',
    `plan_last_modified_by` STRING COMMENT 'Name of the user who performed the most recent modification.',
    `plan_name` STRING COMMENT 'Descriptive name of the disaster recovery plan.',
    `plan_owner` STRING COMMENT 'Individual or team responsible for the plans maintenance.',
    `plan_priority` STRING COMMENT 'Priority level assigned to the plan for resource allocation.. Valid values are `high|medium|low`',
    `plan_review_frequency_months` STRING COMMENT 'Number of months between scheduled plan reviews.',
    `plan_scope` STRING COMMENT 'Scope of the plan, such as critical infrastructure or enterprise-wide.',
    `plan_test_frequency_months` STRING COMMENT 'Interval in months between mandatory DR tests.',
    `plan_type` STRING COMMENT 'Classification of the plan as IT DRP, OT/SCADA DRP, or Business Continuity Plan.. Valid values are `IT_DRP|OT_SCADA_DRP|BCP`',
    `plan_version` STRING COMMENT 'Version identifier for the plan, e.g., v1.0, v2.1.',
    `primary_recovery_site` STRING COMMENT 'Designated primary location for system recovery.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the plan record was initially created.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the plan record.',
    `recovery_point_objective_hours` STRING COMMENT 'Maximum allowable data loss measured in hours.',
    `recovery_time_objective_hours` STRING COMMENT 'Maximum allowable downtime in hours for recovery.',
    `regulatory_requirement_reference` STRING COMMENT 'Reference to the regulatory requirement driving the plan, e.g., NERC CIP‑009.',
    `risk_assessment_summary` STRING COMMENT 'High‑level summary of risks addressed by the plan.',
    `test_result_status` STRING COMMENT 'Outcome of the most recent DR test.. Valid values are `passed|failed|partial|not_tested`',
    CONSTRAINT pk_disaster_recovery_plan PRIMARY KEY(`disaster_recovery_plan_id`)
) COMMENT 'Master record for IT and OT disaster recovery plans (DRPs) and business continuity plans (BCPs) covering critical utility systems. Captures plan name, plan type (IT DRP, OT/SCADA DRP, BCP), covered systems, recovery time objective (RTO), recovery point objective (RPO), primary recovery site, alternate recovery site, plan owner, last tested date, last updated date, test result status, and regulatory requirement reference (NERC CIP-009). Supports resilience planning for critical infrastructure.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` (
    `dr_test_event_id` BIGINT COMMENT 'Unique identifier for each disaster recovery or business continuity test exercise.',
    `disaster_recovery_plan_id` BIGINT COMMENT 'Identifier of the disaster recovery plan that was tested.',
    `employee_id` BIGINT COMMENT 'Reference to the approval workflow record authorizing the test.',
    `test_approval_employee_id` BIGINT COMMENT 'Reference to the approval workflow record authorizing the test.',
    `test_lead_employee_id` BIGINT COMMENT 'Identifier of the individual who coordinated and oversaw the test.',
    `retest_of_dr_test_event_id` BIGINT COMMENT 'Self-referencing FK on dr_test_event (retest_of_dr_test_event_id)',
    `compliance_requirements_met` BOOLEAN COMMENT 'True when the test satisfied all regulatory and internal compliance criteria.',
    `corrective_action_due_date` DATE COMMENT 'Planned completion date for all corrective actions.',
    `corrective_action_status` STRING COMMENT 'Lifecycle state of the remediation activities.. Valid values are `pending|in_progress|completed`',
    `corrective_actions` STRING COMMENT 'Actions required to address identified gaps, including owners and target dates.',
    `documentation_url` STRING COMMENT 'URL pointing to the test plan, results, or supporting documents.',
    `gaps_identified` STRING COMMENT 'Detailed list of deficiencies, failures, or shortfalls observed during the test.',
    `is_simulation` BOOLEAN COMMENT 'True if the test was a simulated exercise rather than a live failover.',
    `nerc_cip_applicable` BOOLEAN COMMENT 'True if the test is subject to NERC CIP‑009 recovery plan testing requirements.',
    `notes` STRING COMMENT 'Additional comments, observations, or remarks captured during or after the test.',
    `record_audit_created` TIMESTAMP COMMENT 'Date and time the test record was initially entered into the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Date and time of the latest modification to the test record.',
    `regulatory_reporting_status` STRING COMMENT 'Current status of required regulatory filings related to the test.. Valid values are `not_reported|reported|pending|exempt`',
    `risk_level` STRING COMMENT 'Risk classification based on the severity of gaps identified.. Valid values are `low|medium|high|critical`',
    `rpo_achieved_minutes` STRING COMMENT 'Actual RPO measured during the test, expressed in minutes.',
    `rpo_target_minutes` STRING COMMENT 'Planned RPO for the tested scenario, expressed in minutes.',
    `rto_achieved_minutes` STRING COMMENT 'Actual RTO measured during the test, expressed in minutes.',
    `rto_target_minutes` STRING COMMENT 'Planned RTO for the tested scenario, expressed in minutes.',
    `severity` STRING COMMENT 'Severity of the impact observed during the test.. Valid values are `low|medium|high|critical`',
    `systems_tested` STRING COMMENT 'Identifiers of IT/OT systems, applications, or infrastructure components included in the test.',
    `test_approval_timestamp` TIMESTAMP COMMENT 'Date and time the test received formal approval.',
    `test_category` STRING COMMENT 'Category such as disaster recovery, business continuity, or hybrid.',
    `test_date` DATE COMMENT 'Date of the disaster recovery test (date component only).',
    `test_duration_minutes` STRING COMMENT 'Total elapsed time of the test measured in minutes.',
    `test_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the test concluded.',
    `test_environment` STRING COMMENT 'Specifies the technology domain(s) involved: IT, OT, or both.',
    `test_event_code` STRING COMMENT 'Business identifier used by operations and reporting to reference the test event.',
    `test_execution_reference` BIGINT COMMENT 'Reference to the system‑generated execution log for the test.',
    `test_execution_timestamp` TIMESTAMP COMMENT 'Date and time the test execution was recorded in the execution log.',
    `test_failure_reason` STRING COMMENT 'Explanation of why the test did not achieve its objectives.',
    `test_location` STRING COMMENT 'Facility, data center, or site identifier for the test execution.',
    `test_methodology` STRING COMMENT 'Narrative description of the methodology applied during the test.',
    `test_outcome` STRING COMMENT 'Final outcome indicating whether the test fully passed, partially passed, or failed.. Valid values are `pass|partial_pass|fail`',
    `test_priority` STRING COMMENT 'Business priority used for planning and resource allocation.. Valid values are `low|medium|high`',
    `test_result_summary` STRING COMMENT 'Concise narrative summarizing the outcome, key metrics, and major findings.',
    `test_scope` STRING COMMENT 'Scope classification indicating whether the test covered critical, non‑critical, or partial systems.. Valid values are `critical|non_critical|partial`',
    `test_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the test began.',
    `test_status` STRING COMMENT 'Lifecycle state of the test record.. Valid values are `planned|in_progress|completed|cancelled`',
    `test_success_metric` STRING COMMENT 'Result of the success‑criteria evaluation: met or not_met.. Valid values are `met|not_met`',
    `test_team` STRING COMMENT 'Name or code of the team executing the test.',
    `test_type` STRING COMMENT 'Type of DR test: tabletop (discussion), functional (partial systems), or full failover (complete switch).. Valid values are `tabletop|functional|full_failover`',
    `test_version` STRING COMMENT 'Version number or revision identifier of the DR plan exercised.',
    CONSTRAINT pk_dr_test_event PRIMARY KEY(`dr_test_event_id`)
) COMMENT 'Transactional record for each disaster recovery or business continuity test exercise conducted for IT and OT systems. Captures test event identifier, associated DR plan, test type (tabletop, functional, full failover), test date, systems tested, RTO achieved, RPO achieved, test outcome (pass, partial pass, fail), gaps identified, and corrective actions required. Supports NERC CIP-009 R3 recovery plan testing and documentation requirements.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` (
    `tech_vendor_id` BIGINT COMMENT 'System-generated unique identifier for the technology vendor record.',
    `acquired_by_tech_vendor_id` BIGINT COMMENT 'Self-referencing FK on tech_vendor (acquired_by_tech_vendor_id)',
    `address_line1` STRING COMMENT 'First line of the vendors mailing address.',
    `address_line2` STRING COMMENT 'Second line of the vendors mailing address (optional).',
    `annual_spend_estimate` DECIMAL(18,2) COMMENT 'Projected annual spend with the vendor, expressed in the selected currency.',
    `approved_vendor_list_flag` BOOLEAN COMMENT 'Indicates whether the vendor is on the utilitys approved vendor list.',
    `city` STRING COMMENT 'City component of the vendors mailing address.',
    `compliance_status` STRING COMMENT 'Overall compliance status of the vendor with regulatory and internal policies.. Valid values are `compliant|non_compliant|under_review`',
    `contract_end_date` DATE COMMENT 'Date when the vendor contract expires or terminates (null if open‑ended).',
    `contract_start_date` DATE COMMENT 'Date when the vendor contract became effective.',
    `contract_status` STRING COMMENT 'Current status of the vendors contract with the utility.. Valid values are `active|inactive|pending|terminated|suspended`',
    `country_code` STRING COMMENT 'Three‑letter ISO country code for the vendors primary location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code used for vendor transactions.. Valid values are `USD|CAD|MXN`',
    `data_privacy_certification` STRING COMMENT 'Security or privacy certification held by the vendor.. Valid values are `iso27001|soc2|none`',
    `data_privacy_certification_date` DATE COMMENT 'Date when the current data privacy certification was obtained.',
    `duns_number` STRING COMMENT 'Dun & Bradstreet unique identifier for the vendor.',
    `insurance_coverage_status` STRING COMMENT 'Status of the vendors required insurance coverage.. Valid values are `insured|uninsured|pending`',
    `insurance_expiration_date` DATE COMMENT 'Date when the vendors insurance coverage expires.',
    `last_rating_date` DATE COMMENT 'Date when the most recent vendor rating was recorded.',
    `last_security_incident_date` DATE COMMENT 'Date of the most recent security incident involving the vendor.',
    `last_security_incident_description` STRING COMMENT 'Brief description of the most recent security incident involving the vendor.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle stage of the vendor record within the master data management process.. Valid values are `active|inactive|archived|pending_review`',
    `nerc_cip_scrm_classification` STRING COMMENT 'Supply Chain Risk Management classification per NERC CIP guidelines.. Valid values are `low|medium|high|critical`',
    `notes` STRING COMMENT 'Free‑form notes or comments about the vendor.',
    `payment_terms` STRING COMMENT 'Standard payment terms negotiated with the vendor.. Valid values are `net30|net45|net60`',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the vendors mailing address.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary vendor contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Name of the primary business contact for the vendor.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary vendor contact.',
    `rating_score` DECIMAL(18,2) COMMENT 'Overall performance rating (0.00‑5.00) assigned by the utility.',
    `registration_number` STRING COMMENT 'State or regulatory registration number for the vendor.',
    `security_assessment_status` STRING COMMENT 'Progress status of the vendors NERC CIP security assessment.. Valid values are `not_started|in_progress|completed|failed`',
    `service_area` STRING COMMENT 'Geographic region(s) where the vendor provides services to the utility.',
    `state_province` STRING COMMENT 'State or province component of the vendors mailing address.',
    `tax_identification_number` STRING COMMENT 'Government‑issued tax identifier for the vendor (e.g., EIN).',
    `tech_vendor_name` STRING COMMENT 'Full legal name of the vendor organization.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the vendor record.',
    `vendor_contact_email` STRING COMMENT 'Email address of the secondary vendor contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `vendor_contact_phone` STRING COMMENT 'Phone number of the secondary vendor contact.',
    `vendor_contact_role` STRING COMMENT 'Role of the secondary vendor contact (e.g., account manager, technical lead).',
    `vendor_rating_source` STRING COMMENT 'Indicates whether the vendor rating originates from internal assessment or an external audit.. Valid values are `internal|external`',
    `vendor_type` STRING COMMENT 'Classification of the vendor based on the primary products or services provided to the utility.. Valid values are `hardware_oem|software_vendor|msp|systems_integrator|telecom_carrier|ot_scada_vendor`',
    `website_url` STRING COMMENT 'Public website address of the vendor.',
    CONSTRAINT pk_tech_vendor PRIMARY KEY(`tech_vendor_id`)
) COMMENT 'Master record for technology vendors, managed service providers (MSPs), and IT/OT contractors providing technology products and services to the utility. Captures vendor name, vendor type (hardware OEM, software vendor, MSP, systems integrator, telecom carrier, OT/SCADA vendor), primary contact, contract status, security assessment status, NERC CIP supply chain risk management (SCRM) classification, and approved vendor list status. Distinct from the supply domains vendor master which focuses on fuel and materials procurement.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`technology`.`supply_chain_risk` (
    `supply_chain_risk_id` BIGINT COMMENT 'Unique surrogate key for each supply chain risk record.',
    `employee_id` BIGINT COMMENT 'Surrogate key referencing the employee or team responsible for the risk.',
    `it_asset_id` BIGINT COMMENT 'Surrogate key referencing the component master record.',
    `vendor_id` BIGINT COMMENT 'Surrogate key referencing the vendor master record.',
    `reassessed_supply_chain_risk_id` BIGINT COMMENT 'Self-referencing FK on supply_chain_risk (reassessed_supply_chain_risk_id)',
    `assessment_date` DATE COMMENT 'Date the risk assessment was performed.',
    `assessment_status` STRING COMMENT 'Current workflow status of the risk assessment.. Valid values are `pending|in_progress|completed|deferred`',
    `compliance_reference` STRING COMMENT 'Reference to the specific NERC CIP‑013 clause or other regulatory requirement.',
    `component_name` STRING COMMENT 'Name of the hardware or software component supplied by the vendor.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the risk record was first created in the system.',
    `identified_threats` STRING COMMENT 'Narrative description of specific threats associated with the vendor or component.',
    `last_review_date` DATE COMMENT 'Date the risk assessment was most recently reviewed.',
    `mitigating_controls` STRING COMMENT 'Controls or safeguards implemented to reduce the identified risk.',
    `nerc_cip_applicable` BOOLEAN COMMENT 'Indicates whether the risk falls under NERC CIP‑013 scope.',
    `nerc_cip_reported` BOOLEAN COMMENT 'True if the risk has been reported to the regulatory body as required.',
    `next_review_date` DATE COMMENT 'Planned date for the next risk assessment review.',
    `record_status` STRING COMMENT 'Current lifecycle status of the risk record.. Valid values are `active|inactive|archived`',
    `regulatory_notification_status` STRING COMMENT 'Status of any required regulatory notifications related to the risk.. Valid values are `not_required|required|submitted|approved|rejected`',
    `remediation_action_plan` STRING COMMENT 'Detailed plan describing steps to remediate the risk.',
    `remediation_due_date` DATE COMMENT 'Target date by which remediation must be completed.',
    `remediation_status` STRING COMMENT 'State of remediation activities for the identified risk.. Valid values are `not_started|in_progress|completed|not_applicable`',
    `risk_assessment_identifier` STRING COMMENT 'External identifier or code assigned to the risk assessment record by the utility.',
    `risk_category` STRING COMMENT 'Classification of the risk type according to NERC CIP‑013 guidance.. Valid values are `software_integrity|hardware_authenticity|remote_access|vendor_notification|supply_chain_disruption`',
    `risk_comments` STRING COMMENT 'Additional notes or observations captured by the assessor.',
    `risk_exposure_amount_usd` DECIMAL(18,2) COMMENT 'Estimated monetary impact of the risk expressed in U.S. dollars.',
    `risk_owner` STRING COMMENT 'Name of the internal individual or team responsible for managing the risk.',
    `risk_rating` STRING COMMENT 'Overall rating indicating the severity of the identified supply chain risk.. Valid values are `low|moderate|high|critical`',
    `risk_score` DECIMAL(18,2) COMMENT 'Numeric score derived from the utilitys internal risk scoring methodology.',
    `source_system` STRING COMMENT 'System of record where the risk information originated.. Valid values are `ERP|CMDB|Manual|Other`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the risk record.',
    CONSTRAINT pk_supply_chain_risk PRIMARY KEY(`supply_chain_risk_id`)
) COMMENT 'NERC CIP-013 supply chain cyber security risk management record for technology vendors and software/hardware components used in BES Cyber Systems. Captures risk assessment identifier, vendor or component assessed, risk category (software integrity, hardware authenticity, remote access, vendor notification), risk rating, identified threats, mitigating controls, assessment date, and remediation status. Supports the utilitys NERC CIP-013 supply chain risk management plan.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`technology`.`it_sla` (
    `it_sla_id` BIGINT COMMENT 'Unique surrogate key for the SLA record.',
    `employee_id` BIGINT COMMENT 'Identifier of the internal owner responsible for the service covered by the SLA.',
    `it_service_id` BIGINT COMMENT 'Foreign key linking to technology.it_service. Business justification: An SLA is defined for a specific IT service; FK replaces free‑text service_type.',
    `person_id` BIGINT COMMENT 'Identifier of the internal owner responsible for the service covered by the SLA.',
    `superseded_it_sla_id` BIGINT COMMENT 'Self-referencing FK on it_sla (superseded_it_sla_id)',
    `breach_indicator` BOOLEAN COMMENT 'Flag indicating whether a breach has occurred during the reporting period.',
    `business_unit` STRING COMMENT 'Internal business unit responsible for the service covered by the SLA.. Valid values are `generation|transmission|distribution|customer_service|finance|it`',
    `compliance_requirement` STRING COMMENT 'Regulatory or standards requirement that the SLA must satisfy.. Valid values are `NERC_CIP|FERC|PUC|ISO|EPA|NIST`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the SLA record was first created.',
    `effective_end_date` DATE COMMENT 'Date the SLA terminates or expires (null for open‑ended).',
    `effective_start_date` DATE COMMENT 'Date the SLA becomes binding.',
    `escalation_contact` STRING COMMENT 'Email address of the person or group to notify on escalation.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `escalation_threshold` DECIMAL(18,2) COMMENT 'Metric value that triggers an escalation.',
    `escalation_threshold_unit` STRING COMMENT 'Unit of measure for the escalation threshold.. Valid values are `%|minutes|hours|seconds|days|requests`',
    `it_sla_description` STRING COMMENT 'Free‑form description of the SLA purpose and scope.',
    `last_review_date` DATE COMMENT 'Date the SLA was last formally reviewed.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the SLA.. Valid values are `active|inactive|draft|suspended|retired`',
    `measurement_period` STRING COMMENT 'Time window over which the metric is calculated.. Valid values are `daily|weekly|monthly|quarterly|yearly|rolling_12_months`',
    `metric_type` STRING COMMENT 'Metric measured against the SLA target.. Valid values are `availability|mttr|response_time|resolution_time|uptime|downtime`',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty applied when the SLA is breached.',
    `penalty_currency` STRING COMMENT 'Currency of the penalty amount.. Valid values are `USD|EUR|GBP|CAD|JPY|AUD`',
    `reporting_frequency` STRING COMMENT 'How often SLA performance is reported.. Valid values are `daily|weekly|monthly|quarterly|annually`',
    `review_frequency` STRING COMMENT 'How often the SLA must be reviewed.. Valid values are `annual|biennial|quarterly`',
    `service_owner_name` STRING COMMENT 'Full name of the service owner.',
    `sla_name` STRING COMMENT 'Human‑readable name of the SLA.',
    `sla_number` STRING COMMENT 'External reference number assigned to the SLA.',
    `sla_version` STRING COMMENT 'Version identifier for the SLA document.',
    `target_unit` STRING COMMENT 'Unit of measure for the target value.. Valid values are `%|minutes|hours|seconds|days|requests`',
    `target_value` DECIMAL(18,2) COMMENT 'Numeric target that the metric must meet.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the SLA record.',
    CONSTRAINT pk_it_sla PRIMARY KEY(`it_sla_id`)
) COMMENT 'Master record for IT and OT service level agreements defining performance commitments between the technology organization and internal business unit customers. Captures SLA identifier, associated IT service, SLA metric type (availability %, MTTR, response time, resolution time), target value, measurement period, reporting frequency, escalation thresholds, and business unit covered. Provides the reference baseline against which SLA performance is measured from incident and service request data.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`technology`.`digital_platform` (
    `digital_platform_id` BIGINT COMMENT 'Unique surrogate key for each digital platform record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Digital platform development and maintenance expenses are tracked against a cost center for financial planning.',
    `tech_project_id` BIGINT COMMENT 'Foreign key linking to technology.tech_project. Business justification: Digital platforms are often delivered as part of a technology project; linking provides project context.',
    `superseded_digital_platform_id` BIGINT COMMENT 'Self-referencing FK on digital_platform (superseded_digital_platform_id)',
    `active_user_count` BIGINT COMMENT 'Number of distinct users actively using the platform during the most recent reporting period.',
    `api_version` STRING COMMENT 'Version identifier of the platforms public API surface.',
    `average_response_time_ms` STRING COMMENT 'Mean time in milliseconds for the platform to respond to user requests.',
    `compliance_status` STRING COMMENT 'Current compliance posture of the platform with applicable regulations (e.g., NERC CIP, FERC).. Valid values are `compliant|non_compliant|pending|exempt`',
    `creation_timestamp` TIMESTAMP COMMENT 'Timestamp when the digital platform record was first created in the system.',
    `data_privacy_impact_assessment` STRING COMMENT 'Result of the most recent privacy impact assessment for the platform.',
    `data_retention_period_days` STRING COMMENT 'Number of days data generated by the platform is retained before archival or deletion.',
    `decommission_date` DATE COMMENT 'Planned or actual date when the platform will be retired from service.',
    `deployment_model` STRING COMMENT 'How the platform is hosted or delivered to users.. Valid values are `on_premise|cloud|hybrid|edge`',
    `digital_platform_description` STRING COMMENT 'Free‑text description of the platforms purpose, scope, and key features.',
    `digital_platform_name` STRING COMMENT 'Human‑readable name of the digital platform.',
    `digital_platform_status` STRING COMMENT 'Current operational state of the platform.. Valid values are `active|inactive|decommissioned|planned|retired`',
    `in_house_development_flag` BOOLEAN COMMENT 'True if the platform was developed internally; otherwise False.',
    `integration_points_count` STRING COMMENT 'Total number of external systems or APIs integrated with the platform.',
    `last_release_date` DATE COMMENT 'Date of the most recent production release of the platform.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the digital platform record.',
    `platform_code` STRING COMMENT 'Business‑assigned code that uniquely identifies the platform across the enterprise.',
    `platform_owner` STRING COMMENT 'Business owner or product manager responsible for the platform.',
    `platform_type` STRING COMMENT 'Category of the platform based on its primary consumer or function.. Valid values are `customer_portal|mobile_app|data_platform|analytics_platform|integration_platform|other`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'True if the platform is subject to mandatory regulatory reporting.',
    `release_version` STRING COMMENT 'Version identifier of the currently deployed software release.',
    `security_classification` STRING COMMENT 'Information security classification assigned to the platform.. Valid values are `public|internal|confidential|restricted`',
    `supported_capabilities` STRING COMMENT 'Comma‑separated list of core business capabilities the platform enables (e.g., self‑service billing, outage notifications).',
    `uptime_percentage` DECIMAL(18,2) COMMENT 'Average percentage of time the platform was available during the reporting period.',
    `vendor` STRING COMMENT 'External vendor or internal development team responsible for the platform.',
    CONSTRAINT pk_digital_platform PRIMARY KEY(`digital_platform_id`)
) COMMENT 'Master record for digital customer and operational platforms managed by the technology organization including customer self-service portals, mobile apps, AMI data platforms, DERMS platforms, and grid analytics platforms. Captures platform name, platform type (customer portal, mobile app, data platform, analytics platform, integration platform), deployment model, supported business capabilities, active user count, release version, vendor or in-house development flag, and lifecycle status. Supports digital transformation portfolio management.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`technology`.`platform_release` (
    `platform_release_id` BIGINT COMMENT 'Unique identifier for the platform release record.',
    `application_id` BIGINT COMMENT 'Unique identifier of the target application or platform.',
    `change_request_id` BIGINT COMMENT 'Identifier of the change request that triggered this release.',
    `created_by_user_employee_id` BIGINT COMMENT 'User identifier of the person who created the release record.',
    `digital_platform_id` BIGINT COMMENT 'Foreign key linking to technology.digital_platform. Business justification: Platform releases belong to a specific digital platform; FK captures this relationship.',
    `employee_id` BIGINT COMMENT 'User who scheduled the release deployment.',
    `release_manager_employee_id` BIGINT COMMENT 'User identifier of the manager responsible for the release.',
    `scheduled_by_user_employee_id` BIGINT COMMENT 'User who scheduled the release deployment.',
    `updated_by_user_employee_id` BIGINT COMMENT 'User identifier of the person who last updated the release record.',
    `rollback_platform_release_id` BIGINT COMMENT 'Self-referencing FK on platform_release (rollback_platform_release_id)',
    `actual_deployment_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the release was deployed to the target environment.',
    `affected_systems` STRING COMMENT 'Comma‑separated list of systems or services impacted by the release.',
    `approval_status` STRING COMMENT 'Current approval state of the release.. Valid values are `approved|pending|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the release was approved.',
    `audit_log_reference` STRING COMMENT 'Reference identifier to the detailed audit log entry for the release.',
    `change_impact_description` STRING COMMENT 'Narrative description of the operational or business impact of the release.',
    `change_window_duration_minutes` STRING COMMENT 'Calculated duration of the change window in minutes.',
    `change_window_end` TIMESTAMP COMMENT 'Planned end time of the change window for the release.',
    `change_window_start` TIMESTAMP COMMENT 'Planned start time of the change window for the release.',
    `compliance_status` STRING COMMENT 'Regulatory compliance status of the release.. Valid values are `compliant|non_compliant|exempt`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the release record was first created in the system.',
    `deployment_duration_seconds` STRING COMMENT 'Total elapsed time of the deployment process measured in seconds.',
    `deployment_environment` STRING COMMENT 'Target environment for the deployment.. Valid values are `dev|test|staging|production`',
    `deployment_method` STRING COMMENT 'Method used to perform the deployment.. Valid values are `automated|manual|semi_automated`',
    `deployment_status` STRING COMMENT 'Current lifecycle status of the deployment.. Valid values are `scheduled|in_progress|completed|failed|rolled_back|cancelled`',
    `documentation_url` STRING COMMENT 'Link to release documentation or release notes.',
    `is_emergency_release` BOOLEAN COMMENT 'Indicates whether the release was performed as an emergency.',
    `is_hotfix` BOOLEAN COMMENT 'True if the release is a hotfix.',
    `nerc_cip_applicable` BOOLEAN COMMENT 'Indicates whether the release is subject to NERC CIP requirements.',
    `number_of_changes` STRING COMMENT 'Count of individual change items (e.g., code commits, configuration updates) packaged in the release.',
    `planned_deployment_date` DATE COMMENT 'Scheduled calendar date for the release deployment.',
    `post_deployment_validation_outcome` STRING COMMENT 'Result of validation activities after deployment.. Valid values are `passed|failed|partial|not_executed`',
    `regulatory_notification_required` BOOLEAN COMMENT 'Indicates if regulatory bodies must be notified about this release.',
    `regulatory_notification_status` STRING COMMENT 'Current status of any required regulatory notification.. Valid values are `not_required|pending|sent|failed`',
    `release_notes` STRING COMMENT 'Brief description of changes, features, and fixes included in the release.',
    `release_number` STRING COMMENT 'External release number or code assigned by the organization.',
    `release_owner_team` STRING COMMENT 'Team or business unit that owns the release.',
    `release_type` STRING COMMENT 'Classification of the release indicating its scope and impact.. Valid values are `major|minor|patch|hotfix`',
    `release_version` STRING COMMENT 'Semantic version string (e.g., 1.2.3) representing the release.',
    `risk_level` STRING COMMENT 'Assessed risk associated with the release.. Valid values are `low|medium|high|critical`',
    `rollback_required` BOOLEAN COMMENT 'Indicates whether a rollback was required for this release.',
    `rollback_timestamp` TIMESTAMP COMMENT 'Timestamp when the rollback was executed, if applicable.',
    `security_classification` STRING COMMENT 'Security classification assigned to the release artifact.. Valid values are `public|internal|confidential|restricted`',
    `source_control_branch` STRING COMMENT 'Version control branch from which the release was built.',
    `source_control_commit_hash` STRING COMMENT 'Commit hash or identifier associated with the release build.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the release record.',
    `validation_timestamp` TIMESTAMP COMMENT 'Timestamp when post‑deployment validation was performed.',
    CONSTRAINT pk_platform_release PRIMARY KEY(`platform_release_id`)
) COMMENT 'Transactional record for each software release, deployment, or version update for digital platforms and enterprise applications. Captures release identifier, associated application or platform, release version, release type (major, minor, patch, hotfix), planned deployment date, actual deployment date, deployment environment (dev, test, staging, production), release notes summary, change request reference, deployment status, and post-deployment validation outcome. Supports application lifecycle management and release governance.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`technology`.`tech_spend` (
    `tech_spend_id` BIGINT COMMENT 'Unique surrogate key for each technology spend record.',
    `approver_employee_id` BIGINT COMMENT 'Identifier of the employee who approved the spend.',
    `created_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who created the spend record.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who approved the spend.',
    `tech_project_id` BIGINT COMMENT 'Identifier of the technology project or initiative associated with the spend.',
    `updated_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last updated the spend record.',
    `vendor_id` BIGINT COMMENT 'Identifier of the external vendor providing the technology product or service.',
    `adjustment_of_tech_spend_id` BIGINT COMMENT 'Self-referencing FK on tech_spend (adjustment_of_tech_spend_id)',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of the spend allocated to the primary cost center when using percentage allocation.',
    `amount` DECIMAL(18,2) COMMENT 'Total gross amount of the spend before taxes or adjustments.',
    `approval_date` DATE COMMENT 'Date the spend was approved.',
    `approval_status` STRING COMMENT 'State of the internal approval workflow for the spend.. Valid values are `not_requested|requested|approved|rejected`',
    `capex_flag` BOOLEAN COMMENT 'True if the spend is capitalized (CAPEX); False if it is operating expense (OPEX).',
    `compliance_requirement` STRING COMMENT 'Regulatory or compliance regime that applies to the spend (e.g., NERC CIP).. Valid values are `none|nerc_cip|ferc|state|federal`',
    `cost_allocation_method` STRING COMMENT 'Method used to allocate the spend across cost centers or projects.. Valid values are `direct|percentage|full_absorption`',
    `cost_center_code` STRING COMMENT 'Internal cost‑center identifier to which the spend is charged.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the spend record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the spend.. Valid values are `^[A-Z]{3}$`',
    `internal_comments` STRING COMMENT 'Internal notes or remarks about the spend record.',
    `invoice_date` DATE COMMENT 'Date the vendor issued the invoice.',
    `invoice_number` STRING COMMENT 'Number of the vendor invoice associated with the spend.',
    `is_recurring` BOOLEAN COMMENT 'True if the spend is part of a recurring contract or subscription.',
    `lifecycle_status` STRING COMMENT 'Current processing status of the spend record.. Valid values are `pending|approved|posted|rejected|cancelled`',
    `net_amount` DECIMAL(18,2) COMMENT 'Net amount after tax and any discounts.',
    `payment_due_date` DATE COMMENT 'Date by which payment must be made to the vendor.',
    `payment_method` STRING COMMENT 'Method used to settle the invoice.. Valid values are `credit_card|bank_transfer|check|wire|internal_transfer`',
    `payment_status` STRING COMMENT 'Current payment settlement status.. Valid values are `unpaid|paid|partial|overdue`',
    `purchase_order_number` STRING COMMENT 'Internal purchase order reference linked to the spend.',
    `recurring_frequency` STRING COMMENT 'Interval at which recurring spend occurs.. Valid values are `monthly|quarterly|annually`',
    `related_application` STRING COMMENT 'Name of the application or system that benefits from the spend.',
    `related_technology_project` STRING COMMENT 'Business identifier of the technology project linked to this spend.',
    `spend_category` STRING COMMENT 'High‑level classification of the spend (e.g., hardware, software, cloud).. Valid values are `hardware|software|telecom|managed_services|professional_services|cloud`',
    `spend_date` DATE COMMENT 'Date the spend was incurred or recognized.',
    `spend_number` STRING COMMENT 'External reference number assigned to the spend transaction for tracking.',
    `spend_period_end` DATE COMMENT 'End date of the accounting period the spend belongs to.',
    `spend_period_start` DATE COMMENT 'Start date of the accounting period the spend belongs to.',
    `spend_subcategory` STRING COMMENT 'More detailed classification within the spend category.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component of the spend, if applicable.',
    `tech_spend_description` STRING COMMENT 'Free‑form text describing the purpose or nature of the spend.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the spend record.',
    CONSTRAINT pk_tech_spend PRIMARY KEY(`tech_spend_id`)
) COMMENT 'Technology expenditure record tracking actual IT and OT spending by category, cost center, and project for internal technology financial management. Captures spend record identifier, spend category (hardware, software licenses, telecom, managed services, professional services, cloud), vendor, invoice reference, amount, currency, spend period, associated tech project or application, cost center, and capitalization flag (CAPEX vs OPEX). Supports technology total cost of ownership (TCO) analysis and IT budget management distinct from the finance domains general ledger.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ADD CONSTRAINT `fk_technology_it_asset_replaced_it_asset_id` FOREIGN KEY (`replaced_it_asset_id`) REFERENCES `power_and_utilities_v2`.`technology`.`it_asset`(`it_asset_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ADD CONSTRAINT `fk_technology_ot_asset_scada_system_id` FOREIGN KEY (`scada_system_id`) REFERENCES `power_and_utilities_v2`.`technology`.`scada_system`(`scada_system_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ADD CONSTRAINT `fk_technology_ot_asset_replaced_ot_asset_id` FOREIGN KEY (`replaced_ot_asset_id`) REFERENCES `power_and_utilities_v2`.`technology`.`ot_asset`(`ot_asset_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ADD CONSTRAINT `fk_technology_application_parent_application_id` FOREIGN KEY (`parent_application_id`) REFERENCES `power_and_utilities_v2`.`technology`.`application`(`application_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ADD CONSTRAINT `fk_technology_network_device_it_asset_id` FOREIGN KEY (`it_asset_id`) REFERENCES `power_and_utilities_v2`.`technology`.`it_asset`(`it_asset_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ADD CONSTRAINT `fk_technology_network_device_upstream_network_device_id` FOREIGN KEY (`upstream_network_device_id`) REFERENCES `power_and_utilities_v2`.`technology`.`network_device`(`network_device_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ADD CONSTRAINT `fk_technology_it_service_it_asset_id` FOREIGN KEY (`it_asset_id`) REFERENCES `power_and_utilities_v2`.`technology`.`it_asset`(`it_asset_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ADD CONSTRAINT `fk_technology_it_service_parent_it_service_id` FOREIGN KEY (`parent_it_service_id`) REFERENCES `power_and_utilities_v2`.`technology`.`it_service`(`it_service_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ADD CONSTRAINT `fk_technology_incident_ticket_it_service_id` FOREIGN KEY (`it_service_id`) REFERENCES `power_and_utilities_v2`.`technology`.`it_service`(`it_service_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ADD CONSTRAINT `fk_technology_incident_ticket_parent_incident_ticket_id` FOREIGN KEY (`parent_incident_ticket_id`) REFERENCES `power_and_utilities_v2`.`technology`.`incident_ticket`(`incident_ticket_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`change_request` ADD CONSTRAINT `fk_technology_change_request_tech_project_id` FOREIGN KEY (`tech_project_id`) REFERENCES `power_and_utilities_v2`.`technology`.`tech_project`(`tech_project_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`change_request` ADD CONSTRAINT `fk_technology_change_request_rollback_change_request_id` FOREIGN KEY (`rollback_change_request_id`) REFERENCES `power_and_utilities_v2`.`technology`.`change_request`(`change_request_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ADD CONSTRAINT `fk_technology_service_request_ticket_it_asset_id` FOREIGN KEY (`it_asset_id`) REFERENCES `power_and_utilities_v2`.`technology`.`it_asset`(`it_asset_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ADD CONSTRAINT `fk_technology_service_request_ticket_it_service_id` FOREIGN KEY (`it_service_id`) REFERENCES `power_and_utilities_v2`.`technology`.`it_service`(`it_service_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ADD CONSTRAINT `fk_technology_service_request_ticket_change_request_id` FOREIGN KEY (`change_request_id`) REFERENCES `power_and_utilities_v2`.`technology`.`change_request`(`change_request_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ADD CONSTRAINT `fk_technology_service_request_ticket_originating_service_request_ticket_id` FOREIGN KEY (`originating_service_request_ticket_id`) REFERENCES `power_and_utilities_v2`.`technology`.`service_request_ticket`(`service_request_ticket_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ADD CONSTRAINT `fk_technology_tech_project_tech_vendor_id` FOREIGN KEY (`tech_vendor_id`) REFERENCES `power_and_utilities_v2`.`technology`.`tech_vendor`(`tech_vendor_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ADD CONSTRAINT `fk_technology_tech_project_parent_tech_project_id` FOREIGN KEY (`parent_tech_project_id`) REFERENCES `power_and_utilities_v2`.`technology`.`tech_project`(`tech_project_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`project_milestone` ADD CONSTRAINT `fk_technology_project_milestone_change_request_id` FOREIGN KEY (`change_request_id`) REFERENCES `power_and_utilities_v2`.`technology`.`change_request`(`change_request_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`project_milestone` ADD CONSTRAINT `fk_technology_project_milestone_tech_project_id` FOREIGN KEY (`tech_project_id`) REFERENCES `power_and_utilities_v2`.`technology`.`tech_project`(`tech_project_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`project_milestone` ADD CONSTRAINT `fk_technology_project_milestone_predecessor_project_milestone_id` FOREIGN KEY (`predecessor_project_milestone_id`) REFERENCES `power_and_utilities_v2`.`technology`.`project_milestone`(`project_milestone_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_vulnerability` ADD CONSTRAINT `fk_technology_cyber_vulnerability_it_asset_id` FOREIGN KEY (`it_asset_id`) REFERENCES `power_and_utilities_v2`.`technology`.`it_asset`(`it_asset_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_vulnerability` ADD CONSTRAINT `fk_technology_cyber_vulnerability_rediscovered_cyber_vulnerability_id` FOREIGN KEY (`rediscovered_cyber_vulnerability_id`) REFERENCES `power_and_utilities_v2`.`technology`.`cyber_vulnerability`(`cyber_vulnerability_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_incident` ADD CONSTRAINT `fk_technology_cyber_incident_it_asset_id` FOREIGN KEY (`it_asset_id`) REFERENCES `power_and_utilities_v2`.`technology`.`it_asset`(`it_asset_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_incident` ADD CONSTRAINT `fk_technology_cyber_incident_cyber_vulnerability_id` FOREIGN KEY (`cyber_vulnerability_id`) REFERENCES `power_and_utilities_v2`.`technology`.`cyber_vulnerability`(`cyber_vulnerability_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_incident` ADD CONSTRAINT `fk_technology_cyber_incident_related_cyber_incident_id` FOREIGN KEY (`related_cyber_incident_id`) REFERENCES `power_and_utilities_v2`.`technology`.`cyber_incident`(`cyber_incident_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` ADD CONSTRAINT `fk_technology_access_entitlement_scada_system_id` FOREIGN KEY (`scada_system_id`) REFERENCES `power_and_utilities_v2`.`technology`.`scada_system`(`scada_system_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` ADD CONSTRAINT `fk_technology_access_entitlement_derived_from_access_entitlement_id` FOREIGN KEY (`derived_from_access_entitlement_id`) REFERENCES `power_and_utilities_v2`.`technology`.`access_entitlement`(`access_entitlement_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` ADD CONSTRAINT `fk_technology_access_review_access_entitlement_id` FOREIGN KEY (`access_entitlement_id`) REFERENCES `power_and_utilities_v2`.`technology`.`access_entitlement`(`access_entitlement_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` ADD CONSTRAINT `fk_technology_access_review_prior_access_review_id` FOREIGN KEY (`prior_access_review_id`) REFERENCES `power_and_utilities_v2`.`technology`.`access_review`(`access_review_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ADD CONSTRAINT `fk_technology_scada_system_redundant_scada_system_id` FOREIGN KEY (`redundant_scada_system_id`) REFERENCES `power_and_utilities_v2`.`technology`.`scada_system`(`scada_system_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ADD CONSTRAINT `fk_technology_scada_configuration_change_request_id` FOREIGN KEY (`change_request_id`) REFERENCES `power_and_utilities_v2`.`technology`.`change_request`(`change_request_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ADD CONSTRAINT `fk_technology_scada_configuration_scada_system_id` FOREIGN KEY (`scada_system_id`) REFERENCES `power_and_utilities_v2`.`technology`.`scada_system`(`scada_system_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ADD CONSTRAINT `fk_technology_scada_configuration_superseded_scada_configuration_id` FOREIGN KEY (`superseded_scada_configuration_id`) REFERENCES `power_and_utilities_v2`.`technology`.`scada_configuration`(`scada_configuration_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`patch_deployment` ADD CONSTRAINT `fk_technology_patch_deployment_it_asset_id` FOREIGN KEY (`it_asset_id`) REFERENCES `power_and_utilities_v2`.`technology`.`it_asset`(`it_asset_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`patch_deployment` ADD CONSTRAINT `fk_technology_patch_deployment_superseded_patch_deployment_id` FOREIGN KEY (`superseded_patch_deployment_id`) REFERENCES `power_and_utilities_v2`.`technology`.`patch_deployment`(`patch_deployment_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`software_license` ADD CONSTRAINT `fk_technology_software_license_application_id` FOREIGN KEY (`application_id`) REFERENCES `power_and_utilities_v2`.`technology`.`application`(`application_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`software_license` ADD CONSTRAINT `fk_technology_software_license_upgraded_from_software_license_id` FOREIGN KEY (`upgraded_from_software_license_id`) REFERENCES `power_and_utilities_v2`.`technology`.`software_license`(`software_license_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ADD CONSTRAINT `fk_technology_telecom_circuit_backup_circuit_id` FOREIGN KEY (`backup_circuit_id`) REFERENCES `power_and_utilities_v2`.`technology`.`telecom_circuit`(`telecom_circuit_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ADD CONSTRAINT `fk_technology_telecom_circuit_network_device_id` FOREIGN KEY (`network_device_id`) REFERENCES `power_and_utilities_v2`.`technology`.`network_device`(`network_device_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ADD CONSTRAINT `fk_technology_telecom_circuit_redundant_telecom_circuit_id` FOREIGN KEY (`redundant_telecom_circuit_id`) REFERENCES `power_and_utilities_v2`.`technology`.`telecom_circuit`(`telecom_circuit_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ADD CONSTRAINT `fk_technology_disaster_recovery_plan_superseded_disaster_recovery_plan_id` FOREIGN KEY (`superseded_disaster_recovery_plan_id`) REFERENCES `power_and_utilities_v2`.`technology`.`disaster_recovery_plan`(`disaster_recovery_plan_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ADD CONSTRAINT `fk_technology_dr_test_event_disaster_recovery_plan_id` FOREIGN KEY (`disaster_recovery_plan_id`) REFERENCES `power_and_utilities_v2`.`technology`.`disaster_recovery_plan`(`disaster_recovery_plan_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ADD CONSTRAINT `fk_technology_dr_test_event_retest_of_dr_test_event_id` FOREIGN KEY (`retest_of_dr_test_event_id`) REFERENCES `power_and_utilities_v2`.`technology`.`dr_test_event`(`dr_test_event_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ADD CONSTRAINT `fk_technology_tech_vendor_acquired_by_tech_vendor_id` FOREIGN KEY (`acquired_by_tech_vendor_id`) REFERENCES `power_and_utilities_v2`.`technology`.`tech_vendor`(`tech_vendor_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`supply_chain_risk` ADD CONSTRAINT `fk_technology_supply_chain_risk_it_asset_id` FOREIGN KEY (`it_asset_id`) REFERENCES `power_and_utilities_v2`.`technology`.`it_asset`(`it_asset_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`supply_chain_risk` ADD CONSTRAINT `fk_technology_supply_chain_risk_reassessed_supply_chain_risk_id` FOREIGN KEY (`reassessed_supply_chain_risk_id`) REFERENCES `power_and_utilities_v2`.`technology`.`supply_chain_risk`(`supply_chain_risk_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_sla` ADD CONSTRAINT `fk_technology_it_sla_it_service_id` FOREIGN KEY (`it_service_id`) REFERENCES `power_and_utilities_v2`.`technology`.`it_service`(`it_service_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_sla` ADD CONSTRAINT `fk_technology_it_sla_superseded_it_sla_id` FOREIGN KEY (`superseded_it_sla_id`) REFERENCES `power_and_utilities_v2`.`technology`.`it_sla`(`it_sla_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`digital_platform` ADD CONSTRAINT `fk_technology_digital_platform_tech_project_id` FOREIGN KEY (`tech_project_id`) REFERENCES `power_and_utilities_v2`.`technology`.`tech_project`(`tech_project_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`digital_platform` ADD CONSTRAINT `fk_technology_digital_platform_superseded_digital_platform_id` FOREIGN KEY (`superseded_digital_platform_id`) REFERENCES `power_and_utilities_v2`.`technology`.`digital_platform`(`digital_platform_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ADD CONSTRAINT `fk_technology_platform_release_application_id` FOREIGN KEY (`application_id`) REFERENCES `power_and_utilities_v2`.`technology`.`application`(`application_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ADD CONSTRAINT `fk_technology_platform_release_change_request_id` FOREIGN KEY (`change_request_id`) REFERENCES `power_and_utilities_v2`.`technology`.`change_request`(`change_request_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ADD CONSTRAINT `fk_technology_platform_release_digital_platform_id` FOREIGN KEY (`digital_platform_id`) REFERENCES `power_and_utilities_v2`.`technology`.`digital_platform`(`digital_platform_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ADD CONSTRAINT `fk_technology_platform_release_rollback_platform_release_id` FOREIGN KEY (`rollback_platform_release_id`) REFERENCES `power_and_utilities_v2`.`technology`.`platform_release`(`platform_release_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ADD CONSTRAINT `fk_technology_tech_spend_tech_project_id` FOREIGN KEY (`tech_project_id`) REFERENCES `power_and_utilities_v2`.`technology`.`tech_project`(`tech_project_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ADD CONSTRAINT `fk_technology_tech_spend_adjustment_of_tech_spend_id` FOREIGN KEY (`adjustment_of_tech_spend_id`) REFERENCES `power_and_utilities_v2`.`technology`.`tech_spend`(`tech_spend_id`);

-- ========= TAGS =========
ALTER SCHEMA `power_and_utilities_v2`.`technology` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `power_and_utilities_v2`.`technology` SET TAGS ('dbx_domain' = 'technology');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `it_asset_id` SET TAGS ('dbx_business_glossary_term' = 'IT Asset Identifier (IT_ASSET_ID)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `replaced_it_asset_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class (ASSET_CLASS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `asset_class` SET TAGS ('dbx_value_regex' = 'hardware|software|virtual|service');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `asset_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Compliance Status (ASSET_COMPLIANCE_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `asset_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `asset_condition` SET TAGS ('dbx_business_glossary_term' = 'Asset Condition (ASSET_CONDITION)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `asset_condition` SET TAGS ('dbx_value_regex' = 'new|good|fair|poor');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `asset_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Asset Created Timestamp (ASSET_CREATED_TIMESTAMP)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `asset_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Description (ASSET_DESCRIPTION)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `asset_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Name (ASSET_NAME)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag (ASSET_TAG)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `asset_tags` SET TAGS ('dbx_business_glossary_term' = 'Asset Tags (ASSET_TAGS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Type (ASSET_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `asset_type` SET TAGS ('dbx_value_regex' = 'server|workstation|laptop|network_device|storage|software_application');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `asset_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Asset Updated Timestamp (ASSET_UPDATED_TIMESTAMP)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `backup_status` SET TAGS ('dbx_business_glossary_term' = 'Backup Status (BACKUP_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `backup_status` SET TAGS ('dbx_value_regex' = 'backed_up|not_backed_up');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `cpu_spec` SET TAGS ('dbx_business_glossary_term' = 'CPU Specification (CPU_SPEC)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `current_book_value` SET TAGS ('dbx_business_glossary_term' = 'Current Book Value (CURRENT_BOOK_VALUE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department (DEPARTMENT)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `deployment_date` SET TAGS ('dbx_business_glossary_term' = 'Deployment Date (DEPLOYMENT_DATE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method (DEPRECIATION_METHOD)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|units_of_production');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `depreciation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Start Date (DEPRECIATION_START_DATE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date (DISPOSAL_DATE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method (DISPOSAL_METHOD)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `encryption_status` SET TAGS ('dbx_business_glossary_term' = 'Encryption Status (ENCRYPTION_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `encryption_status` SET TAGS ('dbx_value_regex' = 'encrypted|not_encrypted');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `end_of_life_plan` SET TAGS ('dbx_business_glossary_term' = 'End‑of‑Life Plan (END_OF_LIFE_PLAN)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address (IP_ADDRESS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `last_patch_date` SET TAGS ('dbx_business_glossary_term' = 'Last Patch Date (LAST_PATCH_DATE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `license_key` SET TAGS ('dbx_business_glossary_term' = 'License Key (LICENSE_KEY)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `license_key` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `license_key` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status (LIFECYCLE_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'ordered|deployed|in_service|retired|disposed');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `mac_address` SET TAGS ('dbx_business_glossary_term' = 'MAC Address (MAC_ADDRESS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `mac_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `mac_address` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `maintenance_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Expiration Date (MAINTENANCE_EXPIRATION_DATE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer (MANUFACTURER)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `memory_gb` SET TAGS ('dbx_business_glossary_term' = 'Memory (GB) (MEMORY_GB)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `model` SET TAGS ('dbx_business_glossary_term' = 'Model (MODEL)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `operating_system` SET TAGS ('dbx_business_glossary_term' = 'Operating System (OPERATING_SYSTEM)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Asset Owner (OWNER)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Date (PURCHASE_DATE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `purchase_price` SET TAGS ('dbx_business_glossary_term' = 'Purchase Price (PURCHASE_PRICE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date (RETIREMENT_DATE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `retirement_reason` SET TAGS ('dbx_business_glossary_term' = 'Retirement Reason (RETIREMENT_REASON)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `security_classification` SET TAGS ('dbx_business_glossary_term' = 'Security Classification (SECURITY_CLASSIFICATION)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `security_classification` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number (SERIAL_NUMBER)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `software_version` SET TAGS ('dbx_business_glossary_term' = 'Software Version (SOFTWARE_VERSION)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `storage_gb` SET TAGS ('dbx_business_glossary_term' = 'Storage Capacity (GB) (STORAGE_GB)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date (WARRANTY_EXPIRATION_DATE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `ot_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Operational Technology Asset Identifier (OT_ASSET_ID)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier (LOCATION_ID)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `scada_system_id` SET TAGS ('dbx_business_glossary_term' = 'Control System Identifier (CTRL_SYS_ID)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `replaced_ot_asset_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `asset_category` SET TAGS ('dbx_business_glossary_term' = 'Asset Category (ASSET_CATEGORY)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `asset_category` SET TAGS ('dbx_value_regex' = 'generation|transmission|distribution|substation|control_center');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `asset_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Name (ASSET_NAME)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Operational Status (ASSET_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_value_regex' = 'online|offline|faulted|maintenance');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag (ASSET_TAG)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Type (ASSET_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `asset_type` SET TAGS ('dbx_value_regex' = 'scada_server|rtu|plc|ied|dcs_controller|hmi_workstation');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Capacity (MW) (CAPACITY_MW)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date (COMMISSION_DATE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_business_glossary_term' = 'Communication Protocol (COMM_PROTOCOL)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_value_regex' = 'dnp3|modbus|iec61850|opcua|profinet');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMPLIANCE_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_business_glossary_term' = 'Criticality Rating (CRITICALITY_RATING)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date (DECOMMISSION_DATE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation URL (DOC_URL)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version (FIRMWARE_VERSION)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `geographic_latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (LATITUDE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `geographic_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `geographic_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `geographic_longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (LONGITUDE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `geographic_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `geographic_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `hardware_version` SET TAGS ('dbx_business_glossary_term' = 'Hardware Version (HARDWARE_VERSION)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date (INSTALL_DATE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address (IP_ADDRESS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `ip_address` SET TAGS ('dbx_value_regex' = '^((25[0-5]|2[0-4]d|[01]?dd?).){3}(25[0-5]|2[0-4]d|[01]?dd?)$');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date (LAST_MAINT_DATE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `last_seen_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Seen Timestamp (LAST_SEEN_TS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status (LIFECYCLE_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'in_service|decommissioned|maintenance|retired|planned');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `mac_address` SET TAGS ('dbx_business_glossary_term' = 'MAC Address (MAC_ADDRESS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `mac_address` SET TAGS ('dbx_value_regex' = '^([0-9A-Fa-f]{2}:){5}[0-9A-Fa-f]{2}$');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `mac_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `mac_address` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `maintenance_window` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window (MAINT_WINDOW)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer (MANUFACTURER)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number (MODEL_NUMBER)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `nerc_cip_impact` SET TAGS ('dbx_business_glossary_term' = 'NERC CIP Impact Classification (CIP_IMPACT)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `nerc_cip_impact` SET TAGS ('dbx_value_regex' = 'high|medium|low|none');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `network_zone` SET TAGS ('dbx_business_glossary_term' = 'Network Zone (NET_ZONE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `network_zone` SET TAGS ('dbx_value_regex' = 'dmz|internal|restricted|untrusted');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `next_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Date (NEXT_MAINT_DATE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `security_patch_level` SET TAGS ('dbx_business_glossary_term' = 'Security Patch Level (SEC_PATCH_LVL)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number (SERIAL_NUMBER)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `software_version` SET TAGS ('dbx_business_glossary_term' = 'Software Version (SOFTWARE_VERSION)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `voltage_kv` SET TAGS ('dbx_business_glossary_term' = 'Voltage (kV) (VOLTAGE_KV)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `vulnerability_score` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Score (VULN_SCORE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date (WARRANTY_EXP)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Application ID');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `parent_application_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `api_exposure` SET TAGS ('dbx_business_glossary_term' = 'API Exposure Level');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `api_exposure` SET TAGS ('dbx_value_regex' = 'internal|partner|public|none');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `application_description` SET TAGS ('dbx_business_glossary_term' = 'Application Description');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `application_name` SET TAGS ('dbx_business_glossary_term' = 'Application Name');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `application_tier` SET TAGS ('dbx_business_glossary_term' = 'Application Tier');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `application_tier` SET TAGS ('dbx_value_regex' = 'presentation|business_logic|data|integration');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Authentication Method');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `authentication_method` SET TAGS ('dbx_value_regex' = 'saml|oauth|ldap|kerberos|local');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `backup_frequency` SET TAGS ('dbx_business_glossary_term' = 'Backup Frequency');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `backup_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|none');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `business_capability` SET TAGS ('dbx_business_glossary_term' = 'Supported Business Capability');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulation');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_value_regex' = 'NERC|FERC|PCI|HIPAA|ISO55000');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `container_orchestration` SET TAGS ('dbx_business_glossary_term' = 'Container Orchestration Platform');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `container_orchestration` SET TAGS ('dbx_value_regex' = 'kubernetes|docker_swarm|none');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `cost_annual_usd` SET TAGS ('dbx_business_glossary_term' = 'Annual Cost (USD)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `data_classification` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `data_retention_policy` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Policy');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `deployment_model` SET TAGS ('dbx_business_glossary_term' = 'Deployment Model');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `deployment_model` SET TAGS ('dbx_value_regex' = 'on_premise|cloud_saas|hybrid');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation URL');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `encryption_at_rest` SET TAGS ('dbx_business_glossary_term' = 'Encryption At Rest');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `encryption_in_transit` SET TAGS ('dbx_business_glossary_term' = 'Encryption In Transit');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `hosting_environment` SET TAGS ('dbx_business_glossary_term' = 'Hosting Environment');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `incident_history_count` SET TAGS ('dbx_business_glossary_term' = 'Incident History Count');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `integration_dependencies` SET TAGS ('dbx_business_glossary_term' = 'Integration Dependencies');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `is_cloud_native` SET TAGS ('dbx_business_glossary_term' = 'Cloud‑Native Flag');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `is_containerized` SET TAGS ('dbx_business_glossary_term' = 'Containerized Flag');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Application Flag');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `last_security_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Security Assessment Date');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Application Lifecycle Status');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|sunset|decommissioned|planned|retired');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `owner_business_owner` SET TAGS ('dbx_business_glossary_term' = 'Business Owner Name (PII)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `owner_business_owner` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `owner_business_owner` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `owner_business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Owner');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `owner_it_department` SET TAGS ('dbx_business_glossary_term' = 'IT Department Owner');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `owner_it_owner` SET TAGS ('dbx_business_glossary_term' = 'IT Owner Name (PII)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `owner_it_owner` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `owner_it_owner` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `repository_url` SET TAGS ('dbx_business_glossary_term' = 'Repository URL');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `sla_response_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'SLA Response Time (Minutes)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `sla_uptime_percent` SET TAGS ('dbx_business_glossary_term' = 'SLA Uptime Percentage');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `source_code_repository` SET TAGS ('dbx_business_glossary_term' = 'Source Code Repository Type');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `source_code_repository` SET TAGS ('dbx_value_regex' = 'git|svn|mercurial|none');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `support_contact` SET TAGS ('dbx_business_glossary_term' = 'Support Contact');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `support_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Support Contact Email');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `support_contact_email` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `support_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `support_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `vendor` SET TAGS ('dbx_business_glossary_term' = 'Application Vendor');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Email');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Application Version');
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ALTER COLUMN `network_device_id` SET TAGS ('dbx_business_glossary_term' = 'Network Device Identifier');
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ALTER COLUMN `network_device_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ALTER COLUMN `network_device_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ALTER COLUMN `it_asset_id` SET TAGS ('dbx_business_glossary_term' = 'It Asset Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Support Contract Identifier (CONTRACT_ID)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ALTER COLUMN `upstream_network_device_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ALTER COLUMN `alert_thresholds` SET TAGS ('dbx_business_glossary_term' = 'Alert Thresholds (ALERT_THRESHOLDS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag (ASSET_TAG)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMPLIANCE_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt|pending');
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ALTER COLUMN `config_version` SET TAGS ('dbx_business_glossary_term' = 'Configuration Version (CFG_VER)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ALTER COLUMN `cpu_utilization_percent` SET TAGS ('dbx_business_glossary_term' = 'CPU Utilization Percentage (CPU_UTIL_PCT)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date (DECOM_DATE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ALTER COLUMN `device_role` SET TAGS ('dbx_business_glossary_term' = 'Device Role (ROLE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ALTER COLUMN `device_role` SET TAGS ('dbx_value_regex' = 'core|distribution|access|edge|management|monitoring');
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Network Device Type (TYPE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'router|switch|firewall|load_balancer|wireless_ap|sdwan_appliance');
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version (FW_VER)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ALTER COLUMN `hostname` SET TAGS ('dbx_business_glossary_term' = 'Device Hostname (HOSTNAME)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date (INST_DATE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ALTER COLUMN `last_audit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Timestamp (LAST_AUDIT_TS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ALTER COLUMN `last_config_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Configuration Change Timestamp (LAST_CFG_TS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date (LAST_MAINT_DATE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ALTER COLUMN `maintenance_window` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window (MAINT_WINDOW)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ALTER COLUMN `maintenance_window` SET TAGS ('dbx_value_regex' = 'weekly|monthly|quarterly|annual|ad_hoc');
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ALTER COLUMN `management_protocol` SET TAGS ('dbx_business_glossary_term' = 'Management Protocol (PROTOCOL)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ALTER COLUMN `management_protocol` SET TAGS ('dbx_value_regex' = 'ssh|telnet|snmp|https|api');
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ALTER COLUMN `memory_utilization_percent` SET TAGS ('dbx_business_glossary_term' = 'Memory Utilization Percentage (MEM_UTIL_PCT)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ALTER COLUMN `monitoring_status` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Status (MONITORING_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ALTER COLUMN `monitoring_status` SET TAGS ('dbx_value_regex' = 'enabled|disabled|error');
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ALTER COLUMN `network_device_status` SET TAGS ('dbx_business_glossary_term' = 'Device Lifecycle Status (STATUS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ALTER COLUMN `network_device_status` SET TAGS ('dbx_value_regex' = 'in_service|out_of_service|maintenance|decommissioned|planned');
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ALTER COLUMN `network_segment` SET TAGS ('dbx_business_glossary_term' = 'Network Segment (SEGMENT)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ALTER COLUMN `network_zone` SET TAGS ('dbx_business_glossary_term' = 'Network Zone (ZONE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ALTER COLUMN `network_zone` SET TAGS ('dbx_value_regex' = 'corporate_lan|ot_dmz|control_network|field_network');
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ALTER COLUMN `power_supply_status` SET TAGS ('dbx_business_glossary_term' = 'Power Supply Status (POWER_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ALTER COLUMN `power_supply_status` SET TAGS ('dbx_value_regex' = 'normal|failed|degraded|unknown');
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ALTER COLUMN `redundancy_group` SET TAGS ('dbx_business_glossary_term' = 'Redundancy Group (REDUNDANCY_GROUP)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating (RISK_RATING)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ALTER COLUMN `security_patch_level` SET TAGS ('dbx_business_glossary_term' = 'Security Patch Level (SEC_PATCH)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ALTER COLUMN `uptime_seconds` SET TAGS ('dbx_business_glossary_term' = 'Device Uptime (UPTIME_SEC)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ALTER COLUMN `vendor` SET TAGS ('dbx_business_glossary_term' = 'Device Vendor (VENDOR)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ALTER COLUMN `vlan_number` SET TAGS ('dbx_business_glossary_term' = 'VLAN Identifier (VLAN_ID)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ALTER COLUMN `warranty_expiration` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date (WARRANTY_EXP)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `it_service_id` SET TAGS ('dbx_business_glossary_term' = 'IT Service Identifier');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Service Owner Identifier (OWNER_ID)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `it_asset_id` SET TAGS ('dbx_business_glossary_term' = 'It Asset Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Service Owner Identifier (OWNER_ID)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `parent_it_service_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `annual_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Budget Amount (BUDGET)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `availability_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Availability Target (PCT)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `budget_currency` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency (CURRENCY)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `budget_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|JPY');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `change_management_process` SET TAGS ('dbx_business_glossary_term' = 'Change Management Process (CHANGE_PROC)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `compliance_certifications` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certifications (CERTIFICATIONS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `cost_per_month` SET TAGS ('dbx_business_glossary_term' = 'Monthly Cost (COST_MONTH)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `criticality` SET TAGS ('dbx_business_glossary_term' = 'Service Criticality (CRITICALITY)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `criticality` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `delivery_model` SET TAGS ('dbx_business_glossary_term' = 'Delivery Model (MODEL)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `delivery_model` SET TAGS ('dbx_value_regex' = 'cloud|on-prem|hybrid');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `dependencies` SET TAGS ('dbx_business_glossary_term' = 'Service Dependencies (DEPENDENCIES)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `deprecation_date` SET TAGS ('dbx_business_glossary_term' = 'Deprecation Date (DEPRECATION)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation URL (DOC_URL)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `escalation_path` SET TAGS ('dbx_business_glossary_term' = 'Escalation Path (ESCALATION)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `incident_management_process` SET TAGS ('dbx_business_glossary_term' = 'Incident Management Process (INCIDENT_PROC)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `it_service_category` SET TAGS ('dbx_business_glossary_term' = 'Service Category (CATEGORY)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `it_service_category` SET TAGS ('dbx_value_regex' = 'infrastructure|application|security|communications|ot_support');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `it_service_description` SET TAGS ('dbx_business_glossary_term' = 'Service Description (DESCRIPTION)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `it_service_name` SET TAGS ('dbx_business_glossary_term' = 'Service Name');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `it_service_status` SET TAGS ('dbx_business_glossary_term' = 'Service Status (STATUS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `it_service_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|retired|pending');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date (LAST_REVIEW)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `maintenance_window` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window (WINDOW)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date (NEXT_REVIEW)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `owner_group` SET TAGS ('dbx_business_glossary_term' = 'Owner Group (GROUP)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `owner_name` SET TAGS ('dbx_business_glossary_term' = 'Service Owner Name (OWNER_NAME)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `request_fulfillment_process` SET TAGS ('dbx_business_glossary_term' = 'Request Fulfillment Process (REQ_PROC)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `security_classification` SET TAGS ('dbx_business_glossary_term' = 'Security Classification (SEC_CLASS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `security_classification` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `service_code` SET TAGS ('dbx_business_glossary_term' = 'Service Code (CODE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `service_end_date` SET TAGS ('dbx_business_glossary_term' = 'Service End Date (END_DATE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `service_region` SET TAGS ('dbx_business_glossary_term' = 'Service Region (REGION)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `service_region` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `service_start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Start Date (START_DATE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type (TYPE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'internal|external');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `sla_resolution_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'SLA Resolution Time (MIN)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `sla_response_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'SLA Response Time (MIN)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'SLA Tier (SLA_TIER)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'gold|silver|bronze');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Service Subcategory (SUBCATEGORY)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `support_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Support Contact Email (SUPPORT_EMAIL)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `support_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `support_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `support_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `support_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Support Contact Phone (SUPPORT_PHONE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `support_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `support_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `supported_processes` SET TAGS ('dbx_business_glossary_term' = 'Supported Business Processes (PROCESSES)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `technology_stack` SET TAGS ('dbx_business_glossary_term' = 'Technology Stack (STACK)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `tier` SET TAGS ('dbx_business_glossary_term' = 'Service Tier (TIER)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `tier` SET TAGS ('dbx_value_regex' = 'critical|standard|basic');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Service Version (VERSION)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `incident_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Ticket ID');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `assigned_to_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned To ID');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reporter ID');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `it_service_id` SET TAGS ('dbx_business_glossary_term' = 'It Service Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Related Incident ID');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Reporter ID');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `quaternary_incident_updated_by_user_person_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `tertiary_incident_created_by_user_person_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `parent_incident_ticket_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `acknowledgment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Timestamp');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `affected_business_unit` SET TAGS ('dbx_business_glossary_term' = 'Affected Business Unit');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `affected_business_unit` SET TAGS ('dbx_value_regex' = 'operations|it|ot|customer_service|finance|regulatory');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `assigned_group` SET TAGS ('dbx_business_glossary_term' = 'Assigned Support Group');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `compliance_category` SET TAGS ('dbx_business_glossary_term' = 'Compliance Category');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `compliance_category` SET TAGS ('dbx_value_regex' = 'cip|ferc|nerc|iso|none');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `customer_impact` SET TAGS ('dbx_business_glossary_term' = 'Customer Impact');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `customer_impact` SET TAGS ('dbx_value_regex' = 'outage|degraded|none|partial|unknown');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Detection Method');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `detection_method` SET TAGS ('dbx_value_regex' = 'alert|log|user_report|sensor|system|other');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `downtime_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Downtime Duration (Minutes)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'level1|level2|level3|level4');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `impact_area` SET TAGS ('dbx_business_glossary_term' = 'Impact Area');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `impact_area` SET TAGS ('dbx_value_regex' = 'customer|business|safety|regulatory|environment|service');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `impact_severity` SET TAGS ('dbx_business_glossary_term' = 'Impact Severity');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `impact_severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|informational');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `incident_source` SET TAGS ('dbx_business_glossary_term' = 'Incident Source');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `incident_source` SET TAGS ('dbx_value_regex' = 'manual|automated|monitoring|third_party');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `incident_ticket_category` SET TAGS ('dbx_business_glossary_term' = 'Incident Category');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `incident_ticket_category` SET TAGS ('dbx_value_regex' = 'network|server|application|ot_scada|cybersecurity|other');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `incident_ticket_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Description');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `incident_ticket_status` SET TAGS ('dbx_business_glossary_term' = 'Ticket Status');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `incident_ticket_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|resolved|closed|cancelled');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `is_external` SET TAGS ('dbx_business_glossary_term' = 'External Reporter Flag');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `is_sla_critical` SET TAGS ('dbx_business_glossary_term' = 'SLA Critical Flag');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `mitigation_action` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Action');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `post_incident_review_completed` SET TAGS ('dbx_business_glossary_term' = 'Post‑Incident Review Completed');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Incident Priority');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'P1|P2|P3|P4');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `regulatory_report_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reported Timestamp');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `resolution_description` SET TAGS ('dbx_business_glossary_term' = 'Resolution Description');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `resolved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolved Timestamp');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Timestamp');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'high|medium|low|none');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'hardware|software|human_error|process|external|unknown');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `service_restoration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Service Restoration Timestamp');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `sla_actual_hours` SET TAGS ('dbx_business_glossary_term' = 'SLA Actual Hours');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'SLA Breach Flag');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_business_glossary_term' = 'SLA Target Hours');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `system_affected` SET TAGS ('dbx_business_glossary_term' = 'System Affected');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `system_affected` SET TAGS ('dbx_value_regex' = 'scada|ems|dms|oms|mrm|other');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Ticket Number');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `ticket_type` SET TAGS ('dbx_business_glossary_term' = 'Ticket Type');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `ticket_type` SET TAGS ('dbx_value_regex' = 'it|ot|cybersecurity');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ALTER COLUMN `work_notes` SET TAGS ('dbx_business_glossary_term' = 'Work Notes');
ALTER TABLE `power_and_utilities_v2`.`technology`.`change_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`technology`.`change_request` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `power_and_utilities_v2`.`technology`.`change_request` ALTER COLUMN `change_request_id` SET TAGS ('dbx_business_glossary_term' = 'Change Request Identifier');
ALTER TABLE `power_and_utilities_v2`.`technology`.`change_request` ALTER COLUMN `approver_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Identifier');
ALTER TABLE `power_and_utilities_v2`.`technology`.`change_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requestor Identifier');
ALTER TABLE `power_and_utilities_v2`.`technology`.`change_request` ALTER COLUMN `tech_project_id` SET TAGS ('dbx_business_glossary_term' = 'Tech Project Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`change_request` ALTER COLUMN `rollback_change_request_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`change_request` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Change Cost');
ALTER TABLE `power_and_utilities_v2`.`technology`.`change_request` ALTER COLUMN `affected_systems` SET TAGS ('dbx_business_glossary_term' = 'Affected Systems');
ALTER TABLE `power_and_utilities_v2`.`technology`.`change_request` ALTER COLUMN `business_event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Business Event Timestamp');
ALTER TABLE `power_and_utilities_v2`.`technology`.`change_request` ALTER COLUMN `change_category` SET TAGS ('dbx_business_glossary_term' = 'Change Category');
ALTER TABLE `power_and_utilities_v2`.`technology`.`change_request` ALTER COLUMN `change_category` SET TAGS ('dbx_value_regex' = 'infrastructure|application|ot_scada|security|process');
ALTER TABLE `power_and_utilities_v2`.`technology`.`change_request` ALTER COLUMN `change_category_detail` SET TAGS ('dbx_business_glossary_term' = 'Change Category Detail');
ALTER TABLE `power_and_utilities_v2`.`technology`.`change_request` ALTER COLUMN `change_description` SET TAGS ('dbx_business_glossary_term' = 'Change Description');
ALTER TABLE `power_and_utilities_v2`.`technology`.`change_request` ALTER COLUMN `change_impact` SET TAGS ('dbx_business_glossary_term' = 'Change Impact');
ALTER TABLE `power_and_utilities_v2`.`technology`.`change_request` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `power_and_utilities_v2`.`technology`.`change_request` ALTER COLUMN `change_request_source` SET TAGS ('dbx_business_glossary_term' = 'Change Request Source');
ALTER TABLE `power_and_utilities_v2`.`technology`.`change_request` ALTER COLUMN `change_request_source` SET TAGS ('dbx_value_regex' = 'IT|OT|Both');
ALTER TABLE `power_and_utilities_v2`.`technology`.`change_request` ALTER COLUMN `change_request_status` SET TAGS ('dbx_business_glossary_term' = 'Change Request Status');
ALTER TABLE `power_and_utilities_v2`.`technology`.`change_request` ALTER COLUMN `change_risk_assessment` SET TAGS ('dbx_business_glossary_term' = 'Change Risk Assessment');
ALTER TABLE `power_and_utilities_v2`.`technology`.`change_request` ALTER COLUMN `change_type` SET TAGS ('dbx_business_glossary_term' = 'Change Type');
ALTER TABLE `power_and_utilities_v2`.`technology`.`change_request` ALTER COLUMN `change_type` SET TAGS ('dbx_value_regex' = 'standard|normal|emergency');
ALTER TABLE `power_and_utilities_v2`.`technology`.`change_request` ALTER COLUMN `change_type_detail` SET TAGS ('dbx_business_glossary_term' = 'Change Type Detail');
ALTER TABLE `power_and_utilities_v2`.`technology`.`change_request` ALTER COLUMN `change_window_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Change Window Duration (Minutes)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`change_request` ALTER COLUMN `change_window_end` SET TAGS ('dbx_business_glossary_term' = 'Change Window End Timestamp');
ALTER TABLE `power_and_utilities_v2`.`technology`.`change_request` ALTER COLUMN `change_window_notes` SET TAGS ('dbx_business_glossary_term' = 'Change Window Notes');
ALTER TABLE `power_and_utilities_v2`.`technology`.`change_request` ALTER COLUMN `change_window_start` SET TAGS ('dbx_business_glossary_term' = 'Change Window Start Timestamp');
ALTER TABLE `power_and_utilities_v2`.`technology`.`change_request` ALTER COLUMN `change_window_timezone` SET TAGS ('dbx_business_glossary_term' = 'Change Window Timezone');
ALTER TABLE `power_and_utilities_v2`.`technology`.`change_request` ALTER COLUMN `compliance_requirement` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement');
ALTER TABLE `power_and_utilities_v2`.`technology`.`change_request` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities_v2`.`technology`.`change_request` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `power_and_utilities_v2`.`technology`.`change_request` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Change Cost');
ALTER TABLE `power_and_utilities_v2`.`technology`.`change_request` ALTER COLUMN `implementation_status` SET TAGS ('dbx_business_glossary_term' = 'Implementation Status');
ALTER TABLE `power_and_utilities_v2`.`technology`.`change_request` ALTER COLUMN `implementation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|failed|rolled_back');
ALTER TABLE `power_and_utilities_v2`.`technology`.`change_request` ALTER COLUMN `origin` SET TAGS ('dbx_business_glossary_term' = 'Change Request Origin');
ALTER TABLE `power_and_utilities_v2`.`technology`.`change_request` ALTER COLUMN `origin` SET TAGS ('dbx_value_regex' = 'manual|automated');
ALTER TABLE `power_and_utilities_v2`.`technology`.`change_request` ALTER COLUMN `post_implementation_review` SET TAGS ('dbx_business_glossary_term' = 'Post‑Implementation Review');
ALTER TABLE `power_and_utilities_v2`.`technology`.`change_request` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Change Priority');
ALTER TABLE `power_and_utilities_v2`.`technology`.`change_request` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `power_and_utilities_v2`.`technology`.`change_request` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`technology`.`change_request` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`technology`.`change_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Change Request Number');
ALTER TABLE `power_and_utilities_v2`.`technology`.`change_request` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `power_and_utilities_v2`.`technology`.`change_request` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `power_and_utilities_v2`.`technology`.`change_request` ALTER COLUMN `rollback_plan` SET TAGS ('dbx_business_glossary_term' = 'Rollback Plan');
ALTER TABLE `power_and_utilities_v2`.`technology`.`change_request` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Request Status Reason');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `service_request_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Service Request Ticket ID');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `approver_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID (APPROVER_ID)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID (APPROVER_ID)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `it_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID (ASSET_ID)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID (ASSET_ID)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Technician ID (TECH_ID)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `crew_member_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Technician ID (TECH_ID)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `crew_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `crew_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requester ID (REQ_ID)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `it_service_id` SET TAGS ('dbx_business_glossary_term' = 'It Service Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID (LOC_ID)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `change_request_id` SET TAGS ('dbx_business_glossary_term' = 'Related Change Request ID (CHG_REQ_ID)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Related Incident Ticket ID (INC_TICKET_ID)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID (VENDOR_ID)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID (WO_ID)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `originating_service_request_ticket_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp (ACT_END_TS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp (ACT_START_TS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `approval_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag (APPROVAL_REQ)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp (APPROVED_TS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit (BUS_UNIT)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `closure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closure Timestamp (CLOSE_TS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag (COMPLY_FLAG)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `cost_estimate_currency` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate Currency (COST_CURR)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `cost_estimate_gross` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate Gross Amount (COST_GROSS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `cost_estimate_net` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate Net Amount (COST_NET)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `cost_estimate_tax` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate Tax Amount (COST_TAX)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (REC_CREATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department (DEPT)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `external_vendor_required` SET TAGS ('dbx_business_glossary_term' = 'External Vendor Required Flag (VENDOR_REQ)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `fulfilled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Fulfilled Timestamp (FULFILL_TS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `fulfillment_notes` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Notes (FULFILL_NOTES)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `fulfillment_sla` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment SLA Type (FULFILL_SLA)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `fulfillment_sla` SET TAGS ('dbx_value_regex' = 'standard|priority|custom');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `impact` SET TAGS ('dbx_business_glossary_term' = 'Impact Level (IMPACT)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `impact` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By (MOD_BY)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority (PRIORITY)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `regulatory_review_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Review Status (REG_REVIEW_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `regulatory_review_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|rejected');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `request_category` SET TAGS ('dbx_business_glossary_term' = 'Request Category (REQ_CAT)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `request_category` SET TAGS ('dbx_value_regex' = 'access_provisioning|hardware_request|software_install|account_management|ot_support');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `request_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Request Subcategory (REQ_SUBCAT)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `requested_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Requested Timestamp (REQ_TS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `requester_name` SET TAGS ('dbx_business_glossary_term' = 'Requester Name (REQ_NAME)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `resolution_code` SET TAGS ('dbx_business_glossary_term' = 'Resolution Code (RES_CODE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `resolution_code` SET TAGS ('dbx_value_regex' = 'resolved|cannot_reproduce|won_t_fix|deferred');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `scheduled_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Timestamp (SCH_END_TS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `scheduled_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Timestamp (SCH_START_TS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `service_request_ticket_description` SET TAGS ('dbx_business_glossary_term' = 'Request Description (REQ_DESC)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `service_request_ticket_status` SET TAGS ('dbx_business_glossary_term' = 'Ticket Status (STATUS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `service_request_ticket_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|fulfilled|closed|cancelled');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `sla_met` SET TAGS ('dbx_business_glossary_term' = 'SLA Met Flag (SLA_MET)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_business_glossary_term' = 'SLA Target Hours (SLA_TGT_HRS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Ticket Number (TICKET_NO)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (REC_UPDATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `urgency` SET TAGS ('dbx_business_glossary_term' = 'Urgency Level (URGENCY)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ALTER COLUMN `urgency` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` SET TAGS ('dbx_subdomain' = 'project_finance');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `tech_project_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Project Identifier');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `tech_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Tech Vendor Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `parent_tech_project_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `actual_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration (Days)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `actual_roi_percent` SET TAGS ('dbx_business_glossary_term' = 'Actual ROI Percent');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `actual_spend` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend Amount');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Project Approval Status');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `benefits_realization_status` SET TAGS ('dbx_business_glossary_term' = 'Benefits Realization Status');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Budget Amount');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `change_request_count` SET TAGS ('dbx_business_glossary_term' = 'Change Request Count');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|CHF');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `data_classification` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `estimated_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration (Days)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `expected_roi_percent` SET TAGS ('dbx_business_glossary_term' = 'Expected ROI Percent');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `external_vendor` SET TAGS ('dbx_business_glossary_term' = 'External Vendor Name');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `funding_source` SET TAGS ('dbx_value_regex' = 'capex|opex|grant|internal|external');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `health_status` SET TAGS ('dbx_business_glossary_term' = 'Project Health Status');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `health_status` SET TAGS ('dbx_value_regex' = 'green|yellow|red');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `health_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `health_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Project Flag');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `is_remote` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Flag');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `milestone_count` SET TAGS ('dbx_business_glossary_term' = 'Milestone Count');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Project Notes');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Project Priority');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Technology Project Code');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `project_manager` SET TAGS ('dbx_business_glossary_term' = 'Technology Project Manager');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `project_name` SET TAGS ('dbx_business_glossary_term' = 'Technology Project Name');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `project_phase` SET TAGS ('dbx_business_glossary_term' = 'Technology Project Phase');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `project_phase` SET TAGS ('dbx_value_regex' = 'initiation|planning|execution|closeout');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Technology Project Type');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `project_type` SET TAGS ('dbx_value_regex' = 'infrastructure|ot_scada|cybersecurity|digital|application');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `project_url` SET TAGS ('dbx_business_glossary_term' = 'Project Collaboration URL');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `regulatory_impact` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Impact');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Project Risk Rating');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'high|medium|low|none');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `sponsor_business_unit` SET TAGS ('dbx_business_glossary_term' = 'Sponsoring Business Unit');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `stakeholder_count` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Count');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `strategic_program` SET TAGS ('dbx_business_glossary_term' = 'Strategic Program Alignment');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `tech_project_description` SET TAGS ('dbx_business_glossary_term' = 'Technology Project Description');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `tech_project_status` SET TAGS ('dbx_business_glossary_term' = 'Technology Project Status');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `tech_project_status` SET TAGS ('dbx_value_regex' = 'active|inactive|completed|cancelled|on_hold');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `technology_stack` SET TAGS ('dbx_business_glossary_term' = 'Technology Stack');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `total_milestones_completed` SET TAGS ('dbx_business_glossary_term' = 'Milestones Completed');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_project` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`technology`.`project_milestone` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`technology`.`project_milestone` SET TAGS ('dbx_subdomain' = 'project_finance');
ALTER TABLE `power_and_utilities_v2`.`technology`.`project_milestone` ALTER COLUMN `project_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Project Milestone Identifier (PM_ID)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`project_milestone` ALTER COLUMN `approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Identifier (APPROVER_ID)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`project_milestone` ALTER COLUMN `change_request_id` SET TAGS ('dbx_business_glossary_term' = 'Change Request Identifier (CR_ID)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`project_milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Milestone Owner Identifier (OWNER_ID)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`project_milestone` ALTER COLUMN `tech_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (PROJ_ID)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`project_milestone` ALTER COLUMN `predecessor_project_milestone_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`project_milestone` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost (ACT_COST)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`project_milestone` ALTER COLUMN `actual_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date (ACTUAL_DT)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`project_milestone` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp (APPROVAL_TS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`project_milestone` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Budget Amount (BUDGET_AMT)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`project_milestone` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp (COMP_TS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`project_milestone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`project_milestone` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR_CD)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`project_milestone` ALTER COLUMN `deliverable_description` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Description (DELIV_DESC)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`project_milestone` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date (DUE_DT)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`project_milestone` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Milestone Flag (CRITICAL_FLG)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`project_milestone` ALTER COLUMN `milestone_code` SET TAGS ('dbx_business_glossary_term' = 'Milestone Code (MS_CODE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`project_milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Milestone Name (MS_NAME)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`project_milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_business_glossary_term' = 'Milestone Type (MS_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`project_milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_value_regex' = 'gate_review|go_live|cutover|testing_complete|regulatory_submission|other');
ALTER TABLE `power_and_utilities_v2`.`technology`.`project_milestone` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Milestone Notes (MS_NOTES)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`project_milestone` ALTER COLUMN `planned_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Date (PLANNED_DT)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`project_milestone` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Milestone Priority (PRIORITY)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`project_milestone` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `power_and_utilities_v2`.`technology`.`project_milestone` ALTER COLUMN `project_milestone_description` SET TAGS ('dbx_business_glossary_term' = 'Milestone Description (MS_DESC)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`project_milestone` ALTER COLUMN `project_milestone_status` SET TAGS ('dbx_business_glossary_term' = 'Milestone Status (MS_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`project_milestone` ALTER COLUMN `project_milestone_status` SET TAGS ('dbx_value_regex' = 'pending|achieved|missed|deferred');
ALTER TABLE `power_and_utilities_v2`.`technology`.`project_milestone` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level (RISK_LVL)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`project_milestone` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `power_and_utilities_v2`.`technology`.`project_milestone` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_vulnerability` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_vulnerability` SET TAGS ('dbx_subdomain' = 'security_governance');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_vulnerability` ALTER COLUMN `cyber_vulnerability_id` SET TAGS ('dbx_business_glossary_term' = 'Cyber Vulnerability Identifier');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_vulnerability` ALTER COLUMN `it_asset_id` SET TAGS ('dbx_business_glossary_term' = 'It Asset Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_vulnerability` ALTER COLUMN `rediscovered_cyber_vulnerability_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_vulnerability` ALTER COLUMN `affected_software_version` SET TAGS ('dbx_business_glossary_term' = 'Affected Software/Firmware Version');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_vulnerability` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_vulnerability` ALTER COLUMN `cve_code` SET TAGS ('dbx_business_glossary_term' = 'Common Vulnerabilities and Exposures (CVE) Identifier');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_vulnerability` ALTER COLUMN `cvss_score` SET TAGS ('dbx_business_glossary_term' = 'Common Vulnerability Scoring System (CVSS) Score');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_vulnerability` ALTER COLUMN `cyber_vulnerability_description` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Description');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_vulnerability` ALTER COLUMN `discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Discovery Date');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_vulnerability` ALTER COLUMN `discovery_method` SET TAGS ('dbx_business_glossary_term' = 'Discovery Method');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_vulnerability` ALTER COLUMN `discovery_method` SET TAGS ('dbx_value_regex' = 'scanning|penetration_test|threat_intel|vendor_advisory|user_report');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_vulnerability` ALTER COLUMN `exploitability_score` SET TAGS ('dbx_business_glossary_term' = 'Exploitability Sub‑Score (CVSS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_vulnerability` ALTER COLUMN `impact_score` SET TAGS ('dbx_business_glossary_term' = 'Impact Sub‑Score (CVSS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_vulnerability` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Flag');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_vulnerability` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_vulnerability` ALTER COLUMN `nerc_cip_applicability` SET TAGS ('dbx_business_glossary_term' = 'NERC CIP Applicability Flag');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_vulnerability` ALTER COLUMN `patch_available` SET TAGS ('dbx_business_glossary_term' = 'Patch Availability Flag');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_vulnerability` ALTER COLUMN `patch_release_date` SET TAGS ('dbx_business_glossary_term' = 'Patch Release Date');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_vulnerability` ALTER COLUMN `references` SET TAGS ('dbx_business_glossary_term' = 'Reference URLs');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_vulnerability` ALTER COLUMN `remediation_action` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_vulnerability` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_vulnerability` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_vulnerability` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|deferred|not_applicable');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_vulnerability` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Severity Level');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_vulnerability` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|informational');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_vulnerability` ALTER COLUMN `vendor` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_vulnerability` ALTER COLUMN `vendor_advisory_reference` SET TAGS ('dbx_business_glossary_term' = 'Vendor Advisory Identifier');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_vulnerability` ALTER COLUMN `vulnerability_name` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Name');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_vulnerability` ALTER COLUMN `vulnerability_type` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Type');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_vulnerability` ALTER COLUMN `vulnerability_type` SET TAGS ('dbx_value_regex' = 'software|hardware|configuration|network|application');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_incident` SET TAGS ('dbx_subdomain' = 'security_governance');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_incident` ALTER COLUMN `cyber_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Cyber Incident ID');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_incident` ALTER COLUMN `it_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID (ASSET_ID)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_incident` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID (ASSET_ID)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_incident` ALTER COLUMN `cyber_vulnerability_id` SET TAGS ('dbx_business_glossary_term' = 'Cyber Vulnerability Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_incident` ALTER COLUMN `related_cyber_incident_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_incident` ALTER COLUMN `affected_systems` SET TAGS ('dbx_business_glossary_term' = 'Affected Systems (AFFECTED_SYSTEMS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_incident` ALTER COLUMN `attack_vector` SET TAGS ('dbx_business_glossary_term' = 'Attack Vector (ATTACK_VECTOR)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_incident` ALTER COLUMN `attack_vector` SET TAGS ('dbx_value_regex' = 'email|web|usb|remote_exploit|credential_theft|social_engineering');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_incident` ALTER COLUMN `containment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Containment Timestamp (CONTAINMENT_TIMESTAMP)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_incident` ALTER COLUMN `detection_source` SET TAGS ('dbx_business_glossary_term' = 'Detection Source (DETECTION_SOURCE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_incident` ALTER COLUMN `detection_source` SET TAGS ('dbx_value_regex' = 'siem|ids|user_report|log_analysis|threat_intel|other');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_incident` ALTER COLUMN `detection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detection Timestamp (DETECTION_TIMESTAMP)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_incident` ALTER COLUMN `eradication_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Eradication Timestamp (ERADICATION_TIMESTAMP)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_incident` ALTER COLUMN `impact_estimate_usd` SET TAGS ('dbx_business_glossary_term' = 'Impact Estimate (USD) (IMPACT_ESTIMATE_USD)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_incident` ALTER COLUMN `impact_estimate_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_incident` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Description (INCIDENT_DESCRIPTION)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Number (INCIDENT_NUMBER)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_value_regex' = 'INC-[0-9]{4}-[0-9]{4}');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status (INCIDENT_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_value_regex' = 'detected|contained|eradicated|recovered|closed|false_positive');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Type (INCIDENT_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_value_regex' = 'malware|phishing|ransomware|unauthorized_access|dos|insider_threat');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_incident` ALTER COLUMN `lessons_learned` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned (LESSONS_LEARNED)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_incident` ALTER COLUMN `mitigation_actions` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Actions (MITIGATION_ACTIONS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_incident` ALTER COLUMN `nerc_cip_reportable` SET TAGS ('dbx_business_glossary_term' = 'NERC CIP Reportable Flag (NERC_CIP_REPORTABLE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_incident` ALTER COLUMN `recovery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Recovery Timestamp (RECOVERY_TIMESTAMP)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_incident` ALTER COLUMN `regulatory_notification_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Status (REGULATORY_NOTIFICATION_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_incident` ALTER COLUMN `regulatory_notification_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|notified|escalated');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_incident` ALTER COLUMN `reported_by` SET TAGS ('dbx_business_glossary_term' = 'Reported By (REPORTED_BY)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_incident` ALTER COLUMN `reporting_department` SET TAGS ('dbx_business_glossary_term' = 'Reporting Department (REPORTING_DEPARTMENT)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_incident` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis (ROOT_CAUSE_ANALYSIS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_incident` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level (SEVERITY_LEVEL)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_incident` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_incident` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` SET TAGS ('dbx_subdomain' = 'security_governance');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` ALTER COLUMN `access_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Access Entitlement Identifier (AEI)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` ALTER COLUMN `approver_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Identifier (AI)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` ALTER COLUMN `approver_employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` ALTER COLUMN `approver_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` ALTER COLUMN `cip_standard_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Control Identifier (CCI)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Identifier (PID)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Identifier (AI)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` ALTER COLUMN `person_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` ALTER COLUMN `person_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` ALTER COLUMN `scada_system_id` SET TAGS ('dbx_business_glossary_term' = 'Target System Identifier (TSI)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` ALTER COLUMN `derived_from_access_entitlement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` ALTER COLUMN `access_entitlement_status` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Lifecycle Status (ELS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` ALTER COLUMN `access_entitlement_status` SET TAGS ('dbx_value_regex' = 'active|revoked|expired|pending|suspended');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` ALTER COLUMN `access_role` SET TAGS ('dbx_business_glossary_term' = 'Access Role (AR)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` ALTER COLUMN `access_role` SET TAGS ('dbx_value_regex' = 'read|write|admin|privileged');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` ALTER COLUMN `audit_trail_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Notes (ATN)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification for Entitlement (BJE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` ALTER COLUMN `compliance_requirement` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement (CR)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` ALTER COLUMN `entitlement_category` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Category (EC)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` ALTER COLUMN `entitlement_category` SET TAGS ('dbx_value_regex' = 'IT|OT|Network|Application|Database');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` ALTER COLUMN `entitlement_code` SET TAGS ('dbx_business_glossary_term' = 'Access Entitlement Code (AEC)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` ALTER COLUMN `entitlement_description` SET TAGS ('dbx_business_glossary_term' = 'Access Entitlement Description (AED)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` ALTER COLUMN `entitlement_name` SET TAGS ('dbx_business_glossary_term' = 'Access Entitlement Name (AEN)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Expiration Date (EED)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` ALTER COLUMN `grant_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Grant Timestamp (EGT)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` ALTER COLUMN `is_temporary` SET TAGS ('dbx_business_glossary_term' = 'Temporary Entitlement Flag (TEF)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date (LRD)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` ALTER COLUMN `nerc_cip_applicability` SET TAGS ('dbx_business_glossary_term' = 'NERC CIP Applicability Flag (NCF)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` ALTER COLUMN `permission_level` SET TAGS ('dbx_business_glossary_term' = 'Permission Level (PL)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` ALTER COLUMN `principal_type` SET TAGS ('dbx_business_glossary_term' = 'Principal Type (PT)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` ALTER COLUMN `principal_type` SET TAGS ('dbx_value_regex' = 'employee|contractor|service_account');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` ALTER COLUMN `review_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency (Days) (RFD)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Revocation Date (ERD)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Revocation Reason (ERR)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level (RL)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Name (SSN)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record Identifier (SSRI)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` ALTER COLUMN `system_name` SET TAGS ('dbx_business_glossary_term' = 'Target System Name (TSN)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` ALTER COLUMN `temporary_end_date` SET TAGS ('dbx_business_glossary_term' = 'Temporary Entitlement End Date (TED)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` SET TAGS ('dbx_subdomain' = 'security_governance');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` ALTER COLUMN `access_review_id` SET TAGS ('dbx_business_glossary_term' = 'Access Review ID');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` ALTER COLUMN `access_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Entitlement ID');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer ID');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer ID');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` ALTER COLUMN `person_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` ALTER COLUMN `person_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` ALTER COLUMN `review_owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Review Owner ID');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` ALTER COLUMN `review_owner_employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` ALTER COLUMN `review_owner_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` ALTER COLUMN `prior_access_review_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` ALTER COLUMN `auto_review_flag` SET TAGS ('dbx_business_glossary_term' = 'Automated Review Flag (ARF)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` ALTER COLUMN `compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Compliance Score (CScore)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (CS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exception');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` ALTER COLUMN `decision` SET TAGS ('dbx_business_glossary_term' = 'Review Decision (RD)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` ALTER COLUMN `decision` SET TAGS ('dbx_value_regex' = 'certified|revoked|modified|exception');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` ALTER COLUMN `decision_reason` SET TAGS ('dbx_business_glossary_term' = 'Decision Reason (DR)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` ALTER COLUMN `entitlement_name` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Name (EN)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` ALTER COLUMN `evidence_documentation` SET TAGS ('dbx_business_glossary_term' = 'Evidence Documentation (ED)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Notes (RN)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` ALTER COLUMN `overall_status` SET TAGS ('dbx_business_glossary_term' = 'Overall Status (OS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` ALTER COLUMN `overall_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|closed');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created (RAC)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated (RAU)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` ALTER COLUMN `review_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Timestamp (RCT)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` ALTER COLUMN `review_cycle_code` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle Code (RCC)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` ALTER COLUMN `review_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Review Owner Name (RON)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` ALTER COLUMN `review_owner_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` ALTER COLUMN `review_owner_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` ALTER COLUMN `review_period_end` SET TAGS ('dbx_business_glossary_term' = 'Review Period End Date (RPED)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` ALTER COLUMN `review_period_start` SET TAGS ('dbx_business_glossary_term' = 'Review Period Start Date (RPSD)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` ALTER COLUMN `review_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Start Timestamp (RST)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Review Type (RT)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'quarterly|annual|ad_hoc');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name (RN)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level (RL)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` ALTER COLUMN `total_certified` SET TAGS ('dbx_business_glossary_term' = 'Total Certified Entitlements (TCE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` ALTER COLUMN `total_entitlements_reviewed` SET TAGS ('dbx_business_glossary_term' = 'Total Entitlements Reviewed (TER)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` ALTER COLUMN `total_non_compliant` SET TAGS ('dbx_business_glossary_term' = 'Total Non‑Compliant Entitlements (TNC)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `scada_system_id` SET TAGS ('dbx_business_glossary_term' = 'SCADA System Identifier');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `redundant_scada_system_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `audit_findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Audit Findings Summary');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `average_response_time_ms` SET TAGS ('dbx_business_glossary_term' = 'Average Response Time (ms)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `capital_expenditure_amount` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure Amount');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `capital_expenditure_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `communication_architecture` SET TAGS ('dbx_business_glossary_term' = 'Communication Architecture');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `communication_architecture` SET TAGS ('dbx_value_regex' = 'point_to_point|hub_spoke|bus|mesh');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `current_operational_state` SET TAGS ('dbx_business_glossary_term' = 'Current Operational State');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `current_operational_state` SET TAGS ('dbx_value_regex' = 'online|offline|degraded|maintenance');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `data_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period (Days)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `deployment_environment` SET TAGS ('dbx_business_glossary_term' = 'Deployment Environment');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `deployment_environment` SET TAGS ('dbx_value_regex' = 'production|dr|test|development');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `firmware_update_schedule` SET TAGS ('dbx_business_glossary_term' = 'Firmware Update Schedule');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `hostname` SET TAGS ('dbx_business_glossary_term' = 'Hostname');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `ip_address` SET TAGS ('dbx_value_regex' = '^((25[0-5]|2[0-4]d|[01]?dd?).){3}(25[0-5]|2[0-4]d|[01]?dd?)$');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `last_firmware_update_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Firmware Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'in_service|retired|planned|decommissioned|maintenance');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `maintenance_window` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `max_concurrent_connections` SET TAGS ('dbx_business_glossary_term' = 'Maximum Concurrent Connections');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `max_throughput_mbps` SET TAGS ('dbx_business_glossary_term' = 'Maximum Throughput (Mbps)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `nerc_cip_bes_classification` SET TAGS ('dbx_business_glossary_term' = 'NERC CIP BES Classification');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `nerc_cip_bes_classification` SET TAGS ('dbx_value_regex' = 'critical|non_critical|unknown');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `operating_expenditure_amount` SET TAGS ('dbx_business_glossary_term' = 'Operating Expenditure Amount');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `operating_expenditure_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `power_consumption_kw` SET TAGS ('dbx_business_glossary_term' = 'Power Consumption (kW)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `primary_function` SET TAGS ('dbx_business_glossary_term' = 'Primary Function');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `redundancy_configuration` SET TAGS ('dbx_business_glossary_term' = 'Redundancy Configuration');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `redundancy_configuration` SET TAGS ('dbx_value_regex' = 'active_active|active_passive|none');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `scada_system_description` SET TAGS ('dbx_business_glossary_term' = 'System Description');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `security_certification` SET TAGS ('dbx_business_glossary_term' = 'Security Certification');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `support_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Support Contact Email');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `support_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `support_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `support_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Support Contact Phone');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `support_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `support_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `supported_protocols` SET TAGS ('dbx_business_glossary_term' = 'Supported Protocols');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `system_code` SET TAGS ('dbx_business_glossary_term' = 'System Code');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `system_name` SET TAGS ('dbx_business_glossary_term' = 'System Name');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `system_type` SET TAGS ('dbx_business_glossary_term' = 'System Type');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `vendor` SET TAGS ('dbx_business_glossary_term' = 'System Vendor');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'System Version');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` SET TAGS ('dbx_subdomain' = 'security_governance');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `scada_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'SCADA Configuration Record Identifier');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `change_request_id` SET TAGS ('dbx_business_glossary_term' = 'Change Request Identifier');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `scada_system_id` SET TAGS ('dbx_business_glossary_term' = 'Control System Identifier');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `superseded_scada_configuration_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Configuration Approved By');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Configuration Approval Date');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `approved_version` SET TAGS ('dbx_business_glossary_term' = 'Approved Configuration Version');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `audit_findings` SET TAGS ('dbx_business_glossary_term' = 'Audit Findings');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|not‑applicable');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Authentication Method');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `baseline_status` SET TAGS ('dbx_business_glossary_term' = 'Baseline Status');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `baseline_status` SET TAGS ('dbx_value_regex' = 'baseline|deviation|exception');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `change_control_date` SET TAGS ('dbx_business_glossary_term' = 'Change Control Date');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `change_control_number` SET TAGS ('dbx_business_glossary_term' = 'Change Control Number');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `change_control_status` SET TAGS ('dbx_business_glossary_term' = 'Change Control Status');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `change_control_status` SET TAGS ('dbx_value_regex' = 'open|in‑progress|closed|rejected');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `change_request_status` SET TAGS ('dbx_business_glossary_term' = 'Change Request Status');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `change_request_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|implemented|closed');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `communication_port` SET TAGS ('dbx_business_glossary_term' = 'Communication Port Number');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non‑compliant|exempt|pending');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `configuration_category` SET TAGS ('dbx_business_glossary_term' = 'Configuration Category');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `configuration_hash` SET TAGS ('dbx_business_glossary_term' = 'Configuration Hash');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `configuration_item_name` SET TAGS ('dbx_business_glossary_term' = 'Configuration Item Name');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `configuration_item_type` SET TAGS ('dbx_business_glossary_term' = 'Configuration Item Type');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `current_version` SET TAGS ('dbx_business_glossary_term' = 'Current Configuration Version');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `deviation_description` SET TAGS ('dbx_business_glossary_term' = 'Configuration Deviation Description');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `deviation_flag` SET TAGS ('dbx_business_glossary_term' = 'Configuration Deviation Flag');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `enabled_services` SET TAGS ('dbx_business_glossary_term' = 'Enabled Services List');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `encryption_enabled` SET TAGS ('dbx_business_glossary_term' = 'Encryption Enabled Flag');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Configuration Flag');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `last_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verification Date');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `patch_date` SET TAGS ('dbx_business_glossary_term' = 'Patch Application Date');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `patch_level` SET TAGS ('dbx_business_glossary_term' = 'Patch Level');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `protocol` SET TAGS ('dbx_business_glossary_term' = 'Communication Protocol');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `regulatory_requirement` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Reference');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (Days)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `security_setting` SET TAGS ('dbx_business_glossary_term' = 'Security Setting');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `system_name` SET TAGS ('dbx_business_glossary_term' = 'Control System Name');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_configuration` ALTER COLUMN `verification_result` SET TAGS ('dbx_business_glossary_term' = 'Verification Result');
ALTER TABLE `power_and_utilities_v2`.`technology`.`patch_deployment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`technology`.`patch_deployment` SET TAGS ('dbx_subdomain' = 'security_governance');
ALTER TABLE `power_and_utilities_v2`.`technology`.`patch_deployment` ALTER COLUMN `patch_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Patch Deployment Identifier');
ALTER TABLE `power_and_utilities_v2`.`technology`.`patch_deployment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (CREATED_BY)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`patch_deployment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`patch_deployment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`patch_deployment` ALTER COLUMN `it_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Target Asset Identifier (ASSET_ID)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`patch_deployment` ALTER COLUMN `updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier (UPDATED_BY)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`patch_deployment` ALTER COLUMN `updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`patch_deployment` ALTER COLUMN `updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`patch_deployment` ALTER COLUMN `superseded_patch_deployment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`patch_deployment` ALTER COLUMN `applied_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Applied Deployment Timestamp (APPLY_TS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`patch_deployment` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Type (ASSET_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`patch_deployment` ALTER COLUMN `asset_type` SET TAGS ('dbx_value_regex' = 'IT|OT|SCADA|EMS|DMS|Network');
ALTER TABLE `power_and_utilities_v2`.`technology`.`patch_deployment` ALTER COLUMN `change_control_ticket` SET TAGS ('dbx_business_glossary_term' = 'Change Control Ticket (CHG_TICKET)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`patch_deployment` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMP_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`patch_deployment` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non-compliant|exempt');
ALTER TABLE `power_and_utilities_v2`.`technology`.`patch_deployment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`patch_deployment` ALTER COLUMN `cve_references` SET TAGS ('dbx_business_glossary_term' = 'CVE References (CVE_REF)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`patch_deployment` ALTER COLUMN `deferral_reason` SET TAGS ('dbx_business_glossary_term' = 'Deferral Reason (DEF_REASON)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`patch_deployment` ALTER COLUMN `deployment_code` SET TAGS ('dbx_business_glossary_term' = 'Deployment Code (DEP_CODE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`patch_deployment` ALTER COLUMN `deployment_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Deployment Duration (DUR_SEC)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`patch_deployment` ALTER COLUMN `deployment_method` SET TAGS ('dbx_business_glossary_term' = 'Deployment Method (DEP_METHOD)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`patch_deployment` ALTER COLUMN `deployment_method` SET TAGS ('dbx_value_regex' = 'automated|manual|semi-automated');
ALTER TABLE `power_and_utilities_v2`.`technology`.`patch_deployment` ALTER COLUMN `deployment_source` SET TAGS ('dbx_business_glossary_term' = 'Deployment Source (DEP_SOURCE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`patch_deployment` ALTER COLUMN `deployment_source` SET TAGS ('dbx_value_regex' = 'vendor_advisory|cisa_kev|internal|third_party');
ALTER TABLE `power_and_utilities_v2`.`technology`.`patch_deployment` ALTER COLUMN `deployment_status` SET TAGS ('dbx_business_glossary_term' = 'Deployment Status (DEP_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`patch_deployment` ALTER COLUMN `deployment_status` SET TAGS ('dbx_value_regex' = 'scheduled|applied|failed|deferred|cancelled');
ALTER TABLE `power_and_utilities_v2`.`technology`.`patch_deployment` ALTER COLUMN `nerc_cip_applicable` SET TAGS ('dbx_business_glossary_term' = 'NERC CIP Applicability (NERC_CIP_APPL)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`patch_deployment` ALTER COLUMN `patch_identifier` SET TAGS ('dbx_business_glossary_term' = 'Patch Identifier (PATCH_ID)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`patch_deployment` ALTER COLUMN `patch_size_mb` SET TAGS ('dbx_business_glossary_term' = 'Patch Size (SIZE_MB)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`patch_deployment` ALTER COLUMN `patch_version` SET TAGS ('dbx_business_glossary_term' = 'Patch Version (PATCH_VER)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`patch_deployment` ALTER COLUMN `rollback_required` SET TAGS ('dbx_business_glossary_term' = 'Rollback Required Flag (ROLLBACK_REQ)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`patch_deployment` ALTER COLUMN `rollback_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Rollback Timestamp (ROLLBACK_TS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`patch_deployment` ALTER COLUMN `scheduled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Deployment Timestamp (SCHED_TS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`patch_deployment` ALTER COLUMN `target_asset_name` SET TAGS ('dbx_business_glossary_term' = 'Target Asset Name (ASSET_NAME)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`patch_deployment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`software_license` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`technology`.`software_license` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `power_and_utilities_v2`.`technology`.`software_license` ALTER COLUMN `software_license_id` SET TAGS ('dbx_business_glossary_term' = 'Software License ID (SLID)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`software_license` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Application Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`software_license` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`software_license` ALTER COLUMN `upgraded_from_software_license_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`software_license` ALTER COLUMN `annual_cost` SET TAGS ('dbx_business_glossary_term' = 'Annual License Cost (ANNUAL_COST)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`software_license` ALTER COLUMN `compliance_last_checked` SET TAGS ('dbx_business_glossary_term' = 'Compliance Last Checked (COMPLIANCE_CHECK_DATE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`software_license` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMPLIANCE_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`software_license` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `power_and_utilities_v2`.`technology`.`software_license` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference (CONTRACT_REF)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`software_license` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`software_license` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR_CODE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`software_license` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|CHF');
ALTER TABLE `power_and_utilities_v2`.`technology`.`software_license` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (END_DATE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`software_license` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (START_DATE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`software_license` ALTER COLUMN `license_key` SET TAGS ('dbx_business_glossary_term' = 'License Key (LK)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`software_license` ALTER COLUMN `license_notes` SET TAGS ('dbx_business_glossary_term' = 'License Notes (NOTES)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`software_license` ALTER COLUMN `license_owner` SET TAGS ('dbx_business_glossary_term' = 'License Owner (OWNER)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`software_license` ALTER COLUMN `license_region` SET TAGS ('dbx_business_glossary_term' = 'License Region (REGION)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`software_license` ALTER COLUMN `license_status` SET TAGS ('dbx_business_glossary_term' = 'License Status (STATUS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`software_license` ALTER COLUMN `license_status` SET TAGS ('dbx_value_regex' = 'active|inactive|expired|suspended|pending');
ALTER TABLE `power_and_utilities_v2`.`technology`.`software_license` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type (TYPE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`software_license` ALTER COLUMN `license_type` SET TAGS ('dbx_value_regex' = 'perpetual|subscription|concurrent|named_user|site');
ALTER TABLE `power_and_utilities_v2`.`technology`.`software_license` ALTER COLUMN `maintenance_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Expiration Date (MAINT_EXP)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`software_license` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Software Product Name (PRODUCT_NAME)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`software_license` ALTER COLUMN `purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Date (PURCHASE_DATE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`software_license` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number (PO_NUMBER)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`software_license` ALTER COLUMN `quantity_deployed` SET TAGS ('dbx_business_glossary_term' = 'Deployed Quantity (QTY_DEPLOYED)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`software_license` ALTER COLUMN `quantity_licensed` SET TAGS ('dbx_business_glossary_term' = 'Licensed Quantity (QTY_LICENSED)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`software_license` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date (RENEW_DATE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`software_license` ALTER COLUMN `renewal_term_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term (RENEW_TERM_MONTHS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`software_license` ALTER COLUMN `support_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Support Expiration Date (SUPPORT_EXP)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`software_license` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Contract Cost (TOTAL_COST)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`software_license` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`software_license` ALTER COLUMN `usage_measure_date` SET TAGS ('dbx_business_glossary_term' = 'Usage Measure Date (USAGE_DATE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`software_license` ALTER COLUMN `usage_metric_percent` SET TAGS ('dbx_business_glossary_term' = 'Usage Metric Percentage (USAGE_PCT)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`software_license` ALTER COLUMN `vendor` SET TAGS ('dbx_business_glossary_term' = 'Software Vendor (VENDOR)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `telecom_circuit_id` SET TAGS ('dbx_business_glossary_term' = 'Telecom Circuit ID');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `backup_circuit_id` SET TAGS ('dbx_business_glossary_term' = 'Backup Circuit ID (BACKUP_ID)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `network_device_id` SET TAGS ('dbx_business_glossary_term' = 'Network Device Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `network_device_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `network_device_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Start Site Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `redundant_telecom_circuit_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `bandwidth_mbps` SET TAGS ('dbx_business_glossary_term' = 'Bandwidth (Mbps) (BW)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `carrier` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name (CARRIER)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `circuit_code` SET TAGS ('dbx_business_glossary_term' = 'Circuit Code (CODE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `circuit_tag` SET TAGS ('dbx_business_glossary_term' = 'Circuit Tag (TAG)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `circuit_type` SET TAGS ('dbx_business_glossary_term' = 'Circuit Type (TYPE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `circuit_type` SET TAGS ('dbx_value_regex' = 'fiber|microwave|cellular|leased_line|mpls|satellite');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements (COMPLIANCE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number (CONTRACT_NO)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `contract_term_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Term (MONTHS) (TERM)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (CREATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFF_FROM)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EFF_UNTIL)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `encryption_status` SET TAGS ('dbx_business_glossary_term' = 'Encryption Status (ENCRYPTED)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `end_location_code` SET TAGS ('dbx_business_glossary_term' = 'End Location Code (END_LOC)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `end_site` SET TAGS ('dbx_business_glossary_term' = 'End Site (END_SITE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `failure_count` SET TAGS ('dbx_business_glossary_term' = 'Failure Count (FAIL_COUNT)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Circuit Flag (PRIMARY)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `last_failure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Failure Timestamp (FAIL_TS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date (INSP_DATE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `maintenance_window` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window (MAINT_WIN)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `monitoring_enabled` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Enabled (MONITOR)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `monthly_cost` SET TAGS ('dbx_business_glossary_term' = 'Monthly Cost (COST)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `network_layer` SET TAGS ('dbx_business_glossary_term' = 'Network Layer (LAYER)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `network_layer` SET TAGS ('dbx_value_regex' = 'L1|L2|L3');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `next_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Date (NEXT_MAINT)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `provisioning_status` SET TAGS ('dbx_business_glossary_term' = 'Provisioning Status (PROV_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `provisioning_status` SET TAGS ('dbx_value_regex' = 'provisioned|provisioning|failed');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `qos_profile` SET TAGS ('dbx_business_glossary_term' = 'QoS Profile (QOS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `redundancy_flag` SET TAGS ('dbx_business_glossary_term' = 'Redundancy Flag (REDUNDANT)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `security_classification` SET TAGS ('dbx_business_glossary_term' = 'Security Classification (SEC_CLASS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `security_classification` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `service_class` SET TAGS ('dbx_business_glossary_term' = 'Service Class (CLASS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `service_class` SET TAGS ('dbx_value_regex' = 'operational_critical|business|backup');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `sla_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'SLA Latency (MS) (SLA_LAT)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `sla_uptime_percent` SET TAGS ('dbx_business_glossary_term' = 'SLA Uptime Percentage (SLA_UP)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `start_location_code` SET TAGS ('dbx_business_glossary_term' = 'Start Location Code (START_LOC)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `technology` SET TAGS ('dbx_business_glossary_term' = 'Circuit Technology (TECH)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `technology` SET TAGS ('dbx_value_regex' = 'GPON|DWDM|Ethernet|SDH|Microwave');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `telecom_circuit_description` SET TAGS ('dbx_business_glossary_term' = 'Circuit Description (DESC)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `telecom_circuit_name` SET TAGS ('dbx_business_glossary_term' = 'Circuit Name (NAME)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `telecom_circuit_status` SET TAGS ('dbx_business_glossary_term' = 'Circuit Status (STATUS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `telecom_circuit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|decommissioned');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date (TERM_DATE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason (TERM_REASON)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (UPDATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` SET TAGS ('dbx_subdomain' = 'project_finance');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `disaster_recovery_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Disaster Recovery Plan ID (DRP ID)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `superseded_disaster_recovery_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `alternate_recovery_site` SET TAGS ('dbx_business_glossary_term' = 'Alternate Recovery Site (Alternate Site)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By (Approver Name)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `backup_strategy` SET TAGS ('dbx_business_glossary_term' = 'Backup Strategy (Backup Method)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (Compliance)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address (Email)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number (Phone)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `covered_systems` SET TAGS ('dbx_business_glossary_term' = 'Covered Systems (Systems Covered by DRP)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `data_center_location` SET TAGS ('dbx_business_glossary_term' = 'Data Center Location (DC Location)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `disaster_recovery_plan_description` SET TAGS ('dbx_business_glossary_term' = 'Plan Description (DRP Description)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Plan Effective Start Date (Effective From)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Plan Effective End Date (Effective Until)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `last_tested_date` SET TAGS ('dbx_business_glossary_term' = 'Last Tested Date (Last Test Date)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Date (Last Update Date)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Disaster Recovery Plan Lifecycle Status (DRP Status)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|retired|archived');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date (Upcoming Review)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `plan_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Approval Date (Approval Date)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `plan_budget_usd` SET TAGS ('dbx_business_glossary_term' = 'Plan Budget (USD) (Budget USD)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `plan_category` SET TAGS ('dbx_business_glossary_term' = 'Disaster Recovery Plan Category (DRP Category)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `plan_category` SET TAGS ('dbx_value_regex' = 'critical|non_critical|optional');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Disaster Recovery Plan Code (DRP Code)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `plan_cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Plan Cost Center Code (Cost Center)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `plan_dependencies` SET TAGS ('dbx_business_glossary_term' = 'Plan Dependencies (Dependent Systems/Plans)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `plan_document_location` SET TAGS ('dbx_business_glossary_term' = 'Plan Document Location (Document Path/URL)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `plan_last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Plan Last Modified By (Modifier Name)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Disaster Recovery Plan Name (DRP Name)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `plan_owner` SET TAGS ('dbx_business_glossary_term' = 'Plan Owner (Owner of DRP)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `plan_priority` SET TAGS ('dbx_business_glossary_term' = 'Plan Priority (Priority Level)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `plan_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `plan_review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Plan Review Frequency (Months)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `plan_scope` SET TAGS ('dbx_business_glossary_term' = 'Plan Scope (Scope of DRP)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `plan_test_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Plan Test Frequency (Months)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Disaster Recovery Plan Type (DRP Type)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'IT_DRP|OT_SCADA_DRP|BCP');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'Plan Version (Version)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `primary_recovery_site` SET TAGS ('dbx_business_glossary_term' = 'Primary Recovery Site (Primary Site)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp (Created At)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp (Updated At)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `recovery_point_objective_hours` SET TAGS ('dbx_business_glossary_term' = 'Recovery Point Objective (RPO) Hours');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `recovery_time_objective_hours` SET TAGS ('dbx_business_glossary_term' = 'Recovery Time Objective (RTO) Hours');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `regulatory_requirement_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Reference (Regulation Ref)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `risk_assessment_summary` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Summary (Risk Summary)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `test_result_status` SET TAGS ('dbx_business_glossary_term' = 'Test Result Status (Test Outcome)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`disaster_recovery_plan` ALTER COLUMN `test_result_status` SET TAGS ('dbx_value_regex' = 'passed|failed|partial|not_tested');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` SET TAGS ('dbx_subdomain' = 'project_finance');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `dr_test_event_id` SET TAGS ('dbx_business_glossary_term' = 'Disaster Recovery Test Event ID (DR Test Event ID)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `disaster_recovery_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Disaster Recovery Plan ID (DR Plan ID)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Test Approval ID (DR Approval ID)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `test_approval_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Test Approval ID (DR Approval ID)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `test_lead_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Test Lead Identifier (DR Test Lead ID)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `retest_of_dr_test_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `compliance_requirements_met` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements Met (DR Compliance Met)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date (DR Action Due)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status (DR Action Status)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `corrective_actions` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions (DR Corrective Actions)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation URL (DR Documentation)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `gaps_identified` SET TAGS ('dbx_business_glossary_term' = 'Gaps Identified (DR Gaps)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `is_simulation` SET TAGS ('dbx_business_glossary_term' = 'Simulation Flag (DR Simulation)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `nerc_cip_applicable` SET TAGS ('dbx_business_glossary_term' = 'NERC CIP Applicability (NERC CIP‑009)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (DR Test Notes)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp (Created)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp (Updated)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `regulatory_reporting_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Status (DR Regulatory Status)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `regulatory_reporting_status` SET TAGS ('dbx_value_regex' = 'not_reported|reported|pending|exempt');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level (DR Risk Level)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `rpo_achieved_minutes` SET TAGS ('dbx_business_glossary_term' = 'Recovery Point Objective Achieved (RPO Achieved)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `rpo_target_minutes` SET TAGS ('dbx_business_glossary_term' = 'Recovery Point Objective Target (RPO Target)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `rto_achieved_minutes` SET TAGS ('dbx_business_glossary_term' = 'Recovery Time Objective Achieved (RTO Achieved)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `rto_target_minutes` SET TAGS ('dbx_business_glossary_term' = 'Recovery Time Objective Target (RTO Target)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Severity (DR Severity)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `systems_tested` SET TAGS ('dbx_business_glossary_term' = 'Systems Tested (DR Systems Tested)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `test_approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Approval Timestamp (Approved At)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `test_category` SET TAGS ('dbx_business_glossary_term' = 'Test Category (DR Category)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Test Date (DR Test Date)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `test_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Test Duration (Minutes)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `test_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test End Timestamp (DR Test End)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `test_environment` SET TAGS ('dbx_business_glossary_term' = 'Test Environment (DR Environment)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `test_event_code` SET TAGS ('dbx_business_glossary_term' = 'Disaster Recovery Test Event Code (DR Test Event Code)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `test_execution_reference` SET TAGS ('dbx_business_glossary_term' = 'Test Execution ID (DR Execution ID)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `test_execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Execution Timestamp (Executed At)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `test_failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Test Failure Reason (DR Failure Reason)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `test_location` SET TAGS ('dbx_business_glossary_term' = 'Test Location (DR Test Location)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `test_methodology` SET TAGS ('dbx_business_glossary_term' = 'Test Methodology (DR Test Methodology)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `test_outcome` SET TAGS ('dbx_business_glossary_term' = 'Test Outcome (DR Test Outcome)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `test_outcome` SET TAGS ('dbx_value_regex' = 'pass|partial_pass|fail');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `test_priority` SET TAGS ('dbx_business_glossary_term' = 'Test Priority (DR Priority)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `test_priority` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `test_result_summary` SET TAGS ('dbx_business_glossary_term' = 'Test Result Summary (DR Summary)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `test_scope` SET TAGS ('dbx_business_glossary_term' = 'Test Scope (DR Test Scope)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `test_scope` SET TAGS ('dbx_value_regex' = 'critical|non_critical|partial');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `test_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Start Timestamp (DR Test Start)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `test_status` SET TAGS ('dbx_business_glossary_term' = 'Test Status (DR Test Status)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `test_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|cancelled');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `test_success_metric` SET TAGS ('dbx_business_glossary_term' = 'Test Success Metric (DR Success Metric)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `test_success_metric` SET TAGS ('dbx_value_regex' = 'met|not_met');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `test_team` SET TAGS ('dbx_business_glossary_term' = 'Test Team (DR Test Team)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type (DR Test Type)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'tabletop|functional|full_failover');
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ALTER COLUMN `test_version` SET TAGS ('dbx_business_glossary_term' = 'Test Version (DR Plan Version)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` SET TAGS ('dbx_subdomain' = 'project_finance');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `tech_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Vendor Identifier');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `acquired_by_tech_vendor_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Vendor Address Line 1');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Vendor Address Line 2');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `annual_spend_estimate` SET TAGS ('dbx_business_glossary_term' = 'Annual Spend Estimate');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `approved_vendor_list_flag` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor List Flag');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Vendor City');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Compliance Status');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Status');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|terminated|suspended');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Country Code');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|MXN');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `data_privacy_certification` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Certification');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `data_privacy_certification` SET TAGS ('dbx_value_regex' = 'iso27001|soc2|none');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `data_privacy_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Certification Date');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor DUNS Number');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `insurance_coverage_status` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Status');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `insurance_coverage_status` SET TAGS ('dbx_value_regex' = 'insured|uninsured|pending');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `insurance_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiration Date');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `last_rating_date` SET TAGS ('dbx_business_glossary_term' = 'Last Rating Date');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `last_security_incident_date` SET TAGS ('dbx_business_glossary_term' = 'Last Security Incident Date');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `last_security_incident_description` SET TAGS ('dbx_business_glossary_term' = 'Last Security Incident Description');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Lifecycle Status');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived|pending_review');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `nerc_cip_scrm_classification` SET TAGS ('dbx_business_glossary_term' = 'NERC CIP SCRM Classification');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `nerc_cip_scrm_classification` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Vendor Notes');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Vendor Payment Terms');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net30|net45|net60');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Postal Code');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `rating_score` SET TAGS ('dbx_business_glossary_term' = 'Vendor Rating Score');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Registration Number');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `security_assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Security Assessment Status');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `security_assessment_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|failed');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `service_area` SET TAGS ('dbx_business_glossary_term' = 'Vendor Service Area');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'Vendor State/Province');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Tax Identification Number');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `tech_vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Legal Name');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Email Address');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `vendor_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Phone Number');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `vendor_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `vendor_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `vendor_contact_role` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Role');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `vendor_rating_source` SET TAGS ('dbx_business_glossary_term' = 'Vendor Rating Source');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `vendor_rating_source` SET TAGS ('dbx_value_regex' = 'internal|external');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `vendor_type` SET TAGS ('dbx_business_glossary_term' = 'Vendor Type');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `vendor_type` SET TAGS ('dbx_value_regex' = 'hardware_oem|software_vendor|msp|systems_integrator|telecom_carrier|ot_scada_vendor');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_vendor` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Vendor Website URL');
ALTER TABLE `power_and_utilities_v2`.`technology`.`supply_chain_risk` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`technology`.`supply_chain_risk` SET TAGS ('dbx_subdomain' = 'security_governance');
ALTER TABLE `power_and_utilities_v2`.`technology`.`supply_chain_risk` ALTER COLUMN `supply_chain_risk_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Chain Risk ID');
ALTER TABLE `power_and_utilities_v2`.`technology`.`supply_chain_risk` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Owner ID');
ALTER TABLE `power_and_utilities_v2`.`technology`.`supply_chain_risk` ALTER COLUMN `it_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Component ID');
ALTER TABLE `power_and_utilities_v2`.`technology`.`supply_chain_risk` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `power_and_utilities_v2`.`technology`.`supply_chain_risk` ALTER COLUMN `reassessed_supply_chain_risk_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`supply_chain_risk` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `power_and_utilities_v2`.`technology`.`supply_chain_risk` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `power_and_utilities_v2`.`technology`.`supply_chain_risk` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|deferred');
ALTER TABLE `power_and_utilities_v2`.`technology`.`supply_chain_risk` ALTER COLUMN `compliance_reference` SET TAGS ('dbx_business_glossary_term' = 'Compliance Reference');
ALTER TABLE `power_and_utilities_v2`.`technology`.`supply_chain_risk` ALTER COLUMN `component_name` SET TAGS ('dbx_business_glossary_term' = 'Component Name');
ALTER TABLE `power_and_utilities_v2`.`technology`.`supply_chain_risk` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`technology`.`supply_chain_risk` ALTER COLUMN `identified_threats` SET TAGS ('dbx_business_glossary_term' = 'Identified Threats');
ALTER TABLE `power_and_utilities_v2`.`technology`.`supply_chain_risk` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `power_and_utilities_v2`.`technology`.`supply_chain_risk` ALTER COLUMN `mitigating_controls` SET TAGS ('dbx_business_glossary_term' = 'Mitigating Controls');
ALTER TABLE `power_and_utilities_v2`.`technology`.`supply_chain_risk` ALTER COLUMN `nerc_cip_applicable` SET TAGS ('dbx_business_glossary_term' = 'NERC CIP Applicable');
ALTER TABLE `power_and_utilities_v2`.`technology`.`supply_chain_risk` ALTER COLUMN `nerc_cip_reported` SET TAGS ('dbx_business_glossary_term' = 'NERC CIP Reported');
ALTER TABLE `power_and_utilities_v2`.`technology`.`supply_chain_risk` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `power_and_utilities_v2`.`technology`.`supply_chain_risk` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `power_and_utilities_v2`.`technology`.`supply_chain_risk` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `power_and_utilities_v2`.`technology`.`supply_chain_risk` ALTER COLUMN `regulatory_notification_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Status');
ALTER TABLE `power_and_utilities_v2`.`technology`.`supply_chain_risk` ALTER COLUMN `regulatory_notification_status` SET TAGS ('dbx_value_regex' = 'not_required|required|submitted|approved|rejected');
ALTER TABLE `power_and_utilities_v2`.`technology`.`supply_chain_risk` ALTER COLUMN `remediation_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action Plan');
ALTER TABLE `power_and_utilities_v2`.`technology`.`supply_chain_risk` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `power_and_utilities_v2`.`technology`.`supply_chain_risk` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status');
ALTER TABLE `power_and_utilities_v2`.`technology`.`supply_chain_risk` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|not_applicable');
ALTER TABLE `power_and_utilities_v2`.`technology`.`supply_chain_risk` ALTER COLUMN `risk_assessment_identifier` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Identifier (RAI)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`supply_chain_risk` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `power_and_utilities_v2`.`technology`.`supply_chain_risk` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'software_integrity|hardware_authenticity|remote_access|vendor_notification|supply_chain_disruption');
ALTER TABLE `power_and_utilities_v2`.`technology`.`supply_chain_risk` ALTER COLUMN `risk_comments` SET TAGS ('dbx_business_glossary_term' = 'Risk Comments');
ALTER TABLE `power_and_utilities_v2`.`technology`.`supply_chain_risk` ALTER COLUMN `risk_exposure_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Risk Exposure Amount (USD)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`supply_chain_risk` ALTER COLUMN `risk_owner` SET TAGS ('dbx_business_glossary_term' = 'Risk Owner');
ALTER TABLE `power_and_utilities_v2`.`technology`.`supply_chain_risk` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `power_and_utilities_v2`.`technology`.`supply_chain_risk` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `power_and_utilities_v2`.`technology`.`supply_chain_risk` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `power_and_utilities_v2`.`technology`.`supply_chain_risk` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`technology`.`supply_chain_risk` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'ERP|CMDB|Manual|Other');
ALTER TABLE `power_and_utilities_v2`.`technology`.`supply_chain_risk` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_sla` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_sla` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_sla` ALTER COLUMN `it_sla_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Identifier');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_sla` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Service Owner Identifier');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_sla` ALTER COLUMN `it_service_id` SET TAGS ('dbx_business_glossary_term' = 'It Service Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_sla` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Service Owner Identifier');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_sla` ALTER COLUMN `superseded_it_sla_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_sla` ALTER COLUMN `breach_indicator` SET TAGS ('dbx_business_glossary_term' = 'Breach Indicator');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_sla` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_sla` ALTER COLUMN `business_unit` SET TAGS ('dbx_value_regex' = 'generation|transmission|distribution|customer_service|finance|it');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_sla` ALTER COLUMN `compliance_requirement` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_sla` ALTER COLUMN `compliance_requirement` SET TAGS ('dbx_value_regex' = 'NERC_CIP|FERC|PUC|ISO|EPA|NIST');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_sla` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_sla` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_sla` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_sla` ALTER COLUMN `escalation_contact` SET TAGS ('dbx_business_glossary_term' = 'Escalation Contact Email');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_sla` ALTER COLUMN `escalation_contact` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_sla` ALTER COLUMN `escalation_contact` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_sla` ALTER COLUMN `escalation_contact` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_sla` ALTER COLUMN `escalation_threshold` SET TAGS ('dbx_business_glossary_term' = 'Escalation Threshold');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_sla` ALTER COLUMN `escalation_threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Escalation Threshold Unit');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_sla` ALTER COLUMN `escalation_threshold_unit` SET TAGS ('dbx_value_regex' = '%|minutes|hours|seconds|days|requests');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_sla` ALTER COLUMN `it_sla_description` SET TAGS ('dbx_business_glossary_term' = 'SLA Description');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_sla` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_sla` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'SLA Lifecycle Status');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_sla` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|suspended|retired');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_sla` ALTER COLUMN `measurement_period` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_sla` ALTER COLUMN `measurement_period` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|yearly|rolling_12_months');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_sla` ALTER COLUMN `metric_type` SET TAGS ('dbx_business_glossary_term' = 'SLA Metric Type');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_sla` ALTER COLUMN `metric_type` SET TAGS ('dbx_value_regex' = 'availability|mttr|response_time|resolution_time|uptime|downtime');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_sla` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_sla` ALTER COLUMN `penalty_currency` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_sla` ALTER COLUMN `penalty_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|JPY|AUD');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_sla` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_sla` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annually');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_sla` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_sla` ALTER COLUMN `review_frequency` SET TAGS ('dbx_value_regex' = 'annual|biennial|quarterly');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_sla` ALTER COLUMN `service_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Service Owner Name');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_sla` ALTER COLUMN `sla_name` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Name');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_sla` ALTER COLUMN `sla_number` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Number');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_sla` ALTER COLUMN `sla_version` SET TAGS ('dbx_business_glossary_term' = 'SLA Version');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_sla` ALTER COLUMN `target_unit` SET TAGS ('dbx_business_glossary_term' = 'SLA Target Unit');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_sla` ALTER COLUMN `target_unit` SET TAGS ('dbx_value_regex' = '%|minutes|hours|seconds|days|requests');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_sla` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'SLA Target Value');
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_sla` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`technology`.`digital_platform` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`technology`.`digital_platform` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `power_and_utilities_v2`.`technology`.`digital_platform` ALTER COLUMN `digital_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Platform Identifier (DP_ID)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`digital_platform` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`digital_platform` ALTER COLUMN `tech_project_id` SET TAGS ('dbx_business_glossary_term' = 'Tech Project Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`digital_platform` ALTER COLUMN `superseded_digital_platform_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`digital_platform` ALTER COLUMN `active_user_count` SET TAGS ('dbx_business_glossary_term' = 'Active User Count (ACTIVE_USERS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`digital_platform` ALTER COLUMN `api_version` SET TAGS ('dbx_business_glossary_term' = 'API Version (API_VER)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`digital_platform` ALTER COLUMN `average_response_time_ms` SET TAGS ('dbx_business_glossary_term' = 'Average Response Time (AVG_RESP_MS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`digital_platform` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status (COMPLIANCE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`digital_platform` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending|exempt');
ALTER TABLE `power_and_utilities_v2`.`technology`.`digital_platform` ALTER COLUMN `creation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`digital_platform` ALTER COLUMN `data_privacy_impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Impact Assessment (DPIA)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`digital_platform` ALTER COLUMN `data_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period (RETENTION_DAYS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`digital_platform` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date (DECOM_DATE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`digital_platform` ALTER COLUMN `deployment_model` SET TAGS ('dbx_business_glossary_term' = 'Deployment Model (DEP_MODEL)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`digital_platform` ALTER COLUMN `deployment_model` SET TAGS ('dbx_value_regex' = 'on_premise|cloud|hybrid|edge');
ALTER TABLE `power_and_utilities_v2`.`technology`.`digital_platform` ALTER COLUMN `digital_platform_description` SET TAGS ('dbx_business_glossary_term' = 'Platform Description (DESCRIPTION)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`digital_platform` ALTER COLUMN `digital_platform_name` SET TAGS ('dbx_business_glossary_term' = 'Digital Platform Name (DP_NAME)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`digital_platform` ALTER COLUMN `digital_platform_status` SET TAGS ('dbx_business_glossary_term' = 'Platform Lifecycle Status (STATUS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`digital_platform` ALTER COLUMN `digital_platform_status` SET TAGS ('dbx_value_regex' = 'active|inactive|decommissioned|planned|retired');
ALTER TABLE `power_and_utilities_v2`.`technology`.`digital_platform` ALTER COLUMN `in_house_development_flag` SET TAGS ('dbx_business_glossary_term' = 'In‑House Development Flag (IN_HOUSE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`digital_platform` ALTER COLUMN `integration_points_count` SET TAGS ('dbx_business_glossary_term' = 'Integration Points Count (INTEGRATION_COUNT)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`digital_platform` ALTER COLUMN `last_release_date` SET TAGS ('dbx_business_glossary_term' = 'Last Release Date (LAST_RELEASE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`digital_platform` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`digital_platform` ALTER COLUMN `platform_code` SET TAGS ('dbx_business_glossary_term' = 'Digital Platform Code (DP_CODE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`digital_platform` ALTER COLUMN `platform_owner` SET TAGS ('dbx_business_glossary_term' = 'Platform Owner (OWNER)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`digital_platform` ALTER COLUMN `platform_type` SET TAGS ('dbx_business_glossary_term' = 'Digital Platform Type (DP_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`digital_platform` ALTER COLUMN `platform_type` SET TAGS ('dbx_value_regex' = 'customer_portal|mobile_app|data_platform|analytics_platform|integration_platform|other');
ALTER TABLE `power_and_utilities_v2`.`technology`.`digital_platform` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag (REG_REPORT)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`digital_platform` ALTER COLUMN `release_version` SET TAGS ('dbx_business_glossary_term' = 'Release Version (RELEASE_VER)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`digital_platform` ALTER COLUMN `security_classification` SET TAGS ('dbx_business_glossary_term' = 'Security Classification (SEC_CLASS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`digital_platform` ALTER COLUMN `security_classification` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `power_and_utilities_v2`.`technology`.`digital_platform` ALTER COLUMN `supported_capabilities` SET TAGS ('dbx_business_glossary_term' = 'Supported Business Capabilities (CAPABILITIES)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`digital_platform` ALTER COLUMN `uptime_percentage` SET TAGS ('dbx_business_glossary_term' = 'Uptime Percentage (UPTIME_PCT)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`digital_platform` ALTER COLUMN `vendor` SET TAGS ('dbx_business_glossary_term' = 'Platform Vendor (VENDOR)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `platform_release_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Release Identifier (PLAT_REL_ID)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Application Identifier (APP_ID)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `change_request_id` SET TAGS ('dbx_business_glossary_term' = 'Change Request Identifier (CR_ID)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (CREATOR_ID)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `digital_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Platform Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduled By User Identifier (SCHED_USER_ID)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `release_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Release Manager Identifier (REL_MGR_ID)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `scheduled_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduled By User Identifier (SCHED_USER_ID)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `scheduled_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `scheduled_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier (UPDATER_ID)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `rollback_platform_release_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `actual_deployment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Deployment Timestamp (ACT_DEP_TS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `affected_systems` SET TAGS ('dbx_business_glossary_term' = 'Affected Systems List (AFFECTED_SYS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status (APPROVAL_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp (APPROVAL_TS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `audit_log_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Log Reference (AUDIT_LOG_REF)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `change_impact_description` SET TAGS ('dbx_business_glossary_term' = 'Change Impact Description (CHG_IMPACT_DESC)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `change_window_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Change Window Duration (minutes) (CHG_WIN_DUR_MIN)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `change_window_end` SET TAGS ('dbx_business_glossary_term' = 'Change Window End Timestamp (CHG_WIN_END)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `change_window_start` SET TAGS ('dbx_business_glossary_term' = 'Change Window Start Timestamp (CHG_WIN_START)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMP_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp (REC_CREATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `deployment_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Deployment Duration (seconds) (DEP_DURATION_SEC)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `deployment_environment` SET TAGS ('dbx_business_glossary_term' = 'Deployment Environment (DEP_ENV)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `deployment_environment` SET TAGS ('dbx_value_regex' = 'dev|test|staging|production');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `deployment_method` SET TAGS ('dbx_business_glossary_term' = 'Deployment Method (DEP_METHOD)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `deployment_method` SET TAGS ('dbx_value_regex' = 'automated|manual|semi_automated');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `deployment_status` SET TAGS ('dbx_business_glossary_term' = 'Deployment Status (DEP_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `deployment_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|failed|rolled_back|cancelled');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation URL (DOC_URL)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `is_emergency_release` SET TAGS ('dbx_business_glossary_term' = 'Emergency Release Flag (EMERG_RELEASE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `is_hotfix` SET TAGS ('dbx_business_glossary_term' = 'Hotfix Flag (HOTFIX_FLAG)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `nerc_cip_applicable` SET TAGS ('dbx_business_glossary_term' = 'NERC CIP Applicability Flag (NERC_CIP_APPL)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `number_of_changes` SET TAGS ('dbx_business_glossary_term' = 'Number of Changes Included (CHG_COUNT)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `planned_deployment_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Deployment Date (PLAN_DEP_DATE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `post_deployment_validation_outcome` SET TAGS ('dbx_business_glossary_term' = 'Post-Deployment Validation Outcome (VAL_OUTCOME)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `post_deployment_validation_outcome` SET TAGS ('dbx_value_regex' = 'passed|failed|partial|not_executed');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `regulatory_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required Flag (REG_NOTIF_REQ)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `regulatory_notification_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Status (REG_NOTIF_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `regulatory_notification_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|sent|failed');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `release_notes` SET TAGS ('dbx_business_glossary_term' = 'Release Notes Summary (REL_NOTES)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `release_number` SET TAGS ('dbx_business_glossary_term' = 'Release Number (REL_NUM)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `release_owner_team` SET TAGS ('dbx_business_glossary_term' = 'Release Owner Team (REL_OWNER_TEAM)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `release_type` SET TAGS ('dbx_business_glossary_term' = 'Release Type (REL_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `release_type` SET TAGS ('dbx_value_regex' = 'major|minor|patch|hotfix');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `release_version` SET TAGS ('dbx_business_glossary_term' = 'Release Version (REL_VER)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level (RISK_LVL)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `rollback_required` SET TAGS ('dbx_business_glossary_term' = 'Rollback Required Flag (ROLLBACK_REQ)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `rollback_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Rollback Timestamp (ROLLBACK_TS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `security_classification` SET TAGS ('dbx_business_glossary_term' = 'Security Classification (SEC_CLASS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `security_classification` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `source_control_branch` SET TAGS ('dbx_business_glossary_term' = 'Source Control Branch (SC_BRANCH)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `source_control_commit_hash` SET TAGS ('dbx_business_glossary_term' = 'Source Control Commit Identifier (SC_COMMIT_ID)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp (REC_UPDATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp (VAL_TS)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` SET TAGS ('dbx_subdomain' = 'project_finance');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `tech_spend_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Spend Record ID');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `approver_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `tech_project_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Project ID');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `adjustment_of_tech_spend_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Spend Amount (Gross)');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_requested|requested|approved|rejected');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `capex_flag` SET TAGS ('dbx_business_glossary_term' = 'CAPEX Flag');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `compliance_requirement` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `compliance_requirement` SET TAGS ('dbx_value_regex' = 'none|nerc_cip|ferc|state|federal');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_value_regex' = 'direct|percentage|full_absorption');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `internal_comments` SET TAGS ('dbx_business_glossary_term' = 'Internal Comments');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `is_recurring` SET TAGS ('dbx_business_glossary_term' = 'Recurring Spend Flag');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Spend Lifecycle Status');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'pending|approved|posted|rejected|cancelled');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Spend Amount');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'credit_card|bank_transfer|check|wire|internal_transfer');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'unpaid|paid|partial|overdue');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `recurring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Recurring Frequency');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `recurring_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `related_application` SET TAGS ('dbx_business_glossary_term' = 'Related Application Name');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `related_technology_project` SET TAGS ('dbx_business_glossary_term' = 'Related Technology Project Code');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `spend_category` SET TAGS ('dbx_business_glossary_term' = 'Technology Spend Category');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `spend_category` SET TAGS ('dbx_value_regex' = 'hardware|software|telecom|managed_services|professional_services|cloud');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `spend_date` SET TAGS ('dbx_business_glossary_term' = 'Spend Date');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `spend_number` SET TAGS ('dbx_business_glossary_term' = 'Technology Spend Number');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `spend_period_end` SET TAGS ('dbx_business_glossary_term' = 'Spend Period End Date');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `spend_period_start` SET TAGS ('dbx_business_glossary_term' = 'Spend Period Start Date');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `spend_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Technology Spend Sub‑Category');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `tech_spend_description` SET TAGS ('dbx_business_glossary_term' = 'Spend Description');
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
