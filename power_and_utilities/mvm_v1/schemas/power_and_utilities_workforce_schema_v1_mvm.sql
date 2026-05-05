-- Schema for Domain: workforce | Business: Power and Utilities | Version: v1_mvm
-- Generated on: 2026-04-29 23:12:59

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `power_and_utilities`.`workforce` COMMENT 'Workforce domain (auto-created for table employee)';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `power_and_utilities`.`workforce`.`employee` (
    `employee_id` BIGINT COMMENT 'Primary key for employee',
    `department_id` BIGINT COMMENT 'Identifier of the department to which the employee is assigned. Links to organizational structure.',
    `supervisor_employee_id` BIGINT COMMENT 'Employee identifier of the direct supervisor or manager. Self-referencing relationship within employee table.',
    `location_id` BIGINT COMMENT 'Identifier of the primary physical work location or facility where the employee is based. May reference generation plant, substation, service center, or office.',
    `manager_employee_id` BIGINT COMMENT 'Self-referencing FK on employee (manager_employee_id)',
    `badge_number` STRING COMMENT 'Physical security badge identifier assigned to the employee for facility access and time tracking.',
    `certification_codes` STRING COMMENT 'Comma-separated list of professional certifications held by the employee. May include electrical licenses, safety certifications, or technical qualifications required for utility operations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the employee record was first created in the system.',
    `date_of_birth` DATE COMMENT 'Employees date of birth. Used for benefits administration and age-related compliance.',
    `disability_status` STRING COMMENT 'Self-disclosed disability status of the employee. Used for reasonable accommodation and compliance with disability employment regulations.',
    `email_address` STRING COMMENT 'Primary corporate email address for the employee. Used for official communications and system access.',
    `emergency_contact_name` STRING COMMENT 'Full name of the primary emergency contact person for the employee.',
    `emergency_contact_phone` STRING COMMENT 'Phone number of the primary emergency contact person.',
    `emergency_contact_relationship` STRING COMMENT 'Relationship of the emergency contact to the employee (e.g., spouse, parent, sibling, friend).',
    `employee_number` STRING COMMENT 'Externally-known unique employee identifier assigned by human resources. Used on badges, timesheets, and payroll systems.',
    `employment_status` STRING COMMENT 'Current lifecycle status of the employee within the organization. Determines access rights and payroll processing.',
    `employment_type` STRING COMMENT 'Classification of the employees employment arrangement. Determines benefits eligibility and scheduling rules.',
    `ethnicity` STRING COMMENT 'Self-identified ethnicity of the employee. Used for diversity reporting and compliance with equal employment opportunity regulations.',
    `exempt_status` STRING COMMENT 'Indicates whether the employee is exempt or non-exempt from overtime pay requirements under FLSA regulations.',
    `first_name` STRING COMMENT 'Legal first name of the employee as recorded in human resources systems.',
    `gender` STRING COMMENT 'Self-identified gender of the employee. Used for diversity reporting and compliance with equal employment opportunity regulations.',
    `hire_date` DATE COMMENT 'Date the employee was originally hired by the organization. Used for seniority and benefits calculations.',
    `job_code` STRING COMMENT 'Standardized code representing the employees job classification. Used for compensation and workforce planning.',
    `job_title` STRING COMMENT 'Official job title or position name assigned to the employee. Reflects role and responsibilities.',
    `last_name` STRING COMMENT 'Legal last name (surname) of the employee as recorded in human resources systems.',
    `last_performance_review_date` DATE COMMENT 'Date of the most recent formal performance review or appraisal for the employee.',
    `last_safety_training_date` DATE COMMENT 'Date the employee last completed mandatory safety training. Critical for utility operations where employees work with high-voltage equipment and hazardous conditions.',
    `middle_name` STRING COMMENT 'Middle name or initial of the employee.',
    `national_id_number` STRING COMMENT 'Government-issued national identification number (e.g., Social Security Number in USA). Used for tax reporting and benefits administration.',
    `pay_grade` STRING COMMENT 'Compensation grade or band assigned to the employee. Determines salary range and benefits tier.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the employee. May be mobile or desk phone.',
    `security_clearance_level` STRING COMMENT 'Level of security clearance granted to the employee for access to critical infrastructure and sensitive systems. Required for employees working on generation, transmission, or distribution control systems.',
    `termination_date` DATE COMMENT 'Date the employees employment ended. Null for active employees.',
    `union_code` STRING COMMENT 'Code identifying the specific labor union to which the employee belongs. Null for non-union employees.',
    `union_member_flag` BOOLEAN COMMENT 'Indicates whether the employee is a member of a labor union. Affects collective bargaining agreement applicability.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the employee record was last modified.',
    `veteran_status` STRING COMMENT 'Indicates whether the employee is a military veteran. Used for affirmative action and veteran hiring programs.',
    `work_schedule_type` STRING COMMENT 'Type of work schedule assigned to the employee. Utility operations often require 24/7 coverage with rotating shifts for plant operators and field crews.',
    CONSTRAINT pk_employee PRIMARY KEY(`employee_id`)
) COMMENT 'Master reference table for employee. Referenced by contract_owner_employee_id.';

