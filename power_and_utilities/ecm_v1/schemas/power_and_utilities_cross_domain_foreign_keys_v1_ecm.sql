-- Cross-Domain Foreign Keys for Business: Power and Utilities | Version: v1_ecm
-- Generated on: 2026-05-05 03:11:23
-- Total cross-domain FK constraints: 1245
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: asset, billing, customer, der, distribution, engagement, finance, generation, gridops, metering, product, property, regulatory, safety, supply, technology, trading, transmission, workforce

-- ========= asset --> billing (1 constraint(s)) =========
-- Requires: asset schema, billing schema
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `power_and_utilities_v2`.`billing`.`billing_account`(`billing_account_id`);

-- ========= asset --> engagement (3 constraint(s)) =========
-- Requires: asset schema, engagement schema
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_dsm_program_id` FOREIGN KEY (`dsm_program_id`) REFERENCES `power_and_utilities_v2`.`engagement`.`dsm_program`(`dsm_program_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_vpp_agreement_id` FOREIGN KEY (`vpp_agreement_id`) REFERENCES `power_and_utilities_v2`.`engagement`.`vpp_agreement`(`vpp_agreement_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_ci_account_id` FOREIGN KEY (`ci_account_id`) REFERENCES `power_and_utilities_v2`.`engagement`.`ci_account`(`ci_account_id`);

-- ========= asset --> finance (14 constraint(s)) =========
-- Requires: asset schema, finance schema
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `power_and_utilities_v2`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `power_and_utilities_v2`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `power_and_utilities_v2`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ADD CONSTRAINT `fk_asset_work_order_task_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ADD CONSTRAINT `fk_asset_work_order_task_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `power_and_utilities_v2`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ADD CONSTRAINT `fk_asset_work_order_task_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `power_and_utilities_v2`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` ADD CONSTRAINT `fk_asset_depreciation_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` ADD CONSTRAINT `fk_asset_depreciation_schedule_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `power_and_utilities_v2`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ADD CONSTRAINT `fk_asset_asset_capex_project_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ADD CONSTRAINT `fk_asset_asset_capex_project_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `power_and_utilities_v2`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ADD CONSTRAINT `fk_asset_compliance_document_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ADD CONSTRAINT `fk_asset_compliance_document_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `power_and_utilities_v2`.`finance`.`gl_account`(`gl_account_id`);

