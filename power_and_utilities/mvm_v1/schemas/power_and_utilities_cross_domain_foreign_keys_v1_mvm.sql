-- Cross-Domain Foreign Keys for Business: Power and Utilities | Version: v1_mvm
-- Generated on: 2026-04-29 23:12:59
-- Total cross-domain FK constraints: 425
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: asset, billing, customer, distribution, finance, generation, market, metering, regulatory, supply, transmission, workforce

-- ========= asset --> customer (6 constraint(s)) =========
-- Requires: asset schema, customer schema
ALTER TABLE `power_and_utilities`.`asset`.`master` ADD CONSTRAINT `fk_asset_master_account_id` FOREIGN KEY (`account_id`) REFERENCES `power_and_utilities`.`customer`.`account`(`account_id`);
ALTER TABLE `power_and_utilities`.`asset`.`master` ADD CONSTRAINT `fk_asset_master_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `power_and_utilities`.`customer`.`premise`(`premise_id`);
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `power_and_utilities`.`customer`.`account`(`account_id`);
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ADD CONSTRAINT `fk_asset_inspection_record_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `power_and_utilities`.`customer`.`premise`(`premise_id`);
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ADD CONSTRAINT `fk_asset_failure_event_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `power_and_utilities`.`customer`.`premise`(`premise_id`);
ALTER TABLE `power_and_utilities`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `power_and_utilities`.`customer`.`premise`(`premise_id`);

-- ========= asset --> distribution (1 constraint(s)) =========
-- Requires: asset schema, distribution schema
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ADD CONSTRAINT `fk_asset_failure_event_distribution_outage_event_id` FOREIGN KEY (`distribution_outage_event_id`) REFERENCES `power_and_utilities`.`distribution`.`distribution_outage_event`(`distribution_outage_event_id`);

-- ========= asset --> finance (6 constraint(s)) =========
-- Requires: asset schema, finance schema
ALTER TABLE `power_and_utilities`.`asset`.`master` ADD CONSTRAINT `fk_asset_master_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `power_and_utilities`.`finance`.`capex_project`(`capex_project_id`);
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities`.`asset`.`warranty` ADD CONSTRAINT `fk_asset_warranty_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `power_and_utilities`.`finance`.`capex_project`(`capex_project_id`);
ALTER TABLE `power_and_utilities`.`asset`.`inspection_crew` ADD CONSTRAINT `fk_asset_inspection_crew_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities`.`finance`.`cost_center`(`cost_center_id`);

-- ========= asset --> generation (1 constraint(s)) =========
-- Requires: asset schema, generation schema
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_generating_unit_id` FOREIGN KEY (`generating_unit_id`) REFERENCES `power_and_utilities`.`generation`.`generating_unit`(`generating_unit_id`);

-- ========= asset --> market (3 constraint(s)) =========
-- Requires: asset schema, market schema
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_ppa_contract_id` FOREIGN KEY (`ppa_contract_id`) REFERENCES `power_and_utilities`.`market`.`ppa_contract`(`ppa_contract_id`);
ALTER TABLE `power_and_utilities`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_ppa_contract_id` FOREIGN KEY (`ppa_contract_id`) REFERENCES `power_and_utilities`.`market`.`ppa_contract`(`ppa_contract_id`);
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ADD CONSTRAINT `fk_asset_failure_event_ppa_contract_id` FOREIGN KEY (`ppa_contract_id`) REFERENCES `power_and_utilities`.`market`.`ppa_contract`(`ppa_contract_id`);

-- ========= asset --> metering (1 constraint(s)) =========
-- Requires: asset schema, metering schema
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ADD CONSTRAINT `fk_asset_failure_event_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `power_and_utilities`.`metering`.`meter`(`meter_id`);

-- ========= asset --> regulatory (3 constraint(s)) =========
-- Requires: asset schema, regulatory schema
ALTER TABLE `power_and_utilities`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `power_and_utilities`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ADD CONSTRAINT `fk_asset_inspection_record_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `power_and_utilities`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ADD CONSTRAINT `fk_asset_failure_event_compliance_event_id` FOREIGN KEY (`compliance_event_id`) REFERENCES `power_and_utilities`.`regulatory`.`compliance_event`(`compliance_event_id`);

-- ========= asset --> supply (4 constraint(s)) =========
-- Requires: asset schema, supply schema
ALTER TABLE `power_and_utilities`.`asset`.`work_order_material` ADD CONSTRAINT `fk_asset_work_order_material_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `power_and_utilities`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `power_and_utilities`.`asset`.`warranty` ADD CONSTRAINT `fk_asset_warranty_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `power_and_utilities`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `power_and_utilities`.`asset`.`warranty` ADD CONSTRAINT `fk_asset_warranty_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities`.`asset`.`inspector` ADD CONSTRAINT `fk_asset_inspector_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities`.`supply`.`vendor`(`vendor_id`);

-- ========= asset --> workforce (2 constraint(s)) =========
-- Requires: asset schema, workforce schema
ALTER TABLE `power_and_utilities`.`asset`.`inspector` ADD CONSTRAINT `fk_asset_inspector_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities`.`asset`.`inspection_crew` ADD CONSTRAINT `fk_asset_inspection_crew_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities`.`workforce`.`employee`(`employee_id`);

-- ========= billing --> customer (10 constraint(s)) =========
-- Requires: billing schema, customer schema
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_account_id` FOREIGN KEY (`account_id`) REFERENCES `power_and_utilities`.`customer`.`account`(`account_id`);
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_customer_service_agreement_id` FOREIGN KEY (`customer_service_agreement_id`) REFERENCES `power_and_utilities`.`customer`.`customer_service_agreement`(`customer_service_agreement_id`);
ALTER TABLE `power_and_utilities`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_account_id` FOREIGN KEY (`account_id`) REFERENCES `power_and_utilities`.`customer`.`account`(`account_id`);
ALTER TABLE `power_and_utilities`.`billing`.`payment_arrangement` ADD CONSTRAINT `fk_billing_payment_arrangement_account_id` FOREIGN KEY (`account_id`) REFERENCES `power_and_utilities`.`customer`.`account`(`account_id`);
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ADD CONSTRAINT `fk_billing_collections_case_account_id` FOREIGN KEY (`account_id`) REFERENCES `power_and_utilities`.`customer`.`account`(`account_id`);
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ADD CONSTRAINT `fk_billing_collections_case_party_id` FOREIGN KEY (`party_id`) REFERENCES `power_and_utilities`.`customer`.`party`(`party_id`);
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ADD CONSTRAINT `fk_billing_bill_dispute_account_id` FOREIGN KEY (`account_id`) REFERENCES `power_and_utilities`.`customer`.`account`(`account_id`);
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ADD CONSTRAINT `fk_billing_credit_adjustment_account_id` FOREIGN KEY (`account_id`) REFERENCES `power_and_utilities`.`customer`.`account`(`account_id`);
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ADD CONSTRAINT `fk_billing_billing_service_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `power_and_utilities`.`customer`.`account`(`account_id`);
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ADD CONSTRAINT `fk_billing_billing_service_agreement_party_id` FOREIGN KEY (`party_id`) REFERENCES `power_and_utilities`.`customer`.`party`(`party_id`);

-- ========= billing --> distribution (3 constraint(s)) =========
-- Requires: billing schema, distribution schema
ALTER TABLE `power_and_utilities`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_service_point_id` FOREIGN KEY (`service_point_id`) REFERENCES `power_and_utilities`.`distribution`.`service_point`(`service_point_id`);
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ADD CONSTRAINT `fk_billing_credit_adjustment_distribution_outage_event_id` FOREIGN KEY (`distribution_outage_event_id`) REFERENCES `power_and_utilities`.`distribution`.`distribution_outage_event`(`distribution_outage_event_id`);
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ADD CONSTRAINT `fk_billing_billing_service_agreement_service_point_id` FOREIGN KEY (`service_point_id`) REFERENCES `power_and_utilities`.`distribution`.`service_point`(`service_point_id`);

-- ========= billing --> finance (4 constraint(s)) =========
-- Requires: billing schema, finance schema
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` ADD CONSTRAINT `fk_billing_rate_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `power_and_utilities`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ADD CONSTRAINT `fk_billing_collections_case_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `power_and_utilities`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ADD CONSTRAINT `fk_billing_billing_service_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities`.`finance`.`cost_center`(`cost_center_id`);

-- ========= billing --> market (4 constraint(s)) =========
-- Requires: billing schema, market schema
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` ADD CONSTRAINT `fk_billing_rate_schedule_ppa_contract_id` FOREIGN KEY (`ppa_contract_id`) REFERENCES `power_and_utilities`.`market`.`ppa_contract`(`ppa_contract_id`);
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` ADD CONSTRAINT `fk_billing_rate_schedule_pricing_node_id` FOREIGN KEY (`pricing_node_id`) REFERENCES `power_and_utilities`.`market`.`pricing_node`(`pricing_node_id`);
ALTER TABLE `power_and_utilities`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_ppa_contract_id` FOREIGN KEY (`ppa_contract_id`) REFERENCES `power_and_utilities`.`market`.`ppa_contract`(`ppa_contract_id`);
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ADD CONSTRAINT `fk_billing_credit_adjustment_settlement_statement_id` FOREIGN KEY (`settlement_statement_id`) REFERENCES `power_and_utilities`.`market`.`settlement_statement`(`settlement_statement_id`);

-- ========= billing --> metering (2 constraint(s)) =========
-- Requires: billing schema, metering schema
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `power_and_utilities`.`metering`.`meter`(`meter_id`);
ALTER TABLE `power_and_utilities`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `power_and_utilities`.`metering`.`meter`(`meter_id`);

-- ========= billing --> regulatory (7 constraint(s)) =========
-- Requires: billing schema, regulatory schema
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` ADD CONSTRAINT `fk_billing_rate_schedule_tariff_schedule_id` FOREIGN KEY (`tariff_schedule_id`) REFERENCES `power_and_utilities`.`regulatory`.`tariff_schedule`(`tariff_schedule_id`);
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_rate_case_id` FOREIGN KEY (`rate_case_id`) REFERENCES `power_and_utilities`.`regulatory`.`rate_case`(`rate_case_id`);
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ADD CONSTRAINT `fk_billing_collections_case_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `power_and_utilities`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ADD CONSTRAINT `fk_billing_bill_dispute_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `power_and_utilities`.`regulatory`.`docket`(`docket_id`);
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ADD CONSTRAINT `fk_billing_credit_adjustment_commission_order_id` FOREIGN KEY (`commission_order_id`) REFERENCES `power_and_utilities`.`regulatory`.`commission_order`(`commission_order_id`);
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ADD CONSTRAINT `fk_billing_billing_service_agreement_tariff_schedule_id` FOREIGN KEY (`tariff_schedule_id`) REFERENCES `power_and_utilities`.`regulatory`.`tariff_schedule`(`tariff_schedule_id`);
ALTER TABLE `power_and_utilities`.`billing`.`bill_cycle` ADD CONSTRAINT `fk_billing_bill_cycle_tariff_schedule_id` FOREIGN KEY (`tariff_schedule_id`) REFERENCES `power_and_utilities`.`regulatory`.`tariff_schedule`(`tariff_schedule_id`);