CREATE OR REPLACE TABLE `power_and_utilities`.`workforce`.`department` (
    `department_id` BIGINT COMMENT 'Primary key for department',
    `budget_amount_annual` DECIMAL(18,2) COMMENT 'The total annual operating budget allocated to the department in US dollars for the current fiscal year.',
    `business_unit_id` BIGINT COMMENT 'Reference to the business unit or division to which this department belongs within the utility company organizational structure.',
    `city` STRING COMMENT 'City where the department is physically located. Organizational contact data classified as confidential.',
    `cost_center_code` STRING COMMENT 'Financial accounting code used to track expenses and budget allocation for the department. Used in general ledger and financial reporting systems.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the department is located.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this department record was first created in the system.',
    `department_code` STRING COMMENT 'Short alphanumeric code used to identify the department in business systems and reporting. Typically used in payroll, timekeeping, and financial systems.',
    `department_name` STRING COMMENT 'Full official name of the department as recognized within the organization.',
    `department_type` STRING COMMENT 'Classification of the department based on its primary function within the utility organization.',
    `department_description` STRING COMMENT 'Detailed description of the departments purpose, responsibilities, and scope of operations within the utility organization.',
    `effective_end_date` DATE COMMENT 'The date when the department was closed, merged, or ceased operations. Null for currently active departments.',
    `effective_start_date` DATE COMMENT 'The date when the department was officially established or became operational within the organization.',
    `email_address` STRING COMMENT 'Primary email address for department communications and inquiries. Organizational contact data classified as confidential.',
    `emergency_response_flag` BOOLEAN COMMENT 'Indicates whether the department is designated as part of the utilitys emergency response and restoration operations for outages and critical incidents.',
    `headcount_actual` STRING COMMENT 'The current number of employees actively assigned to the department.',
    `headcount_authorized` STRING COMMENT 'The approved number of full-time equivalent positions allocated to the department by organizational planning and budgeting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this department record was most recently updated in the system.',
    `location_id` BIGINT COMMENT 'Reference to the primary physical location or facility where the department operates.',
    `manager_employee_id` BIGINT COMMENT 'Reference to the employee who serves as the department manager or head.',
    `parent_department_id` BIGINT COMMENT 'Reference to the parent department in the organizational hierarchy. Null for top-level departments.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the department. Organizational contact data classified as confidential.',
    `physical_address_line1` STRING COMMENT 'First line of the departments physical address including street number and name. Organizational contact data classified as confidential.',
    `physical_address_line2` STRING COMMENT 'Second line of the departments physical address for suite, floor, or building information. Organizational contact data classified as confidential.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the departments physical location. Organizational contact data classified as confidential.',
    `regulatory_oversight_body` STRING COMMENT 'Name of the primary regulatory agency or commission that oversees the departments operations (e.g., FERC, state public utility commission, EPA, NERC).',
    `safety_sensitive_flag` BOOLEAN COMMENT 'Indicates whether the department performs safety-sensitive functions requiring enhanced safety protocols, drug testing, and regulatory compliance per Federal Energy Regulatory Commission (FERC) and Occupational Safety and Health Administration (OSHA) standards.',
    `service_area` STRING COMMENT 'The primary utility service area or operational domain that the department supports within the energy value chain.',
    `state_province` STRING COMMENT 'Two-letter state or province code where the department is located. Organizational contact data classified as confidential.',
    `department_status` STRING COMMENT 'Current operational status of the department indicating whether it is actively functioning within the organization.',
    `union_representation_flag` BOOLEAN COMMENT 'Indicates whether employees in this department are represented by a labor union or collective bargaining agreement.',
    CONSTRAINT pk_department PRIMARY KEY(`department_id`)
) COMMENT 'Master reference table for department. Referenced by department_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `power_and_utilities`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_department_id` FOREIGN KEY (`department_id`) REFERENCES `power_and_utilities`.`workforce`.`department`(`department_id`);
ALTER TABLE `power_and_utilities`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_supervisor_employee_id` FOREIGN KEY (`supervisor_employee_id`) REFERENCES `power_and_utilities`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_manager_employee_id` FOREIGN KEY (`manager_employee_id`) REFERENCES `power_and_utilities`.`workforce`.`employee`(`employee_id`);

-- ========= TAGS =========
ALTER SCHEMA `power_and_utilities`.`workforce` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `power_and_utilities`.`workforce` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `power_and_utilities`.`workforce`.`employee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`workforce`.`employee` SET TAGS ('dbx_subdomain' = 'workforce_core');
ALTER TABLE `power_and_utilities`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `power_and_utilities`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `power_and_utilities`.`workforce`.`employee` ALTER COLUMN `disability_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`workforce`.`employee` ALTER COLUMN `disability_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `power_and_utilities`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities`.`workforce`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities`.`workforce`.`employee` ALTER COLUMN `emergency_contact_relationship` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`workforce`.`employee` ALTER COLUMN `ethnicity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities`.`workforce`.`employee` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities`.`workforce`.`employee` ALTER COLUMN `national_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`workforce`.`employee` ALTER COLUMN `national_id_number` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `power_and_utilities`.`workforce`.`employee` ALTER COLUMN `pay_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities`.`workforce`.`employee` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`workforce`.`employee` ALTER COLUMN `veteran_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`workforce`.`department` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`workforce`.`department` SET TAGS ('dbx_subdomain' = 'workforce_core');
ALTER TABLE `power_and_utilities`.`workforce`.`department` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier');
ALTER TABLE `power_and_utilities`.`workforce`.`department` ALTER COLUMN `budget_amount_annual` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`workforce`.`department` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`workforce`.`department` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`workforce`.`department` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`workforce`.`department` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities`.`workforce`.`department` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`workforce`.`department` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities`.`workforce`.`department` ALTER COLUMN `physical_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`workforce`.`department` ALTER COLUMN `physical_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`workforce`.`department` ALTER COLUMN `physical_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`workforce`.`department` ALTER COLUMN `physical_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`workforce`.`department` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`workforce`.`department` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`workforce`.`department` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`workforce`.`department` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