-- ========= asset --> generation (2 constraint(s)) =========
-- Requires: asset schema, generation schema
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ADD CONSTRAINT `fk_asset_condition_assessment_generating_unit_id` FOREIGN KEY (`generating_unit_id`) REFERENCES `power_and_utilities_v2`.`generation`.`generating_unit`(`generating_unit_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_generating_unit_id` FOREIGN KEY (`generating_unit_id`) REFERENCES `power_and_utilities_v2`.`generation`.`generating_unit`(`generating_unit_id`);

-- ========= asset --> gridops (4 constraint(s)) =========
-- Requires: asset schema, gridops schema
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_balancing_area_id` FOREIGN KEY (`balancing_area_id`) REFERENCES `power_and_utilities_v2`.`gridops`.`balancing_area`(`balancing_area_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_control_zone_id` FOREIGN KEY (`control_zone_id`) REFERENCES `power_and_utilities_v2`.`gridops`.`control_zone`(`control_zone_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ADD CONSTRAINT `fk_asset_condition_assessment_scada_point_id` FOREIGN KEY (`scada_point_id`) REFERENCES `power_and_utilities_v2`.`gridops`.`scada_point`(`scada_point_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ADD CONSTRAINT `fk_asset_operational_reading_scada_point_id` FOREIGN KEY (`scada_point_id`) REFERENCES `power_and_utilities_v2`.`gridops`.`scada_point`(`scada_point_id`);

-- ========= asset --> product (1 constraint(s)) =========
-- Requires: asset schema, product schema
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_product_program_id` FOREIGN KEY (`product_program_id`) REFERENCES `power_and_utilities_v2`.`product`.`product_program`(`product_program_id`);

-- ========= asset --> property (13 constraint(s)) =========
-- Requires: asset schema, property schema
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_site_id` FOREIGN KEY (`site_id`) REFERENCES `power_and_utilities_v2`.`property`.`site`(`site_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `power_and_utilities_v2`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_site_id` FOREIGN KEY (`site_id`) REFERENCES `power_and_utilities_v2`.`property`.`site`(`site_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ADD CONSTRAINT `fk_asset_inspection_document_id` FOREIGN KEY (`document_id`) REFERENCES `power_and_utilities_v2`.`property`.`document`(`document_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ADD CONSTRAINT `fk_asset_failure_event_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `power_and_utilities_v2`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ADD CONSTRAINT `fk_asset_asset_capex_project_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ADD CONSTRAINT `fk_asset_asset_capex_project_site_id` FOREIGN KEY (`site_id`) REFERENCES `power_and_utilities_v2`.`property`.`site`(`site_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ADD CONSTRAINT `fk_asset_risk_assessment_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `power_and_utilities_v2`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ADD CONSTRAINT `fk_asset_compliance_document_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`parcel_allocation` ADD CONSTRAINT `fk_asset_parcel_allocation_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `power_and_utilities_v2`.`property`.`parcel`(`parcel_id`);

-- ========= asset --> regulatory (3 constraint(s)) =========
-- Requires: asset schema, regulatory schema
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ADD CONSTRAINT `fk_asset_lifecycle_event_filing_id` FOREIGN KEY (`filing_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`filing`(`filing_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ADD CONSTRAINT `fk_asset_risk_assessment_filing_id` FOREIGN KEY (`filing_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`filing`(`filing_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ADD CONSTRAINT `fk_asset_risk_assessment_rate_case_id` FOREIGN KEY (`rate_case_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`rate_case`(`rate_case_id`);

-- ========= asset --> safety (1 constraint(s)) =========
-- Requires: asset schema, safety schema
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_safety_program_id` FOREIGN KEY (`safety_program_id`) REFERENCES `power_and_utilities_v2`.`safety`.`safety_program`(`safety_program_id`);

-- ========= asset --> supply (6 constraint(s)) =========
-- Requires: asset schema, supply schema
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `power_and_utilities_v2`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_material_material_master_id` FOREIGN KEY (`material_material_master_id`) REFERENCES `power_and_utilities_v2`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `power_and_utilities_v2`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ADD CONSTRAINT `fk_asset_asset_capex_project_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `power_and_utilities_v2`.`supply`.`procurement_contract`(`procurement_contract_id`);

-- ========= asset --> technology (6 constraint(s)) =========
-- Requires: asset schema, technology schema
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_it_asset_id` FOREIGN KEY (`it_asset_id`) REFERENCES `power_and_utilities_v2`.`technology`.`it_asset`(`it_asset_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_ot_asset_id` FOREIGN KEY (`ot_asset_id`) REFERENCES `power_and_utilities_v2`.`technology`.`ot_asset`(`ot_asset_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_scada_system_id` FOREIGN KEY (`scada_system_id`) REFERENCES `power_and_utilities_v2`.`technology`.`scada_system`(`scada_system_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_tech_project_id` FOREIGN KEY (`tech_project_id`) REFERENCES `power_and_utilities_v2`.`technology`.`tech_project`(`tech_project_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_network_device_id` FOREIGN KEY (`network_device_id`) REFERENCES `power_and_utilities_v2`.`technology`.`network_device`(`network_device_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_it_service_id` FOREIGN KEY (`it_service_id`) REFERENCES `power_and_utilities_v2`.`technology`.`it_service`(`it_service_id`);

-- ========= asset --> workforce (18 constraint(s)) =========
-- Requires: asset schema, workforce schema
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ADD CONSTRAINT `fk_asset_condition_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ADD CONSTRAINT `fk_asset_condition_assessment_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_approved_by_employee_id` FOREIGN KEY (`approved_by_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_closed_by_employee_id` FOREIGN KEY (`closed_by_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_tertiary_work_closed_by_technician_id` FOREIGN KEY (`tertiary_work_closed_by_technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ADD CONSTRAINT `fk_asset_work_order_task_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ADD CONSTRAINT `fk_asset_work_order_task_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ADD CONSTRAINT `fk_asset_inspection_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ADD CONSTRAINT `fk_asset_asset_capex_project_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ADD CONSTRAINT `fk_asset_lifecycle_event_approved_by_employee_id` FOREIGN KEY (`approved_by_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ADD CONSTRAINT `fk_asset_lifecycle_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ADD CONSTRAINT `fk_asset_lifecycle_event_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ADD CONSTRAINT `fk_asset_risk_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ADD CONSTRAINT `fk_asset_risk_assessment_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ADD CONSTRAINT `fk_asset_operational_reading_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ADD CONSTRAINT `fk_asset_operational_reading_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);

-- ========= billing --> asset (2 constraint(s)) =========
-- Requires: billing schema, asset schema
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ADD CONSTRAINT `fk_billing_bill_line_item_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `power_and_utilities_v2`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_location_id` FOREIGN KEY (`location_id`) REFERENCES `power_and_utilities_v2`.`asset`.`location`(`location_id`);

-- ========= billing --> customer (20 constraint(s)) =========
-- Requires: billing schema, customer schema
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ADD CONSTRAINT `fk_billing_bill_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ADD CONSTRAINT `fk_billing_bill_customer_customer_account_id` FOREIGN KEY (`customer_customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ADD CONSTRAINT `fk_billing_bill_person_id` FOREIGN KEY (`person_id`) REFERENCES `power_and_utilities_v2`.`customer`.`person`(`person_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ADD CONSTRAINT `fk_billing_bill_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `power_and_utilities_v2`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ADD CONSTRAINT `fk_billing_bill_line_item_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `power_and_utilities_v2`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_person_id` FOREIGN KEY (`person_id`) REFERENCES `power_and_utilities_v2`.`customer`.`person`(`person_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ADD CONSTRAINT `fk_billing_payment_arrangement_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ADD CONSTRAINT `fk_billing_payment_arrangement_person_id` FOREIGN KEY (`person_id`) REFERENCES `power_and_utilities_v2`.`customer`.`person`(`person_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_customer_customer_account_id` FOREIGN KEY (`customer_customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `power_and_utilities_v2`.`customer`.`premise`(`premise_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_customer_customer_account_id` FOREIGN KEY (`customer_customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_person_id` FOREIGN KEY (`person_id`) REFERENCES `power_and_utilities_v2`.`customer`.`person`(`person_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`deposit` ADD CONSTRAINT `fk_billing_deposit_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`deposit` ADD CONSTRAINT `fk_billing_deposit_customer_customer_account_id` FOREIGN KEY (`customer_customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_person_id` FOREIGN KEY (`person_id`) REFERENCES `power_and_utilities_v2`.`customer`.`person`(`person_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ADD CONSTRAINT `fk_billing_collection_action_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);

-- ========= billing --> der (5 constraint(s)) =========
-- Requires: billing schema, der schema
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ADD CONSTRAINT `fk_billing_bill_nem_account_id` FOREIGN KEY (`nem_account_id`) REFERENCES `power_and_utilities_v2`.`der`.`nem_account`(`nem_account_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ADD CONSTRAINT `fk_billing_bill_der_program_enrollment_id` FOREIGN KEY (`der_program_enrollment_id`) REFERENCES `power_and_utilities_v2`.`der`.`der_program_enrollment`(`der_program_enrollment_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ADD CONSTRAINT `fk_billing_bill_line_item_resource_id` FOREIGN KEY (`resource_id`) REFERENCES `power_and_utilities_v2`.`der`.`resource`(`resource_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_nem_true_up_id` FOREIGN KEY (`nem_true_up_id`) REFERENCES `power_and_utilities_v2`.`der`.`nem_true_up`(`nem_true_up_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_aggregation_group_id` FOREIGN KEY (`aggregation_group_id`) REFERENCES `power_and_utilities_v2`.`der`.`aggregation_group`(`aggregation_group_id`);

-- ========= billing --> engagement (3 constraint(s)) =========
-- Requires: billing schema, engagement schema
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ADD CONSTRAINT `fk_billing_bill_ci_account_id` FOREIGN KEY (`ci_account_id`) REFERENCES `power_and_utilities_v2`.`engagement`.`ci_account`(`ci_account_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ADD CONSTRAINT `fk_billing_bill_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `power_and_utilities_v2`.`engagement`.`opportunity`(`opportunity_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_ci_account_id` FOREIGN KEY (`ci_account_id`) REFERENCES `power_and_utilities_v2`.`engagement`.`ci_account`(`ci_account_id`);

-- ========= billing --> finance (5 constraint(s)) =========
-- Requires: billing schema, finance schema
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ADD CONSTRAINT `fk_billing_bill_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `power_and_utilities_v2`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ADD CONSTRAINT `fk_billing_bill_line_item_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `power_and_utilities_v2`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `power_and_utilities_v2`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `power_and_utilities_v2`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `power_and_utilities_v2`.`finance`.`gl_account`(`gl_account_id`);

-- ========= billing --> gridops (3 constraint(s)) =========
-- Requires: billing schema, gridops schema
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ADD CONSTRAINT `fk_billing_bill_gridops_outage_event_id` FOREIGN KEY (`gridops_outage_event_id`) REFERENCES `power_and_utilities_v2`.`gridops`.`gridops_outage_event`(`gridops_outage_event_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ADD CONSTRAINT `fk_billing_bill_line_item_dr_dispatch_event_id` FOREIGN KEY (`dr_dispatch_event_id`) REFERENCES `power_and_utilities_v2`.`gridops`.`dr_dispatch_event`(`dr_dispatch_event_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_reliability_event_id` FOREIGN KEY (`reliability_event_id`) REFERENCES `power_and_utilities_v2`.`gridops`.`reliability_event`(`reliability_event_id`);

-- ========= billing --> metering (3 constraint(s)) =========
-- Requires: billing schema, metering schema
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ADD CONSTRAINT `fk_billing_bill_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `power_and_utilities_v2`.`metering`.`meter`(`meter_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ADD CONSTRAINT `fk_billing_bill_line_item_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `power_and_utilities_v2`.`metering`.`meter`(`meter_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ADD CONSTRAINT `fk_billing_bill_line_item_metering_service_point_id` FOREIGN KEY (`metering_service_point_id`) REFERENCES `power_and_utilities_v2`.`metering`.`metering_service_point`(`metering_service_point_id`);

-- ========= billing --> product (7 constraint(s)) =========
-- Requires: billing schema, product schema
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ADD CONSTRAINT `fk_billing_bill_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `power_and_utilities_v2`.`product`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ADD CONSTRAINT `fk_billing_bill_line_item_tou_period_id` FOREIGN KEY (`tou_period_id`) REFERENCES `power_and_utilities_v2`.`product`.`tou_period`(`tou_period_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ADD CONSTRAINT `fk_billing_bill_line_item_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `power_and_utilities_v2`.`product`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ADD CONSTRAINT `fk_billing_bill_line_item_product_tariff_rider_id` FOREIGN KEY (`product_tariff_rider_id`) REFERENCES `power_and_utilities_v2`.`product`.`product_tariff_rider`(`product_tariff_rider_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `power_and_utilities_v2`.`product`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_rate_component` ADD CONSTRAINT `fk_billing_billing_rate_component_product_rate_component_id` FOREIGN KEY (`product_rate_component_id`) REFERENCES `power_and_utilities_v2`.`product`.`product_rate_component`(`product_rate_component_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`assistance` ADD CONSTRAINT `fk_billing_assistance_product_program_id` FOREIGN KEY (`product_program_id`) REFERENCES `power_and_utilities_v2`.`product`.`product_program`(`product_program_id`);

-- ========= billing --> regulatory (3 constraint(s)) =========
-- Requires: billing schema, regulatory schema
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ADD CONSTRAINT `fk_billing_bill_rate_case_id` FOREIGN KEY (`rate_case_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`rate_case`(`rate_case_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ADD CONSTRAINT `fk_billing_bill_tariff_schedule_id` FOREIGN KEY (`tariff_schedule_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`tariff_schedule`(`tariff_schedule_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_body_id` FOREIGN KEY (`body_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`body`(`body_id`);

-- ========= billing --> safety (1 constraint(s)) =========
-- Requires: billing schema, safety schema
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `power_and_utilities_v2`.`safety`.`incident`(`incident_id`);

-- ========= billing --> technology (4 constraint(s)) =========
-- Requires: billing schema, technology schema
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ADD CONSTRAINT `fk_billing_bill_scada_system_id` FOREIGN KEY (`scada_system_id`) REFERENCES `power_and_utilities_v2`.`technology`.`scada_system`(`scada_system_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ADD CONSTRAINT `fk_billing_bill_line_item_it_asset_id` FOREIGN KEY (`it_asset_id`) REFERENCES `power_and_utilities_v2`.`technology`.`it_asset`(`it_asset_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_it_service_id` FOREIGN KEY (`it_service_id`) REFERENCES `power_and_utilities_v2`.`technology`.`it_service`(`it_service_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_it_service_id` FOREIGN KEY (`it_service_id`) REFERENCES `power_and_utilities_v2`.`technology`.`it_service`(`it_service_id`);

-- ========= billing --> trading (3 constraint(s)) =========
-- Requires: billing schema, trading schema
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ADD CONSTRAINT `fk_billing_bill_settlement_id` FOREIGN KEY (`settlement_id`) REFERENCES `power_and_utilities_v2`.`trading`.`settlement`(`settlement_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ADD CONSTRAINT `fk_billing_bill_line_item_trade_leg_id` FOREIGN KEY (`trade_leg_id`) REFERENCES `power_and_utilities_v2`.`trading`.`trade_leg`(`trade_leg_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `power_and_utilities_v2`.`trading`.`portfolio`(`portfolio_id`);

-- ========= billing --> transmission (3 constraint(s)) =========
-- Requires: billing schema, transmission schema
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ADD CONSTRAINT `fk_billing_bill_transmission_outage_id` FOREIGN KEY (`transmission_outage_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`transmission_outage`(`transmission_outage_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ADD CONSTRAINT `fk_billing_bill_line_item_line_id` FOREIGN KEY (`line_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`line`(`line_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_transmission_outage_id` FOREIGN KEY (`transmission_outage_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`transmission_outage`(`transmission_outage_id`);

-- ========= billing --> workforce (6 constraint(s)) =========
-- Requires: billing schema, workforce schema
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ADD CONSTRAINT `fk_billing_bill_line_item_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ADD CONSTRAINT `fk_billing_bill_line_item_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ADD CONSTRAINT `fk_billing_payment_arrangement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ADD CONSTRAINT `fk_billing_collection_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);

-- ========= customer --> asset (4 constraint(s)) =========
-- Requires: customer schema, asset schema
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ADD CONSTRAINT `fk_customer_customer_service_point_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`nem_agreement` ADD CONSTRAINT `fk_customer_nem_agreement_asset_permit_compliance_document_id` FOREIGN KEY (`asset_permit_compliance_document_id`) REFERENCES `power_and_utilities_v2`.`asset`.`compliance_document`(`compliance_document_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`nem_agreement` ADD CONSTRAINT `fk_customer_nem_agreement_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`dr_enrollment` ADD CONSTRAINT `fk_customer_dr_enrollment_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);

-- ========= customer --> distribution (8 constraint(s)) =========
-- Requires: customer schema, distribution schema
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ADD CONSTRAINT `fk_customer_customer_service_point_circuit_feeder_id` FOREIGN KEY (`circuit_feeder_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ADD CONSTRAINT `fk_customer_customer_service_point_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_distribution_service_point_id` FOREIGN KEY (`distribution_service_point_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`distribution_service_point`(`distribution_service_point_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ADD CONSTRAINT `fk_customer_enrollment_distribution_service_point_id` FOREIGN KEY (`distribution_service_point_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`distribution_service_point`(`distribution_service_point_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`nem_agreement` ADD CONSTRAINT `fk_customer_nem_agreement_distribution_service_point_id` FOREIGN KEY (`distribution_service_point_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`distribution_service_point`(`distribution_service_point_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`dr_enrollment` ADD CONSTRAINT `fk_customer_dr_enrollment_distribution_service_point_id` FOREIGN KEY (`distribution_service_point_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`distribution_service_point`(`distribution_service_point_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_distribution_service_point_id` FOREIGN KEY (`distribution_service_point_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`distribution_service_point`(`distribution_service_point_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_distribution_service_point_id` FOREIGN KEY (`distribution_service_point_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`distribution_service_point`(`distribution_service_point_id`);

-- ========= customer --> engagement (3 constraint(s)) =========
-- Requires: customer schema, engagement schema
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ADD CONSTRAINT `fk_customer_customer_service_point_vpp_agreement_id` FOREIGN KEY (`vpp_agreement_id`) REFERENCES `power_and_utilities_v2`.`engagement`.`vpp_agreement`(`vpp_agreement_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account_plan` ADD CONSTRAINT `fk_customer_customer_account_plan_ci_account_id` FOREIGN KEY (`ci_account_id`) REFERENCES `power_and_utilities_v2`.`engagement`.`ci_account`(`ci_account_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account_plan` ADD CONSTRAINT `fk_customer_customer_account_plan_key_account_manager_id` FOREIGN KEY (`key_account_manager_id`) REFERENCES `power_and_utilities_v2`.`engagement`.`key_account_manager`(`key_account_manager_id`);

-- ========= customer --> finance (3 constraint(s)) =========
-- Requires: customer schema, finance schema
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `power_and_utilities_v2`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ADD CONSTRAINT `fk_customer_business_entity_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `power_and_utilities_v2`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ADD CONSTRAINT `fk_customer_customer_service_point_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);

-- ========= customer --> metering (2 constraint(s)) =========
-- Requires: customer schema, metering schema
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ADD CONSTRAINT `fk_customer_customer_service_point_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `power_and_utilities_v2`.`metering`.`meter`(`meter_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `power_and_utilities_v2`.`metering`.`meter`(`meter_id`);

-- ========= customer --> product (3 constraint(s)) =========
-- Requires: customer schema, product schema
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `power_and_utilities_v2`.`product`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ADD CONSTRAINT `fk_customer_customer_service_point_service_plan_id` FOREIGN KEY (`service_plan_id`) REFERENCES `power_and_utilities_v2`.`product`.`service_plan`(`service_plan_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `power_and_utilities_v2`.`product`.`rate_schedule`(`rate_schedule_id`);

-- ========= customer --> property (2 constraint(s)) =========
-- Requires: customer schema, property schema
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ADD CONSTRAINT `fk_customer_premise_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `power_and_utilities_v2`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`nem_agreement` ADD CONSTRAINT `fk_customer_nem_agreement_document_id` FOREIGN KEY (`document_id`) REFERENCES `power_and_utilities_v2`.`property`.`document`(`document_id`);

-- ========= customer --> regulatory (2 constraint(s)) =========
-- Requires: customer schema, regulatory schema
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_rate_case_id` FOREIGN KEY (`rate_case_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`rate_case`(`rate_case_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_tariff_schedule_id` FOREIGN KEY (`tariff_schedule_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`tariff_schedule`(`tariff_schedule_id`);

-- ========= customer --> supply (1 constraint(s)) =========
-- Requires: customer schema, supply schema
ALTER TABLE `power_and_utilities_v2`.`customer`.`third_party_access` ADD CONSTRAINT `fk_customer_third_party_access_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);

-- ========= customer --> technology (2 constraint(s)) =========
-- Requires: customer schema, technology schema
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_it_asset_id` FOREIGN KEY (`it_asset_id`) REFERENCES `power_and_utilities_v2`.`technology`.`it_asset`(`it_asset_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ADD CONSTRAINT `fk_customer_customer_service_point_ot_asset_id` FOREIGN KEY (`ot_asset_id`) REFERENCES `power_and_utilities_v2`.`technology`.`ot_asset`(`ot_asset_id`);

-- ========= customer --> workforce (8 constraint(s)) =========
-- Requires: customer schema, workforce schema
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ADD CONSTRAINT `fk_customer_customer_service_point_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ADD CONSTRAINT `fk_customer_customer_service_point_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`move_order` ADD CONSTRAINT `fk_customer_move_order_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`move_order` ADD CONSTRAINT `fk_customer_move_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);

-- ========= der --> asset (6 constraint(s)) =========
-- Requires: der schema, asset schema
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ADD CONSTRAINT `fk_der_resource_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ADD CONSTRAINT `fk_der_resource_location_id` FOREIGN KEY (`location_id`) REFERENCES `power_and_utilities_v2`.`asset`.`location`(`location_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ADD CONSTRAINT `fk_der_interconnection_request_location_id` FOREIGN KEY (`location_id`) REFERENCES `power_and_utilities_v2`.`asset`.`location`(`location_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ADD CONSTRAINT `fk_der_nem_account_asset_permit_compliance_document_id` FOREIGN KEY (`asset_permit_compliance_document_id`) REFERENCES `power_and_utilities_v2`.`asset`.`compliance_document`(`compliance_document_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`bess_operation` ADD CONSTRAINT `fk_der_bess_operation_location_id` FOREIGN KEY (`location_id`) REFERENCES `power_and_utilities_v2`.`asset`.`location`(`location_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`ev_charging_session` ADD CONSTRAINT `fk_der_ev_charging_session_location_id` FOREIGN KEY (`location_id`) REFERENCES `power_and_utilities_v2`.`asset`.`location`(`location_id`);

-- ========= der --> billing (1 constraint(s)) =========
-- Requires: der schema, billing schema
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ADD CONSTRAINT `fk_der_resource_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `power_and_utilities_v2`.`billing`.`billing_account`(`billing_account_id`);

-- ========= der --> customer (10 constraint(s)) =========
-- Requires: der schema, customer schema
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ADD CONSTRAINT `fk_der_resource_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `power_and_utilities_v2`.`customer`.`premise`(`premise_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ADD CONSTRAINT `fk_der_interconnection_request_person_id` FOREIGN KEY (`person_id`) REFERENCES `power_and_utilities_v2`.`customer`.`person`(`person_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ADD CONSTRAINT `fk_der_nem_account_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_true_up` ADD CONSTRAINT `fk_der_nem_true_up_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_true_up` ADD CONSTRAINT `fk_der_nem_true_up_person_id` FOREIGN KEY (`person_id`) REFERENCES `power_and_utilities_v2`.`customer`.`person`(`person_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program_enrollment` ADD CONSTRAINT `fk_der_der_program_enrollment_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`ev_charging_session` ADD CONSTRAINT `fk_der_ev_charging_session_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`ev_charging_session` ADD CONSTRAINT `fk_der_ev_charging_session_person_id` FOREIGN KEY (`person_id`) REFERENCES `power_and_utilities_v2`.`customer`.`person`(`person_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`community_solar_subscription` ADD CONSTRAINT `fk_der_community_solar_subscription_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`community_solar_subscription` ADD CONSTRAINT `fk_der_community_solar_subscription_person_id` FOREIGN KEY (`person_id`) REFERENCES `power_and_utilities_v2`.`customer`.`person`(`person_id`);

-- ========= der --> distribution (6 constraint(s)) =========
-- Requires: der schema, distribution schema
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ADD CONSTRAINT `fk_der_resource_circuit_feeder_id` FOREIGN KEY (`circuit_feeder_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ADD CONSTRAINT `fk_der_resource_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ADD CONSTRAINT `fk_der_interconnection_request_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program_enrollment` ADD CONSTRAINT `fk_der_der_program_enrollment_distribution_service_point_id` FOREIGN KEY (`distribution_service_point_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`distribution_service_point`(`distribution_service_point_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ADD CONSTRAINT `fk_der_interconnection_study_circuit_feeder_id` FOREIGN KEY (`circuit_feeder_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ADD CONSTRAINT `fk_der_interconnection_study_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`feeder`(`feeder_id`);

-- ========= der --> finance (7 constraint(s)) =========
-- Requires: der schema, finance schema
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ADD CONSTRAINT `fk_der_resource_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `power_and_utilities_v2`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ADD CONSTRAINT `fk_der_nem_account_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `power_and_utilities_v2`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_true_up` ADD CONSTRAINT `fk_der_nem_true_up_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `power_and_utilities_v2`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program_enrollment` ADD CONSTRAINT `fk_der_der_program_enrollment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ADD CONSTRAINT `fk_der_aggregation_group_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`bess_operation` ADD CONSTRAINT `fk_der_bess_operation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ADD CONSTRAINT `fk_der_microgrid_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `power_and_utilities_v2`.`finance`.`fixed_asset`(`fixed_asset_id`);

-- ========= der --> generation (3 constraint(s)) =========
-- Requires: der schema, generation schema
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ADD CONSTRAINT `fk_der_resource_generating_unit_id` FOREIGN KEY (`generating_unit_id`) REFERENCES `power_and_utilities_v2`.`generation`.`generating_unit`(`generating_unit_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ADD CONSTRAINT `fk_der_resource_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `power_and_utilities_v2`.`generation`.`plant`(`plant_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`community_solar_subscription` ADD CONSTRAINT `fk_der_community_solar_subscription_renewable_resource_id` FOREIGN KEY (`renewable_resource_id`) REFERENCES `power_and_utilities_v2`.`generation`.`renewable_resource`(`renewable_resource_id`);

-- ========= der --> gridops (2 constraint(s)) =========
-- Requires: der schema, gridops schema
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ADD CONSTRAINT `fk_der_aggregation_group_balancing_area_id` FOREIGN KEY (`balancing_area_id`) REFERENCES `power_and_utilities_v2`.`gridops`.`balancing_area`(`balancing_area_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`program_zone_assignment` ADD CONSTRAINT `fk_der_program_zone_assignment_control_zone_id` FOREIGN KEY (`control_zone_id`) REFERENCES `power_and_utilities_v2`.`gridops`.`control_zone`(`control_zone_id`);

-- ========= der --> metering (6 constraint(s)) =========
-- Requires: der schema, metering schema
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ADD CONSTRAINT `fk_der_resource_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `power_and_utilities_v2`.`metering`.`meter`(`meter_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ADD CONSTRAINT `fk_der_resource_metering_service_point_id` FOREIGN KEY (`metering_service_point_id`) REFERENCES `power_and_utilities_v2`.`metering`.`metering_service_point`(`metering_service_point_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ADD CONSTRAINT `fk_der_interconnection_request_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `power_and_utilities_v2`.`metering`.`meter`(`meter_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program_enrollment` ADD CONSTRAINT `fk_der_der_program_enrollment_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `power_and_utilities_v2`.`metering`.`meter`(`meter_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`ev_charging_session` ADD CONSTRAINT `fk_der_ev_charging_session_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `power_and_utilities_v2`.`metering`.`meter`(`meter_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`community_solar_subscription` ADD CONSTRAINT `fk_der_community_solar_subscription_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `power_and_utilities_v2`.`metering`.`meter`(`meter_id`);

-- ========= der --> product (4 constraint(s)) =========
-- Requires: der schema, product schema
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ADD CONSTRAINT `fk_der_nem_account_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `power_and_utilities_v2`.`product`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`ev_charging_session` ADD CONSTRAINT `fk_der_ev_charging_session_service_plan_id` FOREIGN KEY (`service_plan_id`) REFERENCES `power_and_utilities_v2`.`product`.`service_plan`(`service_plan_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ADD CONSTRAINT `fk_der_microgrid_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `power_and_utilities_v2`.`product`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`community_solar_subscription` ADD CONSTRAINT `fk_der_community_solar_subscription_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `power_and_utilities_v2`.`product`.`rate_schedule`(`rate_schedule_id`);

-- ========= der --> property (7 constraint(s)) =========
-- Requires: der schema, property schema
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ADD CONSTRAINT `fk_der_resource_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `power_and_utilities_v2`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ADD CONSTRAINT `fk_der_resource_site_id` FOREIGN KEY (`site_id`) REFERENCES `power_and_utilities_v2`.`property`.`site`(`site_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ADD CONSTRAINT `fk_der_interconnection_request_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `power_and_utilities_v2`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ADD CONSTRAINT `fk_der_nem_account_document_id` FOREIGN KEY (`document_id`) REFERENCES `power_and_utilities_v2`.`property`.`document`(`document_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ADD CONSTRAINT `fk_der_interconnection_study_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `power_and_utilities_v2`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ADD CONSTRAINT `fk_der_microgrid_site_id` FOREIGN KEY (`site_id`) REFERENCES `power_and_utilities_v2`.`property`.`site`(`site_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`community_solar_subscription` ADD CONSTRAINT `fk_der_community_solar_subscription_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `power_and_utilities_v2`.`property`.`parcel`(`parcel_id`);

-- ========= der --> regulatory (13 constraint(s)) =========
-- Requires: der schema, regulatory schema
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ADD CONSTRAINT `fk_der_resource_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ADD CONSTRAINT `fk_der_resource_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ADD CONSTRAINT `fk_der_interconnection_request_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ADD CONSTRAINT `fk_der_interconnection_request_filing_id` FOREIGN KEY (`filing_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`filing`(`filing_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_true_up` ADD CONSTRAINT `fk_der_nem_true_up_filing_id` FOREIGN KEY (`filing_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`filing`(`filing_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ADD CONSTRAINT `fk_der_aggregation_group_rate_case_id` FOREIGN KEY (`rate_case_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`rate_case`(`rate_case_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ADD CONSTRAINT `fk_der_interconnection_study_filing_id` FOREIGN KEY (`filing_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`filing`(`filing_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`bess_operation` ADD CONSTRAINT `fk_der_bess_operation_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`ev_charging_session` ADD CONSTRAINT `fk_der_ev_charging_session_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ADD CONSTRAINT `fk_der_microgrid_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ADD CONSTRAINT `fk_der_microgrid_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`performance_summary` ADD CONSTRAINT `fk_der_performance_summary_filing_id` FOREIGN KEY (`filing_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`filing`(`filing_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program` ADD CONSTRAINT `fk_der_der_program_rate_case_id` FOREIGN KEY (`rate_case_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`rate_case`(`rate_case_id`);

-- ========= der --> safety (3 constraint(s)) =========
-- Requires: der schema, safety schema
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ADD CONSTRAINT `fk_der_dispatch_event_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `power_and_utilities_v2`.`safety`.`incident`(`incident_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`bess_operation` ADD CONSTRAINT `fk_der_bess_operation_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `power_and_utilities_v2`.`safety`.`incident`(`incident_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`ev_charging_session` ADD CONSTRAINT `fk_der_ev_charging_session_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `power_and_utilities_v2`.`safety`.`incident`(`incident_id`);

-- ========= der --> supply (5 constraint(s)) =========
-- Requires: der schema, supply schema
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ADD CONSTRAINT `fk_der_resource_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `power_and_utilities_v2`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ADD CONSTRAINT `fk_der_resource_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`bess_operation` ADD CONSTRAINT `fk_der_bess_operation_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`ev_charging_session` ADD CONSTRAINT `fk_der_ev_charging_session_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ADD CONSTRAINT `fk_der_microgrid_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);

-- ========= der --> technology (5 constraint(s)) =========
-- Requires: der schema, technology schema
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ADD CONSTRAINT `fk_der_resource_it_asset_id` FOREIGN KEY (`it_asset_id`) REFERENCES `power_and_utilities_v2`.`technology`.`it_asset`(`it_asset_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ADD CONSTRAINT `fk_der_dispatch_event_scada_system_id` FOREIGN KEY (`scada_system_id`) REFERENCES `power_and_utilities_v2`.`technology`.`scada_system`(`scada_system_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`bess_operation` ADD CONSTRAINT `fk_der_bess_operation_it_asset_id` FOREIGN KEY (`it_asset_id`) REFERENCES `power_and_utilities_v2`.`technology`.`it_asset`(`it_asset_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`ev_charging_session` ADD CONSTRAINT `fk_der_ev_charging_session_it_asset_id` FOREIGN KEY (`it_asset_id`) REFERENCES `power_and_utilities_v2`.`technology`.`it_asset`(`it_asset_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ADD CONSTRAINT `fk_der_microgrid_scada_system_id` FOREIGN KEY (`scada_system_id`) REFERENCES `power_and_utilities_v2`.`technology`.`scada_system`(`scada_system_id`);

-- ========= der --> trading (2 constraint(s)) =========
-- Requires: der schema, trading schema
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ADD CONSTRAINT `fk_der_nem_account_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `power_and_utilities_v2`.`trading`.`portfolio`(`portfolio_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ADD CONSTRAINT `fk_der_aggregation_group_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `power_and_utilities_v2`.`trading`.`portfolio`(`portfolio_id`);

-- ========= der --> transmission (3 constraint(s)) =========
-- Requires: der schema, transmission schema
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ADD CONSTRAINT `fk_der_resource_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ADD CONSTRAINT `fk_der_interconnection_request_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ADD CONSTRAINT `fk_der_interconnection_study_line_id` FOREIGN KEY (`line_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`line`(`line_id`);

-- ========= der --> workforce (5 constraint(s)) =========
-- Requires: der schema, workforce schema
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ADD CONSTRAINT `fk_der_interconnection_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ADD CONSTRAINT `fk_der_interconnection_request_inspector_employee_id` FOREIGN KEY (`inspector_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ADD CONSTRAINT `fk_der_interconnection_request_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`bess_operation` ADD CONSTRAINT `fk_der_bess_operation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`bess_operation` ADD CONSTRAINT `fk_der_bess_operation_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);

-- ========= distribution --> asset (12 constraint(s)) =========
-- Requires: distribution schema, asset schema
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ADD CONSTRAINT `fk_distribution_distribution_substation_location_id` FOREIGN KEY (`location_id`) REFERENCES `power_and_utilities_v2`.`asset`.`location`(`location_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ADD CONSTRAINT `fk_distribution_distribution_service_point_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ADD CONSTRAINT `fk_distribution_distribution_transformer_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ADD CONSTRAINT `fk_distribution_distribution_transformer_location_id` FOREIGN KEY (`location_id`) REFERENCES `power_and_utilities_v2`.`asset`.`location`(`location_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ADD CONSTRAINT `fk_distribution_pole_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ADD CONSTRAINT `fk_distribution_protective_device_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ADD CONSTRAINT `fk_distribution_gas_main_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ADD CONSTRAINT `fk_distribution_gas_service_line_location_id` FOREIGN KEY (`location_id`) REFERENCES `power_and_utilities_v2`.`asset`.`location`(`location_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ADD CONSTRAINT `fk_distribution_gas_service_line_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `power_and_utilities_v2`.`asset`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ADD CONSTRAINT `fk_distribution_distribution_outage_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `power_and_utilities_v2`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak_survey` ADD CONSTRAINT `fk_distribution_gas_leak_survey_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ADD CONSTRAINT `fk_distribution_gas_leak_location_id` FOREIGN KEY (`location_id`) REFERENCES `power_and_utilities_v2`.`asset`.`location`(`location_id`);

-- ========= distribution --> billing (1 constraint(s)) =========
-- Requires: distribution schema, billing schema
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ADD CONSTRAINT `fk_distribution_distribution_service_point_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `power_and_utilities_v2`.`billing`.`billing_account`(`billing_account_id`);

-- ========= distribution --> customer (4 constraint(s)) =========
-- Requires: distribution schema, customer schema
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ADD CONSTRAINT `fk_distribution_feeder_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `power_and_utilities_v2`.`customer`.`service_territory`(`service_territory_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ADD CONSTRAINT `fk_distribution_distribution_substation_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `power_and_utilities_v2`.`customer`.`service_territory`(`service_territory_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ADD CONSTRAINT `fk_distribution_distribution_service_point_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `power_and_utilities_v2`.`customer`.`premise`(`premise_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`service_connection_order` ADD CONSTRAINT `fk_distribution_service_connection_order_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);

-- ========= distribution --> der (5 constraint(s)) =========
-- Requires: distribution schema, der schema
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ADD CONSTRAINT `fk_distribution_feeder_aggregation_group_id` FOREIGN KEY (`aggregation_group_id`) REFERENCES `power_and_utilities_v2`.`der`.`aggregation_group`(`aggregation_group_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ADD CONSTRAINT `fk_distribution_distribution_service_point_nem_account_id` FOREIGN KEY (`nem_account_id`) REFERENCES `power_and_utilities_v2`.`der`.`nem_account`(`nem_account_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ADD CONSTRAINT `fk_distribution_distribution_service_point_microgrid_id` FOREIGN KEY (`microgrid_id`) REFERENCES `power_and_utilities_v2`.`der`.`microgrid`(`microgrid_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ADD CONSTRAINT `fk_distribution_distribution_outage_event_resource_id` FOREIGN KEY (`resource_id`) REFERENCES `power_and_utilities_v2`.`der`.`resource`(`resource_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`service_connection_order` ADD CONSTRAINT `fk_distribution_service_connection_order_resource_id` FOREIGN KEY (`resource_id`) REFERENCES `power_and_utilities_v2`.`der`.`resource`(`resource_id`);

-- ========= distribution --> finance (7 constraint(s)) =========
-- Requires: distribution schema, finance schema
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ADD CONSTRAINT `fk_distribution_feeder_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ADD CONSTRAINT `fk_distribution_distribution_substation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ADD CONSTRAINT `fk_distribution_distribution_service_point_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `power_and_utilities_v2`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ADD CONSTRAINT `fk_distribution_distribution_transformer_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `power_and_utilities_v2`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ADD CONSTRAINT `fk_distribution_pole_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `power_and_utilities_v2`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ADD CONSTRAINT `fk_distribution_gas_main_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `power_and_utilities_v2`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ADD CONSTRAINT `fk_distribution_distribution_outage_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);

-- ========= distribution --> generation (1 constraint(s)) =========
-- Requires: distribution schema, generation schema
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ADD CONSTRAINT `fk_distribution_distribution_outage_event_generation_outage_id` FOREIGN KEY (`generation_outage_id`) REFERENCES `power_and_utilities_v2`.`generation`.`generation_outage`(`generation_outage_id`);

-- ========= distribution --> gridops (5 constraint(s)) =========
-- Requires: distribution schema, gridops schema
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ADD CONSTRAINT `fk_distribution_feeder_balancing_area_id` FOREIGN KEY (`balancing_area_id`) REFERENCES `power_and_utilities_v2`.`gridops`.`balancing_area`(`balancing_area_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ADD CONSTRAINT `fk_distribution_distribution_substation_balancing_area_id` FOREIGN KEY (`balancing_area_id`) REFERENCES `power_and_utilities_v2`.`gridops`.`balancing_area`(`balancing_area_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ADD CONSTRAINT `fk_distribution_distribution_substation_control_zone_id` FOREIGN KEY (`control_zone_id`) REFERENCES `power_and_utilities_v2`.`gridops`.`control_zone`(`control_zone_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ADD CONSTRAINT `fk_distribution_distribution_outage_event_gridops_outage_event_id` FOREIGN KEY (`gridops_outage_event_id`) REFERENCES `power_and_utilities_v2`.`gridops`.`gridops_outage_event`(`gridops_outage_event_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_switching_order` ADD CONSTRAINT `fk_distribution_distribution_switching_order_gridops_switching_order_id` FOREIGN KEY (`gridops_switching_order_id`) REFERENCES `power_and_utilities_v2`.`gridops`.`gridops_switching_order`(`gridops_switching_order_id`);

-- ========= distribution --> product (3 constraint(s)) =========
-- Requires: distribution schema, product schema
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ADD CONSTRAINT `fk_distribution_distribution_service_point_product_program_id` FOREIGN KEY (`product_program_id`) REFERENCES `power_and_utilities_v2`.`product`.`product_program`(`product_program_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ADD CONSTRAINT `fk_distribution_distribution_service_point_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `power_and_utilities_v2`.`product`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ADD CONSTRAINT `fk_distribution_distribution_service_point_service_plan_id` FOREIGN KEY (`service_plan_id`) REFERENCES `power_and_utilities_v2`.`product`.`service_plan`(`service_plan_id`);

-- ========= distribution --> property (5 constraint(s)) =========
-- Requires: distribution schema, property schema
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ADD CONSTRAINT `fk_distribution_distribution_substation_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `power_and_utilities_v2`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ADD CONSTRAINT `fk_distribution_distribution_service_point_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ADD CONSTRAINT `fk_distribution_distribution_service_point_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `power_and_utilities_v2`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ADD CONSTRAINT `fk_distribution_distribution_transformer_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `power_and_utilities_v2`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ADD CONSTRAINT `fk_distribution_pole_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `power_and_utilities_v2`.`property`.`parcel`(`parcel_id`);

-- ========= distribution --> regulatory (7 constraint(s)) =========
-- Requires: distribution schema, regulatory schema
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ADD CONSTRAINT `fk_distribution_feeder_rate_case_id` FOREIGN KEY (`rate_case_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`rate_case`(`rate_case_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ADD CONSTRAINT `fk_distribution_distribution_substation_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ADD CONSTRAINT `fk_distribution_distribution_service_point_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ADD CONSTRAINT `fk_distribution_distribution_service_point_tariff_schedule_id` FOREIGN KEY (`tariff_schedule_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`tariff_schedule`(`tariff_schedule_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ADD CONSTRAINT `fk_distribution_gas_main_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ADD CONSTRAINT `fk_distribution_distribution_outage_event_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`docket`(`docket_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ADD CONSTRAINT `fk_distribution_gas_leak_violation_notice_id` FOREIGN KEY (`violation_notice_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`violation_notice`(`violation_notice_id`);

-- ========= distribution --> safety (2 constraint(s)) =========
-- Requires: distribution schema, safety schema
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ADD CONSTRAINT `fk_distribution_feeder_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `power_and_utilities_v2`.`safety`.`emergency_response_plan`(`emergency_response_plan_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ADD CONSTRAINT `fk_distribution_distribution_outage_event_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `power_and_utilities_v2`.`safety`.`incident`(`incident_id`);

-- ========= distribution --> supply (13 constraint(s)) =========
-- Requires: distribution schema, supply schema
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ADD CONSTRAINT `fk_distribution_distribution_transformer_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `power_and_utilities_v2`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ADD CONSTRAINT `fk_distribution_distribution_transformer_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ADD CONSTRAINT `fk_distribution_pole_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `power_and_utilities_v2`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ADD CONSTRAINT `fk_distribution_pole_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ADD CONSTRAINT `fk_distribution_protective_device_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `power_and_utilities_v2`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ADD CONSTRAINT `fk_distribution_protective_device_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ADD CONSTRAINT `fk_distribution_gas_main_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `power_and_utilities_v2`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ADD CONSTRAINT `fk_distribution_gas_main_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ADD CONSTRAINT `fk_distribution_gas_service_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `power_and_utilities_v2`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ADD CONSTRAINT `fk_distribution_gas_service_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ADD CONSTRAINT `fk_distribution_conductor_span_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `power_and_utilities_v2`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ADD CONSTRAINT `fk_distribution_conductor_span_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `power_and_utilities_v2`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ADD CONSTRAINT `fk_distribution_conductor_span_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);

-- ========= distribution --> technology (10 constraint(s)) =========
-- Requires: distribution schema, technology schema
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ADD CONSTRAINT `fk_distribution_feeder_scada_system_id` FOREIGN KEY (`scada_system_id`) REFERENCES `power_and_utilities_v2`.`technology`.`scada_system`(`scada_system_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ADD CONSTRAINT `fk_distribution_distribution_substation_network_device_id` FOREIGN KEY (`network_device_id`) REFERENCES `power_and_utilities_v2`.`technology`.`network_device`(`network_device_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ADD CONSTRAINT `fk_distribution_distribution_service_point_it_service_id` FOREIGN KEY (`it_service_id`) REFERENCES `power_and_utilities_v2`.`technology`.`it_service`(`it_service_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ADD CONSTRAINT `fk_distribution_distribution_transformer_it_asset_id` FOREIGN KEY (`it_asset_id`) REFERENCES `power_and_utilities_v2`.`technology`.`it_asset`(`it_asset_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ADD CONSTRAINT `fk_distribution_pole_network_device_id` FOREIGN KEY (`network_device_id`) REFERENCES `power_and_utilities_v2`.`technology`.`network_device`(`network_device_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ADD CONSTRAINT `fk_distribution_protective_device_scada_system_id` FOREIGN KEY (`scada_system_id`) REFERENCES `power_and_utilities_v2`.`technology`.`scada_system`(`scada_system_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ADD CONSTRAINT `fk_distribution_gas_main_scada_system_id` FOREIGN KEY (`scada_system_id`) REFERENCES `power_and_utilities_v2`.`technology`.`scada_system`(`scada_system_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ADD CONSTRAINT `fk_distribution_distribution_outage_event_incident_ticket_id` FOREIGN KEY (`incident_ticket_id`) REFERENCES `power_and_utilities_v2`.`technology`.`incident_ticket`(`incident_ticket_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_switching_order` ADD CONSTRAINT `fk_distribution_distribution_switching_order_change_request_id` FOREIGN KEY (`change_request_id`) REFERENCES `power_and_utilities_v2`.`technology`.`change_request`(`change_request_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ADD CONSTRAINT `fk_distribution_gas_leak_it_asset_id` FOREIGN KEY (`it_asset_id`) REFERENCES `power_and_utilities_v2`.`technology`.`it_asset`(`it_asset_id`);

-- ========= distribution --> transmission (1 constraint(s)) =========
-- Requires: distribution schema, transmission schema
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ADD CONSTRAINT `fk_distribution_distribution_substation_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`transmission_substation`(`transmission_substation_id`);

-- ========= distribution --> workforce (18 constraint(s)) =========
-- Requires: distribution schema, workforce schema
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ADD CONSTRAINT `fk_distribution_distribution_service_point_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ADD CONSTRAINT `fk_distribution_distribution_transformer_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ADD CONSTRAINT `fk_distribution_pole_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ADD CONSTRAINT `fk_distribution_protective_device_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ADD CONSTRAINT `fk_distribution_gas_main_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ADD CONSTRAINT `fk_distribution_gas_service_line_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ADD CONSTRAINT `fk_distribution_distribution_outage_event_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ADD CONSTRAINT `fk_distribution_distribution_outage_event_storm_event_id` FOREIGN KEY (`storm_event_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`storm_event`(`storm_event_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_switching_order` ADD CONSTRAINT `fk_distribution_distribution_switching_order_approved_by_operator_employee_id` FOREIGN KEY (`approved_by_operator_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_switching_order` ADD CONSTRAINT `fk_distribution_distribution_switching_order_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_switching_order` ADD CONSTRAINT `fk_distribution_distribution_switching_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_switching_order` ADD CONSTRAINT `fk_distribution_distribution_switching_order_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak_survey` ADD CONSTRAINT `fk_distribution_gas_leak_survey_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ADD CONSTRAINT `fk_distribution_gas_leak_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`service_connection_order` ADD CONSTRAINT `fk_distribution_service_connection_order_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`service_connection_order` ADD CONSTRAINT `fk_distribution_service_connection_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`service_connection_order` ADD CONSTRAINT `fk_distribution_service_connection_order_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder_crew_assignment` ADD CONSTRAINT `fk_distribution_feeder_crew_assignment_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`crew`(`crew_id`);

-- ========= engagement --> customer (23 constraint(s)) =========
-- Requires: engagement schema, customer schema
ALTER TABLE `power_and_utilities_v2`.`engagement`.`opportunity` ADD CONSTRAINT `fk_engagement_opportunity_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`opportunity` ADD CONSTRAINT `fk_engagement_opportunity_customer_customer_account_id` FOREIGN KEY (`customer_customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ADD CONSTRAINT `fk_engagement_energy_audit_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ADD CONSTRAINT `fk_engagement_energy_audit_customer_customer_account_id` FOREIGN KEY (`customer_customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dr_event_participation` ADD CONSTRAINT `fk_engagement_dr_event_participation_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dr_event_participation` ADD CONSTRAINT `fk_engagement_dr_event_participation_customer_customer_account_id` FOREIGN KEY (`customer_customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dr_event_participation` ADD CONSTRAINT `fk_engagement_dr_event_participation_enrollment_id` FOREIGN KEY (`enrollment_id`) REFERENCES `power_and_utilities_v2`.`customer`.`enrollment`(`enrollment_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` ADD CONSTRAINT `fk_engagement_vpp_agreement_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` ADD CONSTRAINT `fk_engagement_vpp_agreement_customer_customer_account_id` FOREIGN KEY (`customer_customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ADD CONSTRAINT `fk_engagement_large_customer_contract_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ADD CONSTRAINT `fk_engagement_large_customer_contract_customer_customer_account_id` FOREIGN KEY (`customer_customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ADD CONSTRAINT `fk_engagement_crm_interaction_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ADD CONSTRAINT `fk_engagement_crm_interaction_customer_customer_account_id` FOREIGN KEY (`customer_customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ADD CONSTRAINT `fk_engagement_crm_interaction_complaint_id` FOREIGN KEY (`complaint_id`) REFERENCES `power_and_utilities_v2`.`customer`.`complaint`(`complaint_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` ADD CONSTRAINT `fk_engagement_satisfaction_survey_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `power_and_utilities_v2`.`customer`.`contact`(`contact_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` ADD CONSTRAINT `fk_engagement_satisfaction_survey_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` ADD CONSTRAINT `fk_engagement_satisfaction_survey_customer_customer_account_id` FOREIGN KEY (`customer_customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` ADD CONSTRAINT `fk_engagement_satisfaction_survey_person_id` FOREIGN KEY (`person_id`) REFERENCES `power_and_utilities_v2`.`customer`.`person`(`person_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ADD CONSTRAINT `fk_engagement_engagement_account_plan_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ADD CONSTRAINT `fk_engagement_engagement_account_plan_customer_customer_account_id` FOREIGN KEY (`customer_customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_incentive_payment` ADD CONSTRAINT `fk_engagement_dsm_incentive_payment_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_incentive_payment` ADD CONSTRAINT `fk_engagement_dsm_incentive_payment_customer_customer_account_id` FOREIGN KEY (`customer_customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_incentive_payment` ADD CONSTRAINT `fk_engagement_dsm_incentive_payment_enrollment_id` FOREIGN KEY (`enrollment_id`) REFERENCES `power_and_utilities_v2`.`customer`.`enrollment`(`enrollment_id`);

-- ========= engagement --> der (6 constraint(s)) =========
-- Requires: engagement schema, der schema
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ADD CONSTRAINT `fk_engagement_ci_account_nem_account_id` FOREIGN KEY (`nem_account_id`) REFERENCES `power_and_utilities_v2`.`der`.`nem_account`(`nem_account_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`opportunity` ADD CONSTRAINT `fk_engagement_opportunity_interconnection_request_id` FOREIGN KEY (`interconnection_request_id`) REFERENCES `power_and_utilities_v2`.`der`.`interconnection_request`(`interconnection_request_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ADD CONSTRAINT `fk_engagement_energy_audit_resource_id` FOREIGN KEY (`resource_id`) REFERENCES `power_and_utilities_v2`.`der`.`resource`(`resource_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` ADD CONSTRAINT `fk_engagement_vpp_agreement_aggregator_id` FOREIGN KEY (`aggregator_id`) REFERENCES `power_and_utilities_v2`.`der`.`aggregator`(`aggregator_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ADD CONSTRAINT `fk_engagement_crm_interaction_resource_id` FOREIGN KEY (`resource_id`) REFERENCES `power_and_utilities_v2`.`der`.`resource`(`resource_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ADD CONSTRAINT `fk_engagement_engagement_account_plan_aggregation_group_id` FOREIGN KEY (`aggregation_group_id`) REFERENCES `power_and_utilities_v2`.`der`.`aggregation_group`(`aggregation_group_id`);

-- ========= engagement --> distribution (2 constraint(s)) =========
-- Requires: engagement schema, distribution schema
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dr_event_participation` ADD CONSTRAINT `fk_engagement_dr_event_participation_distribution_service_point_id` FOREIGN KEY (`distribution_service_point_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`distribution_service_point`(`distribution_service_point_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ADD CONSTRAINT `fk_engagement_large_customer_contract_distribution_service_point_id` FOREIGN KEY (`distribution_service_point_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`distribution_service_point`(`distribution_service_point_id`);

-- ========= engagement --> gridops (6 constraint(s)) =========
-- Requires: engagement schema, gridops schema
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ADD CONSTRAINT `fk_engagement_ci_account_balancing_area_id` FOREIGN KEY (`balancing_area_id`) REFERENCES `power_and_utilities_v2`.`gridops`.`balancing_area`(`balancing_area_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dr_event_participation` ADD CONSTRAINT `fk_engagement_dr_event_participation_dr_dispatch_event_id` FOREIGN KEY (`dr_dispatch_event_id`) REFERENCES `power_and_utilities_v2`.`gridops`.`dr_dispatch_event`(`dr_dispatch_event_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` ADD CONSTRAINT `fk_engagement_vpp_agreement_balancing_area_id` FOREIGN KEY (`balancing_area_id`) REFERENCES `power_and_utilities_v2`.`gridops`.`balancing_area`(`balancing_area_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ADD CONSTRAINT `fk_engagement_large_customer_contract_balancing_area_id` FOREIGN KEY (`balancing_area_id`) REFERENCES `power_and_utilities_v2`.`gridops`.`balancing_area`(`balancing_area_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ADD CONSTRAINT `fk_engagement_crm_interaction_gridops_outage_event_id` FOREIGN KEY (`gridops_outage_event_id`) REFERENCES `power_and_utilities_v2`.`gridops`.`gridops_outage_event`(`gridops_outage_event_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ADD CONSTRAINT `fk_engagement_engagement_account_plan_balancing_area_id` FOREIGN KEY (`balancing_area_id`) REFERENCES `power_and_utilities_v2`.`gridops`.`balancing_area`(`balancing_area_id`);

-- ========= engagement --> product (8 constraint(s)) =========
-- Requires: engagement schema, product schema
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ADD CONSTRAINT `fk_engagement_ci_account_product_program_id` FOREIGN KEY (`product_program_id`) REFERENCES `power_and_utilities_v2`.`product`.`product_program`(`product_program_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`opportunity` ADD CONSTRAINT `fk_engagement_opportunity_product_program_id` FOREIGN KEY (`product_program_id`) REFERENCES `power_and_utilities_v2`.`product`.`product_program`(`product_program_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ADD CONSTRAINT `fk_engagement_energy_audit_product_program_id` FOREIGN KEY (`product_program_id`) REFERENCES `power_and_utilities_v2`.`product`.`product_program`(`product_program_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dr_event_participation` ADD CONSTRAINT `fk_engagement_dr_event_participation_product_program_id` FOREIGN KEY (`product_program_id`) REFERENCES `power_and_utilities_v2`.`product`.`product_program`(`product_program_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ADD CONSTRAINT `fk_engagement_large_customer_contract_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `power_and_utilities_v2`.`product`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ADD CONSTRAINT `fk_engagement_crm_interaction_product_program_id` FOREIGN KEY (`product_program_id`) REFERENCES `power_and_utilities_v2`.`product`.`product_program`(`product_program_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` ADD CONSTRAINT `fk_engagement_satisfaction_survey_product_program_id` FOREIGN KEY (`product_program_id`) REFERENCES `power_and_utilities_v2`.`product`.`product_program`(`product_program_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_incentive_payment` ADD CONSTRAINT `fk_engagement_dsm_incentive_payment_product_program_id` FOREIGN KEY (`product_program_id`) REFERENCES `power_and_utilities_v2`.`product`.`product_program`(`product_program_id`);

-- ========= engagement --> property (7 constraint(s)) =========
-- Requires: engagement schema, property schema
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ADD CONSTRAINT `fk_engagement_energy_audit_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` ADD CONSTRAINT `fk_engagement_vpp_agreement_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ADD CONSTRAINT `fk_engagement_large_customer_contract_site_id` FOREIGN KEY (`site_id`) REFERENCES `power_and_utilities_v2`.`property`.`site`(`site_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ADD CONSTRAINT `fk_engagement_crm_interaction_site_id` FOREIGN KEY (`site_id`) REFERENCES `power_and_utilities_v2`.`property`.`site`(`site_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` ADD CONSTRAINT `fk_engagement_satisfaction_survey_site_id` FOREIGN KEY (`site_id`) REFERENCES `power_and_utilities_v2`.`property`.`site`(`site_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ADD CONSTRAINT `fk_engagement_engagement_account_plan_site_id` FOREIGN KEY (`site_id`) REFERENCES `power_and_utilities_v2`.`property`.`site`(`site_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`outreach_campaign` ADD CONSTRAINT `fk_engagement_outreach_campaign_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `power_and_utilities_v2`.`property`.`parcel`(`parcel_id`);

-- ========= engagement --> regulatory (1 constraint(s)) =========
-- Requires: engagement schema, regulatory schema
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ADD CONSTRAINT `fk_engagement_crm_interaction_filing_id` FOREIGN KEY (`filing_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`filing`(`filing_id`);

-- ========= engagement --> technology (4 constraint(s)) =========
-- Requires: engagement schema, technology schema
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ADD CONSTRAINT `fk_engagement_energy_audit_scada_system_id` FOREIGN KEY (`scada_system_id`) REFERENCES `power_and_utilities_v2`.`technology`.`scada_system`(`scada_system_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dr_event_participation` ADD CONSTRAINT `fk_engagement_dr_event_participation_scada_system_id` FOREIGN KEY (`scada_system_id`) REFERENCES `power_and_utilities_v2`.`technology`.`scada_system`(`scada_system_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` ADD CONSTRAINT `fk_engagement_satisfaction_survey_it_service_id` FOREIGN KEY (`it_service_id`) REFERENCES `power_and_utilities_v2`.`technology`.`it_service`(`it_service_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`outreach_campaign` ADD CONSTRAINT `fk_engagement_outreach_campaign_digital_platform_id` FOREIGN KEY (`digital_platform_id`) REFERENCES `power_and_utilities_v2`.`technology`.`digital_platform`(`digital_platform_id`);

-- ========= engagement --> trading (3 constraint(s)) =========
-- Requires: engagement schema, trading schema
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ADD CONSTRAINT `fk_engagement_ci_account_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `power_and_utilities_v2`.`trading`.`counterparty`(`counterparty_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ADD CONSTRAINT `fk_engagement_large_customer_contract_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `power_and_utilities_v2`.`trading`.`portfolio`(`portfolio_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ADD CONSTRAINT `fk_engagement_crm_interaction_trade_id` FOREIGN KEY (`trade_id`) REFERENCES `power_and_utilities_v2`.`trading`.`trade`(`trade_id`);

-- ========= engagement --> transmission (1 constraint(s)) =========
-- Requires: engagement schema, transmission schema
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ADD CONSTRAINT `fk_engagement_crm_interaction_transmission_outage_id` FOREIGN KEY (`transmission_outage_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`transmission_outage`(`transmission_outage_id`);

-- ========= engagement --> workforce (9 constraint(s)) =========
-- Requires: engagement schema, workforce schema
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ADD CONSTRAINT `fk_engagement_key_account_manager_crew_member_id` FOREIGN KEY (`crew_member_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`crew_member`(`crew_member_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ADD CONSTRAINT `fk_engagement_key_account_manager_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ADD CONSTRAINT `fk_engagement_key_account_manager_system_user_employee_id` FOREIGN KEY (`system_user_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`opportunity` ADD CONSTRAINT `fk_engagement_opportunity_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`opportunity` ADD CONSTRAINT `fk_engagement_opportunity_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ADD CONSTRAINT `fk_engagement_energy_audit_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dr_event_participation` ADD CONSTRAINT `fk_engagement_dr_event_participation_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ADD CONSTRAINT `fk_engagement_crm_interaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ADD CONSTRAINT `fk_engagement_engagement_account_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);

-- ========= finance --> asset (4 constraint(s)) =========
-- Requires: finance schema, asset schema
ALTER TABLE `power_and_utilities_v2`.`finance`.`finance_capex_project` ADD CONSTRAINT `fk_finance_finance_capex_project_asset_capex_project_id` FOREIGN KEY (`asset_capex_project_id`) REFERENCES `power_and_utilities_v2`.`asset`.`asset_capex_project`(`asset_capex_project_id`);
ALTER TABLE `power_and_utilities_v2`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`finance`.`depreciation_run` ADD CONSTRAINT `fk_finance_depreciation_run_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`finance`.`finance_lease` ADD CONSTRAINT `fk_finance_finance_lease_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);

-- ========= finance --> billing (1 constraint(s)) =========
-- Requires: finance schema, billing schema
ALTER TABLE `power_and_utilities_v2`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `power_and_utilities_v2`.`billing`.`cycle`(`cycle_id`);

-- ========= finance --> customer (1 constraint(s)) =========
-- Requires: finance schema, customer schema
ALTER TABLE `power_and_utilities_v2`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_person_id` FOREIGN KEY (`person_id`) REFERENCES `power_and_utilities_v2`.`customer`.`person`(`person_id`);

-- ========= finance --> engagement (2 constraint(s)) =========
-- Requires: finance schema, engagement schema
ALTER TABLE `power_and_utilities_v2`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_ci_account_id` FOREIGN KEY (`ci_account_id`) REFERENCES `power_and_utilities_v2`.`engagement`.`ci_account`(`ci_account_id`);
ALTER TABLE `power_and_utilities_v2`.`finance`.`ar_transaction` ADD CONSTRAINT `fk_finance_ar_transaction_large_customer_contract_id` FOREIGN KEY (`large_customer_contract_id`) REFERENCES `power_and_utilities_v2`.`engagement`.`large_customer_contract`(`large_customer_contract_id`);

-- ========= finance --> generation (1 constraint(s)) =========
-- Requires: finance schema, generation schema
ALTER TABLE `power_and_utilities_v2`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `power_and_utilities_v2`.`generation`.`plant`(`plant_id`);

-- ========= finance --> property (12 constraint(s)) =========
-- Requires: finance schema, property schema
ALTER TABLE `power_and_utilities_v2`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);
ALTER TABLE `power_and_utilities_v2`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `power_and_utilities_v2`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `power_and_utilities_v2`.`finance`.`finance_capex_project` ADD CONSTRAINT `fk_finance_finance_capex_project_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `power_and_utilities_v2`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `power_and_utilities_v2`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);
ALTER TABLE `power_and_utilities_v2`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `power_and_utilities_v2`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `power_and_utilities_v2`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);
ALTER TABLE `power_and_utilities_v2`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `power_and_utilities_v2`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `power_and_utilities_v2`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);
ALTER TABLE `power_and_utilities_v2`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `power_and_utilities_v2`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `power_and_utilities_v2`.`finance`.`ar_transaction` ADD CONSTRAINT `fk_finance_ar_transaction_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);
ALTER TABLE `power_and_utilities_v2`.`finance`.`ar_transaction` ADD CONSTRAINT `fk_finance_ar_transaction_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `power_and_utilities_v2`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `power_and_utilities_v2`.`finance`.`finance_lease` ADD CONSTRAINT `fk_finance_finance_lease_document_id` FOREIGN KEY (`document_id`) REFERENCES `power_and_utilities_v2`.`property`.`document`(`document_id`);

-- ========= finance --> regulatory (1 constraint(s)) =========
-- Requires: finance schema, regulatory schema
ALTER TABLE `power_and_utilities_v2`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_rate_case_id` FOREIGN KEY (`rate_case_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`rate_case`(`rate_case_id`);

-- ========= finance --> supply (3 constraint(s)) =========
-- Requires: finance schema, supply schema
ALTER TABLE `power_and_utilities_v2`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `power_and_utilities_v2`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `power_and_utilities_v2`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `power_and_utilities_v2`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `power_and_utilities_v2`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);

-- ========= finance --> technology (1 constraint(s)) =========
-- Requires: finance schema, technology schema
ALTER TABLE `power_and_utilities_v2`.`finance`.`finance_capex_project` ADD CONSTRAINT `fk_finance_finance_capex_project_tech_project_id` FOREIGN KEY (`tech_project_id`) REFERENCES `power_and_utilities_v2`.`technology`.`tech_project`(`tech_project_id`);

-- ========= finance --> trading (5 constraint(s)) =========
-- Requires: finance schema, trading schema
ALTER TABLE `power_and_utilities_v2`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_trade_id` FOREIGN KEY (`trade_id`) REFERENCES `power_and_utilities_v2`.`trading`.`trade`(`trade_id`);
ALTER TABLE `power_and_utilities_v2`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `power_and_utilities_v2`.`trading`.`portfolio`(`portfolio_id`);
ALTER TABLE `power_and_utilities_v2`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `power_and_utilities_v2`.`trading`.`portfolio`(`portfolio_id`);
ALTER TABLE `power_and_utilities_v2`.`finance`.`ar_transaction` ADD CONSTRAINT `fk_finance_ar_transaction_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `power_and_utilities_v2`.`trading`.`counterparty`(`counterparty_id`);
ALTER TABLE `power_and_utilities_v2`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `power_and_utilities_v2`.`trading`.`portfolio`(`portfolio_id`);

-- ========= finance --> workforce (8 constraint(s)) =========
-- Requires: finance schema, workforce schema
ALTER TABLE `power_and_utilities_v2`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_approver_employee_id` FOREIGN KEY (`approver_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`finance`.`depreciation_run` ADD CONSTRAINT `fk_finance_depreciation_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_approved_by_user_employee_id` FOREIGN KEY (`approved_by_user_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);

-- ========= generation --> asset (4 constraint(s)) =========
-- Requires: generation schema, asset schema
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ADD CONSTRAINT `fk_generation_plant_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ADD CONSTRAINT `fk_generation_generating_unit_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` ADD CONSTRAINT `fk_generation_unit_availability_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `power_and_utilities_v2`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ADD CONSTRAINT `fk_generation_generation_outage_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `power_and_utilities_v2`.`asset`.`work_order`(`work_order_id`);

-- ========= generation --> billing (3 constraint(s)) =========
-- Requires: generation schema, billing schema
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` ADD CONSTRAINT `fk_generation_energy_output_bill_line_item_id` FOREIGN KEY (`bill_line_item_id`) REFERENCES `power_and_utilities_v2`.`billing`.`bill_line_item`(`bill_line_item_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ADD CONSTRAINT `fk_generation_rec_certificate_bill_line_item_id` FOREIGN KEY (`bill_line_item_id`) REFERENCES `power_and_utilities_v2`.`billing`.`bill_line_item`(`bill_line_item_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ADD CONSTRAINT `fk_generation_ppa_delivery_bill_id` FOREIGN KEY (`bill_id`) REFERENCES `power_and_utilities_v2`.`billing`.`bill`(`bill_id`);

-- ========= generation --> customer (2 constraint(s)) =========
-- Requires: generation schema, customer schema
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ADD CONSTRAINT `fk_generation_rec_certificate_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ADD CONSTRAINT `fk_generation_renewable_resource_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);

-- ========= generation --> engagement (1 constraint(s)) =========
-- Requires: generation schema, engagement schema
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ADD CONSTRAINT `fk_generation_ppa_delivery_ci_account_id` FOREIGN KEY (`ci_account_id`) REFERENCES `power_and_utilities_v2`.`engagement`.`ci_account`(`ci_account_id`);

-- ========= generation --> finance (4 constraint(s)) =========
-- Requires: generation schema, finance schema
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ADD CONSTRAINT `fk_generation_plant_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `power_and_utilities_v2`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ADD CONSTRAINT `fk_generation_plant_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ADD CONSTRAINT `fk_generation_generating_unit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ADD CONSTRAINT `fk_generation_generating_unit_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `power_and_utilities_v2`.`finance`.`gl_account`(`gl_account_id`);

-- ========= generation --> gridops (9 constraint(s)) =========
-- Requires: generation schema, gridops schema
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ADD CONSTRAINT `fk_generation_plant_balancing_area_id` FOREIGN KEY (`balancing_area_id`) REFERENCES `power_and_utilities_v2`.`gridops`.`balancing_area`(`balancing_area_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ADD CONSTRAINT `fk_generation_generating_unit_balancing_area_id` FOREIGN KEY (`balancing_area_id`) REFERENCES `power_and_utilities_v2`.`gridops`.`balancing_area`(`balancing_area_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` ADD CONSTRAINT `fk_generation_energy_output_ems_dispatch_instruction_id` FOREIGN KEY (`ems_dispatch_instruction_id`) REFERENCES `power_and_utilities_v2`.`gridops`.`ems_dispatch_instruction`(`ems_dispatch_instruction_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ADD CONSTRAINT `fk_generation_generation_outage_balancing_area_id` FOREIGN KEY (`balancing_area_id`) REFERENCES `power_and_utilities_v2`.`gridops`.`balancing_area`(`balancing_area_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ADD CONSTRAINT `fk_generation_emissions_record_balancing_area_id` FOREIGN KEY (`balancing_area_id`) REFERENCES `power_and_utilities_v2`.`gridops`.`balancing_area`(`balancing_area_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ADD CONSTRAINT `fk_generation_ppa_delivery_balancing_area_id` FOREIGN KEY (`balancing_area_id`) REFERENCES `power_and_utilities_v2`.`gridops`.`balancing_area`(`balancing_area_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ADD CONSTRAINT `fk_generation_ppa_delivery_balancing_authority_balancing_area_id` FOREIGN KEY (`balancing_authority_balancing_area_id`) REFERENCES `power_and_utilities_v2`.`gridops`.`balancing_area`(`balancing_area_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ADD CONSTRAINT `fk_generation_ppa_delivery_ems_dispatch_instruction_id` FOREIGN KEY (`ems_dispatch_instruction_id`) REFERENCES `power_and_utilities_v2`.`gridops`.`ems_dispatch_instruction`(`ems_dispatch_instruction_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ADD CONSTRAINT `fk_generation_startup_shutdown_event_ems_dispatch_instruction_id` FOREIGN KEY (`ems_dispatch_instruction_id`) REFERENCES `power_and_utilities_v2`.`gridops`.`ems_dispatch_instruction`(`ems_dispatch_instruction_id`);

-- ========= generation --> metering (5 constraint(s)) =========
-- Requires: generation schema, metering schema
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ADD CONSTRAINT `fk_generation_generating_unit_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `power_and_utilities_v2`.`metering`.`meter`(`meter_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ADD CONSTRAINT `fk_generation_rec_certificate_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `power_and_utilities_v2`.`metering`.`meter`(`meter_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ADD CONSTRAINT `fk_generation_ppa_delivery_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `power_and_utilities_v2`.`metering`.`meter`(`meter_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ADD CONSTRAINT `fk_generation_renewable_resource_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `power_and_utilities_v2`.`metering`.`meter`(`meter_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`allocation` ADD CONSTRAINT `fk_generation_allocation_metering_service_point_id` FOREIGN KEY (`metering_service_point_id`) REFERENCES `power_and_utilities_v2`.`metering`.`metering_service_point`(`metering_service_point_id`);

-- ========= generation --> product (3 constraint(s)) =========
-- Requires: generation schema, product schema
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ADD CONSTRAINT `fk_generation_plant_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `power_and_utilities_v2`.`product`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` ADD CONSTRAINT `fk_generation_energy_output_rate_schedule_version_id` FOREIGN KEY (`rate_schedule_version_id`) REFERENCES `power_and_utilities_v2`.`product`.`rate_schedule_version`(`rate_schedule_version_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ADD CONSTRAINT `fk_generation_renewable_resource_product_program_id` FOREIGN KEY (`product_program_id`) REFERENCES `power_and_utilities_v2`.`product`.`product_program`(`product_program_id`);

-- ========= generation --> property (8 constraint(s)) =========
-- Requires: generation schema, property schema
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ADD CONSTRAINT `fk_generation_plant_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `power_and_utilities_v2`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ADD CONSTRAINT `fk_generation_generating_unit_site_id` FOREIGN KEY (`site_id`) REFERENCES `power_and_utilities_v2`.`property`.`site`(`site_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ADD CONSTRAINT `fk_generation_generation_outage_site_id` FOREIGN KEY (`site_id`) REFERENCES `power_and_utilities_v2`.`property`.`site`(`site_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ADD CONSTRAINT `fk_generation_emissions_record_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `power_and_utilities_v2`.`property`.`permit`(`permit_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ADD CONSTRAINT `fk_generation_rec_certificate_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ADD CONSTRAINT `fk_generation_ppa_delivery_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` ADD CONSTRAINT `fk_generation_forecast_site_id` FOREIGN KEY (`site_id`) REFERENCES `power_and_utilities_v2`.`property`.`site`(`site_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ADD CONSTRAINT `fk_generation_startup_shutdown_event_site_id` FOREIGN KEY (`site_id`) REFERENCES `power_and_utilities_v2`.`property`.`site`(`site_id`);

-- ========= generation --> safety (1 constraint(s)) =========
-- Requires: generation schema, safety schema
ALTER TABLE `power_and_utilities_v2`.`generation`.`audit_plant_assignment` ADD CONSTRAINT `fk_generation_audit_plant_assignment_safety_audit_id` FOREIGN KEY (`safety_audit_id`) REFERENCES `power_and_utilities_v2`.`safety`.`safety_audit`(`safety_audit_id`);

-- ========= generation --> supply (5 constraint(s)) =========
-- Requires: generation schema, supply schema
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ADD CONSTRAINT `fk_generation_fuel_consumption_fuel_receipt_id` FOREIGN KEY (`fuel_receipt_id`) REFERENCES `power_and_utilities_v2`.`supply`.`fuel_receipt`(`fuel_receipt_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ADD CONSTRAINT `fk_generation_fuel_consumption_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `power_and_utilities_v2`.`supply`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ADD CONSTRAINT `fk_generation_fuel_consumption_supplier_vendor_id` FOREIGN KEY (`supplier_vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ADD CONSTRAINT `fk_generation_fuel_consumption_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`nuclear_fuel_cycle` ADD CONSTRAINT `fk_generation_nuclear_fuel_cycle_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);

-- ========= generation --> technology (5 constraint(s)) =========
-- Requires: generation schema, technology schema
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ADD CONSTRAINT `fk_generation_plant_scada_system_id` FOREIGN KEY (`scada_system_id`) REFERENCES `power_and_utilities_v2`.`technology`.`scada_system`(`scada_system_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ADD CONSTRAINT `fk_generation_generating_unit_it_asset_id` FOREIGN KEY (`it_asset_id`) REFERENCES `power_and_utilities_v2`.`technology`.`it_asset`(`it_asset_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ADD CONSTRAINT `fk_generation_generating_unit_ot_asset_id` FOREIGN KEY (`ot_asset_id`) REFERENCES `power_and_utilities_v2`.`technology`.`ot_asset`(`ot_asset_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` ADD CONSTRAINT `fk_generation_energy_output_scada_system_id` FOREIGN KEY (`scada_system_id`) REFERENCES `power_and_utilities_v2`.`technology`.`scada_system`(`scada_system_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ADD CONSTRAINT `fk_generation_startup_shutdown_event_scada_system_id` FOREIGN KEY (`scada_system_id`) REFERENCES `power_and_utilities_v2`.`technology`.`scada_system`(`scada_system_id`);

-- ========= generation --> trading (3 constraint(s)) =========
-- Requires: generation schema, trading schema
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ADD CONSTRAINT `fk_generation_rec_certificate_ppa_contract_id` FOREIGN KEY (`ppa_contract_id`) REFERENCES `power_and_utilities_v2`.`trading`.`ppa_contract`(`ppa_contract_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ADD CONSTRAINT `fk_generation_ppa_delivery_ppa_contract_id` FOREIGN KEY (`ppa_contract_id`) REFERENCES `power_and_utilities_v2`.`trading`.`ppa_contract`(`ppa_contract_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`allocation` ADD CONSTRAINT `fk_generation_allocation_ppa_contract_id` FOREIGN KEY (`ppa_contract_id`) REFERENCES `power_and_utilities_v2`.`trading`.`ppa_contract`(`ppa_contract_id`);

-- ========= generation --> transmission (7 constraint(s)) =========
-- Requires: generation schema, transmission schema
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ADD CONSTRAINT `fk_generation_plant_line_id` FOREIGN KEY (`line_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`line`(`line_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ADD CONSTRAINT `fk_generation_plant_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ADD CONSTRAINT `fk_generation_generating_unit_bus_id` FOREIGN KEY (`bus_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`bus`(`bus_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` ADD CONSTRAINT `fk_generation_unit_availability_transmission_outage_id` FOREIGN KEY (`transmission_outage_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`transmission_outage`(`transmission_outage_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ADD CONSTRAINT `fk_generation_generation_outage_transmission_outage_id` FOREIGN KEY (`transmission_outage_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`transmission_outage`(`transmission_outage_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ADD CONSTRAINT `fk_generation_ppa_delivery_line_id` FOREIGN KEY (`line_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`line`(`line_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ADD CONSTRAINT `fk_generation_renewable_resource_interconnection_agreement_id` FOREIGN KEY (`interconnection_agreement_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`interconnection_agreement`(`interconnection_agreement_id`);

-- ========= generation --> workforce (6 constraint(s)) =========
-- Requires: generation schema, workforce schema
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ADD CONSTRAINT `fk_generation_plant_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ADD CONSTRAINT `fk_generation_generating_unit_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ADD CONSTRAINT `fk_generation_generation_outage_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ADD CONSTRAINT `fk_generation_generation_outage_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ADD CONSTRAINT `fk_generation_emissions_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ADD CONSTRAINT `fk_generation_startup_shutdown_event_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);

-- ========= gridops --> asset (14 constraint(s)) =========
-- Requires: gridops schema, asset schema
ALTER TABLE `power_and_utilities_v2`.`gridops`.`scada_point` ADD CONSTRAINT `fk_gridops_scada_point_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`scada_point` ADD CONSTRAINT `fk_gridops_scada_point_associated_asset_registry_id` FOREIGN KEY (`associated_asset_registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`scada_reading` ADD CONSTRAINT `fk_gridops_scada_reading_asset_registry_id` FOREIGN KEY (`asset_registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`scada_reading` ADD CONSTRAINT `fk_gridops_scada_reading_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`voltage_control_action` ADD CONSTRAINT `fk_gridops_voltage_control_action_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`gridops_switching_order` ADD CONSTRAINT `fk_gridops_gridops_switching_order_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `power_and_utilities_v2`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`switching_step` ADD CONSTRAINT `fk_gridops_switching_step_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `power_and_utilities_v2`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`gridops_outage_event` ADD CONSTRAINT `fk_gridops_gridops_outage_event_asset_registry_id` FOREIGN KEY (`asset_registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`gridops_outage_event` ADD CONSTRAINT `fk_gridops_gridops_outage_event_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`operator_log` ADD CONSTRAINT `fk_gridops_operator_log_asset_registry_id` FOREIGN KEY (`asset_registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`operator_log` ADD CONSTRAINT `fk_gridops_operator_log_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`alarm_event` ADD CONSTRAINT `fk_gridops_alarm_event_asset_registry_id` FOREIGN KEY (`asset_registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`alarm_event` ADD CONSTRAINT `fk_gridops_alarm_event_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`alarm_event` ADD CONSTRAINT `fk_gridops_alarm_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `power_and_utilities_v2`.`asset`.`work_order`(`work_order_id`);

-- ========= gridops --> customer (6 constraint(s)) =========
-- Requires: gridops schema, customer schema
ALTER TABLE `power_and_utilities_v2`.`gridops`.`switching_step` ADD CONSTRAINT `fk_gridops_switching_step_person_id` FOREIGN KEY (`person_id`) REFERENCES `power_and_utilities_v2`.`customer`.`person`(`person_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`dr_dispatch_event` ADD CONSTRAINT `fk_gridops_dr_dispatch_event_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`dr_dispatch_event` ADD CONSTRAINT `fk_gridops_dr_dispatch_event_dr_enrollment_id` FOREIGN KEY (`dr_enrollment_id`) REFERENCES `power_and_utilities_v2`.`customer`.`dr_enrollment`(`dr_enrollment_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`dr_dispatch_event` ADD CONSTRAINT `fk_gridops_dr_dispatch_event_person_id` FOREIGN KEY (`person_id`) REFERENCES `power_and_utilities_v2`.`customer`.`person`(`person_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`operator_log` ADD CONSTRAINT `fk_gridops_operator_log_person_id` FOREIGN KEY (`person_id`) REFERENCES `power_and_utilities_v2`.`customer`.`person`(`person_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`energy_balance` ADD CONSTRAINT `fk_gridops_energy_balance_person_id` FOREIGN KEY (`person_id`) REFERENCES `power_and_utilities_v2`.`customer`.`person`(`person_id`);

-- ========= gridops --> der (8 constraint(s)) =========
-- Requires: gridops schema, der schema
ALTER TABLE `power_and_utilities_v2`.`gridops`.`scada_point` ADD CONSTRAINT `fk_gridops_scada_point_resource_id` FOREIGN KEY (`resource_id`) REFERENCES `power_and_utilities_v2`.`der`.`resource`(`resource_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`scada_reading` ADD CONSTRAINT `fk_gridops_scada_reading_resource_id` FOREIGN KEY (`resource_id`) REFERENCES `power_and_utilities_v2`.`der`.`resource`(`resource_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`ems_dispatch_instruction` ADD CONSTRAINT `fk_gridops_ems_dispatch_instruction_der_program_id` FOREIGN KEY (`der_program_id`) REFERENCES `power_and_utilities_v2`.`der`.`der_program`(`der_program_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`gridops_outage_event` ADD CONSTRAINT `fk_gridops_gridops_outage_event_resource_id` FOREIGN KEY (`resource_id`) REFERENCES `power_and_utilities_v2`.`der`.`resource`(`resource_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`dr_dispatch_event` ADD CONSTRAINT `fk_gridops_dr_dispatch_event_der_program_id` FOREIGN KEY (`der_program_id`) REFERENCES `power_and_utilities_v2`.`der`.`der_program`(`der_program_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`dr_resource_response` ADD CONSTRAINT `fk_gridops_dr_resource_response_aggregator_id` FOREIGN KEY (`aggregator_id`) REFERENCES `power_and_utilities_v2`.`der`.`aggregator`(`aggregator_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`dr_resource_response` ADD CONSTRAINT `fk_gridops_dr_resource_response_resource_id` FOREIGN KEY (`resource_id`) REFERENCES `power_and_utilities_v2`.`der`.`resource`(`resource_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`energy_balance` ADD CONSTRAINT `fk_gridops_energy_balance_aggregation_group_id` FOREIGN KEY (`aggregation_group_id`) REFERENCES `power_and_utilities_v2`.`der`.`aggregation_group`(`aggregation_group_id`);

-- ========= gridops --> distribution (7 constraint(s)) =========
-- Requires: gridops schema, distribution schema
ALTER TABLE `power_and_utilities_v2`.`gridops`.`scada_reading` ADD CONSTRAINT `fk_gridops_scada_reading_distribution_switching_order_id` FOREIGN KEY (`distribution_switching_order_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`distribution_switching_order`(`distribution_switching_order_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`ems_dispatch_instruction` ADD CONSTRAINT `fk_gridops_ems_dispatch_instruction_distribution_switching_order_id` FOREIGN KEY (`distribution_switching_order_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`distribution_switching_order`(`distribution_switching_order_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`switching_step` ADD CONSTRAINT `fk_gridops_switching_step_distribution_substation_id` FOREIGN KEY (`distribution_substation_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`distribution_substation`(`distribution_substation_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`switching_step` ADD CONSTRAINT `fk_gridops_switching_step_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`outage_restoration_log` ADD CONSTRAINT `fk_gridops_outage_restoration_log_distribution_substation_id` FOREIGN KEY (`distribution_substation_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`distribution_substation`(`distribution_substation_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`outage_restoration_log` ADD CONSTRAINT `fk_gridops_outage_restoration_log_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`alarm_event` ADD CONSTRAINT `fk_gridops_alarm_event_distribution_switching_order_id` FOREIGN KEY (`distribution_switching_order_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`distribution_switching_order`(`distribution_switching_order_id`);

-- ========= gridops --> finance (3 constraint(s)) =========
-- Requires: gridops schema, finance schema
ALTER TABLE `power_and_utilities_v2`.`gridops`.`gridops_outage_event` ADD CONSTRAINT `fk_gridops_gridops_outage_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`dr_dispatch_event` ADD CONSTRAINT `fk_gridops_dr_dispatch_event_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `power_and_utilities_v2`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`energy_balance` ADD CONSTRAINT `fk_gridops_energy_balance_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `power_and_utilities_v2`.`finance`.`gl_account`(`gl_account_id`);

-- ========= gridops --> generation (1 constraint(s)) =========
-- Requires: gridops schema, generation schema
ALTER TABLE `power_and_utilities_v2`.`gridops`.`ems_dispatch_instruction` ADD CONSTRAINT `fk_gridops_ems_dispatch_instruction_generating_unit_id` FOREIGN KEY (`generating_unit_id`) REFERENCES `power_and_utilities_v2`.`generation`.`generating_unit`(`generating_unit_id`);

-- ========= gridops --> metering (1 constraint(s)) =========
-- Requires: gridops schema, metering schema
ALTER TABLE `power_and_utilities_v2`.`gridops`.`dispatch_participation` ADD CONSTRAINT `fk_gridops_dispatch_participation_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `power_and_utilities_v2`.`metering`.`meter`(`meter_id`);

-- ========= gridops --> product (3 constraint(s)) =========
-- Requires: gridops schema, product schema
ALTER TABLE `power_and_utilities_v2`.`gridops`.`dr_dispatch_event` ADD CONSTRAINT `fk_gridops_dr_dispatch_event_product_program_id` FOREIGN KEY (`product_program_id`) REFERENCES `power_and_utilities_v2`.`product`.`product_program`(`product_program_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`dr_resource_response` ADD CONSTRAINT `fk_gridops_dr_resource_response_product_program_id` FOREIGN KEY (`product_program_id`) REFERENCES `power_and_utilities_v2`.`product`.`product_program`(`product_program_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`energy_balance` ADD CONSTRAINT `fk_gridops_energy_balance_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `power_and_utilities_v2`.`product`.`rate_schedule`(`rate_schedule_id`);

-- ========= gridops --> property (1 constraint(s)) =========
-- Requires: gridops schema, property schema
ALTER TABLE `power_and_utilities_v2`.`gridops`.`transmission_limit` ADD CONSTRAINT `fk_gridops_transmission_limit_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);

-- ========= gridops --> regulatory (5 constraint(s)) =========
-- Requires: gridops schema, regulatory schema
ALTER TABLE `power_and_utilities_v2`.`gridops`.`control_zone` ADD CONSTRAINT `fk_gridops_control_zone_cip_standard_id` FOREIGN KEY (`cip_standard_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`cip_standard`(`cip_standard_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`frequency_regulation_event` ADD CONSTRAINT `fk_gridops_frequency_regulation_event_rate_case_id` FOREIGN KEY (`rate_case_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`rate_case`(`rate_case_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`gridops_outage_event` ADD CONSTRAINT `fk_gridops_gridops_outage_event_filing_id` FOREIGN KEY (`filing_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`filing`(`filing_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`dr_dispatch_event` ADD CONSTRAINT `fk_gridops_dr_dispatch_event_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`energy_balance` ADD CONSTRAINT `fk_gridops_energy_balance_rate_case_id` FOREIGN KEY (`rate_case_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`rate_case`(`rate_case_id`);

-- ========= gridops --> safety (4 constraint(s)) =========
-- Requires: gridops schema, safety schema
ALTER TABLE `power_and_utilities_v2`.`gridops`.`gridops_switching_order` ADD CONSTRAINT `fk_gridops_gridops_switching_order_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `power_and_utilities_v2`.`safety`.`incident`(`incident_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`gridops_outage_event` ADD CONSTRAINT `fk_gridops_gridops_outage_event_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `power_and_utilities_v2`.`safety`.`incident`(`incident_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`reliability_event` ADD CONSTRAINT `fk_gridops_reliability_event_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `power_and_utilities_v2`.`safety`.`incident`(`incident_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`operator_log` ADD CONSTRAINT `fk_gridops_operator_log_safety_audit_id` FOREIGN KEY (`safety_audit_id`) REFERENCES `power_and_utilities_v2`.`safety`.`safety_audit`(`safety_audit_id`);

-- ========= gridops --> supply (5 constraint(s)) =========
-- Requires: gridops schema, supply schema
ALTER TABLE `power_and_utilities_v2`.`gridops`.`gridops_switching_order` ADD CONSTRAINT `fk_gridops_gridops_switching_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `power_and_utilities_v2`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`gridops_switching_order` ADD CONSTRAINT `fk_gridops_gridops_switching_order_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `power_and_utilities_v2`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`gridops_outage_event` ADD CONSTRAINT `fk_gridops_gridops_outage_event_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `power_and_utilities_v2`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`gridops_outage_event` ADD CONSTRAINT `fk_gridops_gridops_outage_event_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`switching_order_material_allocation` ADD CONSTRAINT `fk_gridops_switching_order_material_allocation_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `power_and_utilities_v2`.`supply`.`material_master`(`material_master_id`);

-- ========= gridops --> technology (7 constraint(s)) =========
-- Requires: gridops schema, technology schema
ALTER TABLE `power_and_utilities_v2`.`gridops`.`control_zone` ADD CONSTRAINT `fk_gridops_control_zone_scada_system_id` FOREIGN KEY (`scada_system_id`) REFERENCES `power_and_utilities_v2`.`technology`.`scada_system`(`scada_system_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`scada_point` ADD CONSTRAINT `fk_gridops_scada_point_it_asset_id` FOREIGN KEY (`it_asset_id`) REFERENCES `power_and_utilities_v2`.`technology`.`it_asset`(`it_asset_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`scada_point` ADD CONSTRAINT `fk_gridops_scada_point_network_device_id` FOREIGN KEY (`network_device_id`) REFERENCES `power_and_utilities_v2`.`technology`.`network_device`(`network_device_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`scada_reading` ADD CONSTRAINT `fk_gridops_scada_reading_ot_asset_id` FOREIGN KEY (`ot_asset_id`) REFERENCES `power_and_utilities_v2`.`technology`.`ot_asset`(`ot_asset_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`switching_step` ADD CONSTRAINT `fk_gridops_switching_step_network_device_id` FOREIGN KEY (`network_device_id`) REFERENCES `power_and_utilities_v2`.`technology`.`network_device`(`network_device_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`gridops_outage_event` ADD CONSTRAINT `fk_gridops_gridops_outage_event_incident_ticket_id` FOREIGN KEY (`incident_ticket_id`) REFERENCES `power_and_utilities_v2`.`technology`.`incident_ticket`(`incident_ticket_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`grid_contingency` ADD CONSTRAINT `fk_gridops_grid_contingency_scada_system_id` FOREIGN KEY (`scada_system_id`) REFERENCES `power_and_utilities_v2`.`technology`.`scada_system`(`scada_system_id`);

-- ========= gridops --> trading (1 constraint(s)) =========
-- Requires: gridops schema, trading schema
ALTER TABLE `power_and_utilities_v2`.`gridops`.`scada_reading` ADD CONSTRAINT `fk_gridops_scada_reading_lmp_price_id` FOREIGN KEY (`lmp_price_id`) REFERENCES `power_and_utilities_v2`.`trading`.`lmp_price`(`lmp_price_id`);

-- ========= gridops --> transmission (7 constraint(s)) =========
-- Requires: gridops schema, transmission schema
ALTER TABLE `power_and_utilities_v2`.`gridops`.`scada_point` ADD CONSTRAINT `fk_gridops_scada_point_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`scada_reading` ADD CONSTRAINT `fk_gridops_scada_reading_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`ems_dispatch_instruction` ADD CONSTRAINT `fk_gridops_ems_dispatch_instruction_bus_id` FOREIGN KEY (`bus_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`bus`(`bus_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`voltage_control_action` ADD CONSTRAINT `fk_gridops_voltage_control_action_bus_id` FOREIGN KEY (`bus_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`bus`(`bus_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`voltage_control_action` ADD CONSTRAINT `fk_gridops_voltage_control_action_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`gridops_switching_order` ADD CONSTRAINT `fk_gridops_gridops_switching_order_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`alarm_event` ADD CONSTRAINT `fk_gridops_alarm_event_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`transmission_substation`(`transmission_substation_id`);

-- ========= gridops --> workforce (28 constraint(s)) =========
-- Requires: gridops schema, workforce schema
ALTER TABLE `power_and_utilities_v2`.`gridops`.`scada_reading` ADD CONSTRAINT `fk_gridops_scada_reading_crew_member_id` FOREIGN KEY (`crew_member_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`crew_member`(`crew_member_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`scada_reading` ADD CONSTRAINT `fk_gridops_scada_reading_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`ems_dispatch_instruction` ADD CONSTRAINT `fk_gridops_ems_dispatch_instruction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`ems_dispatch_instruction` ADD CONSTRAINT `fk_gridops_ems_dispatch_instruction_operator_employee_id` FOREIGN KEY (`operator_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`frequency_regulation_event` ADD CONSTRAINT `fk_gridops_frequency_regulation_event_crew_member_id` FOREIGN KEY (`crew_member_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`crew_member`(`crew_member_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`frequency_regulation_event` ADD CONSTRAINT `fk_gridops_frequency_regulation_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`voltage_control_action` ADD CONSTRAINT `fk_gridops_voltage_control_action_approver_employee_id` FOREIGN KEY (`approver_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`voltage_control_action` ADD CONSTRAINT `fk_gridops_voltage_control_action_approver_id` FOREIGN KEY (`approver_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`voltage_control_action` ADD CONSTRAINT `fk_gridops_voltage_control_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`voltage_control_action` ADD CONSTRAINT `fk_gridops_voltage_control_action_primary_voltage_employee_id` FOREIGN KEY (`primary_voltage_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`voltage_control_action` ADD CONSTRAINT `fk_gridops_voltage_control_action_verified_by_operator_employee_id` FOREIGN KEY (`verified_by_operator_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`gridops_switching_order` ADD CONSTRAINT `fk_gridops_gridops_switching_order_approving_supervisor_employee_id` FOREIGN KEY (`approving_supervisor_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`gridops_switching_order` ADD CONSTRAINT `fk_gridops_gridops_switching_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`gridops_switching_order` ADD CONSTRAINT `fk_gridops_gridops_switching_order_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`switching_step` ADD CONSTRAINT `fk_gridops_switching_step_authorizing_operator_employee_id` FOREIGN KEY (`authorizing_operator_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`switching_step` ADD CONSTRAINT `fk_gridops_switching_step_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`switching_step` ADD CONSTRAINT `fk_gridops_switching_step_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`gridops_outage_event` ADD CONSTRAINT `fk_gridops_gridops_outage_event_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`gridops_outage_event` ADD CONSTRAINT `fk_gridops_gridops_outage_event_storm_event_id` FOREIGN KEY (`storm_event_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`storm_event`(`storm_event_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`outage_restoration_log` ADD CONSTRAINT `fk_gridops_outage_restoration_log_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`dr_dispatch_event` ADD CONSTRAINT `fk_gridops_dr_dispatch_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`operator_log` ADD CONSTRAINT `fk_gridops_operator_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`operator_log` ADD CONSTRAINT `fk_gridops_operator_log_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`shift`(`shift_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`operator_log` ADD CONSTRAINT `fk_gridops_operator_log_shift_supervisor_employee_id` FOREIGN KEY (`shift_supervisor_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`alarm_event` ADD CONSTRAINT `fk_gridops_alarm_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`alarm_event` ADD CONSTRAINT `fk_gridops_alarm_event_shelved_by_operator_employee_id` FOREIGN KEY (`shelved_by_operator_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`energy_balance` ADD CONSTRAINT `fk_gridops_energy_balance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`gridops`.`transmission_limit` ADD CONSTRAINT `fk_gridops_transmission_limit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);

-- ========= metering --> asset (5 constraint(s)) =========
-- Requires: metering schema, asset schema
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ADD CONSTRAINT `fk_metering_meter_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ADD CONSTRAINT `fk_metering_meter_location_id` FOREIGN KEY (`location_id`) REFERENCES `power_and_utilities_v2`.`asset`.`location`(`location_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ADD CONSTRAINT `fk_metering_interval_read_location_id` FOREIGN KEY (`location_id`) REFERENCES `power_and_utilities_v2`.`asset`.`location`(`location_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` ADD CONSTRAINT `fk_metering_meter_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `power_and_utilities_v2`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_work_order_assignment` ADD CONSTRAINT `fk_metering_meter_work_order_assignment_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `power_and_utilities_v2`.`asset`.`work_order`(`work_order_id`);

-- ========= metering --> billing (1 constraint(s)) =========
-- Requires: metering schema, billing schema
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ADD CONSTRAINT `fk_metering_metering_service_point_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `power_and_utilities_v2`.`billing`.`cycle`(`cycle_id`);

-- ========= metering --> customer (2 constraint(s)) =========
-- Requires: metering schema, customer schema
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ADD CONSTRAINT `fk_metering_meter_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `power_and_utilities_v2`.`customer`.`premise`(`premise_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_premise` ADD CONSTRAINT `fk_metering_meter_premise_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `power_and_utilities_v2`.`customer`.`premise`(`premise_id`);

-- ========= metering --> distribution (5 constraint(s)) =========
-- Requires: metering schema, distribution schema
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ADD CONSTRAINT `fk_metering_meter_distribution_service_point_id` FOREIGN KEY (`distribution_service_point_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`distribution_service_point`(`distribution_service_point_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ADD CONSTRAINT `fk_metering_meter_distribution_transformer_id` FOREIGN KEY (`distribution_transformer_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`distribution_transformer`(`distribution_transformer_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ADD CONSTRAINT `fk_metering_meter_pole_id` FOREIGN KEY (`pole_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`pole`(`pole_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ADD CONSTRAINT `fk_metering_metering_service_point_distribution_transformer_id` FOREIGN KEY (`distribution_transformer_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`distribution_transformer`(`distribution_transformer_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ADD CONSTRAINT `fk_metering_metering_service_point_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`feeder`(`feeder_id`);

-- ========= metering --> engagement (3 constraint(s)) =========
-- Requires: metering schema, engagement schema
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ADD CONSTRAINT `fk_metering_meter_vpp_agreement_id` FOREIGN KEY (`vpp_agreement_id`) REFERENCES `power_and_utilities_v2`.`engagement`.`vpp_agreement`(`vpp_agreement_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ADD CONSTRAINT `fk_metering_metering_service_point_large_customer_contract_id` FOREIGN KEY (`large_customer_contract_id`) REFERENCES `power_and_utilities_v2`.`engagement`.`large_customer_contract`(`large_customer_contract_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_enrollment` ADD CONSTRAINT `fk_metering_metering_enrollment_dsm_program_id` FOREIGN KEY (`dsm_program_id`) REFERENCES `power_and_utilities_v2`.`engagement`.`dsm_program`(`dsm_program_id`);

-- ========= metering --> finance (9 constraint(s)) =========
-- Requires: metering schema, finance schema
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ADD CONSTRAINT `fk_metering_meter_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `power_and_utilities_v2`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_premise` ADD CONSTRAINT `fk_metering_meter_premise_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ADD CONSTRAINT `fk_metering_metering_service_point_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ADD CONSTRAINT `fk_metering_metering_service_point_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `power_and_utilities_v2`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ADD CONSTRAINT `fk_metering_register_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `power_and_utilities_v2`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_rule` ADD CONSTRAINT `fk_metering_vee_rule_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `power_and_utilities_v2`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` ADD CONSTRAINT `fk_metering_meter_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`tou_schedule` ADD CONSTRAINT `fk_metering_tou_schedule_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `power_and_utilities_v2`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_test` ADD CONSTRAINT `fk_metering_meter_test_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);

-- ========= metering --> gridops (3 constraint(s)) =========
-- Requires: metering schema, gridops schema
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ADD CONSTRAINT `fk_metering_metering_service_point_balancing_area_id` FOREIGN KEY (`balancing_area_id`) REFERENCES `power_and_utilities_v2`.`gridops`.`balancing_area`(`balancing_area_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ADD CONSTRAINT `fk_metering_metering_service_point_control_zone_id` FOREIGN KEY (`control_zone_id`) REFERENCES `power_and_utilities_v2`.`gridops`.`control_zone`(`control_zone_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` ADD CONSTRAINT `fk_metering_meter_event_gridops_outage_event_id` FOREIGN KEY (`gridops_outage_event_id`) REFERENCES `power_and_utilities_v2`.`gridops`.`gridops_outage_event`(`gridops_outage_event_id`);

-- ========= metering --> product (3 constraint(s)) =========
-- Requires: metering schema, product schema
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_configuration` ADD CONSTRAINT `fk_metering_meter_configuration_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `power_and_utilities_v2`.`product`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ADD CONSTRAINT `fk_metering_metering_service_point_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `power_and_utilities_v2`.`product`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ADD CONSTRAINT `fk_metering_metering_service_point_rate_season_calendar_id` FOREIGN KEY (`rate_season_calendar_id`) REFERENCES `power_and_utilities_v2`.`product`.`rate_season_calendar`(`rate_season_calendar_id`);

-- ========= metering --> property (2 constraint(s)) =========
-- Requires: metering schema, property schema
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ADD CONSTRAINT `fk_metering_metering_service_point_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `power_and_utilities_v2`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_test` ADD CONSTRAINT `fk_metering_meter_test_site_id` FOREIGN KEY (`site_id`) REFERENCES `power_and_utilities_v2`.`property`.`site`(`site_id`);

-- ========= metering --> regulatory (3 constraint(s)) =========
-- Requires: metering schema, regulatory schema
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_configuration` ADD CONSTRAINT `fk_metering_meter_configuration_tariff_schedule_id` FOREIGN KEY (`tariff_schedule_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`tariff_schedule`(`tariff_schedule_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` ADD CONSTRAINT `fk_metering_meter_event_violation_notice_id` FOREIGN KEY (`violation_notice_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`violation_notice`(`violation_notice_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_test` ADD CONSTRAINT `fk_metering_meter_test_filing_id` FOREIGN KEY (`filing_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`filing`(`filing_id`);

-- ========= metering --> supply (3 constraint(s)) =========
-- Requires: metering schema, supply schema
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ADD CONSTRAINT `fk_metering_meter_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `power_and_utilities_v2`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ADD CONSTRAINT `fk_metering_meter_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ADD CONSTRAINT `fk_metering_metering_service_point_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `power_and_utilities_v2`.`supply`.`purchase_order`(`purchase_order_id`);

-- ========= metering --> technology (4 constraint(s)) =========
-- Requires: metering schema, technology schema
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ADD CONSTRAINT `fk_metering_meter_it_asset_id` FOREIGN KEY (`it_asset_id`) REFERENCES `power_and_utilities_v2`.`technology`.`it_asset`(`it_asset_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ADD CONSTRAINT `fk_metering_meter_scada_system_id` FOREIGN KEY (`scada_system_id`) REFERENCES `power_and_utilities_v2`.`technology`.`scada_system`(`scada_system_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ADD CONSTRAINT `fk_metering_metering_service_point_scada_system_id` FOREIGN KEY (`scada_system_id`) REFERENCES `power_and_utilities_v2`.`technology`.`scada_system`(`scada_system_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_test` ADD CONSTRAINT `fk_metering_meter_test_it_asset_id` FOREIGN KEY (`it_asset_id`) REFERENCES `power_and_utilities_v2`.`technology`.`it_asset`(`it_asset_id`);

-- ========= metering --> transmission (1 constraint(s)) =========
-- Requires: metering schema, transmission schema
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ADD CONSTRAINT `fk_metering_metering_service_point_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`transmission_substation`(`transmission_substation_id`);

-- ========= metering --> workforce (7 constraint(s)) =========
-- Requires: metering schema, workforce schema
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ADD CONSTRAINT `fk_metering_meter_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_configuration` ADD CONSTRAINT `fk_metering_meter_configuration_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_result` ADD CONSTRAINT `fk_metering_vee_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_result` ADD CONSTRAINT `fk_metering_vee_result_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` ADD CONSTRAINT `fk_metering_meter_event_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` ADD CONSTRAINT `fk_metering_meter_event_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_test` ADD CONSTRAINT `fk_metering_meter_test_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);

-- ========= product --> asset (1 constraint(s)) =========
-- Requires: product schema, asset schema
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ADD CONSTRAINT `fk_product_service_plan_compliance_document_id` FOREIGN KEY (`compliance_document_id`) REFERENCES `power_and_utilities_v2`.`asset`.`compliance_document`(`compliance_document_id`);

-- ========= product --> billing (1 constraint(s)) =========
-- Requires: product schema, billing schema
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_tier` ADD CONSTRAINT `fk_product_rate_tier_billing_rate_component_id` FOREIGN KEY (`billing_rate_component_id`) REFERENCES `power_and_utilities_v2`.`billing`.`billing_rate_component`(`billing_rate_component_id`);

-- ========= product --> customer (2 constraint(s)) =========
-- Requires: product schema, customer schema
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_applicability` ADD CONSTRAINT `fk_product_rate_schedule_applicability_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `power_and_utilities_v2`.`customer`.`service_territory`(`service_territory_id`);
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ADD CONSTRAINT `fk_product_special_contract_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);

-- ========= product --> finance (5 constraint(s)) =========
-- Requires: product schema, finance schema
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ADD CONSTRAINT `fk_product_rate_schedule_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `power_and_utilities_v2`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `power_and_utilities_v2`.`product`.`product_rate_component` ADD CONSTRAINT `fk_product_product_rate_component_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `power_and_utilities_v2`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ADD CONSTRAINT `fk_product_service_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_version` ADD CONSTRAINT `fk_product_rate_schedule_version_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `power_and_utilities_v2`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ADD CONSTRAINT `fk_product_product_program_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `power_and_utilities_v2`.`finance`.`budget`(`budget_id`);

-- ========= product --> property (1 constraint(s)) =========
-- Requires: product schema, property schema
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ADD CONSTRAINT `fk_product_special_contract_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `power_and_utilities_v2`.`property`.`parcel`(`parcel_id`);

-- ========= product --> regulatory (10 constraint(s)) =========
-- Requires: product schema, regulatory schema
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ADD CONSTRAINT `fk_product_rate_schedule_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`docket`(`docket_id`);
ALTER TABLE `power_and_utilities_v2`.`product`.`product_tariff_rider` ADD CONSTRAINT `fk_product_product_tariff_rider_filing_id` FOREIGN KEY (`filing_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`filing`(`filing_id`);
ALTER TABLE `power_and_utilities_v2`.`product`.`eligibility_rule` ADD CONSTRAINT `fk_product_eligibility_rule_rate_case_id` FOREIGN KEY (`rate_case_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`rate_case`(`rate_case_id`);
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ADD CONSTRAINT `fk_product_service_plan_body_id` FOREIGN KEY (`body_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`body`(`body_id`);
ALTER TABLE `power_and_utilities_v2`.`product`.`ee_measure` ADD CONSTRAINT `fk_product_ee_measure_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_version` ADD CONSTRAINT `fk_product_rate_schedule_version_body_id` FOREIGN KEY (`body_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`body`(`body_id`);
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_applicability` ADD CONSTRAINT `fk_product_rate_schedule_applicability_body_id` FOREIGN KEY (`body_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`body`(`body_id`);
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ADD CONSTRAINT `fk_product_special_contract_rate_case_id` FOREIGN KEY (`rate_case_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`rate_case`(`rate_case_id`);
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ADD CONSTRAINT `fk_product_product_program_body_id` FOREIGN KEY (`body_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`body`(`body_id`);
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ADD CONSTRAINT `fk_product_program_measure_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);

-- ========= product --> technology (5 constraint(s)) =========
-- Requires: product schema, technology schema
ALTER TABLE `power_and_utilities_v2`.`product`.`eligibility_rule` ADD CONSTRAINT `fk_product_eligibility_rule_application_id` FOREIGN KEY (`application_id`) REFERENCES `power_and_utilities_v2`.`technology`.`application`(`application_id`);
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ADD CONSTRAINT `fk_product_service_plan_it_service_id` FOREIGN KEY (`it_service_id`) REFERENCES `power_and_utilities_v2`.`technology`.`it_service`(`it_service_id`);
ALTER TABLE `power_and_utilities_v2`.`product`.`ee_measure` ADD CONSTRAINT `fk_product_ee_measure_application_id` FOREIGN KEY (`application_id`) REFERENCES `power_and_utilities_v2`.`technology`.`application`(`application_id`);
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ADD CONSTRAINT `fk_product_product_program_application_id` FOREIGN KEY (`application_id`) REFERENCES `power_and_utilities_v2`.`technology`.`application`(`application_id`);
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ADD CONSTRAINT `fk_product_program_measure_application_id` FOREIGN KEY (`application_id`) REFERENCES `power_and_utilities_v2`.`technology`.`application`(`application_id`);

-- ========= property --> asset (2 constraint(s)) =========
-- Requires: property schema, asset schema
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ADD CONSTRAINT `fk_property_permit_asset_capex_project_id` FOREIGN KEY (`asset_capex_project_id`) REFERENCES `power_and_utilities_v2`.`asset`.`asset_capex_project`(`asset_capex_project_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`environmental_condition` ADD CONSTRAINT `fk_property_environmental_condition_location_id` FOREIGN KEY (`location_id`) REFERENCES `power_and_utilities_v2`.`asset`.`location`(`location_id`);

-- ========= property --> customer (19 constraint(s)) =========
-- Requires: property schema, customer schema
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ADD CONSTRAINT `fk_property_property_lease_business_entity_id` FOREIGN KEY (`business_entity_id`) REFERENCES `power_and_utilities_v2`.`customer`.`business_entity`(`business_entity_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ADD CONSTRAINT `fk_property_acquisition_acquirer_business_entity_id` FOREIGN KEY (`acquirer_business_entity_id`) REFERENCES `power_and_utilities_v2`.`customer`.`business_entity`(`business_entity_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ADD CONSTRAINT `fk_property_acquisition_business_entity_id` FOREIGN KEY (`business_entity_id`) REFERENCES `power_and_utilities_v2`.`customer`.`business_entity`(`business_entity_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ADD CONSTRAINT `fk_property_acquisition_person_id` FOREIGN KEY (`person_id`) REFERENCES `power_and_utilities_v2`.`customer`.`person`(`person_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ADD CONSTRAINT `fk_property_acquisition_seller_business_entity_id` FOREIGN KEY (`seller_business_entity_id`) REFERENCES `power_and_utilities_v2`.`customer`.`business_entity`(`business_entity_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ADD CONSTRAINT `fk_property_disposition_business_entity_id` FOREIGN KEY (`business_entity_id`) REFERENCES `power_and_utilities_v2`.`customer`.`business_entity`(`business_entity_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ADD CONSTRAINT `fk_property_disposition_disposition_business_entity_id` FOREIGN KEY (`disposition_business_entity_id`) REFERENCES `power_and_utilities_v2`.`customer`.`business_entity`(`business_entity_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ADD CONSTRAINT `fk_property_disposition_disposition_seller_party_business_entity_id` FOREIGN KEY (`disposition_seller_party_business_entity_id`) REFERENCES `power_and_utilities_v2`.`customer`.`business_entity`(`business_entity_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ADD CONSTRAINT `fk_property_disposition_seller_party_business_entity_id` FOREIGN KEY (`seller_party_business_entity_id`) REFERENCES `power_and_utilities_v2`.`customer`.`business_entity`(`business_entity_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`encroachment` ADD CONSTRAINT `fk_property_encroachment_business_entity_id` FOREIGN KEY (`business_entity_id`) REFERENCES `power_and_utilities_v2`.`customer`.`business_entity`(`business_entity_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`encroachment` ADD CONSTRAINT `fk_property_encroachment_person_id` FOREIGN KEY (`person_id`) REFERENCES `power_and_utilities_v2`.`customer`.`person`(`person_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ADD CONSTRAINT `fk_property_appraisal_person_id` FOREIGN KEY (`person_id`) REFERENCES `power_and_utilities_v2`.`customer`.`person`(`person_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ADD CONSTRAINT `fk_property_appraisal_appraisal_person_id` FOREIGN KEY (`appraisal_person_id`) REFERENCES `power_and_utilities_v2`.`customer`.`person`(`person_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ADD CONSTRAINT `fk_property_appraisal_appraisal_reviewed_by_person_id` FOREIGN KEY (`appraisal_reviewed_by_person_id`) REFERENCES `power_and_utilities_v2`.`customer`.`person`(`person_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`environmental_condition` ADD CONSTRAINT `fk_property_environmental_condition_business_entity_id` FOREIGN KEY (`business_entity_id`) REFERENCES `power_and_utilities_v2`.`customer`.`business_entity`(`business_entity_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`environmental_condition` ADD CONSTRAINT `fk_property_environmental_condition_person_id` FOREIGN KEY (`person_id`) REFERENCES `power_and_utilities_v2`.`customer`.`person`(`person_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`lease_payment` ADD CONSTRAINT `fk_property_lease_payment_business_entity_id` FOREIGN KEY (`business_entity_id`) REFERENCES `power_and_utilities_v2`.`customer`.`business_entity`(`business_entity_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` ADD CONSTRAINT `fk_property_condemnation_proceeding_business_entity_id` FOREIGN KEY (`business_entity_id`) REFERENCES `power_and_utilities_v2`.`customer`.`business_entity`(`business_entity_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` ADD CONSTRAINT `fk_property_condemnation_proceeding_person_id` FOREIGN KEY (`person_id`) REFERENCES `power_and_utilities_v2`.`customer`.`person`(`person_id`);

-- ========= property --> finance (3 constraint(s)) =========
-- Requires: property schema, finance schema
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ADD CONSTRAINT `fk_property_permit_finance_capex_project_id` FOREIGN KEY (`finance_capex_project_id`) REFERENCES `power_and_utilities_v2`.`finance`.`finance_capex_project`(`finance_capex_project_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ADD CONSTRAINT `fk_property_remediation_activity_finance_capex_project_id` FOREIGN KEY (`finance_capex_project_id`) REFERENCES `power_and_utilities_v2`.`finance`.`finance_capex_project`(`finance_capex_project_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`space_allocation` ADD CONSTRAINT `fk_property_space_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);

-- ========= property --> gridops (3 constraint(s)) =========
-- Requires: property schema, gridops schema
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ADD CONSTRAINT `fk_property_facility_balancing_area_id` FOREIGN KEY (`balancing_area_id`) REFERENCES `power_and_utilities_v2`.`gridops`.`balancing_area`(`balancing_area_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ADD CONSTRAINT `fk_property_facility_control_zone_id` FOREIGN KEY (`control_zone_id`) REFERENCES `power_and_utilities_v2`.`gridops`.`control_zone`(`control_zone_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ADD CONSTRAINT `fk_property_site_balancing_area_id` FOREIGN KEY (`balancing_area_id`) REFERENCES `power_and_utilities_v2`.`gridops`.`balancing_area`(`balancing_area_id`);

-- ========= property --> supply (3 constraint(s)) =========
-- Requires: property schema, supply schema
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ADD CONSTRAINT `fk_property_appraisal_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ADD CONSTRAINT `fk_property_remediation_activity_primary_remediation_vendor_id` FOREIGN KEY (`primary_remediation_vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ADD CONSTRAINT `fk_property_remediation_activity_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);

-- ========= property --> trading (1 constraint(s)) =========
-- Requires: property schema, trading schema
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ADD CONSTRAINT `fk_property_property_lease_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `power_and_utilities_v2`.`trading`.`counterparty`(`counterparty_id`);

-- ========= property --> workforce (2 constraint(s)) =========
-- Requires: property schema, workforce schema
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ADD CONSTRAINT `fk_property_appraisal_approved_by_employee_id` FOREIGN KEY (`approved_by_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ADD CONSTRAINT `fk_property_appraisal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);

-- ========= regulatory --> asset (9 constraint(s)) =========
-- Requires: regulatory schema, asset schema
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ADD CONSTRAINT `fk_regulatory_filing_asset_capex_project_id` FOREIGN KEY (`asset_capex_project_id`) REFERENCES `power_and_utilities_v2`.`asset`.`asset_capex_project`(`asset_capex_project_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ADD CONSTRAINT `fk_regulatory_compliance_obligation_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ADD CONSTRAINT `fk_regulatory_cip_asset_classification_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ADD CONSTRAINT `fk_regulatory_cip_asset_classification_tertiary_cip_registry_id` FOREIGN KEY (`tertiary_cip_registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rab_asset` ADD CONSTRAINT `fk_regulatory_rab_asset_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rab_asset` ADD CONSTRAINT `fk_regulatory_rab_asset_depreciation_schedule_id` FOREIGN KEY (`depreciation_schedule_id`) REFERENCES `power_and_utilities_v2`.`asset`.`depreciation_schedule`(`depreciation_schedule_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rps_obligation` ADD CONSTRAINT `fk_regulatory_rps_obligation_asset_permit_compliance_document_id` FOREIGN KEY (`asset_permit_compliance_document_id`) REFERENCES `power_and_utilities_v2`.`asset`.`compliance_document`(`compliance_document_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rps_obligation` ADD CONSTRAINT `fk_regulatory_rps_obligation_compliance_document_id` FOREIGN KEY (`compliance_document_id`) REFERENCES `power_and_utilities_v2`.`asset`.`compliance_document`(`compliance_document_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ADD CONSTRAINT `fk_regulatory_regulatory_audit_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);

-- ========= regulatory --> customer (5 constraint(s)) =========
-- Requires: regulatory schema, customer schema
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ADD CONSTRAINT `fk_regulatory_cip_asset_classification_person_id` FOREIGN KEY (`person_id`) REFERENCES `power_and_utilities_v2`.`customer`.`person`(`person_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ADD CONSTRAINT `fk_regulatory_cpcn_application_applicant_organization_business_entity_id` FOREIGN KEY (`applicant_organization_business_entity_id`) REFERENCES `power_and_utilities_v2`.`customer`.`business_entity`(`business_entity_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ADD CONSTRAINT `fk_regulatory_cpcn_application_business_entity_id` FOREIGN KEY (`business_entity_id`) REFERENCES `power_and_utilities_v2`.`customer`.`business_entity`(`business_entity_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`correspondence` ADD CONSTRAINT `fk_regulatory_correspondence_person_id` FOREIGN KEY (`person_id`) REFERENCES `power_and_utilities_v2`.`customer`.`person`(`person_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`ferc_form` ADD CONSTRAINT `fk_regulatory_ferc_form_business_entity_id` FOREIGN KEY (`business_entity_id`) REFERENCES `power_and_utilities_v2`.`customer`.`business_entity`(`business_entity_id`);

-- ========= regulatory --> engagement (6 constraint(s)) =========
-- Requires: regulatory schema, engagement schema
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ADD CONSTRAINT `fk_regulatory_filing_ci_account_id` FOREIGN KEY (`ci_account_id`) REFERENCES `power_and_utilities_v2`.`engagement`.`ci_account`(`ci_account_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ADD CONSTRAINT `fk_regulatory_filing_large_customer_contract_id` FOREIGN KEY (`large_customer_contract_id`) REFERENCES `power_and_utilities_v2`.`engagement`.`large_customer_contract`(`large_customer_contract_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`tariff_schedule` ADD CONSTRAINT `fk_regulatory_tariff_schedule_ci_account_id` FOREIGN KEY (`ci_account_id`) REFERENCES `power_and_utilities_v2`.`engagement`.`ci_account`(`ci_account_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ADD CONSTRAINT `fk_regulatory_compliance_obligation_ci_account_id` FOREIGN KEY (`ci_account_id`) REFERENCES `power_and_utilities_v2`.`engagement`.`ci_account`(`ci_account_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` ADD CONSTRAINT `fk_regulatory_mitigation_plan_ci_account_id` FOREIGN KEY (`ci_account_id`) REFERENCES `power_and_utilities_v2`.`engagement`.`ci_account`(`ci_account_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ADD CONSTRAINT `fk_regulatory_regulatory_audit_ci_account_id` FOREIGN KEY (`ci_account_id`) REFERENCES `power_and_utilities_v2`.`engagement`.`ci_account`(`ci_account_id`);

-- ========= regulatory --> finance (9 constraint(s)) =========
-- Requires: regulatory schema, finance schema
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ADD CONSTRAINT `fk_regulatory_filing_finance_capex_project_id` FOREIGN KEY (`finance_capex_project_id`) REFERENCES `power_and_utilities_v2`.`finance`.`finance_capex_project`(`finance_capex_project_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ADD CONSTRAINT `fk_regulatory_rate_case_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`tariff_schedule` ADD CONSTRAINT `fk_regulatory_tariff_schedule_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `power_and_utilities_v2`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ADD CONSTRAINT `fk_regulatory_compliance_obligation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rab_asset` ADD CONSTRAINT `fk_regulatory_rab_asset_regulatory_asset_id` FOREIGN KEY (`regulatory_asset_id`) REFERENCES `power_and_utilities_v2`.`finance`.`regulatory_asset`(`regulatory_asset_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`violation_notice` ADD CONSTRAINT `fk_regulatory_violation_notice_finance_capex_project_id` FOREIGN KEY (`finance_capex_project_id`) REFERENCES `power_and_utilities_v2`.`finance`.`finance_capex_project`(`finance_capex_project_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`ferc_form` ADD CONSTRAINT `fk_regulatory_ferc_form_finance_capex_project_id` FOREIGN KEY (`finance_capex_project_id`) REFERENCES `power_and_utilities_v2`.`finance`.`finance_capex_project`(`finance_capex_project_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ADD CONSTRAINT `fk_regulatory_eia_report_finance_capex_project_id` FOREIGN KEY (`finance_capex_project_id`) REFERENCES `power_and_utilities_v2`.`finance`.`finance_capex_project`(`finance_capex_project_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ADD CONSTRAINT `fk_regulatory_regulatory_audit_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `power_and_utilities_v2`.`finance`.`internal_order`(`internal_order_id`);

-- ========= regulatory --> generation (3 constraint(s)) =========
-- Requires: regulatory schema, generation schema
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ADD CONSTRAINT `fk_regulatory_filing_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `power_and_utilities_v2`.`generation`.`plant`(`plant_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ADD CONSTRAINT `fk_regulatory_compliance_obligation_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `power_and_utilities_v2`.`generation`.`plant`(`plant_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`emission_allowance` ADD CONSTRAINT `fk_regulatory_emission_allowance_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `power_and_utilities_v2`.`generation`.`plant`(`plant_id`);

-- ========= regulatory --> metering (1 constraint(s)) =========
-- Requires: regulatory schema, metering schema
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ADD CONSTRAINT `fk_regulatory_rec_inventory_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `power_and_utilities_v2`.`metering`.`meter`(`meter_id`);

-- ========= regulatory --> property (9 constraint(s)) =========
-- Requires: regulatory schema, property schema
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ADD CONSTRAINT `fk_regulatory_filing_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ADD CONSTRAINT `fk_regulatory_rate_case_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`tariff_schedule` ADD CONSTRAINT `fk_regulatory_tariff_schedule_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ADD CONSTRAINT `fk_regulatory_compliance_obligation_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_evidence` ADD CONSTRAINT `fk_regulatory_compliance_evidence_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ADD CONSTRAINT `fk_regulatory_cpcn_application_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ADD CONSTRAINT `fk_regulatory_environmental_permit_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`emission_allowance` ADD CONSTRAINT `fk_regulatory_emission_allowance_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ADD CONSTRAINT `fk_regulatory_rec_inventory_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);

-- ========= regulatory --> technology (8 constraint(s)) =========
-- Requires: regulatory schema, technology schema
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ADD CONSTRAINT `fk_regulatory_rate_case_tech_project_id` FOREIGN KEY (`tech_project_id`) REFERENCES `power_and_utilities_v2`.`technology`.`tech_project`(`tech_project_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`commission_order` ADD CONSTRAINT `fk_regulatory_commission_order_tech_project_id` FOREIGN KEY (`tech_project_id`) REFERENCES `power_and_utilities_v2`.`technology`.`tech_project`(`tech_project_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ADD CONSTRAINT `fk_regulatory_compliance_obligation_scada_system_id` FOREIGN KEY (`scada_system_id`) REFERENCES `power_and_utilities_v2`.`technology`.`scada_system`(`scada_system_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ADD CONSTRAINT `fk_regulatory_environmental_permit_ot_asset_id` FOREIGN KEY (`ot_asset_id`) REFERENCES `power_and_utilities_v2`.`technology`.`ot_asset`(`ot_asset_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ADD CONSTRAINT `fk_regulatory_rec_inventory_ot_asset_id` FOREIGN KEY (`ot_asset_id`) REFERENCES `power_and_utilities_v2`.`technology`.`ot_asset`(`ot_asset_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rps_obligation` ADD CONSTRAINT `fk_regulatory_rps_obligation_ot_asset_id` FOREIGN KEY (`ot_asset_id`) REFERENCES `power_and_utilities_v2`.`technology`.`ot_asset`(`ot_asset_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`violation_notice` ADD CONSTRAINT `fk_regulatory_violation_notice_ot_asset_id` FOREIGN KEY (`ot_asset_id`) REFERENCES `power_and_utilities_v2`.`technology`.`ot_asset`(`ot_asset_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ADD CONSTRAINT `fk_regulatory_regulatory_audit_scada_system_id` FOREIGN KEY (`scada_system_id`) REFERENCES `power_and_utilities_v2`.`technology`.`scada_system`(`scada_system_id`);

-- ========= regulatory --> transmission (1 constraint(s)) =========
-- Requires: regulatory schema, transmission schema
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`commission_order` ADD CONSTRAINT `fk_regulatory_commission_order_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`tariff`(`tariff_id`);

-- ========= regulatory --> workforce (19 constraint(s)) =========
-- Requires: regulatory schema, workforce schema
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ADD CONSTRAINT `fk_regulatory_filing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ADD CONSTRAINT `fk_regulatory_filing_responsible_employee_id` FOREIGN KEY (`responsible_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`docket` ADD CONSTRAINT `fk_regulatory_docket_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ADD CONSTRAINT `fk_regulatory_compliance_obligation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ADD CONSTRAINT `fk_regulatory_cip_asset_classification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ADD CONSTRAINT `fk_regulatory_cpcn_application_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`emission_allowance` ADD CONSTRAINT `fk_regulatory_emission_allowance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`emission_allowance` ADD CONSTRAINT `fk_regulatory_emission_allowance_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ADD CONSTRAINT `fk_regulatory_rec_inventory_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`correspondence` ADD CONSTRAINT `fk_regulatory_correspondence_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`correspondence` ADD CONSTRAINT `fk_regulatory_correspondence_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`correspondence` ADD CONSTRAINT `fk_regulatory_correspondence_updated_by_user_employee_id` FOREIGN KEY (`updated_by_user_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case_testimony` ADD CONSTRAINT `fk_regulatory_rate_case_testimony_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case_testimony` ADD CONSTRAINT `fk_regulatory_rate_case_testimony_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`violation_notice` ADD CONSTRAINT `fk_regulatory_violation_notice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`violation_notice` ADD CONSTRAINT `fk_regulatory_violation_notice_responsible_employee_id` FOREIGN KEY (`responsible_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` ADD CONSTRAINT `fk_regulatory_mitigation_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` ADD CONSTRAINT `fk_regulatory_mitigation_plan_responsible_owner_employee_id` FOREIGN KEY (`responsible_owner_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ADD CONSTRAINT `fk_regulatory_regulatory_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);

-- ========= safety --> asset (21 constraint(s)) =========
-- Requires: safety schema, asset schema
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_asset_permit_compliance_document_id` FOREIGN KEY (`asset_permit_compliance_document_id`) REFERENCES `power_and_utilities_v2`.`asset`.`compliance_document`(`compliance_document_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_asset_risk_risk_assessment_id` FOREIGN KEY (`asset_risk_risk_assessment_id`) REFERENCES `power_and_utilities_v2`.`asset`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_compliance_document_id` FOREIGN KEY (`compliance_document_id`) REFERENCES `power_and_utilities_v2`.`asset`.`compliance_document`(`compliance_document_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_location_id` FOREIGN KEY (`location_id`) REFERENCES `power_and_utilities_v2`.`asset`.`location`(`location_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `power_and_utilities_v2`.`asset`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `power_and_utilities_v2`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` ADD CONSTRAINT `fk_safety_observation_location_id` FOREIGN KEY (`location_id`) REFERENCES `power_and_utilities_v2`.`asset`.`location`(`location_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` ADD CONSTRAINT `fk_safety_audit_finding_asset_registry_id` FOREIGN KEY (`asset_registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` ADD CONSTRAINT `fk_safety_audit_finding_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` ADD CONSTRAINT `fk_safety_audit_finding_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `power_and_utilities_v2`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_location_id` FOREIGN KEY (`location_id`) REFERENCES `power_and_utilities_v2`.`asset`.`location`(`location_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `power_and_utilities_v2`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ADD CONSTRAINT `fk_safety_job_hazard_analysis_asset_registry_id` FOREIGN KEY (`asset_registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ADD CONSTRAINT `fk_safety_job_hazard_analysis_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `power_and_utilities_v2`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` ADD CONSTRAINT `fk_safety_cip_compliance_record_asset_registry_id` FOREIGN KEY (`asset_registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` ADD CONSTRAINT `fk_safety_cip_compliance_record_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` ADD CONSTRAINT `fk_safety_emergency_drill_location_id` FOREIGN KEY (`location_id`) REFERENCES `power_and_utilities_v2`.`asset`.`location`(`location_id`);

-- ========= safety --> billing (1 constraint(s)) =========
-- Requires: safety schema, billing schema
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `power_and_utilities_v2`.`billing`.`billing_account`(`billing_account_id`);

-- ========= safety --> customer (6 constraint(s)) =========
-- Requires: safety schema, customer schema
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ADD CONSTRAINT `fk_safety_safety_program_business_entity_id` FOREIGN KEY (`business_entity_id`) REFERENCES `power_and_utilities_v2`.`customer`.`business_entity`(`business_entity_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ADD CONSTRAINT `fk_safety_safety_program_person_id` FOREIGN KEY (`person_id`) REFERENCES `power_and_utilities_v2`.`customer`.`person`(`person_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_person_id` FOREIGN KEY (`person_id`) REFERENCES `power_and_utilities_v2`.`customer`.`person`(`person_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`training` ADD CONSTRAINT `fk_safety_training_person_id` FOREIGN KEY (`person_id`) REFERENCES `power_and_utilities_v2`.`customer`.`person`(`person_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` ADD CONSTRAINT `fk_safety_cip_compliance_record_business_entity_id` FOREIGN KEY (`business_entity_id`) REFERENCES `power_and_utilities_v2`.`customer`.`business_entity`(`business_entity_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` ADD CONSTRAINT `fk_safety_cip_compliance_record_person_id` FOREIGN KEY (`person_id`) REFERENCES `power_and_utilities_v2`.`customer`.`person`(`person_id`);

-- ========= safety --> distribution (7 constraint(s)) =========
-- Requires: safety schema, distribution schema
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_distribution_service_point_id` FOREIGN KEY (`distribution_service_point_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`distribution_service_point`(`distribution_service_point_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` ADD CONSTRAINT `fk_safety_observation_distribution_transformer_id` FOREIGN KEY (`distribution_transformer_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`distribution_transformer`(`distribution_transformer_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` ADD CONSTRAINT `fk_safety_observation_pole_id` FOREIGN KEY (`pole_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`pole`(`pole_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_audit` ADD CONSTRAINT `fk_safety_safety_audit_distribution_substation_id` FOREIGN KEY (`distribution_substation_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`distribution_substation`(`distribution_substation_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_distribution_transformer_id` FOREIGN KEY (`distribution_transformer_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`distribution_transformer`(`distribution_transformer_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` ADD CONSTRAINT `fk_safety_pipeline_integrity_assessment_gas_main_id` FOREIGN KEY (`gas_main_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`gas_main`(`gas_main_id`);

-- ========= safety --> engagement (4 constraint(s)) =========
-- Requires: safety schema, engagement schema
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_ci_account_id` FOREIGN KEY (`ci_account_id`) REFERENCES `power_and_utilities_v2`.`engagement`.`ci_account`(`ci_account_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` ADD CONSTRAINT `fk_safety_observation_ci_account_id` FOREIGN KEY (`ci_account_id`) REFERENCES `power_and_utilities_v2`.`engagement`.`ci_account`(`ci_account_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_ci_account_id` FOREIGN KEY (`ci_account_id`) REFERENCES `power_and_utilities_v2`.`engagement`.`ci_account`(`ci_account_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` ADD CONSTRAINT `fk_safety_emergency_drill_ci_account_id` FOREIGN KEY (`ci_account_id`) REFERENCES `power_and_utilities_v2`.`engagement`.`ci_account`(`ci_account_id`);

-- ========= safety --> finance (10 constraint(s)) =========
-- Requires: safety schema, finance schema
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ADD CONSTRAINT `fk_safety_safety_program_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `power_and_utilities_v2`.`finance`.`budget`(`budget_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_audit` ADD CONSTRAINT `fk_safety_safety_audit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ADD CONSTRAINT `fk_safety_hazmat_release_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`training` ADD CONSTRAINT `fk_safety_training_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ADD CONSTRAINT `fk_safety_job_hazard_analysis_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ADD CONSTRAINT `fk_safety_environmental_compliance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` ADD CONSTRAINT `fk_safety_pipeline_integrity_assessment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);

-- ========= safety --> generation (12 constraint(s)) =========
-- Requires: safety schema, generation schema
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_generating_unit_id` FOREIGN KEY (`generating_unit_id`) REFERENCES `power_and_utilities_v2`.`generation`.`generating_unit`(`generating_unit_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `power_and_utilities_v2`.`generation`.`plant`(`plant_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ADD CONSTRAINT `fk_safety_safety_program_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `power_and_utilities_v2`.`generation`.`plant`(`plant_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` ADD CONSTRAINT `fk_safety_observation_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `power_and_utilities_v2`.`generation`.`plant`(`plant_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ADD CONSTRAINT `fk_safety_hazmat_inventory_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `power_and_utilities_v2`.`generation`.`plant`(`plant_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ADD CONSTRAINT `fk_safety_hazmat_release_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `power_and_utilities_v2`.`generation`.`plant`(`plant_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`training` ADD CONSTRAINT `fk_safety_training_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `power_and_utilities_v2`.`generation`.`plant`(`plant_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ADD CONSTRAINT `fk_safety_job_hazard_analysis_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `power_and_utilities_v2`.`generation`.`plant`(`plant_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `power_and_utilities_v2`.`generation`.`plant`(`plant_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_emission` ADD CONSTRAINT `fk_safety_environmental_emission_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `power_and_utilities_v2`.`generation`.`plant`(`plant_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ADD CONSTRAINT `fk_safety_environmental_compliance_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `power_and_utilities_v2`.`generation`.`plant`(`plant_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` ADD CONSTRAINT `fk_safety_emergency_drill_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `power_and_utilities_v2`.`generation`.`plant`(`plant_id`);

-- ========= safety --> metering (6 constraint(s)) =========
-- Requires: safety schema, metering schema
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `power_and_utilities_v2`.`metering`.`meter`(`meter_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` ADD CONSTRAINT `fk_safety_observation_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `power_and_utilities_v2`.`metering`.`meter`(`meter_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` ADD CONSTRAINT `fk_safety_observation_metering_service_point_id` FOREIGN KEY (`metering_service_point_id`) REFERENCES `power_and_utilities_v2`.`metering`.`metering_service_point`(`metering_service_point_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_audit` ADD CONSTRAINT `fk_safety_safety_audit_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `power_and_utilities_v2`.`metering`.`meter`(`meter_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_audit` ADD CONSTRAINT `fk_safety_safety_audit_metering_service_point_id` FOREIGN KEY (`metering_service_point_id`) REFERENCES `power_and_utilities_v2`.`metering`.`metering_service_point`(`metering_service_point_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `power_and_utilities_v2`.`metering`.`meter`(`meter_id`);

-- ========= safety --> product (1 constraint(s)) =========
-- Requires: safety schema, product schema
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ADD CONSTRAINT `fk_safety_safety_program_product_program_id` FOREIGN KEY (`product_program_id`) REFERENCES `power_and_utilities_v2`.`product`.`product_program`(`product_program_id`);

-- ========= safety --> property (14 constraint(s)) =========
-- Requires: safety schema, property schema
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `power_and_utilities_v2`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ADD CONSTRAINT `fk_safety_safety_program_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` ADD CONSTRAINT `fk_safety_observation_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_audit` ADD CONSTRAINT `fk_safety_safety_audit_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ADD CONSTRAINT `fk_safety_hazmat_inventory_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ADD CONSTRAINT `fk_safety_hazmat_release_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_site_id` FOREIGN KEY (`site_id`) REFERENCES `power_and_utilities_v2`.`property`.`site`(`site_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_emission` ADD CONSTRAINT `fk_safety_environmental_emission_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ADD CONSTRAINT `fk_safety_environmental_compliance_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` ADD CONSTRAINT `fk_safety_pipeline_integrity_assessment_site_id` FOREIGN KEY (`site_id`) REFERENCES `power_and_utilities_v2`.`property`.`site`(`site_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` ADD CONSTRAINT `fk_safety_cip_compliance_record_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` ADD CONSTRAINT `fk_safety_emergency_drill_site_id` FOREIGN KEY (`site_id`) REFERENCES `power_and_utilities_v2`.`property`.`site`(`site_id`);

-- ========= safety --> regulatory (8 constraint(s)) =========
-- Requires: safety schema, regulatory schema
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`docket`(`docket_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_filing_id` FOREIGN KEY (`filing_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`filing`(`filing_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_violation_notice_id` FOREIGN KEY (`violation_notice_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`violation_notice`(`violation_notice_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ADD CONSTRAINT `fk_safety_safety_program_body_id` FOREIGN KEY (`body_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`body`(`body_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` ADD CONSTRAINT `fk_safety_observation_body_id` FOREIGN KEY (`body_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`body`(`body_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_audit` ADD CONSTRAINT `fk_safety_safety_audit_body_id` FOREIGN KEY (`body_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`body`(`body_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_emission` ADD CONSTRAINT `fk_safety_environmental_emission_eia_report_id` FOREIGN KEY (`eia_report_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`eia_report`(`eia_report_id`);

-- ========= safety --> supply (5 constraint(s)) =========
-- Requires: safety schema, supply schema
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_contractor_vendor_id` FOREIGN KEY (`contractor_vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ADD CONSTRAINT `fk_safety_hazmat_inventory_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `power_and_utilities_v2`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_contractor_vendor_id` FOREIGN KEY (`contractor_vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);

-- ========= safety --> technology (3 constraint(s)) =========
-- Requires: safety schema, technology schema
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_ot_asset_id` FOREIGN KEY (`ot_asset_id`) REFERENCES `power_and_utilities_v2`.`technology`.`ot_asset`(`ot_asset_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` ADD CONSTRAINT `fk_safety_observation_ot_asset_id` FOREIGN KEY (`ot_asset_id`) REFERENCES `power_and_utilities_v2`.`technology`.`ot_asset`(`ot_asset_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_ot_asset_id` FOREIGN KEY (`ot_asset_id`) REFERENCES `power_and_utilities_v2`.`technology`.`ot_asset`(`ot_asset_id`);

-- ========= safety --> workforce (26 constraint(s)) =========
-- Requires: safety schema, workforce schema
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ADD CONSTRAINT `fk_safety_safety_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` ADD CONSTRAINT `fk_safety_observation_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` ADD CONSTRAINT `fk_safety_observation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_audit` ADD CONSTRAINT `fk_safety_safety_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` ADD CONSTRAINT `fk_safety_audit_finding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_responsible_employee_id` FOREIGN KEY (`responsible_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_responsible_party_employee_id` FOREIGN KEY (`responsible_party_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_updated_by_user_employee_id` FOREIGN KEY (`updated_by_user_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ADD CONSTRAINT `fk_safety_hazmat_inventory_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ADD CONSTRAINT `fk_safety_hazmat_release_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`training` ADD CONSTRAINT `fk_safety_training_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ADD CONSTRAINT `fk_safety_job_hazard_analysis_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_authorized_by_employee_id` FOREIGN KEY (`authorized_by_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_issuer_employee_id` FOREIGN KEY (`issuer_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_primary_permit_employee_id` FOREIGN KEY (`primary_permit_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_tertiary_permit_authorized_by_employee_id` FOREIGN KEY (`tertiary_permit_authorized_by_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_emission` ADD CONSTRAINT `fk_safety_environmental_emission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ADD CONSTRAINT `fk_safety_environmental_compliance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` ADD CONSTRAINT `fk_safety_pipeline_integrity_assessment_assessor_employee_id` FOREIGN KEY (`assessor_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` ADD CONSTRAINT `fk_safety_pipeline_integrity_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` ADD CONSTRAINT `fk_safety_cip_compliance_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` ADD CONSTRAINT `fk_safety_emergency_drill_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);

-- ========= supply --> asset (10 constraint(s)) =========
-- Requires: supply schema, asset schema
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_asset_capex_project_id` FOREIGN KEY (`asset_capex_project_id`) REFERENCES `power_and_utilities_v2`.`asset`.`asset_capex_project`(`asset_capex_project_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_location_id` FOREIGN KEY (`location_id`) REFERENCES `power_and_utilities_v2`.`asset`.`location`(`location_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_asset_capex_project_id` FOREIGN KEY (`asset_capex_project_id`) REFERENCES `power_and_utilities_v2`.`asset`.`asset_capex_project`(`asset_capex_project_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_source_location_id` FOREIGN KEY (`source_location_id`) REFERENCES `power_and_utilities_v2`.`asset`.`location`(`location_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ADD CONSTRAINT `fk_supply_requisition_asset_capex_project_id` FOREIGN KEY (`asset_capex_project_id`) REFERENCES `power_and_utilities_v2`.`asset`.`asset_capex_project`(`asset_capex_project_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ADD CONSTRAINT `fk_supply_rfq_location_id` FOREIGN KEY (`location_id`) REFERENCES `power_and_utilities_v2`.`asset`.`location`(`location_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_location_id` FOREIGN KEY (`location_id`) REFERENCES `power_and_utilities_v2`.`asset`.`location`(`location_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_origin_location_id` FOREIGN KEY (`origin_location_id`) REFERENCES `power_and_utilities_v2`.`asset`.`location`(`location_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ADD CONSTRAINT `fk_supply_service_entry_sheet_location_id` FOREIGN KEY (`location_id`) REFERENCES `power_and_utilities_v2`.`asset`.`location`(`location_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ADD CONSTRAINT `fk_supply_service_entry_sheet_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `power_and_utilities_v2`.`asset`.`work_order`(`work_order_id`);

-- ========= supply --> customer (5 constraint(s)) =========
-- Requires: supply schema, customer schema
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_customer_service_point_id` FOREIGN KEY (`customer_service_point_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_service_point`(`customer_service_point_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_customer_service_point_id` FOREIGN KEY (`customer_service_point_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_service_point`(`customer_service_point_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ADD CONSTRAINT `fk_supply_rfq_business_entity_id` FOREIGN KEY (`business_entity_id`) REFERENCES `power_and_utilities_v2`.`customer`.`business_entity`(`business_entity_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);

-- ========= supply --> engagement (6 constraint(s)) =========
-- Requires: supply schema, engagement schema
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_large_customer_contract_id` FOREIGN KEY (`large_customer_contract_id`) REFERENCES `power_and_utilities_v2`.`engagement`.`large_customer_contract`(`large_customer_contract_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ADD CONSTRAINT `fk_supply_inventory_stock_ci_account_id` FOREIGN KEY (`ci_account_id`) REFERENCES `power_and_utilities_v2`.`engagement`.`ci_account`(`ci_account_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_ci_account_id` FOREIGN KEY (`ci_account_id`) REFERENCES `power_and_utilities_v2`.`engagement`.`ci_account`(`ci_account_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ADD CONSTRAINT `fk_supply_vendor_quotation_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `power_and_utilities_v2`.`engagement`.`opportunity`(`opportunity_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_ci_account_id` FOREIGN KEY (`ci_account_id`) REFERENCES `power_and_utilities_v2`.`engagement`.`ci_account`(`ci_account_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ADD CONSTRAINT `fk_supply_service_entry_sheet_ci_account_id` FOREIGN KEY (`ci_account_id`) REFERENCES `power_and_utilities_v2`.`engagement`.`ci_account`(`ci_account_id`);

-- ========= supply --> finance (12 constraint(s)) =========
-- Requires: supply schema, finance schema
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `power_and_utilities_v2`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ADD CONSTRAINT `fk_supply_po_line_item_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ADD CONSTRAINT `fk_supply_po_line_item_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `power_and_utilities_v2`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_finance_capex_project_id` FOREIGN KEY (`finance_capex_project_id`) REFERENCES `power_and_utilities_v2`.`finance`.`finance_capex_project`(`finance_capex_project_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `power_and_utilities_v2`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ADD CONSTRAINT `fk_supply_requisition_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `power_and_utilities_v2`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ADD CONSTRAINT `fk_supply_rfq_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ADD CONSTRAINT `fk_supply_vendor_quotation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ADD CONSTRAINT `fk_supply_warehouse_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ADD CONSTRAINT `fk_supply_service_entry_sheet_finance_capex_project_id` FOREIGN KEY (`finance_capex_project_id`) REFERENCES `power_and_utilities_v2`.`finance`.`finance_capex_project`(`finance_capex_project_id`);

-- ========= supply --> generation (4 constraint(s)) =========
-- Requires: supply schema, generation schema
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `power_and_utilities_v2`.`generation`.`plant`(`plant_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ADD CONSTRAINT `fk_supply_inventory_stock_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `power_and_utilities_v2`.`generation`.`plant`(`plant_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_supply_schedule` ADD CONSTRAINT `fk_supply_fuel_supply_schedule_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `power_and_utilities_v2`.`generation`.`plant`(`plant_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ADD CONSTRAINT `fk_supply_fuel_receipt_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `power_and_utilities_v2`.`generation`.`plant`(`plant_id`);

-- ========= supply --> property (5 constraint(s)) =========
-- Requires: supply schema, property schema
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ADD CONSTRAINT `fk_supply_procurement_contract_site_id` FOREIGN KEY (`site_id`) REFERENCES `power_and_utilities_v2`.`property`.`site`(`site_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_supply_schedule` ADD CONSTRAINT `fk_supply_fuel_supply_schedule_site_id` FOREIGN KEY (`site_id`) REFERENCES `power_and_utilities_v2`.`property`.`site`(`site_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ADD CONSTRAINT `fk_supply_warehouse_site_id` FOREIGN KEY (`site_id`) REFERENCES `power_and_utilities_v2`.`property`.`site`(`site_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_qualification` ADD CONSTRAINT `fk_supply_vendor_qualification_document_id` FOREIGN KEY (`document_id`) REFERENCES `power_and_utilities_v2`.`property`.`document`(`document_id`);

-- ========= supply --> regulatory (4 constraint(s)) =========
-- Requires: supply schema, regulatory schema
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ADD CONSTRAINT `fk_supply_inventory_stock_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_supply_schedule` ADD CONSTRAINT `fk_supply_fuel_supply_schedule_filing_id` FOREIGN KEY (`filing_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`filing`(`filing_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ADD CONSTRAINT `fk_supply_fuel_receipt_filing_id` FOREIGN KEY (`filing_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`filing`(`filing_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_filing_id` FOREIGN KEY (`filing_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`filing`(`filing_id`);

-- ========= supply --> technology (6 constraint(s)) =========
-- Requires: supply schema, technology schema
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ADD CONSTRAINT `fk_supply_vendor_tech_vendor_id` FOREIGN KEY (`tech_vendor_id`) REFERENCES `power_and_utilities_v2`.`technology`.`tech_vendor`(`tech_vendor_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_it_asset_id` FOREIGN KEY (`it_asset_id`) REFERENCES `power_and_utilities_v2`.`technology`.`it_asset`(`it_asset_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ADD CONSTRAINT `fk_supply_inventory_stock_it_asset_id` FOREIGN KEY (`it_asset_id`) REFERENCES `power_and_utilities_v2`.`technology`.`it_asset`(`it_asset_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_it_asset_id` FOREIGN KEY (`it_asset_id`) REFERENCES `power_and_utilities_v2`.`technology`.`it_asset`(`it_asset_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_network_device_id` FOREIGN KEY (`network_device_id`) REFERENCES `power_and_utilities_v2`.`technology`.`network_device`(`network_device_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ADD CONSTRAINT `fk_supply_service_entry_sheet_it_service_id` FOREIGN KEY (`it_service_id`) REFERENCES `power_and_utilities_v2`.`technology`.`it_service`(`it_service_id`);

-- ========= supply --> workforce (21 constraint(s)) =========
-- Requires: supply schema, workforce schema
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ADD CONSTRAINT `fk_supply_vendor_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_approved_by_employee_id` FOREIGN KEY (`approved_by_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_last_modified_by_employee_id` FOREIGN KEY (`last_modified_by_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_received_by_user_employee_id` FOREIGN KEY (`received_by_user_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_posted_by_user_employee_id` FOREIGN KEY (`posted_by_user_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ADD CONSTRAINT `fk_supply_requisition_approver_employee_id` FOREIGN KEY (`approver_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ADD CONSTRAINT `fk_supply_requisition_approver_id` FOREIGN KEY (`approver_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ADD CONSTRAINT `fk_supply_requisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ADD CONSTRAINT `fk_supply_requisition_requisition_employee_id` FOREIGN KEY (`requisition_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ADD CONSTRAINT `fk_supply_rfq_approved_by_employee_id` FOREIGN KEY (`approved_by_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ADD CONSTRAINT `fk_supply_rfq_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_performance` ADD CONSTRAINT `fk_supply_vendor_performance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_performance` ADD CONSTRAINT `fk_supply_vendor_performance_evaluator_employee_id` FOREIGN KEY (`evaluator_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ADD CONSTRAINT `fk_supply_invoice_verification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ADD CONSTRAINT `fk_supply_invoice_verification_verification_user_employee_id` FOREIGN KEY (`verification_user_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ADD CONSTRAINT `fk_supply_service_entry_sheet_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ADD CONSTRAINT `fk_supply_service_entry_sheet_posted_by_user_employee_id` FOREIGN KEY (`posted_by_user_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ADD CONSTRAINT `fk_supply_service_entry_sheet_primary_service_employee_id` FOREIGN KEY (`primary_service_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);

-- ========= technology --> asset (6 constraint(s)) =========
-- Requires: technology schema, asset schema
ALTER TABLE `power_and_utilities_v2`.`technology`.`ot_asset` ADD CONSTRAINT `fk_technology_ot_asset_location_id` FOREIGN KEY (`location_id`) REFERENCES `power_and_utilities_v2`.`asset`.`location`(`location_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ADD CONSTRAINT `fk_technology_incident_ticket_location_id` FOREIGN KEY (`location_id`) REFERENCES `power_and_utilities_v2`.`asset`.`location`(`location_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ADD CONSTRAINT `fk_technology_service_request_ticket_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ADD CONSTRAINT `fk_technology_service_request_ticket_location_id` FOREIGN KEY (`location_id`) REFERENCES `power_and_utilities_v2`.`asset`.`location`(`location_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ADD CONSTRAINT `fk_technology_service_request_ticket_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `power_and_utilities_v2`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`cyber_incident` ADD CONSTRAINT `fk_technology_cyber_incident_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);

-- ========= technology --> customer (8 constraint(s)) =========
-- Requires: technology schema, customer schema
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ADD CONSTRAINT `fk_technology_it_service_person_id` FOREIGN KEY (`person_id`) REFERENCES `power_and_utilities_v2`.`customer`.`person`(`person_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ADD CONSTRAINT `fk_technology_incident_ticket_person_id` FOREIGN KEY (`person_id`) REFERENCES `power_and_utilities_v2`.`customer`.`person`(`person_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ADD CONSTRAINT `fk_technology_incident_ticket_quaternary_incident_updated_by_user_person_id` FOREIGN KEY (`quaternary_incident_updated_by_user_person_id`) REFERENCES `power_and_utilities_v2`.`customer`.`person`(`person_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ADD CONSTRAINT `fk_technology_incident_ticket_tertiary_incident_created_by_user_person_id` FOREIGN KEY (`tertiary_incident_created_by_user_person_id`) REFERENCES `power_and_utilities_v2`.`customer`.`person`(`person_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ADD CONSTRAINT `fk_technology_service_request_ticket_person_id` FOREIGN KEY (`person_id`) REFERENCES `power_and_utilities_v2`.`customer`.`person`(`person_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` ADD CONSTRAINT `fk_technology_access_entitlement_person_id` FOREIGN KEY (`person_id`) REFERENCES `power_and_utilities_v2`.`customer`.`person`(`person_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` ADD CONSTRAINT `fk_technology_access_review_person_id` FOREIGN KEY (`person_id`) REFERENCES `power_and_utilities_v2`.`customer`.`person`(`person_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_sla` ADD CONSTRAINT `fk_technology_it_sla_person_id` FOREIGN KEY (`person_id`) REFERENCES `power_and_utilities_v2`.`customer`.`person`(`person_id`);

-- ========= technology --> finance (7 constraint(s)) =========
-- Requires: technology schema, finance schema
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ADD CONSTRAINT `fk_technology_it_asset_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ADD CONSTRAINT `fk_technology_it_asset_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `power_and_utilities_v2`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ADD CONSTRAINT `fk_technology_application_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`application` ADD CONSTRAINT `fk_technology_application_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `power_and_utilities_v2`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ADD CONSTRAINT `fk_technology_it_service_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`software_license` ADD CONSTRAINT `fk_technology_software_license_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`digital_platform` ADD CONSTRAINT `fk_technology_digital_platform_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);

-- ========= technology --> property (5 constraint(s)) =========
-- Requires: technology schema, property schema
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ADD CONSTRAINT `fk_technology_it_asset_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_asset` ADD CONSTRAINT `fk_technology_it_asset_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `power_and_utilities_v2`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ADD CONSTRAINT `fk_technology_network_device_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`scada_system` ADD CONSTRAINT `fk_technology_scada_system_site_id` FOREIGN KEY (`site_id`) REFERENCES `power_and_utilities_v2`.`property`.`site`(`site_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`telecom_circuit` ADD CONSTRAINT `fk_technology_telecom_circuit_site_id` FOREIGN KEY (`site_id`) REFERENCES `power_and_utilities_v2`.`property`.`site`(`site_id`);

-- ========= technology --> regulatory (1 constraint(s)) =========
-- Requires: technology schema, regulatory schema
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` ADD CONSTRAINT `fk_technology_access_entitlement_cip_standard_id` FOREIGN KEY (`cip_standard_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`cip_standard`(`cip_standard_id`);

-- ========= technology --> safety (2 constraint(s)) =========
-- Requires: technology schema, safety schema
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ADD CONSTRAINT `fk_technology_incident_ticket_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `power_and_utilities_v2`.`safety`.`incident`(`incident_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ADD CONSTRAINT `fk_technology_service_request_ticket_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `power_and_utilities_v2`.`safety`.`incident`(`incident_id`);

-- ========= technology --> supply (4 constraint(s)) =========
-- Requires: technology schema, supply schema
ALTER TABLE `power_and_utilities_v2`.`technology`.`network_device` ADD CONSTRAINT `fk_technology_network_device_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `power_and_utilities_v2`.`supply`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ADD CONSTRAINT `fk_technology_service_request_ticket_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`supply_chain_risk` ADD CONSTRAINT `fk_technology_supply_chain_risk_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ADD CONSTRAINT `fk_technology_tech_spend_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);

-- ========= technology --> workforce (33 constraint(s)) =========
-- Requires: technology schema, workforce schema
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_service` ADD CONSTRAINT `fk_technology_it_service_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ADD CONSTRAINT `fk_technology_incident_ticket_assigned_to_employee_id` FOREIGN KEY (`assigned_to_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ADD CONSTRAINT `fk_technology_incident_ticket_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ADD CONSTRAINT `fk_technology_incident_ticket_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`incident_ticket` ADD CONSTRAINT `fk_technology_incident_ticket_updated_by_user_employee_id` FOREIGN KEY (`updated_by_user_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`change_request` ADD CONSTRAINT `fk_technology_change_request_approver_employee_id` FOREIGN KEY (`approver_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`change_request` ADD CONSTRAINT `fk_technology_change_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ADD CONSTRAINT `fk_technology_service_request_ticket_approver_employee_id` FOREIGN KEY (`approver_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ADD CONSTRAINT `fk_technology_service_request_ticket_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ADD CONSTRAINT `fk_technology_service_request_ticket_crew_member_id` FOREIGN KEY (`crew_member_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`crew_member`(`crew_member_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`service_request_ticket` ADD CONSTRAINT `fk_technology_service_request_ticket_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`project_milestone` ADD CONSTRAINT `fk_technology_project_milestone_approved_by_employee_id` FOREIGN KEY (`approved_by_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`project_milestone` ADD CONSTRAINT `fk_technology_project_milestone_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` ADD CONSTRAINT `fk_technology_access_entitlement_approver_employee_id` FOREIGN KEY (`approver_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_entitlement` ADD CONSTRAINT `fk_technology_access_entitlement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` ADD CONSTRAINT `fk_technology_access_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`access_review` ADD CONSTRAINT `fk_technology_access_review_review_owner_employee_id` FOREIGN KEY (`review_owner_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`patch_deployment` ADD CONSTRAINT `fk_technology_patch_deployment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`patch_deployment` ADD CONSTRAINT `fk_technology_patch_deployment_updated_by_user_employee_id` FOREIGN KEY (`updated_by_user_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ADD CONSTRAINT `fk_technology_dr_test_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ADD CONSTRAINT `fk_technology_dr_test_event_test_approval_employee_id` FOREIGN KEY (`test_approval_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`dr_test_event` ADD CONSTRAINT `fk_technology_dr_test_event_test_lead_employee_id` FOREIGN KEY (`test_lead_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`supply_chain_risk` ADD CONSTRAINT `fk_technology_supply_chain_risk_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`it_sla` ADD CONSTRAINT `fk_technology_it_sla_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ADD CONSTRAINT `fk_technology_platform_release_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ADD CONSTRAINT `fk_technology_platform_release_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ADD CONSTRAINT `fk_technology_platform_release_release_manager_employee_id` FOREIGN KEY (`release_manager_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ADD CONSTRAINT `fk_technology_platform_release_scheduled_by_user_employee_id` FOREIGN KEY (`scheduled_by_user_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`platform_release` ADD CONSTRAINT `fk_technology_platform_release_updated_by_user_employee_id` FOREIGN KEY (`updated_by_user_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ADD CONSTRAINT `fk_technology_tech_spend_approver_employee_id` FOREIGN KEY (`approver_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ADD CONSTRAINT `fk_technology_tech_spend_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ADD CONSTRAINT `fk_technology_tech_spend_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`technology`.`tech_spend` ADD CONSTRAINT `fk_technology_tech_spend_updated_by_user_employee_id` FOREIGN KEY (`updated_by_user_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);

-- ========= trading --> asset (6 constraint(s)) =========
-- Requires: trading schema, asset schema
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ADD CONSTRAINT `fk_trading_trade_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ADD CONSTRAINT `fk_trading_ppa_contract_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ADD CONSTRAINT `fk_trading_market_bid_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ADD CONSTRAINT `fk_trading_lmp_price_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ADD CONSTRAINT `fk_trading_rec_transaction_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ADD CONSTRAINT `fk_trading_ancillary_award_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);

-- ========= trading --> customer (6 constraint(s)) =========
-- Requires: trading schema, customer schema
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ADD CONSTRAINT `fk_trading_trade_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ADD CONSTRAINT `fk_trading_trade_customer_service_point_id` FOREIGN KEY (`customer_service_point_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_service_point`(`customer_service_point_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ADD CONSTRAINT `fk_trading_position_person_id` FOREIGN KEY (`person_id`) REFERENCES `power_and_utilities_v2`.`customer`.`person`(`person_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ADD CONSTRAINT `fk_trading_ppa_contract_business_entity_id` FOREIGN KEY (`business_entity_id`) REFERENCES `power_and_utilities_v2`.`customer`.`business_entity`(`business_entity_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ADD CONSTRAINT `fk_trading_market_bid_person_id` FOREIGN KEY (`person_id`) REFERENCES `power_and_utilities_v2`.`customer`.`person`(`person_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ADD CONSTRAINT `fk_trading_rec_transaction_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);

-- ========= trading --> der (4 constraint(s)) =========
-- Requires: trading schema, der schema
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ADD CONSTRAINT `fk_trading_trade_resource_id` FOREIGN KEY (`resource_id`) REFERENCES `power_and_utilities_v2`.`der`.`resource`(`resource_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ADD CONSTRAINT `fk_trading_position_resource_id` FOREIGN KEY (`resource_id`) REFERENCES `power_and_utilities_v2`.`der`.`resource`(`resource_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ADD CONSTRAINT `fk_trading_ppa_contract_resource_id` FOREIGN KEY (`resource_id`) REFERENCES `power_and_utilities_v2`.`der`.`resource`(`resource_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ADD CONSTRAINT `fk_trading_market_bid_resource_id` FOREIGN KEY (`resource_id`) REFERENCES `power_and_utilities_v2`.`der`.`resource`(`resource_id`);

-- ========= trading --> engagement (4 constraint(s)) =========
-- Requires: trading schema, engagement schema
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ADD CONSTRAINT `fk_trading_trade_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `power_and_utilities_v2`.`engagement`.`opportunity`(`opportunity_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ADD CONSTRAINT `fk_trading_portfolio_vpp_agreement_id` FOREIGN KEY (`vpp_agreement_id`) REFERENCES `power_and_utilities_v2`.`engagement`.`vpp_agreement`(`vpp_agreement_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ADD CONSTRAINT `fk_trading_settlement_dr_event_participation_id` FOREIGN KEY (`dr_event_participation_id`) REFERENCES `power_and_utilities_v2`.`engagement`.`dr_event_participation`(`dr_event_participation_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ADD CONSTRAINT `fk_trading_rec_transaction_dsm_program_id` FOREIGN KEY (`dsm_program_id`) REFERENCES `power_and_utilities_v2`.`engagement`.`dsm_program`(`dsm_program_id`);

-- ========= trading --> finance (4 constraint(s)) =========
-- Requires: trading schema, finance schema
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ADD CONSTRAINT `fk_trading_portfolio_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ADD CONSTRAINT `fk_trading_portfolio_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ADD CONSTRAINT `fk_trading_hedge_program_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ADD CONSTRAINT `fk_trading_hedge_program_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`profit_center`(`profit_center_id`);

-- ========= trading --> generation (3 constraint(s)) =========
-- Requires: trading schema, generation schema
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ADD CONSTRAINT `fk_trading_trade_generating_unit_id` FOREIGN KEY (`generating_unit_id`) REFERENCES `power_and_utilities_v2`.`generation`.`generating_unit`(`generating_unit_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ADD CONSTRAINT `fk_trading_ppa_contract_generating_unit_id` FOREIGN KEY (`generating_unit_id`) REFERENCES `power_and_utilities_v2`.`generation`.`generating_unit`(`generating_unit_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ADD CONSTRAINT `fk_trading_rec_transaction_rec_certificate_id` FOREIGN KEY (`rec_certificate_id`) REFERENCES `power_and_utilities_v2`.`generation`.`rec_certificate`(`rec_certificate_id`);

-- ========= trading --> gridops (4 constraint(s)) =========
-- Requires: trading schema, gridops schema
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ADD CONSTRAINT `fk_trading_trade_balancing_area_id` FOREIGN KEY (`balancing_area_id`) REFERENCES `power_and_utilities_v2`.`gridops`.`balancing_area`(`balancing_area_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ADD CONSTRAINT `fk_trading_position_balancing_area_id` FOREIGN KEY (`balancing_area_id`) REFERENCES `power_and_utilities_v2`.`gridops`.`balancing_area`(`balancing_area_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ADD CONSTRAINT `fk_trading_ppa_contract_balancing_area_id` FOREIGN KEY (`balancing_area_id`) REFERENCES `power_and_utilities_v2`.`gridops`.`balancing_area`(`balancing_area_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ADD CONSTRAINT `fk_trading_settlement_balancing_area_id` FOREIGN KEY (`balancing_area_id`) REFERENCES `power_and_utilities_v2`.`gridops`.`balancing_area`(`balancing_area_id`);

-- ========= trading --> metering (3 constraint(s)) =========
-- Requires: trading schema, metering schema
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ADD CONSTRAINT `fk_trading_trade_metering_service_point_id` FOREIGN KEY (`metering_service_point_id`) REFERENCES `power_and_utilities_v2`.`metering`.`metering_service_point`(`metering_service_point_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ADD CONSTRAINT `fk_trading_trade_leg_metering_service_point_id` FOREIGN KEY (`metering_service_point_id`) REFERENCES `power_and_utilities_v2`.`metering`.`metering_service_point`(`metering_service_point_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ADD CONSTRAINT `fk_trading_ppa_contract_metering_service_point_id` FOREIGN KEY (`metering_service_point_id`) REFERENCES `power_and_utilities_v2`.`metering`.`metering_service_point`(`metering_service_point_id`);

-- ========= trading --> product (4 constraint(s)) =========
-- Requires: trading schema, product schema
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ADD CONSTRAINT `fk_trading_ppa_contract_product_program_id` FOREIGN KEY (`product_program_id`) REFERENCES `power_and_utilities_v2`.`product`.`product_program`(`product_program_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ADD CONSTRAINT `fk_trading_market_bid_product_program_id` FOREIGN KEY (`product_program_id`) REFERENCES `power_and_utilities_v2`.`product`.`product_program`(`product_program_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ADD CONSTRAINT `fk_trading_rec_transaction_product_program_id` FOREIGN KEY (`product_program_id`) REFERENCES `power_and_utilities_v2`.`product`.`product_program`(`product_program_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ADD CONSTRAINT `fk_trading_ancillary_award_product_program_id` FOREIGN KEY (`product_program_id`) REFERENCES `power_and_utilities_v2`.`product`.`product_program`(`product_program_id`);

-- ========= trading --> property (4 constraint(s)) =========
-- Requires: trading schema, property schema
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ADD CONSTRAINT `fk_trading_trade_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ADD CONSTRAINT `fk_trading_ppa_contract_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ADD CONSTRAINT `fk_trading_market_bid_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ADD CONSTRAINT `fk_trading_rec_transaction_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);

-- ========= trading --> regulatory (6 constraint(s)) =========
-- Requires: trading schema, regulatory schema
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ADD CONSTRAINT `fk_trading_trade_filing_id` FOREIGN KEY (`filing_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`filing`(`filing_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ADD CONSTRAINT `fk_trading_position_rps_obligation_id` FOREIGN KEY (`rps_obligation_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`rps_obligation`(`rps_obligation_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ADD CONSTRAINT `fk_trading_ppa_contract_rate_case_id` FOREIGN KEY (`rate_case_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`rate_case`(`rate_case_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ADD CONSTRAINT `fk_trading_settlement_filing_id` FOREIGN KEY (`filing_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`filing`(`filing_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ADD CONSTRAINT `fk_trading_rec_transaction_rec_inventory_id` FOREIGN KEY (`rec_inventory_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`rec_inventory`(`rec_inventory_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ADD CONSTRAINT `fk_trading_ancillary_award_filing_id` FOREIGN KEY (`filing_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`filing`(`filing_id`);

-- ========= trading --> supply (2 constraint(s)) =========
-- Requires: trading schema, supply schema
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ADD CONSTRAINT `fk_trading_trade_fuel_supply_schedule_id` FOREIGN KEY (`fuel_supply_schedule_id`) REFERENCES `power_and_utilities_v2`.`supply`.`fuel_supply_schedule`(`fuel_supply_schedule_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ADD CONSTRAINT `fk_trading_trade_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `power_and_utilities_v2`.`supply`.`procurement_contract`(`procurement_contract_id`);

-- ========= trading --> technology (5 constraint(s)) =========
-- Requires: trading schema, technology schema
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ADD CONSTRAINT `fk_trading_trade_application_id` FOREIGN KEY (`application_id`) REFERENCES `power_and_utilities_v2`.`technology`.`application`(`application_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ADD CONSTRAINT `fk_trading_ppa_contract_scada_system_id` FOREIGN KEY (`scada_system_id`) REFERENCES `power_and_utilities_v2`.`technology`.`scada_system`(`scada_system_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ADD CONSTRAINT `fk_trading_market_bid_application_id` FOREIGN KEY (`application_id`) REFERENCES `power_and_utilities_v2`.`technology`.`application`(`application_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ADD CONSTRAINT `fk_trading_settlement_it_service_id` FOREIGN KEY (`it_service_id`) REFERENCES `power_and_utilities_v2`.`technology`.`it_service`(`it_service_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ADD CONSTRAINT `fk_trading_rec_transaction_scada_system_id` FOREIGN KEY (`scada_system_id`) REFERENCES `power_and_utilities_v2`.`technology`.`scada_system`(`scada_system_id`);

-- ========= trading --> transmission (6 constraint(s)) =========
-- Requires: trading schema, transmission schema
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ADD CONSTRAINT `fk_trading_trade_line_id` FOREIGN KEY (`line_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`line`(`line_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ADD CONSTRAINT `fk_trading_trade_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ADD CONSTRAINT `fk_trading_position_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ADD CONSTRAINT `fk_trading_market_bid_line_id` FOREIGN KEY (`line_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`line`(`line_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ADD CONSTRAINT `fk_trading_settlement_transmission_outage_id` FOREIGN KEY (`transmission_outage_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`transmission_outage`(`transmission_outage_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ADD CONSTRAINT `fk_trading_ancillary_award_line_id` FOREIGN KEY (`line_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`line`(`line_id`);

-- ========= trading --> workforce (5 constraint(s)) =========
-- Requires: trading schema, workforce schema
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ADD CONSTRAINT `fk_trading_trade_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ADD CONSTRAINT `fk_trading_trade_trader_employee_id` FOREIGN KEY (`trader_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ADD CONSTRAINT `fk_trading_position_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ADD CONSTRAINT `fk_trading_ppa_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ADD CONSTRAINT `fk_trading_market_bid_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);

-- ========= transmission --> asset (9 constraint(s)) =========
-- Requires: transmission schema, asset schema
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ADD CONSTRAINT `fk_transmission_line_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ADD CONSTRAINT `fk_transmission_transmission_substation_location_id` FOREIGN KEY (`location_id`) REFERENCES `power_and_utilities_v2`.`asset`.`location`(`location_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ADD CONSTRAINT `fk_transmission_transmission_substation_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ADD CONSTRAINT `fk_transmission_transmission_transformer_location_id` FOREIGN KEY (`location_id`) REFERENCES `power_and_utilities_v2`.`asset`.`location`(`location_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ADD CONSTRAINT `fk_transmission_transmission_transformer_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ADD CONSTRAINT `fk_transmission_protection_relay_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`vegetation_inspection` ADD CONSTRAINT `fk_transmission_vegetation_inspection_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `power_and_utilities_v2`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_switching_order` ADD CONSTRAINT `fk_transmission_transmission_switching_order_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `power_and_utilities_v2`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line_project_assignment` ADD CONSTRAINT `fk_transmission_line_project_assignment_asset_capex_project_id` FOREIGN KEY (`asset_capex_project_id`) REFERENCES `power_and_utilities_v2`.`asset`.`asset_capex_project`(`asset_capex_project_id`);

-- ========= transmission --> billing (1 constraint(s)) =========
-- Requires: transmission schema, billing schema
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_switching_order` ADD CONSTRAINT `fk_transmission_transmission_switching_order_adjustment_id` FOREIGN KEY (`adjustment_id`) REFERENCES `power_and_utilities_v2`.`billing`.`adjustment`(`adjustment_id`);

-- ========= transmission --> customer (4 constraint(s)) =========
-- Requires: transmission schema, customer schema
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ADD CONSTRAINT `fk_transmission_line_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ADD CONSTRAINT `fk_transmission_transmission_substation_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`service_request` ADD CONSTRAINT `fk_transmission_service_request_business_entity_id` FOREIGN KEY (`business_entity_id`) REFERENCES `power_and_utilities_v2`.`customer`.`business_entity`(`business_entity_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interconnection_agreement` ADD CONSTRAINT `fk_transmission_interconnection_agreement_business_entity_id` FOREIGN KEY (`business_entity_id`) REFERENCES `power_and_utilities_v2`.`customer`.`business_entity`(`business_entity_id`);

-- ========= transmission --> engagement (3 constraint(s)) =========
-- Requires: transmission schema, engagement schema
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ADD CONSTRAINT `fk_transmission_line_ci_account_id` FOREIGN KEY (`ci_account_id`) REFERENCES `power_and_utilities_v2`.`engagement`.`ci_account`(`ci_account_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ADD CONSTRAINT `fk_transmission_transmission_substation_ci_account_id` FOREIGN KEY (`ci_account_id`) REFERENCES `power_and_utilities_v2`.`engagement`.`ci_account`(`ci_account_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_outage` ADD CONSTRAINT `fk_transmission_transmission_outage_ci_account_id` FOREIGN KEY (`ci_account_id`) REFERENCES `power_and_utilities_v2`.`engagement`.`ci_account`(`ci_account_id`);

-- ========= transmission --> finance (5 constraint(s)) =========
-- Requires: transmission schema, finance schema
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ADD CONSTRAINT `fk_transmission_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ADD CONSTRAINT `fk_transmission_transmission_substation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ADD CONSTRAINT `fk_transmission_transmission_substation_finance_capex_project_id` FOREIGN KEY (`finance_capex_project_id`) REFERENCES `power_and_utilities_v2`.`finance`.`finance_capex_project`(`finance_capex_project_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ADD CONSTRAINT `fk_transmission_transmission_transformer_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `power_and_utilities_v2`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`service_request` ADD CONSTRAINT `fk_transmission_service_request_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);

-- ========= transmission --> gridops (4 constraint(s)) =========
-- Requires: transmission schema, gridops schema
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ADD CONSTRAINT `fk_transmission_line_balancing_area_id` FOREIGN KEY (`balancing_area_id`) REFERENCES `power_and_utilities_v2`.`gridops`.`balancing_area`(`balancing_area_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`topology` ADD CONSTRAINT `fk_transmission_topology_control_zone_id` FOREIGN KEY (`control_zone_id`) REFERENCES `power_and_utilities_v2`.`gridops`.`control_zone`(`control_zone_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ADD CONSTRAINT `fk_transmission_bus_balancing_area_id` FOREIGN KEY (`balancing_area_id`) REFERENCES `power_and_utilities_v2`.`gridops`.`balancing_area`(`balancing_area_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_switching_order` ADD CONSTRAINT `fk_transmission_transmission_switching_order_control_center_id` FOREIGN KEY (`control_center_id`) REFERENCES `power_and_utilities_v2`.`gridops`.`control_center`(`control_center_id`);

-- ========= transmission --> product (3 constraint(s)) =========
-- Requires: transmission schema, product schema
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ADD CONSTRAINT `fk_transmission_line_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `power_and_utilities_v2`.`product`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_outage` ADD CONSTRAINT `fk_transmission_transmission_outage_special_contract_id` FOREIGN KEY (`special_contract_id`) REFERENCES `power_and_utilities_v2`.`product`.`special_contract`(`special_contract_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`service_request` ADD CONSTRAINT `fk_transmission_service_request_service_plan_id` FOREIGN KEY (`service_plan_id`) REFERENCES `power_and_utilities_v2`.`product`.`service_plan`(`service_plan_id`);

-- ========= transmission --> property (6 constraint(s)) =========
-- Requires: transmission schema, property schema
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ADD CONSTRAINT `fk_transmission_transmission_substation_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ADD CONSTRAINT `fk_transmission_transmission_substation_gis_boundary_id` FOREIGN KEY (`gis_boundary_id`) REFERENCES `power_and_utilities_v2`.`property`.`gis_boundary`(`gis_boundary_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ADD CONSTRAINT `fk_transmission_transmission_substation_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `power_and_utilities_v2`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ADD CONSTRAINT `fk_transmission_transmission_substation_site_id` FOREIGN KEY (`site_id`) REFERENCES `power_and_utilities_v2`.`property`.`site`(`site_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_switching_order` ADD CONSTRAINT `fk_transmission_transmission_switching_order_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way_agreement` ADD CONSTRAINT `fk_transmission_right_of_way_agreement_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `power_and_utilities_v2`.`property`.`parcel`(`parcel_id`);

-- ========= transmission --> regulatory (2 constraint(s)) =========
-- Requires: transmission schema, regulatory schema
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ADD CONSTRAINT `fk_transmission_transmission_substation_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_outage` ADD CONSTRAINT `fk_transmission_transmission_outage_violation_notice_id` FOREIGN KEY (`violation_notice_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`violation_notice`(`violation_notice_id`);

-- ========= transmission --> safety (1 constraint(s)) =========
-- Requires: transmission schema, safety schema
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_outage` ADD CONSTRAINT `fk_transmission_transmission_outage_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `power_and_utilities_v2`.`safety`.`incident`(`incident_id`);

-- ========= transmission --> supply (3 constraint(s)) =========
-- Requires: transmission schema, supply schema
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ADD CONSTRAINT `fk_transmission_transmission_transformer_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `power_and_utilities_v2`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_outage` ADD CONSTRAINT `fk_transmission_transmission_outage_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `power_and_utilities_v2`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_outage` ADD CONSTRAINT `fk_transmission_transmission_outage_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);

-- ========= transmission --> technology (8 constraint(s)) =========
-- Requires: transmission schema, technology schema
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ADD CONSTRAINT `fk_transmission_line_scada_system_id` FOREIGN KEY (`scada_system_id`) REFERENCES `power_and_utilities_v2`.`technology`.`scada_system`(`scada_system_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ADD CONSTRAINT `fk_transmission_line_telecom_circuit_id` FOREIGN KEY (`telecom_circuit_id`) REFERENCES `power_and_utilities_v2`.`technology`.`telecom_circuit`(`telecom_circuit_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ADD CONSTRAINT `fk_transmission_transmission_substation_disaster_recovery_plan_id` FOREIGN KEY (`disaster_recovery_plan_id`) REFERENCES `power_and_utilities_v2`.`technology`.`disaster_recovery_plan`(`disaster_recovery_plan_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ADD CONSTRAINT `fk_transmission_transmission_substation_scada_system_id` FOREIGN KEY (`scada_system_id`) REFERENCES `power_and_utilities_v2`.`technology`.`scada_system`(`scada_system_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ADD CONSTRAINT `fk_transmission_transmission_transformer_scada_system_id` FOREIGN KEY (`scada_system_id`) REFERENCES `power_and_utilities_v2`.`technology`.`scada_system`(`scada_system_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_outage` ADD CONSTRAINT `fk_transmission_transmission_outage_incident_ticket_id` FOREIGN KEY (`incident_ticket_id`) REFERENCES `power_and_utilities_v2`.`technology`.`incident_ticket`(`incident_ticket_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ADD CONSTRAINT `fk_transmission_protection_relay_it_asset_id` FOREIGN KEY (`it_asset_id`) REFERENCES `power_and_utilities_v2`.`technology`.`it_asset`(`it_asset_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_switching_order` ADD CONSTRAINT `fk_transmission_transmission_switching_order_change_request_id` FOREIGN KEY (`change_request_id`) REFERENCES `power_and_utilities_v2`.`technology`.`change_request`(`change_request_id`);

-- ========= transmission --> workforce (17 constraint(s)) =========
-- Requires: transmission schema, workforce schema
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ADD CONSTRAINT `fk_transmission_transmission_substation_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_outage` ADD CONSTRAINT `fk_transmission_transmission_outage_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_outage` ADD CONSTRAINT `fk_transmission_transmission_outage_storm_event_id` FOREIGN KEY (`storm_event_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`storm_event`(`storm_event_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency_violation` ADD CONSTRAINT `fk_transmission_contingency_violation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency_violation` ADD CONSTRAINT `fk_transmission_contingency_violation_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ADD CONSTRAINT `fk_transmission_protection_relay_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ADD CONSTRAINT `fk_transmission_relay_test_event_approval_user_employee_id` FOREIGN KEY (`approval_user_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ADD CONSTRAINT `fk_transmission_relay_test_event_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ADD CONSTRAINT `fk_transmission_relay_test_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ADD CONSTRAINT `fk_transmission_relay_test_event_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ADD CONSTRAINT `fk_transmission_relay_test_event_technician_lead_technician_id` FOREIGN KEY (`technician_lead_technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way` ADD CONSTRAINT `fk_transmission_right_of_way_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`vegetation_inspection` ADD CONSTRAINT `fk_transmission_vegetation_inspection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`vegetation_inspection` ADD CONSTRAINT `fk_transmission_vegetation_inspection_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_switching_order` ADD CONSTRAINT `fk_transmission_transmission_switching_order_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_switching_order` ADD CONSTRAINT `fk_transmission_transmission_switching_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_switching_order` ADD CONSTRAINT `fk_transmission_transmission_switching_order_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);

-- ========= workforce --> asset (4 constraint(s)) =========
-- Requires: workforce schema, asset schema
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ADD CONSTRAINT `fk_workforce_work_order_assignment_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `power_and_utilities_v2`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `power_and_utilities_v2`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ADD CONSTRAINT `fk_workforce_storm_assignment_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `power_and_utilities_v2`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`asset_technician_authorization` ADD CONSTRAINT `fk_workforce_asset_technician_authorization_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);

-- ========= workforce --> customer (1 constraint(s)) =========
-- Requires: workforce schema, customer schema
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ADD CONSTRAINT `fk_workforce_schedule_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `power_and_utilities_v2`.`customer`.`service_territory`(`service_territory_id`);

-- ========= workforce --> der (2 constraint(s)) =========
-- Requires: workforce schema, der schema
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ADD CONSTRAINT `fk_workforce_schedule_resource_id` FOREIGN KEY (`resource_id`) REFERENCES `power_and_utilities_v2`.`der`.`resource`(`resource_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_resource_id` FOREIGN KEY (`resource_id`) REFERENCES `power_and_utilities_v2`.`der`.`resource`(`resource_id`);

-- ========= workforce --> distribution (1 constraint(s)) =========
-- Requires: workforce schema, distribution schema
ALTER TABLE `power_and_utilities_v2`.`workforce`.`dispatch_zone` ADD CONSTRAINT `fk_workforce_dispatch_zone_distribution_substation_id` FOREIGN KEY (`distribution_substation_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`distribution_substation`(`distribution_substation_id`);

-- ========= workforce --> finance (12 constraint(s)) =========
-- Requires: workforce schema, finance schema
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ADD CONSTRAINT `fk_workforce_crew_member_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ADD CONSTRAINT `fk_workforce_shift_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ADD CONSTRAINT `fk_workforce_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ADD CONSTRAINT `fk_workforce_schedule_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `power_and_utilities_v2`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `power_and_utilities_v2`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `power_and_utilities_v2`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ADD CONSTRAINT `fk_workforce_absence_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ADD CONSTRAINT `fk_workforce_storm_assignment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ADD CONSTRAINT `fk_workforce_storm_assignment_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `power_and_utilities_v2`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ADD CONSTRAINT `fk_workforce_on_call_rotation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities_v2`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ADD CONSTRAINT `fk_workforce_on_call_rotation_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `power_and_utilities_v2`.`finance`.`wbs_element`(`wbs_element_id`);

-- ========= workforce --> property (9 constraint(s)) =========
-- Requires: workforce schema, property schema
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ADD CONSTRAINT `fk_workforce_technician_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_gis_boundary_id` FOREIGN KEY (`gis_boundary_id`) REFERENCES `power_and_utilities_v2`.`property`.`gis_boundary`(`gis_boundary_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_site_id` FOREIGN KEY (`site_id`) REFERENCES `power_and_utilities_v2`.`property`.`site`(`site_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ADD CONSTRAINT `fk_workforce_shift_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ADD CONSTRAINT `fk_workforce_schedule_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`labor_rate` ADD CONSTRAINT `fk_workforce_labor_rate_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ADD CONSTRAINT `fk_workforce_storm_assignment_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_parcel_impact` ADD CONSTRAINT `fk_workforce_storm_parcel_impact_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `power_and_utilities_v2`.`property`.`parcel`(`parcel_id`);

-- ========= workforce --> supply (2 constraint(s)) =========
-- Requires: workforce schema, supply schema
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ADD CONSTRAINT `fk_workforce_crew_member_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ADD CONSTRAINT `fk_workforce_technician_qualification_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);

-- ========= workforce --> technology (3 constraint(s)) =========
-- Requires: workforce schema, technology schema
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ADD CONSTRAINT `fk_workforce_technician_it_asset_id` FOREIGN KEY (`it_asset_id`) REFERENCES `power_and_utilities_v2`.`technology`.`it_asset`(`it_asset_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ADD CONSTRAINT `fk_workforce_technician_scada_system_id` FOREIGN KEY (`scada_system_id`) REFERENCES `power_and_utilities_v2`.`technology`.`scada_system`(`scada_system_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_tech_project_id` FOREIGN KEY (`tech_project_id`) REFERENCES `power_and_utilities_v2`.`technology`.`tech_project`(`tech_project_id`);

-- ========= workforce --> transmission (1 constraint(s)) =========
-- Requires: workforce schema, transmission schema
ALTER TABLE `power_and_utilities_v2`.`workforce`.`line_crew_assignment` ADD CONSTRAINT `fk_workforce_line_crew_assignment_line_id` FOREIGN KEY (`line_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`line`(`line_id`);