-- ========= customer --> asset (1 constraint(s)) =========
-- Requires: customer schema, asset schema
ALTER TABLE `power_and_utilities`.`customer`.`move_order` ADD CONSTRAINT `fk_customer_move_order_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `power_and_utilities`.`asset`.`work_order`(`work_order_id`);

-- ========= customer --> billing (2 constraint(s)) =========
-- Requires: customer schema, billing schema
ALTER TABLE `power_and_utilities`.`customer`.`credit_deposit` ADD CONSTRAINT `fk_customer_credit_deposit_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `power_and_utilities`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `power_and_utilities`.`customer`.`credit_deposit` ADD CONSTRAINT `fk_customer_credit_deposit_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `power_and_utilities`.`billing`.`payment`(`payment_id`);

-- ========= customer --> distribution (3 constraint(s)) =========
-- Requires: customer schema, distribution schema
ALTER TABLE `power_and_utilities`.`customer`.`customer_service_agreement` ADD CONSTRAINT `fk_customer_customer_service_agreement_service_point_id` FOREIGN KEY (`service_point_id`) REFERENCES `power_and_utilities`.`distribution`.`service_point`(`service_point_id`);
ALTER TABLE `power_and_utilities`.`customer`.`move_order` ADD CONSTRAINT `fk_customer_move_order_service_point_id` FOREIGN KEY (`service_point_id`) REFERENCES `power_and_utilities`.`distribution`.`service_point`(`service_point_id`);
ALTER TABLE `power_and_utilities`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_distribution_outage_event_id` FOREIGN KEY (`distribution_outage_event_id`) REFERENCES `power_and_utilities`.`distribution`.`distribution_outage_event`(`distribution_outage_event_id`);

-- ========= customer --> finance (6 constraint(s)) =========
-- Requires: customer schema, finance schema
ALTER TABLE `power_and_utilities`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities`.`customer`.`premise` ADD CONSTRAINT `fk_customer_premise_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities`.`customer`.`customer_service_agreement` ADD CONSTRAINT `fk_customer_customer_service_agreement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `power_and_utilities`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `power_and_utilities`.`customer`.`enrollment` ADD CONSTRAINT `fk_customer_enrollment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities`.`customer`.`credit_deposit` ADD CONSTRAINT `fk_customer_credit_deposit_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `power_and_utilities`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `power_and_utilities`.`customer`.`credit_deposit` ADD CONSTRAINT `fk_customer_credit_deposit_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `power_and_utilities`.`finance`.`journal_entry`(`journal_entry_id`);

