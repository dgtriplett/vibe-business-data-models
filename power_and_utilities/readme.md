# Power and Utilities Lakehouse Data Models

**Version 1** | Generated April 29, 2026 — vibe-modelling-agent v0.7.1

**Industry:** power_and_utilities

## Table of Contents

  - [Business Description](#business-description)
  - [Model Scope](#model-scope)
  - [Model Metrics](#model-metrics)
  - [Domain & Product Breakdown](#domain--product-breakdown)
    - [Asset](#domain-asset)
    - [Billing](#domain-billing)
    - [Customer](#domain-customer)
    - [Distribution](#domain-distribution)
    - [Finance](#domain-finance)
    - [Generation](#domain-generation)
    - [Market](#domain-market)
    - [Metering](#domain-metering)
    - [Regulatory](#domain-regulatory)
    - [Supply](#domain-supply)
    - [Transmission](#domain-transmission)
    - [Workforce](#domain-workforce)

## Business Description

I am an electric and gas utility with energy generation, transmission, and distribution to serve residential and commercial customers

## Model Scope

This industry currently ships **MVM (Minimum Viable Model)** only — `mvm_v1`. The MVM is a production-ready, focused data model that covers the essential business functions of an electric and gas utility (generation, transmission, distribution, metering, customer, billing, supply, asset, market, regulatory, finance, workforce) with full attribute depth.

An **ECM (Expanded Coverage Model)** with broader corporate/back-office coverage is planned in a future revision and will be added as `ecm_v1` alongside `mvm_v1`.

## Model Metrics

| Metric | MVM (Minimum Viable Model) |
|---|---|
| Domains | 12 |
| Subdomains | 28 |
| Products (Tables) | 188 |
| Attributes (Columns) | 7375 |
| Foreign Keys | 889 |
| Metric Views | 113 |
| Avg Attributes/Product | 39.2 |

## Domain & Product Breakdown

<a id="domain-asset"></a>
### asset

| Subdomain | Product |
|---|---|
| asset_registry | facility |
| asset_registry | hierarchy |
| asset_registry | location |
| asset_registry | master |
| asset_registry | warranty |
| condition_monitoring | condition |
| condition_monitoring | failure_event |
| condition_monitoring | inspection_crew |
| condition_monitoring | inspection_record |
| condition_monitoring | inspector |
| maintenance_operations | pm_schedule |
| maintenance_operations | work_order |
| maintenance_operations | work_order_material |

<a id="domain-billing"></a>
### billing

| Subdomain | Product |
|---|---|
| account_settlement | collections_action |
| account_settlement | collections_case |
| account_settlement | credit_adjustment |
| account_settlement | payment |
| account_settlement | payment_arrangement |
| revenue_pricing | bill_cycle |
| revenue_pricing | bill_dispute |
| revenue_pricing | billing_service_agreement |
| revenue_pricing | invoice |
| revenue_pricing | invoice_line |
| revenue_pricing | rate_schedule |

<a id="domain-customer"></a>
### customer

| Subdomain | Product |
|---|---|
| account_management | account |
| account_management | account_hierarchy |
| account_management | contact |
| account_management | customer_service_agreement |
| account_management | party |
| account_management | preference |
| account_management | premise |
| service_operations | credit_deposit |
| service_operations | enrollment |
| service_operations | interaction |
| service_operations | move_order |
| service_operations | segment |

<a id="domain-distribution"></a>
### distribution

| Subdomain | Product |
|---|---|
| network_infrastructure | bus |
| network_infrastructure | city_gate_station |
| network_infrastructure | der_interconnection |
| network_infrastructure | distribution_substation |
| network_infrastructure | district |
| network_infrastructure | feeder |
| network_infrastructure | gas_main |
| network_infrastructure | gas_network_node |
| network_infrastructure | gas_service_lateral |
| network_infrastructure | network_model |
| network_infrastructure | pole |
| network_infrastructure | protective_device |
| network_infrastructure | service_area |
| network_infrastructure | service_point |
| network_infrastructure | service_territory |
| network_infrastructure | service_transformer |
| network_infrastructure | voltage_regulation_device |
| network_infrastructure | zone |
| operational_events | crew_dispatch |
| operational_events | demand_response_event |
| operational_events | der_dispatch |
| operational_events | distribution_outage_event |
| operational_events | gas_leak_survey |
| operational_events | load_profile |
| operational_events | reliability_index |
| operational_events | service_point_dr_participation |
| operational_events | switching_operation |

<a id="domain-finance"></a>
### finance

| Subdomain | Product |
|---|---|
| accounting_operations | cost_center |
| accounting_operations | financial_period |
| accounting_operations | gl_account |
| accounting_operations | journal_entry |
| accounting_operations | journal_entry_line |
| accounting_operations | journal_entry_template |
| accounting_operations | opex_transaction |
| accounting_operations | organization |
| accounting_operations | profit_center |
| capital_management | budget |
| capital_management | capex_expenditure |
| capital_management | capex_project |
| capital_management | depreciation_run |
| capital_management | depreciation_study |
| capital_management | fixed_asset |
| capital_management | wbs_element |
| regulatory_compliance | rate_case_cost_study |
| regulatory_compliance | regulatory_asset_entry |
| regulatory_compliance | regulatory_deferral |
| regulatory_compliance | tax_provision |

<a id="domain-generation"></a>
### generation

| Subdomain | Product |
|---|---|
| asset_operations | dispatch_schedule |
| asset_operations | generating_unit |
| asset_operations | generation_outage_event |
| asset_operations | plant |
| asset_operations | unit_output |
| fuel_management | fuel_consumption |
| fuel_management | fuel_contract |
| fuel_management | fuel_inventory |
| regulatory_compliance | capacity_resource |
| regulatory_compliance | emissions_record |
| regulatory_compliance | environmental_permit |

<a id="domain-market"></a>
### market

| Subdomain | Product |
|---|---|
| capacity_management | ancillary_service_award |
| capacity_management | capacity_market_auction |
| capacity_management | capacity_obligation |
| capacity_management | capacity_transfer_agreement |
| capacity_management | demand_response_program |
| capacity_management | rec_inventory |
| capacity_management | rec_transaction |
| capacity_management | transmission_right |
| capacity_management | transmission_rights_portfolio |
| energy_trading | dispatch_award |
| energy_trading | energy_bid |
| energy_trading | lmp_price |
| energy_trading | market_zone |
| energy_trading | participant_registration |
| energy_trading | ppa_contract |
| energy_trading | pricing_node |
| energy_trading | rto_iso |
| energy_trading | wholesale_counterparty |
| financial_settlement | settlement_line_item |
| financial_settlement | settlement_statement |

<a id="domain-metering"></a>
### metering

| Subdomain | Product |
|---|---|
| asset_registry | ami_endpoint |
| asset_registry | meter |
| asset_registry | meter_channel |
| asset_registry | meter_configuration |
| asset_registry | meter_premise |
| asset_registry | read_cycle |
| asset_registry | tou_schedule |
| asset_registry | vee_rule_set |
| consumption_operations | daily_usage_summary |
| consumption_operations | interval_read |
| consumption_operations | meter_event |
| consumption_operations | meter_program_enrollment |
| consumption_operations | meter_test |
| consumption_operations | register_read |
| consumption_operations | remote_service_action |
| consumption_operations | vee_event |

<a id="domain-regulatory"></a>
### regulatory

| Subdomain | Product |
|---|---|
| obligation_tracking | compliance_event |
| obligation_tracking | compliance_obligation |
| obligation_tracking | corrective_action_plan |
| obligation_tracking | emissions_report |
| obligation_tracking | violation |
| proceeding_management | commission_order |
| proceeding_management | compliance_calendar |
| proceeding_management | cost_recovery_mechanism |
| proceeding_management | cpcn_application |
| proceeding_management | docket |
| proceeding_management | filing |
| proceeding_management | irp_portfolio |
| proceeding_management | irp_submission |
| proceeding_management | prudency_review |
| proceeding_management | rate_case |
| proceeding_management | rider_charge |
| proceeding_management | rps_program |
| proceeding_management | tariff_schedule |

<a id="domain-supply"></a>
### supply

| Subdomain | Product |
|---|---|
| inventory_operations | goods_issue |
| inventory_operations | goods_receipt |
| inventory_operations | inventory_stock |
| inventory_operations | material_master |
| inventory_operations | material_reservation |
| inventory_operations | stock_transfer |
| inventory_operations | warehouse |
| procurement_transactions | fuel_delivery |
| procurement_transactions | po_line_item |
| procurement_transactions | purchase_order |
| procurement_transactions | purchase_requisition |
| vendor_management | procurement_contract |
| vendor_management | vendor |
| vendor_management | vendor_invoice |
| vendor_management | vendor_performance |

<a id="domain-transmission"></a>
### transmission

| Subdomain | Product |
|---|---|
| asset_infrastructure | bus |
| asset_infrastructure | grid_topology |
| asset_infrastructure | line |
| asset_infrastructure | nerc_cip_asset |
| asset_infrastructure | protection_system |
| asset_infrastructure | transformer |
| asset_infrastructure | transmission_substation |
| operational_coordination | balancing_authority |
| operational_coordination | congestion_event |
| operational_coordination | constrained_element |
| operational_coordination | contingency_scenario |
| operational_coordination | control_area |
| operational_coordination | control_center |
| operational_coordination | crew |
| operational_coordination | flowgate |
| operational_coordination | interchange_schedule |
| operational_coordination | interconnection_request |
| operational_coordination | operator |
| operational_coordination | outage |
| operational_coordination | service_request |
| operational_coordination | switching_order |
| operational_coordination | tariff_rate |
| operational_coordination | transfer_capability |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product |
|---|---|
| workforce_core | department |
| workforce_core | employee |