-- ========= customer --> regulatory (4 constraint(s)) =========
-- Requires: customer schema, regulatory schema
ALTER TABLE `power_and_utilities`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_tariff_schedule_id` FOREIGN KEY (`tariff_schedule_id`) REFERENCES `power_and_utilities`.`regulatory`.`tariff_schedule`(`tariff_schedule_id`);
ALTER TABLE `power_and_utilities`.`customer`.`customer_service_agreement` ADD CONSTRAINT `fk_customer_customer_service_agreement_tariff_schedule_id` FOREIGN KEY (`tariff_schedule_id`) REFERENCES `power_and_utilities`.`regulatory`.`tariff_schedule`(`tariff_schedule_id`);
ALTER TABLE `power_and_utilities`.`customer`.`enrollment` ADD CONSTRAINT `fk_customer_enrollment_tariff_schedule_id` FOREIGN KEY (`tariff_schedule_id`) REFERENCES `power_and_utilities`.`regulatory`.`tariff_schedule`(`tariff_schedule_id`);
ALTER TABLE `power_and_utilities`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `power_and_utilities`.`regulatory`.`docket`(`docket_id`);

-- ========= distribution --> asset (10 constraint(s)) =========
-- Requires: distribution schema, asset schema
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ADD CONSTRAINT `fk_distribution_service_transformer_master_id` FOREIGN KEY (`master_id`) REFERENCES `power_and_utilities`.`asset`.`master`(`master_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ADD CONSTRAINT `fk_distribution_distribution_substation_master_id` FOREIGN KEY (`master_id`) REFERENCES `power_and_utilities`.`asset`.`master`(`master_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ADD CONSTRAINT `fk_distribution_gas_main_master_id` FOREIGN KEY (`master_id`) REFERENCES `power_and_utilities`.`asset`.`master`(`master_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ADD CONSTRAINT `fk_distribution_distribution_outage_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `power_and_utilities`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ADD CONSTRAINT `fk_distribution_der_interconnection_master_id` FOREIGN KEY (`master_id`) REFERENCES `power_and_utilities`.`asset`.`master`(`master_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ADD CONSTRAINT `fk_distribution_gas_leak_survey_repair_work_order_id` FOREIGN KEY (`repair_work_order_id`) REFERENCES `power_and_utilities`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ADD CONSTRAINT `fk_distribution_gas_leak_survey_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `power_and_utilities`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ADD CONSTRAINT `fk_distribution_pole_master_id` FOREIGN KEY (`master_id`) REFERENCES `power_and_utilities`.`asset`.`master`(`master_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ADD CONSTRAINT `fk_distribution_gas_service_lateral_master_id` FOREIGN KEY (`master_id`) REFERENCES `power_and_utilities`.`asset`.`master`(`master_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`crew_dispatch` ADD CONSTRAINT `fk_distribution_crew_dispatch_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `power_and_utilities`.`asset`.`work_order`(`work_order_id`);

-- ========= distribution --> customer (4 constraint(s)) =========
-- Requires: distribution schema, customer schema
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ADD CONSTRAINT `fk_distribution_service_point_account_id` FOREIGN KEY (`account_id`) REFERENCES `power_and_utilities`.`customer`.`account`(`account_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ADD CONSTRAINT `fk_distribution_service_point_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `power_and_utilities`.`customer`.`premise`(`premise_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ADD CONSTRAINT `fk_distribution_der_interconnection_account_id` FOREIGN KEY (`account_id`) REFERENCES `power_and_utilities`.`customer`.`account`(`account_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`crew_dispatch` ADD CONSTRAINT `fk_distribution_crew_dispatch_account_id` FOREIGN KEY (`account_id`) REFERENCES `power_and_utilities`.`customer`.`account`(`account_id`);

-- ========= distribution --> finance (24 constraint(s)) =========
-- Requires: distribution schema, finance schema
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ADD CONSTRAINT `fk_distribution_feeder_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `power_and_utilities`.`finance`.`capex_project`(`capex_project_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ADD CONSTRAINT `fk_distribution_feeder_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ADD CONSTRAINT `fk_distribution_feeder_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `power_and_utilities`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ADD CONSTRAINT `fk_distribution_service_transformer_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ADD CONSTRAINT `fk_distribution_service_transformer_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `power_and_utilities`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ADD CONSTRAINT `fk_distribution_distribution_substation_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `power_and_utilities`.`finance`.`capex_project`(`capex_project_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ADD CONSTRAINT `fk_distribution_distribution_substation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ADD CONSTRAINT `fk_distribution_distribution_substation_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `power_and_utilities`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ADD CONSTRAINT `fk_distribution_gas_main_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `power_and_utilities`.`finance`.`capex_project`(`capex_project_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ADD CONSTRAINT `fk_distribution_gas_main_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ADD CONSTRAINT `fk_distribution_gas_main_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `power_and_utilities`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ADD CONSTRAINT `fk_distribution_distribution_outage_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ADD CONSTRAINT `fk_distribution_distribution_outage_event_opex_transaction_id` FOREIGN KEY (`opex_transaction_id`) REFERENCES `power_and_utilities`.`finance`.`opex_transaction`(`opex_transaction_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ADD CONSTRAINT `fk_distribution_reliability_index_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ADD CONSTRAINT `fk_distribution_voltage_regulation_device_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `power_and_utilities`.`finance`.`capex_project`(`capex_project_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ADD CONSTRAINT `fk_distribution_voltage_regulation_device_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ADD CONSTRAINT `fk_distribution_voltage_regulation_device_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `power_and_utilities`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ADD CONSTRAINT `fk_distribution_gas_leak_survey_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ADD CONSTRAINT `fk_distribution_gas_leak_survey_opex_transaction_id` FOREIGN KEY (`opex_transaction_id`) REFERENCES `power_and_utilities`.`finance`.`opex_transaction`(`opex_transaction_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`demand_response_event` ADD CONSTRAINT `fk_distribution_demand_response_event_opex_transaction_id` FOREIGN KEY (`opex_transaction_id`) REFERENCES `power_and_utilities`.`finance`.`opex_transaction`(`opex_transaction_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ADD CONSTRAINT `fk_distribution_pole_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ADD CONSTRAINT `fk_distribution_pole_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `power_and_utilities`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ADD CONSTRAINT `fk_distribution_gas_service_lateral_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ADD CONSTRAINT `fk_distribution_gas_service_lateral_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `power_and_utilities`.`finance`.`fixed_asset`(`fixed_asset_id`);

-- ========= distribution --> market (6 constraint(s)) =========
-- Requires: distribution schema, market schema
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ADD CONSTRAINT `fk_distribution_feeder_pricing_node_id` FOREIGN KEY (`pricing_node_id`) REFERENCES `power_and_utilities`.`market`.`pricing_node`(`pricing_node_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ADD CONSTRAINT `fk_distribution_distribution_substation_pricing_node_id` FOREIGN KEY (`pricing_node_id`) REFERENCES `power_and_utilities`.`market`.`pricing_node`(`pricing_node_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ADD CONSTRAINT `fk_distribution_service_point_pricing_node_id` FOREIGN KEY (`pricing_node_id`) REFERENCES `power_and_utilities`.`market`.`pricing_node`(`pricing_node_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ADD CONSTRAINT `fk_distribution_der_interconnection_participant_registration_id` FOREIGN KEY (`participant_registration_id`) REFERENCES `power_and_utilities`.`market`.`participant_registration`(`participant_registration_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ADD CONSTRAINT `fk_distribution_der_interconnection_ppa_contract_id` FOREIGN KEY (`ppa_contract_id`) REFERENCES `power_and_utilities`.`market`.`ppa_contract`(`ppa_contract_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ADD CONSTRAINT `fk_distribution_load_profile_pricing_node_id` FOREIGN KEY (`pricing_node_id`) REFERENCES `power_and_utilities`.`market`.`pricing_node`(`pricing_node_id`);

-- ========= distribution --> metering (1 constraint(s)) =========
-- Requires: distribution schema, metering schema
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ADD CONSTRAINT `fk_distribution_service_point_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `power_and_utilities`.`metering`.`meter`(`meter_id`);

-- ========= distribution --> regulatory (14 constraint(s)) =========
-- Requires: distribution schema, regulatory schema
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ADD CONSTRAINT `fk_distribution_feeder_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `power_and_utilities`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ADD CONSTRAINT `fk_distribution_feeder_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `power_and_utilities`.`regulatory`.`docket`(`docket_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ADD CONSTRAINT `fk_distribution_service_transformer_rate_case_id` FOREIGN KEY (`rate_case_id`) REFERENCES `power_and_utilities`.`regulatory`.`rate_case`(`rate_case_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ADD CONSTRAINT `fk_distribution_distribution_substation_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `power_and_utilities`.`regulatory`.`docket`(`docket_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ADD CONSTRAINT `fk_distribution_service_point_tariff_schedule_id` FOREIGN KEY (`tariff_schedule_id`) REFERENCES `power_and_utilities`.`regulatory`.`tariff_schedule`(`tariff_schedule_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ADD CONSTRAINT `fk_distribution_gas_main_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `power_and_utilities`.`regulatory`.`docket`(`docket_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ADD CONSTRAINT `fk_distribution_distribution_outage_event_compliance_event_id` FOREIGN KEY (`compliance_event_id`) REFERENCES `power_and_utilities`.`regulatory`.`compliance_event`(`compliance_event_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ADD CONSTRAINT `fk_distribution_distribution_outage_event_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `power_and_utilities`.`regulatory`.`docket`(`docket_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ADD CONSTRAINT `fk_distribution_reliability_index_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `power_and_utilities`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ADD CONSTRAINT `fk_distribution_der_interconnection_cpcn_application_id` FOREIGN KEY (`cpcn_application_id`) REFERENCES `power_and_utilities`.`regulatory`.`cpcn_application`(`cpcn_application_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ADD CONSTRAINT `fk_distribution_der_interconnection_tariff_schedule_id` FOREIGN KEY (`tariff_schedule_id`) REFERENCES `power_and_utilities`.`regulatory`.`tariff_schedule`(`tariff_schedule_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ADD CONSTRAINT `fk_distribution_gas_leak_survey_compliance_event_id` FOREIGN KEY (`compliance_event_id`) REFERENCES `power_and_utilities`.`regulatory`.`compliance_event`(`compliance_event_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ADD CONSTRAINT `fk_distribution_gas_leak_survey_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `power_and_utilities`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ADD CONSTRAINT `fk_distribution_pole_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `power_and_utilities`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);

-- ========= distribution --> supply (7 constraint(s)) =========
-- Requires: distribution schema, supply schema
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ADD CONSTRAINT `fk_distribution_feeder_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `power_and_utilities`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ADD CONSTRAINT `fk_distribution_service_transformer_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `power_and_utilities`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ADD CONSTRAINT `fk_distribution_service_point_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `power_and_utilities`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ADD CONSTRAINT `fk_distribution_gas_main_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `power_and_utilities`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ADD CONSTRAINT `fk_distribution_voltage_regulation_device_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `power_and_utilities`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ADD CONSTRAINT `fk_distribution_pole_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `power_and_utilities`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ADD CONSTRAINT `fk_distribution_gas_service_lateral_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `power_and_utilities`.`supply`.`material_master`(`material_master_id`);

-- ========= distribution --> transmission (4 constraint(s)) =========
-- Requires: distribution schema, transmission schema
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ADD CONSTRAINT `fk_distribution_der_interconnection_transformer_id` FOREIGN KEY (`transformer_id`) REFERENCES `power_and_utilities`.`transmission`.`transformer`(`transformer_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ADD CONSTRAINT `fk_distribution_load_profile_transformer_id` FOREIGN KEY (`transformer_id`) REFERENCES `power_and_utilities`.`transmission`.`transformer`(`transformer_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`city_gate_station` ADD CONSTRAINT `fk_distribution_city_gate_station_operator_id` FOREIGN KEY (`operator_id`) REFERENCES `power_and_utilities`.`transmission`.`operator`(`operator_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`crew_dispatch` ADD CONSTRAINT `fk_distribution_crew_dispatch_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `power_and_utilities`.`transmission`.`crew`(`crew_id`);

-- ========= finance --> asset (7 constraint(s)) =========
-- Requires: finance schema, asset schema
ALTER TABLE `power_and_utilities`.`finance`.`capex_project` ADD CONSTRAINT `fk_finance_capex_project_location_id` FOREIGN KEY (`location_id`) REFERENCES `power_and_utilities`.`asset`.`location`(`location_id`);
ALTER TABLE `power_and_utilities`.`finance`.`capex_expenditure` ADD CONSTRAINT `fk_finance_capex_expenditure_master_id` FOREIGN KEY (`master_id`) REFERENCES `power_and_utilities`.`asset`.`master`(`master_id`);
ALTER TABLE `power_and_utilities`.`finance`.`capex_expenditure` ADD CONSTRAINT `fk_finance_capex_expenditure_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `power_and_utilities`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `power_and_utilities`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_master_id` FOREIGN KEY (`master_id`) REFERENCES `power_and_utilities`.`asset`.`master`(`master_id`);
ALTER TABLE `power_and_utilities`.`finance`.`opex_transaction` ADD CONSTRAINT `fk_finance_opex_transaction_master_id` FOREIGN KEY (`master_id`) REFERENCES `power_and_utilities`.`asset`.`master`(`master_id`);
ALTER TABLE `power_and_utilities`.`finance`.`opex_transaction` ADD CONSTRAINT `fk_finance_opex_transaction_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `power_and_utilities`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `power_and_utilities`.`finance`.`regulatory_asset_entry` ADD CONSTRAINT `fk_finance_regulatory_asset_entry_master_id` FOREIGN KEY (`master_id`) REFERENCES `power_and_utilities`.`asset`.`master`(`master_id`);

-- ========= finance --> regulatory (5 constraint(s)) =========
-- Requires: finance schema, regulatory schema
ALTER TABLE `power_and_utilities`.`finance`.`capex_project` ADD CONSTRAINT `fk_finance_capex_project_rate_case_id` FOREIGN KEY (`rate_case_id`) REFERENCES `power_and_utilities`.`regulatory`.`rate_case`(`rate_case_id`);
ALTER TABLE `power_and_utilities`.`finance`.`rate_case_cost_study` ADD CONSTRAINT `fk_finance_rate_case_cost_study_rate_case_id` FOREIGN KEY (`rate_case_id`) REFERENCES `power_and_utilities`.`regulatory`.`rate_case`(`rate_case_id`);
ALTER TABLE `power_and_utilities`.`finance`.`tax_provision` ADD CONSTRAINT `fk_finance_tax_provision_rate_case_id` FOREIGN KEY (`rate_case_id`) REFERENCES `power_and_utilities`.`regulatory`.`rate_case`(`rate_case_id`);
ALTER TABLE `power_and_utilities`.`finance`.`regulatory_deferral` ADD CONSTRAINT `fk_finance_regulatory_deferral_rate_case_id` FOREIGN KEY (`rate_case_id`) REFERENCES `power_and_utilities`.`regulatory`.`rate_case`(`rate_case_id`);
ALTER TABLE `power_and_utilities`.`finance`.`regulatory_asset_entry` ADD CONSTRAINT `fk_finance_regulatory_asset_entry_rate_case_id` FOREIGN KEY (`rate_case_id`) REFERENCES `power_and_utilities`.`regulatory`.`rate_case`(`rate_case_id`);

-- ========= finance --> supply (6 constraint(s)) =========
-- Requires: finance schema, supply schema
ALTER TABLE `power_and_utilities`.`finance`.`capex_expenditure` ADD CONSTRAINT `fk_finance_capex_expenditure_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `power_and_utilities`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `power_and_utilities`.`finance`.`capex_expenditure` ADD CONSTRAINT `fk_finance_capex_expenditure_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `power_and_utilities`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `power_and_utilities`.`finance`.`capex_expenditure` ADD CONSTRAINT `fk_finance_capex_expenditure_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities`.`finance`.`opex_transaction` ADD CONSTRAINT `fk_finance_opex_transaction_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `power_and_utilities`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `power_and_utilities`.`finance`.`opex_transaction` ADD CONSTRAINT `fk_finance_opex_transaction_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities`.`supply`.`vendor`(`vendor_id`);

-- ========= generation --> asset (2 constraint(s)) =========
-- Requires: generation schema, asset schema
ALTER TABLE `power_and_utilities`.`generation`.`plant` ADD CONSTRAINT `fk_generation_plant_master_id` FOREIGN KEY (`master_id`) REFERENCES `power_and_utilities`.`asset`.`master`(`master_id`);
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ADD CONSTRAINT `fk_generation_generating_unit_master_id` FOREIGN KEY (`master_id`) REFERENCES `power_and_utilities`.`asset`.`master`(`master_id`);

-- ========= generation --> finance (6 constraint(s)) =========
-- Requires: generation schema, finance schema
ALTER TABLE `power_and_utilities`.`generation`.`plant` ADD CONSTRAINT `fk_generation_plant_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ADD CONSTRAINT `fk_generation_generating_unit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ADD CONSTRAINT `fk_generation_fuel_consumption_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `power_and_utilities`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ADD CONSTRAINT `fk_generation_emissions_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities`.`generation`.`capacity_resource` ADD CONSTRAINT `fk_generation_capacity_resource_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `power_and_utilities`.`finance`.`capex_project`(`capex_project_id`);
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ADD CONSTRAINT `fk_generation_environmental_permit_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `power_and_utilities`.`finance`.`capex_project`(`capex_project_id`);

-- ========= generation --> market (5 constraint(s)) =========
-- Requires: generation schema, market schema
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` ADD CONSTRAINT `fk_generation_dispatch_schedule_ppa_contract_id` FOREIGN KEY (`ppa_contract_id`) REFERENCES `power_and_utilities`.`market`.`ppa_contract`(`ppa_contract_id`);
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` ADD CONSTRAINT `fk_generation_dispatch_schedule_pricing_node_id` FOREIGN KEY (`pricing_node_id`) REFERENCES `power_and_utilities`.`market`.`pricing_node`(`pricing_node_id`);
ALTER TABLE `power_and_utilities`.`generation`.`unit_output` ADD CONSTRAINT `fk_generation_unit_output_ppa_contract_id` FOREIGN KEY (`ppa_contract_id`) REFERENCES `power_and_utilities`.`market`.`ppa_contract`(`ppa_contract_id`);
ALTER TABLE `power_and_utilities`.`generation`.`capacity_resource` ADD CONSTRAINT `fk_generation_capacity_resource_ppa_contract_id` FOREIGN KEY (`ppa_contract_id`) REFERENCES `power_and_utilities`.`market`.`ppa_contract`(`ppa_contract_id`);
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ADD CONSTRAINT `fk_generation_fuel_contract_wholesale_counterparty_id` FOREIGN KEY (`wholesale_counterparty_id`) REFERENCES `power_and_utilities`.`market`.`wholesale_counterparty`(`wholesale_counterparty_id`);

-- ========= generation --> regulatory (7 constraint(s)) =========
-- Requires: generation schema, regulatory schema
ALTER TABLE `power_and_utilities`.`generation`.`plant` ADD CONSTRAINT `fk_generation_plant_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `power_and_utilities`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `power_and_utilities`.`generation`.`plant` ADD CONSTRAINT `fk_generation_plant_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `power_and_utilities`.`regulatory`.`docket`(`docket_id`);
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ADD CONSTRAINT `fk_generation_generating_unit_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `power_and_utilities`.`regulatory`.`docket`(`docket_id`);
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` ADD CONSTRAINT `fk_generation_generation_outage_event_compliance_event_id` FOREIGN KEY (`compliance_event_id`) REFERENCES `power_and_utilities`.`regulatory`.`compliance_event`(`compliance_event_id`);
ALTER TABLE `power_and_utilities`.`generation`.`capacity_resource` ADD CONSTRAINT `fk_generation_capacity_resource_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `power_and_utilities`.`regulatory`.`docket`(`docket_id`);
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ADD CONSTRAINT `fk_generation_fuel_contract_prudency_review_id` FOREIGN KEY (`prudency_review_id`) REFERENCES `power_and_utilities`.`regulatory`.`prudency_review`(`prudency_review_id`);
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ADD CONSTRAINT `fk_generation_environmental_permit_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `power_and_utilities`.`regulatory`.`docket`(`docket_id`);

-- ========= generation --> supply (5 constraint(s)) =========
-- Requires: generation schema, supply schema
ALTER TABLE `power_and_utilities`.`generation`.`fuel_inventory` ADD CONSTRAINT `fk_generation_fuel_inventory_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `power_and_utilities`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ADD CONSTRAINT `fk_generation_fuel_consumption_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `power_and_utilities`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ADD CONSTRAINT `fk_generation_fuel_consumption_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `power_and_utilities`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ADD CONSTRAINT `fk_generation_fuel_consumption_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ADD CONSTRAINT `fk_generation_fuel_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities`.`supply`.`vendor`(`vendor_id`);

-- ========= generation --> transmission (4 constraint(s)) =========
-- Requires: generation schema, transmission schema
ALTER TABLE `power_and_utilities`.`generation`.`plant` ADD CONSTRAINT `fk_generation_plant_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `power_and_utilities`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ADD CONSTRAINT `fk_generation_generating_unit_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `power_and_utilities`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` ADD CONSTRAINT `fk_generation_dispatch_schedule_grid_topology_id` FOREIGN KEY (`grid_topology_id`) REFERENCES `power_and_utilities`.`transmission`.`grid_topology`(`grid_topology_id`);
ALTER TABLE `power_and_utilities`.`generation`.`capacity_resource` ADD CONSTRAINT `fk_generation_capacity_resource_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `power_and_utilities`.`transmission`.`transmission_substation`(`transmission_substation_id`);

-- ========= market --> asset (6 constraint(s)) =========
-- Requires: market schema, asset schema
ALTER TABLE `power_and_utilities`.`market`.`capacity_obligation` ADD CONSTRAINT `fk_market_capacity_obligation_master_id` FOREIGN KEY (`master_id`) REFERENCES `power_and_utilities`.`asset`.`master`(`master_id`);
ALTER TABLE `power_and_utilities`.`market`.`energy_bid` ADD CONSTRAINT `fk_market_energy_bid_master_id` FOREIGN KEY (`master_id`) REFERENCES `power_and_utilities`.`asset`.`master`(`master_id`);
ALTER TABLE `power_and_utilities`.`market`.`dispatch_award` ADD CONSTRAINT `fk_market_dispatch_award_master_id` FOREIGN KEY (`master_id`) REFERENCES `power_and_utilities`.`asset`.`master`(`master_id`);
ALTER TABLE `power_and_utilities`.`market`.`ancillary_service_award` ADD CONSTRAINT `fk_market_ancillary_service_award_master_id` FOREIGN KEY (`master_id`) REFERENCES `power_and_utilities`.`asset`.`master`(`master_id`);
ALTER TABLE `power_and_utilities`.`market`.`rec_inventory` ADD CONSTRAINT `fk_market_rec_inventory_master_id` FOREIGN KEY (`master_id`) REFERENCES `power_and_utilities`.`asset`.`master`(`master_id`);
ALTER TABLE `power_and_utilities`.`market`.`pricing_node` ADD CONSTRAINT `fk_market_pricing_node_location_id` FOREIGN KEY (`location_id`) REFERENCES `power_and_utilities`.`asset`.`location`(`location_id`);

-- ========= market --> customer (1 constraint(s)) =========
-- Requires: market schema, customer schema
ALTER TABLE `power_and_utilities`.`market`.`rec_transaction` ADD CONSTRAINT `fk_market_rec_transaction_account_id` FOREIGN KEY (`account_id`) REFERENCES `power_and_utilities`.`customer`.`account`(`account_id`);

-- ========= market --> finance (16 constraint(s)) =========
-- Requires: market schema, finance schema
ALTER TABLE `power_and_utilities`.`market`.`wholesale_counterparty` ADD CONSTRAINT `fk_market_wholesale_counterparty_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities`.`market`.`ppa_contract` ADD CONSTRAINT `fk_market_ppa_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities`.`market`.`ppa_contract` ADD CONSTRAINT `fk_market_ppa_contract_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `power_and_utilities`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `power_and_utilities`.`market`.`capacity_obligation` ADD CONSTRAINT `fk_market_capacity_obligation_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `power_and_utilities`.`finance`.`capex_project`(`capex_project_id`);
ALTER TABLE `power_and_utilities`.`market`.`energy_bid` ADD CONSTRAINT `fk_market_energy_bid_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities`.`market`.`dispatch_award` ADD CONSTRAINT `fk_market_dispatch_award_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities`.`market`.`settlement_statement` ADD CONSTRAINT `fk_market_settlement_statement_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `power_and_utilities`.`finance`.`capex_project`(`capex_project_id`);
ALTER TABLE `power_and_utilities`.`market`.`settlement_statement` ADD CONSTRAINT `fk_market_settlement_statement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities`.`market`.`settlement_statement` ADD CONSTRAINT `fk_market_settlement_statement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `power_and_utilities`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `power_and_utilities`.`market`.`rec_transaction` ADD CONSTRAINT `fk_market_rec_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities`.`market`.`rec_transaction` ADD CONSTRAINT `fk_market_rec_transaction_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `power_and_utilities`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `power_and_utilities`.`market`.`transmission_right` ADD CONSTRAINT `fk_market_transmission_right_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `power_and_utilities`.`finance`.`capex_project`(`capex_project_id`);
ALTER TABLE `power_and_utilities`.`market`.`transmission_right` ADD CONSTRAINT `fk_market_transmission_right_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities`.`market`.`settlement_line_item` ADD CONSTRAINT `fk_market_settlement_line_item_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities`.`market`.`settlement_line_item` ADD CONSTRAINT `fk_market_settlement_line_item_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `power_and_utilities`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `power_and_utilities`.`market`.`transmission_rights_portfolio` ADD CONSTRAINT `fk_market_transmission_rights_portfolio_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities`.`finance`.`cost_center`(`cost_center_id`);

-- ========= market --> generation (10 constraint(s)) =========
-- Requires: market schema, generation schema
ALTER TABLE `power_and_utilities`.`market`.`ppa_contract` ADD CONSTRAINT `fk_market_ppa_contract_generating_unit_id` FOREIGN KEY (`generating_unit_id`) REFERENCES `power_and_utilities`.`generation`.`generating_unit`(`generating_unit_id`);
ALTER TABLE `power_and_utilities`.`market`.`capacity_obligation` ADD CONSTRAINT `fk_market_capacity_obligation_capacity_resource_id` FOREIGN KEY (`capacity_resource_id`) REFERENCES `power_and_utilities`.`generation`.`capacity_resource`(`capacity_resource_id`);
ALTER TABLE `power_and_utilities`.`market`.`energy_bid` ADD CONSTRAINT `fk_market_energy_bid_generating_unit_id` FOREIGN KEY (`generating_unit_id`) REFERENCES `power_and_utilities`.`generation`.`generating_unit`(`generating_unit_id`);
ALTER TABLE `power_and_utilities`.`market`.`energy_bid` ADD CONSTRAINT `fk_market_energy_bid_resource_generating_unit_id` FOREIGN KEY (`resource_generating_unit_id`) REFERENCES `power_and_utilities`.`generation`.`generating_unit`(`generating_unit_id`);
ALTER TABLE `power_and_utilities`.`market`.`dispatch_award` ADD CONSTRAINT `fk_market_dispatch_award_generating_unit_id` FOREIGN KEY (`generating_unit_id`) REFERENCES `power_and_utilities`.`generation`.`generating_unit`(`generating_unit_id`);
ALTER TABLE `power_and_utilities`.`market`.`ancillary_service_award` ADD CONSTRAINT `fk_market_ancillary_service_award_capacity_resource_id` FOREIGN KEY (`capacity_resource_id`) REFERENCES `power_and_utilities`.`generation`.`capacity_resource`(`capacity_resource_id`);
ALTER TABLE `power_and_utilities`.`market`.`rec_inventory` ADD CONSTRAINT `fk_market_rec_inventory_generating_unit_id` FOREIGN KEY (`generating_unit_id`) REFERENCES `power_and_utilities`.`generation`.`generating_unit`(`generating_unit_id`);
ALTER TABLE `power_and_utilities`.`market`.`rec_transaction` ADD CONSTRAINT `fk_market_rec_transaction_generating_unit_id` FOREIGN KEY (`generating_unit_id`) REFERENCES `power_and_utilities`.`generation`.`generating_unit`(`generating_unit_id`);
ALTER TABLE `power_and_utilities`.`market`.`settlement_line_item` ADD CONSTRAINT `fk_market_settlement_line_item_generating_unit_id` FOREIGN KEY (`generating_unit_id`) REFERENCES `power_and_utilities`.`generation`.`generating_unit`(`generating_unit_id`);
ALTER TABLE `power_and_utilities`.`market`.`capacity_transfer_agreement` ADD CONSTRAINT `fk_market_capacity_transfer_agreement_capacity_resource_id` FOREIGN KEY (`capacity_resource_id`) REFERENCES `power_and_utilities`.`generation`.`capacity_resource`(`capacity_resource_id`);

-- ========= market --> regulatory (18 constraint(s)) =========
-- Requires: market schema, regulatory schema
ALTER TABLE `power_and_utilities`.`market`.`wholesale_counterparty` ADD CONSTRAINT `fk_market_wholesale_counterparty_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `power_and_utilities`.`regulatory`.`docket`(`docket_id`);
ALTER TABLE `power_and_utilities`.`market`.`ppa_contract` ADD CONSTRAINT `fk_market_ppa_contract_commission_order_id` FOREIGN KEY (`commission_order_id`) REFERENCES `power_and_utilities`.`regulatory`.`commission_order`(`commission_order_id`);
ALTER TABLE `power_and_utilities`.`market`.`ppa_contract` ADD CONSTRAINT `fk_market_ppa_contract_cost_recovery_mechanism_id` FOREIGN KEY (`cost_recovery_mechanism_id`) REFERENCES `power_and_utilities`.`regulatory`.`cost_recovery_mechanism`(`cost_recovery_mechanism_id`);
ALTER TABLE `power_and_utilities`.`market`.`ppa_contract` ADD CONSTRAINT `fk_market_ppa_contract_irp_portfolio_id` FOREIGN KEY (`irp_portfolio_id`) REFERENCES `power_and_utilities`.`regulatory`.`irp_portfolio`(`irp_portfolio_id`);
ALTER TABLE `power_and_utilities`.`market`.`ppa_contract` ADD CONSTRAINT `fk_market_ppa_contract_rate_case_id` FOREIGN KEY (`rate_case_id`) REFERENCES `power_and_utilities`.`regulatory`.`rate_case`(`rate_case_id`);
ALTER TABLE `power_and_utilities`.`market`.`ppa_contract` ADD CONSTRAINT `fk_market_ppa_contract_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `power_and_utilities`.`regulatory`.`docket`(`docket_id`);
ALTER TABLE `power_and_utilities`.`market`.`settlement_statement` ADD CONSTRAINT `fk_market_settlement_statement_cost_recovery_mechanism_id` FOREIGN KEY (`cost_recovery_mechanism_id`) REFERENCES `power_and_utilities`.`regulatory`.`cost_recovery_mechanism`(`cost_recovery_mechanism_id`);
ALTER TABLE `power_and_utilities`.`market`.`settlement_statement` ADD CONSTRAINT `fk_market_settlement_statement_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `power_and_utilities`.`regulatory`.`docket`(`docket_id`);
ALTER TABLE `power_and_utilities`.`market`.`settlement_statement` ADD CONSTRAINT `fk_market_settlement_statement_prudency_review_id` FOREIGN KEY (`prudency_review_id`) REFERENCES `power_and_utilities`.`regulatory`.`prudency_review`(`prudency_review_id`);
ALTER TABLE `power_and_utilities`.`market`.`settlement_statement` ADD CONSTRAINT `fk_market_settlement_statement_rate_case_id` FOREIGN KEY (`rate_case_id`) REFERENCES `power_and_utilities`.`regulatory`.`rate_case`(`rate_case_id`);
ALTER TABLE `power_and_utilities`.`market`.`rec_inventory` ADD CONSTRAINT `fk_market_rec_inventory_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `power_and_utilities`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `power_and_utilities`.`market`.`rec_inventory` ADD CONSTRAINT `fk_market_rec_inventory_irp_submission_id` FOREIGN KEY (`irp_submission_id`) REFERENCES `power_and_utilities`.`regulatory`.`irp_submission`(`irp_submission_id`);
ALTER TABLE `power_and_utilities`.`market`.`rec_inventory` ADD CONSTRAINT `fk_market_rec_inventory_rps_program_id` FOREIGN KEY (`rps_program_id`) REFERENCES `power_and_utilities`.`regulatory`.`rps_program`(`rps_program_id`);
ALTER TABLE `power_and_utilities`.`market`.`rec_transaction` ADD CONSTRAINT `fk_market_rec_transaction_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `power_and_utilities`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `power_and_utilities`.`market`.`rec_transaction` ADD CONSTRAINT `fk_market_rec_transaction_irp_submission_id` FOREIGN KEY (`irp_submission_id`) REFERENCES `power_and_utilities`.`regulatory`.`irp_submission`(`irp_submission_id`);
ALTER TABLE `power_and_utilities`.`market`.`rec_transaction` ADD CONSTRAINT `fk_market_rec_transaction_rider_charge_id` FOREIGN KEY (`rider_charge_id`) REFERENCES `power_and_utilities`.`regulatory`.`rider_charge`(`rider_charge_id`);
ALTER TABLE `power_and_utilities`.`market`.`transmission_right` ADD CONSTRAINT `fk_market_transmission_right_cost_recovery_mechanism_id` FOREIGN KEY (`cost_recovery_mechanism_id`) REFERENCES `power_and_utilities`.`regulatory`.`cost_recovery_mechanism`(`cost_recovery_mechanism_id`);
ALTER TABLE `power_and_utilities`.`market`.`transmission_right` ADD CONSTRAINT `fk_market_transmission_right_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `power_and_utilities`.`regulatory`.`docket`(`docket_id`);

-- ========= market --> supply (6 constraint(s)) =========
-- Requires: market schema, supply schema
ALTER TABLE `power_and_utilities`.`market`.`wholesale_counterparty` ADD CONSTRAINT `fk_market_wholesale_counterparty_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities`.`market`.`ppa_contract` ADD CONSTRAINT `fk_market_ppa_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities`.`market`.`capacity_obligation` ADD CONSTRAINT `fk_market_capacity_obligation_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `power_and_utilities`.`supply`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `power_and_utilities`.`market`.`dispatch_award` ADD CONSTRAINT `fk_market_dispatch_award_fuel_delivery_id` FOREIGN KEY (`fuel_delivery_id`) REFERENCES `power_and_utilities`.`supply`.`fuel_delivery`(`fuel_delivery_id`);
ALTER TABLE `power_and_utilities`.`market`.`settlement_statement` ADD CONSTRAINT `fk_market_settlement_statement_vendor_invoice_id` FOREIGN KEY (`vendor_invoice_id`) REFERENCES `power_and_utilities`.`supply`.`vendor_invoice`(`vendor_invoice_id`);
ALTER TABLE `power_and_utilities`.`market`.`rec_transaction` ADD CONSTRAINT `fk_market_rec_transaction_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities`.`supply`.`vendor`(`vendor_id`);

-- ========= market --> transmission (1 constraint(s)) =========
-- Requires: market schema, transmission schema
ALTER TABLE `power_and_utilities`.`market`.`ppa_contract` ADD CONSTRAINT `fk_market_ppa_contract_interconnection_request_id` FOREIGN KEY (`interconnection_request_id`) REFERENCES `power_and_utilities`.`transmission`.`interconnection_request`(`interconnection_request_id`);

-- ========= metering --> asset (6 constraint(s)) =========
-- Requires: metering schema, asset schema
ALTER TABLE `power_and_utilities`.`metering`.`meter` ADD CONSTRAINT `fk_metering_meter_master_id` FOREIGN KEY (`master_id`) REFERENCES `power_and_utilities`.`asset`.`master`(`master_id`);
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` ADD CONSTRAINT `fk_metering_meter_premise_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `power_and_utilities`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ADD CONSTRAINT `fk_metering_vee_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `power_and_utilities`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `power_and_utilities`.`metering`.`meter_event` ADD CONSTRAINT `fk_metering_meter_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `power_and_utilities`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `power_and_utilities`.`metering`.`meter_test` ADD CONSTRAINT `fk_metering_meter_test_master_id` FOREIGN KEY (`master_id`) REFERENCES `power_and_utilities`.`asset`.`master`(`master_id`);
ALTER TABLE `power_and_utilities`.`metering`.`meter_test` ADD CONSTRAINT `fk_metering_meter_test_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `power_and_utilities`.`asset`.`work_order`(`work_order_id`);

-- ========= metering --> billing (7 constraint(s)) =========
-- Requires: metering schema, billing schema
ALTER TABLE `power_and_utilities`.`metering`.`meter` ADD CONSTRAINT `fk_metering_meter_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `power_and_utilities`.`billing`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ADD CONSTRAINT `fk_metering_register_read_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `power_and_utilities`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ADD CONSTRAINT `fk_metering_vee_event_bill_cycle_id` FOREIGN KEY (`bill_cycle_id`) REFERENCES `power_and_utilities`.`billing`.`bill_cycle`(`bill_cycle_id`);
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ADD CONSTRAINT `fk_metering_vee_event_bill_dispute_id` FOREIGN KEY (`bill_dispute_id`) REFERENCES `power_and_utilities`.`billing`.`bill_dispute`(`bill_dispute_id`);
ALTER TABLE `power_and_utilities`.`metering`.`meter_event` ADD CONSTRAINT `fk_metering_meter_event_credit_adjustment_id` FOREIGN KEY (`credit_adjustment_id`) REFERENCES `power_and_utilities`.`billing`.`credit_adjustment`(`credit_adjustment_id`);
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ADD CONSTRAINT `fk_metering_meter_program_enrollment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `power_and_utilities`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ADD CONSTRAINT `fk_metering_daily_usage_summary_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `power_and_utilities`.`billing`.`invoice`(`invoice_id`);

-- ========= metering --> customer (5 constraint(s)) =========
-- Requires: metering schema, customer schema
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` ADD CONSTRAINT `fk_metering_meter_premise_account_id` FOREIGN KEY (`account_id`) REFERENCES `power_and_utilities`.`customer`.`account`(`account_id`);
ALTER TABLE `power_and_utilities`.`metering`.`meter_event` ADD CONSTRAINT `fk_metering_meter_event_account_id` FOREIGN KEY (`account_id`) REFERENCES `power_and_utilities`.`customer`.`account`(`account_id`);
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ADD CONSTRAINT `fk_metering_meter_program_enrollment_account_id` FOREIGN KEY (`account_id`) REFERENCES `power_and_utilities`.`customer`.`account`(`account_id`);
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ADD CONSTRAINT `fk_metering_remote_service_action_account_id` FOREIGN KEY (`account_id`) REFERENCES `power_and_utilities`.`customer`.`account`(`account_id`);
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ADD CONSTRAINT `fk_metering_daily_usage_summary_account_id` FOREIGN KEY (`account_id`) REFERENCES `power_and_utilities`.`customer`.`account`(`account_id`);

-- ========= metering --> distribution (12 constraint(s)) =========
-- Requires: metering schema, distribution schema
ALTER TABLE `power_and_utilities`.`metering`.`meter_premise` ADD CONSTRAINT `fk_metering_meter_premise_service_point_id` FOREIGN KEY (`service_point_id`) REFERENCES `power_and_utilities`.`distribution`.`service_point`(`service_point_id`);
ALTER TABLE `power_and_utilities`.`metering`.`ami_endpoint` ADD CONSTRAINT `fk_metering_ami_endpoint_service_point_id` FOREIGN KEY (`service_point_id`) REFERENCES `power_and_utilities`.`distribution`.`service_point`(`service_point_id`);
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ADD CONSTRAINT `fk_metering_interval_read_service_point_id` FOREIGN KEY (`service_point_id`) REFERENCES `power_and_utilities`.`distribution`.`service_point`(`service_point_id`);
ALTER TABLE `power_and_utilities`.`metering`.`register_read` ADD CONSTRAINT `fk_metering_register_read_service_point_id` FOREIGN KEY (`service_point_id`) REFERENCES `power_and_utilities`.`distribution`.`service_point`(`service_point_id`);
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ADD CONSTRAINT `fk_metering_vee_event_service_point_id` FOREIGN KEY (`service_point_id`) REFERENCES `power_and_utilities`.`distribution`.`service_point`(`service_point_id`);
ALTER TABLE `power_and_utilities`.`metering`.`meter_event` ADD CONSTRAINT `fk_metering_meter_event_service_point_id` FOREIGN KEY (`service_point_id`) REFERENCES `power_and_utilities`.`distribution`.`service_point`(`service_point_id`);
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ADD CONSTRAINT `fk_metering_meter_program_enrollment_service_point_id` FOREIGN KEY (`service_point_id`) REFERENCES `power_and_utilities`.`distribution`.`service_point`(`service_point_id`);
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ADD CONSTRAINT `fk_metering_remote_service_action_demand_response_event_id` FOREIGN KEY (`demand_response_event_id`) REFERENCES `power_and_utilities`.`distribution`.`demand_response_event`(`demand_response_event_id`);
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ADD CONSTRAINT `fk_metering_remote_service_action_distribution_outage_event_id` FOREIGN KEY (`distribution_outage_event_id`) REFERENCES `power_and_utilities`.`distribution`.`distribution_outage_event`(`distribution_outage_event_id`);
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ADD CONSTRAINT `fk_metering_remote_service_action_service_point_id` FOREIGN KEY (`service_point_id`) REFERENCES `power_and_utilities`.`distribution`.`service_point`(`service_point_id`);
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ADD CONSTRAINT `fk_metering_daily_usage_summary_service_point_id` FOREIGN KEY (`service_point_id`) REFERENCES `power_and_utilities`.`distribution`.`service_point`(`service_point_id`);
ALTER TABLE `power_and_utilities`.`metering`.`meter_channel` ADD CONSTRAINT `fk_metering_meter_channel_service_point_id` FOREIGN KEY (`service_point_id`) REFERENCES `power_and_utilities`.`distribution`.`service_point`(`service_point_id`);

-- ========= metering --> finance (4 constraint(s)) =========
-- Requires: metering schema, finance schema
ALTER TABLE `power_and_utilities`.`metering`.`meter` ADD CONSTRAINT `fk_metering_meter_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ADD CONSTRAINT `fk_metering_remote_service_action_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities`.`metering`.`meter_test` ADD CONSTRAINT `fk_metering_meter_test_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities`.`metering`.`meter_test` ADD CONSTRAINT `fk_metering_meter_test_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `power_and_utilities`.`finance`.`gl_account`(`gl_account_id`);

-- ========= metering --> market (9 constraint(s)) =========
-- Requires: metering schema, market schema
ALTER TABLE `power_and_utilities`.`metering`.`meter` ADD CONSTRAINT `fk_metering_meter_participant_registration_id` FOREIGN KEY (`participant_registration_id`) REFERENCES `power_and_utilities`.`market`.`participant_registration`(`participant_registration_id`);
ALTER TABLE `power_and_utilities`.`metering`.`meter` ADD CONSTRAINT `fk_metering_meter_pricing_node_id` FOREIGN KEY (`pricing_node_id`) REFERENCES `power_and_utilities`.`market`.`pricing_node`(`pricing_node_id`);
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ADD CONSTRAINT `fk_metering_interval_read_ppa_contract_id` FOREIGN KEY (`ppa_contract_id`) REFERENCES `power_and_utilities`.`market`.`ppa_contract`(`ppa_contract_id`);
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ADD CONSTRAINT `fk_metering_interval_read_pricing_node_id` FOREIGN KEY (`pricing_node_id`) REFERENCES `power_and_utilities`.`market`.`pricing_node`(`pricing_node_id`);
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ADD CONSTRAINT `fk_metering_meter_program_enrollment_participant_registration_id` FOREIGN KEY (`participant_registration_id`) REFERENCES `power_and_utilities`.`market`.`participant_registration`(`participant_registration_id`);
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ADD CONSTRAINT `fk_metering_meter_program_enrollment_ppa_contract_id` FOREIGN KEY (`ppa_contract_id`) REFERENCES `power_and_utilities`.`market`.`ppa_contract`(`ppa_contract_id`);
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ADD CONSTRAINT `fk_metering_remote_service_action_dispatch_award_id` FOREIGN KEY (`dispatch_award_id`) REFERENCES `power_and_utilities`.`market`.`dispatch_award`(`dispatch_award_id`);
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ADD CONSTRAINT `fk_metering_daily_usage_summary_ppa_contract_id` FOREIGN KEY (`ppa_contract_id`) REFERENCES `power_and_utilities`.`market`.`ppa_contract`(`ppa_contract_id`);
ALTER TABLE `power_and_utilities`.`metering`.`daily_usage_summary` ADD CONSTRAINT `fk_metering_daily_usage_summary_pricing_node_id` FOREIGN KEY (`pricing_node_id`) REFERENCES `power_and_utilities`.`market`.`pricing_node`(`pricing_node_id`);

-- ========= metering --> regulatory (8 constraint(s)) =========
-- Requires: metering schema, regulatory schema
ALTER TABLE `power_and_utilities`.`metering`.`meter` ADD CONSTRAINT `fk_metering_meter_tariff_schedule_id` FOREIGN KEY (`tariff_schedule_id`) REFERENCES `power_and_utilities`.`regulatory`.`tariff_schedule`(`tariff_schedule_id`);
ALTER TABLE `power_and_utilities`.`metering`.`interval_read` ADD CONSTRAINT `fk_metering_interval_read_tariff_schedule_id` FOREIGN KEY (`tariff_schedule_id`) REFERENCES `power_and_utilities`.`regulatory`.`tariff_schedule`(`tariff_schedule_id`);
ALTER TABLE `power_and_utilities`.`metering`.`vee_event` ADD CONSTRAINT `fk_metering_vee_event_rate_case_id` FOREIGN KEY (`rate_case_id`) REFERENCES `power_and_utilities`.`regulatory`.`rate_case`(`rate_case_id`);
ALTER TABLE `power_and_utilities`.`metering`.`meter_event` ADD CONSTRAINT `fk_metering_meter_event_compliance_event_id` FOREIGN KEY (`compliance_event_id`) REFERENCES `power_and_utilities`.`regulatory`.`compliance_event`(`compliance_event_id`);
ALTER TABLE `power_and_utilities`.`metering`.`meter_program_enrollment` ADD CONSTRAINT `fk_metering_meter_program_enrollment_tariff_schedule_id` FOREIGN KEY (`tariff_schedule_id`) REFERENCES `power_and_utilities`.`regulatory`.`tariff_schedule`(`tariff_schedule_id`);
ALTER TABLE `power_and_utilities`.`metering`.`remote_service_action` ADD CONSTRAINT `fk_metering_remote_service_action_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `power_and_utilities`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `power_and_utilities`.`metering`.`meter_test` ADD CONSTRAINT `fk_metering_meter_test_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `power_and_utilities`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `power_and_utilities`.`metering`.`meter_configuration` ADD CONSTRAINT `fk_metering_meter_configuration_tariff_schedule_id` FOREIGN KEY (`tariff_schedule_id`) REFERENCES `power_and_utilities`.`regulatory`.`tariff_schedule`(`tariff_schedule_id`);

-- ========= metering --> supply (2 constraint(s)) =========
-- Requires: metering schema, supply schema
ALTER TABLE `power_and_utilities`.`metering`.`meter` ADD CONSTRAINT `fk_metering_meter_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `power_and_utilities`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `power_and_utilities`.`metering`.`meter` ADD CONSTRAINT `fk_metering_meter_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `power_and_utilities`.`supply`.`purchase_order`(`purchase_order_id`);

-- ========= regulatory --> asset (3 constraint(s)) =========
-- Requires: regulatory schema, asset schema
ALTER TABLE `power_and_utilities`.`regulatory`.`cpcn_application` ADD CONSTRAINT `fk_regulatory_cpcn_application_master_id` FOREIGN KEY (`master_id`) REFERENCES `power_and_utilities`.`asset`.`master`(`master_id`);
ALTER TABLE `power_and_utilities`.`regulatory`.`compliance_event` ADD CONSTRAINT `fk_regulatory_compliance_event_master_id` FOREIGN KEY (`master_id`) REFERENCES `power_and_utilities`.`asset`.`master`(`master_id`);
ALTER TABLE `power_and_utilities`.`regulatory`.`emissions_report` ADD CONSTRAINT `fk_regulatory_emissions_report_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities`.`asset`.`facility`(`facility_id`);

-- ========= regulatory --> customer (1 constraint(s)) =========
-- Requires: regulatory schema, customer schema
ALTER TABLE `power_and_utilities`.`regulatory`.`cpcn_application` ADD CONSTRAINT `fk_regulatory_cpcn_application_party_id` FOREIGN KEY (`party_id`) REFERENCES `power_and_utilities`.`customer`.`party`(`party_id`);

-- ========= regulatory --> distribution (1 constraint(s)) =========
-- Requires: regulatory schema, distribution schema
ALTER TABLE `power_and_utilities`.`regulatory`.`emissions_report` ADD CONSTRAINT `fk_regulatory_emissions_report_der_interconnection_id` FOREIGN KEY (`der_interconnection_id`) REFERENCES `power_and_utilities`.`distribution`.`der_interconnection`(`der_interconnection_id`);

-- ========= regulatory --> finance (10 constraint(s)) =========
-- Requires: regulatory schema, finance schema
ALTER TABLE `power_and_utilities`.`regulatory`.`rate_case` ADD CONSTRAINT `fk_regulatory_rate_case_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `power_and_utilities`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `power_and_utilities`.`regulatory`.`tariff_schedule` ADD CONSTRAINT `fk_regulatory_tariff_schedule_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `power_and_utilities`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `power_and_utilities`.`regulatory`.`cpcn_application` ADD CONSTRAINT `fk_regulatory_cpcn_application_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `power_and_utilities`.`finance`.`capex_project`(`capex_project_id`);
ALTER TABLE `power_and_utilities`.`regulatory`.`compliance_obligation` ADD CONSTRAINT `fk_regulatory_compliance_obligation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities`.`regulatory`.`compliance_event` ADD CONSTRAINT `fk_regulatory_compliance_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities`.`regulatory`.`emissions_report` ADD CONSTRAINT `fk_regulatory_emissions_report_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities`.`regulatory`.`prudency_review` ADD CONSTRAINT `fk_regulatory_prudency_review_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `power_and_utilities`.`finance`.`capex_project`(`capex_project_id`);
ALTER TABLE `power_and_utilities`.`regulatory`.`prudency_review` ADD CONSTRAINT `fk_regulatory_prudency_review_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `power_and_utilities`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `power_and_utilities`.`regulatory`.`cost_recovery_mechanism` ADD CONSTRAINT `fk_regulatory_cost_recovery_mechanism_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `power_and_utilities`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `power_and_utilities`.`regulatory`.`commission_order` ADD CONSTRAINT `fk_regulatory_commission_order_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `power_and_utilities`.`finance`.`financial_period`(`financial_period_id`);

-- ========= regulatory --> generation (1 constraint(s)) =========
-- Requires: regulatory schema, generation schema
ALTER TABLE `power_and_utilities`.`regulatory`.`emissions_report` ADD CONSTRAINT `fk_regulatory_emissions_report_generating_unit_id` FOREIGN KEY (`generating_unit_id`) REFERENCES `power_and_utilities`.`generation`.`generating_unit`(`generating_unit_id`);

-- ========= regulatory --> market (2 constraint(s)) =========
-- Requires: regulatory schema, market schema
ALTER TABLE `power_and_utilities`.`regulatory`.`irp_submission` ADD CONSTRAINT `fk_regulatory_irp_submission_rto_iso_id` FOREIGN KEY (`rto_iso_id`) REFERENCES `power_and_utilities`.`market`.`rto_iso`(`rto_iso_id`);
ALTER TABLE `power_and_utilities`.`regulatory`.`emissions_report` ADD CONSTRAINT `fk_regulatory_emissions_report_rec_transaction_id` FOREIGN KEY (`rec_transaction_id`) REFERENCES `power_and_utilities`.`market`.`rec_transaction`(`rec_transaction_id`);

-- ========= regulatory --> transmission (1 constraint(s)) =========
-- Requires: regulatory schema, transmission schema
ALTER TABLE `power_and_utilities`.`regulatory`.`cpcn_application` ADD CONSTRAINT `fk_regulatory_cpcn_application_interconnection_request_id` FOREIGN KEY (`interconnection_request_id`) REFERENCES `power_and_utilities`.`transmission`.`interconnection_request`(`interconnection_request_id`);

-- ========= regulatory --> workforce (2 constraint(s)) =========
-- Requires: regulatory schema, workforce schema
ALTER TABLE `power_and_utilities`.`regulatory`.`compliance_event` ADD CONSTRAINT `fk_regulatory_compliance_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities`.`regulatory`.`compliance_calendar` ADD CONSTRAINT `fk_regulatory_compliance_calendar_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities`.`workforce`.`employee`(`employee_id`);

-- ========= supply --> asset (8 constraint(s)) =========
-- Requires: supply schema, asset schema
ALTER TABLE `power_and_utilities`.`supply`.`po_line_item` ADD CONSTRAINT `fk_supply_po_line_item_master_id` FOREIGN KEY (`master_id`) REFERENCES `power_and_utilities`.`asset`.`master`(`master_id`);
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_master_id` FOREIGN KEY (`master_id`) REFERENCES `power_and_utilities`.`asset`.`master`(`master_id`);
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `power_and_utilities`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ADD CONSTRAINT `fk_supply_stock_transfer_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `power_and_utilities`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ADD CONSTRAINT `fk_supply_vendor_invoice_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `power_and_utilities`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ADD CONSTRAINT `fk_supply_material_reservation_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `power_and_utilities`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ADD CONSTRAINT `fk_supply_goods_issue_master_id` FOREIGN KEY (`master_id`) REFERENCES `power_and_utilities`.`asset`.`master`(`master_id`);
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ADD CONSTRAINT `fk_supply_goods_issue_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `power_and_utilities`.`asset`.`work_order`(`work_order_id`);

-- ========= supply --> finance (18 constraint(s)) =========
-- Requires: supply schema, finance schema
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `power_and_utilities`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `power_and_utilities`.`finance`.`capex_project`(`capex_project_id`);
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `power_and_utilities`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ADD CONSTRAINT `fk_supply_stock_transfer_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `power_and_utilities`.`finance`.`capex_project`(`capex_project_id`);
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ADD CONSTRAINT `fk_supply_purchase_requisition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ADD CONSTRAINT `fk_supply_purchase_requisition_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `power_and_utilities`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ADD CONSTRAINT `fk_supply_vendor_invoice_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `power_and_utilities`.`finance`.`capex_project`(`capex_project_id`);
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ADD CONSTRAINT `fk_supply_vendor_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ADD CONSTRAINT `fk_supply_vendor_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `power_and_utilities`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ADD CONSTRAINT `fk_supply_fuel_delivery_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ADD CONSTRAINT `fk_supply_fuel_delivery_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `power_and_utilities`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ADD CONSTRAINT `fk_supply_vendor_performance_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `power_and_utilities`.`finance`.`capex_project`(`capex_project_id`);
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ADD CONSTRAINT `fk_supply_material_reservation_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `power_and_utilities`.`finance`.`capex_project`(`capex_project_id`);
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ADD CONSTRAINT `fk_supply_goods_issue_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `power_and_utilities`.`finance`.`capex_project`(`capex_project_id`);
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ADD CONSTRAINT `fk_supply_goods_issue_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ADD CONSTRAINT `fk_supply_goods_issue_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `power_and_utilities`.`finance`.`gl_account`(`gl_account_id`);

-- ========= supply --> generation (3 constraint(s)) =========
-- Requires: supply schema, generation schema
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ADD CONSTRAINT `fk_supply_fuel_delivery_fuel_contract_id` FOREIGN KEY (`fuel_contract_id`) REFERENCES `power_and_utilities`.`generation`.`fuel_contract`(`fuel_contract_id`);
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ADD CONSTRAINT `fk_supply_fuel_delivery_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `power_and_utilities`.`generation`.`plant`(`plant_id`);
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ADD CONSTRAINT `fk_supply_fuel_delivery_fuel_plant_id` FOREIGN KEY (`fuel_plant_id`) REFERENCES `power_and_utilities`.`generation`.`plant`(`plant_id`);

-- ========= supply --> metering (3 constraint(s)) =========
-- Requires: supply schema, metering schema
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `power_and_utilities`.`metering`.`meter`(`meter_id`);
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ADD CONSTRAINT `fk_supply_stock_transfer_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `power_and_utilities`.`metering`.`meter`(`meter_id`);
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ADD CONSTRAINT `fk_supply_goods_issue_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `power_and_utilities`.`metering`.`meter`(`meter_id`);

-- ========= supply --> regulatory (10 constraint(s)) =========
-- Requires: supply schema, regulatory schema
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ADD CONSTRAINT `fk_supply_material_master_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `power_and_utilities`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `power_and_utilities`.`regulatory`.`docket`(`docket_id`);
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_compliance_event_id` FOREIGN KEY (`compliance_event_id`) REFERENCES `power_and_utilities`.`regulatory`.`compliance_event`(`compliance_event_id`);
ALTER TABLE `power_and_utilities`.`supply`.`procurement_contract` ADD CONSTRAINT `fk_supply_procurement_contract_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `power_and_utilities`.`regulatory`.`docket`(`docket_id`);
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ADD CONSTRAINT `fk_supply_warehouse_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `power_and_utilities`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ADD CONSTRAINT `fk_supply_stock_transfer_compliance_event_id` FOREIGN KEY (`compliance_event_id`) REFERENCES `power_and_utilities`.`regulatory`.`compliance_event`(`compliance_event_id`);
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ADD CONSTRAINT `fk_supply_vendor_invoice_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `power_and_utilities`.`regulatory`.`docket`(`docket_id`);
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ADD CONSTRAINT `fk_supply_fuel_delivery_compliance_event_id` FOREIGN KEY (`compliance_event_id`) REFERENCES `power_and_utilities`.`regulatory`.`compliance_event`(`compliance_event_id`);
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ADD CONSTRAINT `fk_supply_fuel_delivery_emissions_report_id` FOREIGN KEY (`emissions_report_id`) REFERENCES `power_and_utilities`.`regulatory`.`emissions_report`(`emissions_report_id`);
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ADD CONSTRAINT `fk_supply_vendor_performance_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `power_and_utilities`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);

-- ========= supply --> workforce (6 constraint(s)) =========
-- Requires: supply schema, workforce schema
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ADD CONSTRAINT `fk_supply_purchase_requisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ADD CONSTRAINT `fk_supply_vendor_performance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ADD CONSTRAINT `fk_supply_vendor_performance_evaluator_employee_id` FOREIGN KEY (`evaluator_employee_id`) REFERENCES `power_and_utilities`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ADD CONSTRAINT `fk_supply_material_reservation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ADD CONSTRAINT `fk_supply_goods_issue_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities`.`workforce`.`employee`(`employee_id`);

-- ========= transmission --> asset (6 constraint(s)) =========
-- Requires: transmission schema, asset schema
ALTER TABLE `power_and_utilities`.`transmission`.`line` ADD CONSTRAINT `fk_transmission_line_master_id` FOREIGN KEY (`master_id`) REFERENCES `power_and_utilities`.`asset`.`master`(`master_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ADD CONSTRAINT `fk_transmission_transmission_substation_master_id` FOREIGN KEY (`master_id`) REFERENCES `power_and_utilities`.`asset`.`master`(`master_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ADD CONSTRAINT `fk_transmission_transformer_master_id` FOREIGN KEY (`master_id`) REFERENCES `power_and_utilities`.`asset`.`master`(`master_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`nerc_cip_asset` ADD CONSTRAINT `fk_transmission_nerc_cip_asset_master_id` FOREIGN KEY (`master_id`) REFERENCES `power_and_utilities`.`asset`.`master`(`master_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ADD CONSTRAINT `fk_transmission_protection_system_master_id` FOREIGN KEY (`master_id`) REFERENCES `power_and_utilities`.`asset`.`master`(`master_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`crew` ADD CONSTRAINT `fk_transmission_crew_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities`.`asset`.`facility`(`facility_id`);

-- ========= transmission --> billing (2 constraint(s)) =========
-- Requires: transmission schema, billing schema
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ADD CONSTRAINT `fk_transmission_outage_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `power_and_utilities`.`billing`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ADD CONSTRAINT `fk_transmission_tariff_rate_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `power_and_utilities`.`billing`.`rate_schedule`(`rate_schedule_id`);

-- ========= transmission --> customer (1 constraint(s)) =========
-- Requires: transmission schema, customer schema
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ADD CONSTRAINT `fk_transmission_service_request_party_id` FOREIGN KEY (`party_id`) REFERENCES `power_and_utilities`.`customer`.`party`(`party_id`);

-- ========= transmission --> distribution (1 constraint(s)) =========
-- Requires: transmission schema, distribution schema
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ADD CONSTRAINT `fk_transmission_outage_distribution_outage_event_id` FOREIGN KEY (`distribution_outage_event_id`) REFERENCES `power_and_utilities`.`distribution`.`distribution_outage_event`(`distribution_outage_event_id`);

-- ========= transmission --> finance (15 constraint(s)) =========
-- Requires: transmission schema, finance schema
ALTER TABLE `power_and_utilities`.`transmission`.`line` ADD CONSTRAINT `fk_transmission_line_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `power_and_utilities`.`finance`.`capex_project`(`capex_project_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`line` ADD CONSTRAINT `fk_transmission_line_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `power_and_utilities`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ADD CONSTRAINT `fk_transmission_transmission_substation_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `power_and_utilities`.`finance`.`capex_project`(`capex_project_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ADD CONSTRAINT `fk_transmission_transmission_substation_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `power_and_utilities`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ADD CONSTRAINT `fk_transmission_transformer_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `power_and_utilities`.`finance`.`capex_project`(`capex_project_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ADD CONSTRAINT `fk_transmission_transformer_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `power_and_utilities`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ADD CONSTRAINT `fk_transmission_service_request_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ADD CONSTRAINT `fk_transmission_interconnection_request_capex_project_id` FOREIGN KEY (`capex_project_id`) REFERENCES `power_and_utilities`.`finance`.`capex_project`(`capex_project_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ADD CONSTRAINT `fk_transmission_interconnection_request_regulatory_asset_entry_id` FOREIGN KEY (`regulatory_asset_entry_id`) REFERENCES `power_and_utilities`.`finance`.`regulatory_asset_entry`(`regulatory_asset_entry_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ADD CONSTRAINT `fk_transmission_congestion_event_regulatory_deferral_id` FOREIGN KEY (`regulatory_deferral_id`) REFERENCES `power_and_utilities`.`finance`.`regulatory_deferral`(`regulatory_deferral_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ADD CONSTRAINT `fk_transmission_outage_opex_transaction_id` FOREIGN KEY (`opex_transaction_id`) REFERENCES `power_and_utilities`.`finance`.`opex_transaction`(`opex_transaction_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`nerc_cip_asset` ADD CONSTRAINT `fk_transmission_nerc_cip_asset_capex_expenditure_id` FOREIGN KEY (`capex_expenditure_id`) REFERENCES `power_and_utilities`.`finance`.`capex_expenditure`(`capex_expenditure_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ADD CONSTRAINT `fk_transmission_tariff_rate_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `power_and_utilities`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ADD CONSTRAINT `fk_transmission_switching_order_opex_transaction_id` FOREIGN KEY (`opex_transaction_id`) REFERENCES `power_and_utilities`.`finance`.`opex_transaction`(`opex_transaction_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ADD CONSTRAINT `fk_transmission_protection_system_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `power_and_utilities`.`finance`.`fixed_asset`(`fixed_asset_id`);

-- ========= transmission --> generation (1 constraint(s)) =========
-- Requires: transmission schema, generation schema
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ADD CONSTRAINT `fk_transmission_interconnection_request_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `power_and_utilities`.`generation`.`plant`(`plant_id`);

-- ========= transmission --> market (12 constraint(s)) =========
-- Requires: transmission schema, market schema
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` ADD CONSTRAINT `fk_transmission_interchange_schedule_ppa_contract_id` FOREIGN KEY (`ppa_contract_id`) REFERENCES `power_and_utilities`.`market`.`ppa_contract`(`ppa_contract_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` ADD CONSTRAINT `fk_transmission_interchange_schedule_pricing_node_id` FOREIGN KEY (`pricing_node_id`) REFERENCES `power_and_utilities`.`market`.`pricing_node`(`pricing_node_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` ADD CONSTRAINT `fk_transmission_interchange_schedule_rto_iso_id` FOREIGN KEY (`rto_iso_id`) REFERENCES `power_and_utilities`.`market`.`rto_iso`(`rto_iso_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` ADD CONSTRAINT `fk_transmission_interchange_schedule_transmission_right_id` FOREIGN KEY (`transmission_right_id`) REFERENCES `power_and_utilities`.`market`.`transmission_right`(`transmission_right_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ADD CONSTRAINT `fk_transmission_interconnection_request_participant_registration_id` FOREIGN KEY (`participant_registration_id`) REFERENCES `power_and_utilities`.`market`.`participant_registration`(`participant_registration_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ADD CONSTRAINT `fk_transmission_interconnection_request_rto_iso_id` FOREIGN KEY (`rto_iso_id`) REFERENCES `power_and_utilities`.`market`.`rto_iso`(`rto_iso_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ADD CONSTRAINT `fk_transmission_congestion_event_pricing_node_id` FOREIGN KEY (`pricing_node_id`) REFERENCES `power_and_utilities`.`market`.`pricing_node`(`pricing_node_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ADD CONSTRAINT `fk_transmission_congestion_event_lmp_price_id` FOREIGN KEY (`lmp_price_id`) REFERENCES `power_and_utilities`.`market`.`lmp_price`(`lmp_price_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ADD CONSTRAINT `fk_transmission_congestion_event_rto_iso_id` FOREIGN KEY (`rto_iso_id`) REFERENCES `power_and_utilities`.`market`.`rto_iso`(`rto_iso_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`constrained_element` ADD CONSTRAINT `fk_transmission_constrained_element_pricing_node_id` FOREIGN KEY (`pricing_node_id`) REFERENCES `power_and_utilities`.`market`.`pricing_node`(`pricing_node_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`flowgate` ADD CONSTRAINT `fk_transmission_flowgate_rto_iso_id` FOREIGN KEY (`rto_iso_id`) REFERENCES `power_and_utilities`.`market`.`rto_iso`(`rto_iso_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`bus` ADD CONSTRAINT `fk_transmission_bus_market_zone_id` FOREIGN KEY (`market_zone_id`) REFERENCES `power_and_utilities`.`market`.`market_zone`(`market_zone_id`);

-- ========= transmission --> regulatory (12 constraint(s)) =========
-- Requires: transmission schema, regulatory schema
ALTER TABLE `power_and_utilities`.`transmission`.`line` ADD CONSTRAINT `fk_transmission_line_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `power_and_utilities`.`regulatory`.`docket`(`docket_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ADD CONSTRAINT `fk_transmission_transmission_substation_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `power_and_utilities`.`regulatory`.`docket`(`docket_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ADD CONSTRAINT `fk_transmission_transformer_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `power_and_utilities`.`regulatory`.`docket`(`docket_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ADD CONSTRAINT `fk_transmission_interconnection_request_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `power_and_utilities`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ADD CONSTRAINT `fk_transmission_congestion_event_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `power_and_utilities`.`regulatory`.`docket`(`docket_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ADD CONSTRAINT `fk_transmission_outage_compliance_event_id` FOREIGN KEY (`compliance_event_id`) REFERENCES `power_and_utilities`.`regulatory`.`compliance_event`(`compliance_event_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`nerc_cip_asset` ADD CONSTRAINT `fk_transmission_nerc_cip_asset_compliance_event_id` FOREIGN KEY (`compliance_event_id`) REFERENCES `power_and_utilities`.`regulatory`.`compliance_event`(`compliance_event_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`nerc_cip_asset` ADD CONSTRAINT `fk_transmission_nerc_cip_asset_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `power_and_utilities`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ADD CONSTRAINT `fk_transmission_tariff_rate_tariff_schedule_id` FOREIGN KEY (`tariff_schedule_id`) REFERENCES `power_and_utilities`.`regulatory`.`tariff_schedule`(`tariff_schedule_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ADD CONSTRAINT `fk_transmission_switching_order_compliance_event_id` FOREIGN KEY (`compliance_event_id`) REFERENCES `power_and_utilities`.`regulatory`.`compliance_event`(`compliance_event_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ADD CONSTRAINT `fk_transmission_protection_system_compliance_event_id` FOREIGN KEY (`compliance_event_id`) REFERENCES `power_and_utilities`.`regulatory`.`compliance_event`(`compliance_event_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ADD CONSTRAINT `fk_transmission_protection_system_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `power_and_utilities`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);

-- ========= transmission --> supply (4 constraint(s)) =========
-- Requires: transmission schema, supply schema
ALTER TABLE `power_and_utilities`.`transmission`.`line` ADD CONSTRAINT `fk_transmission_line_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `power_and_utilities`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ADD CONSTRAINT `fk_transmission_transformer_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `power_and_utilities`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ADD CONSTRAINT `fk_transmission_outage_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `power_and_utilities`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ADD CONSTRAINT `fk_transmission_protection_system_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `power_and_utilities`.`supply`.`material_master`(`material_master_id`);

-- ========= workforce --> asset (1 constraint(s)) =========
-- Requires: workforce schema, asset schema
ALTER TABLE `power_and_utilities`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_location_id` FOREIGN KEY (`location_id`) REFERENCES `power_and_utilities`.`asset`.`location`(`location_id`);

