# Power and Utilities Lakehouse Data Models

**Version 1** | Generated April 29, 2026 — vibe-modelling-agent v0.7.1

**Industry:** power_and_utilities

## Table of Contents

- [Business Description](#business-description)
- [Model Scope Variations](#model-scope-variations)
  - [MVM (Minimum Viable Model)](#mvm-minimum-viable-model--v1_mvm)
  - [ECM (Expanded Coverage Model)](#ecm-expanded-coverage-model--v1_ecm)
- [Head-to-Head Comparison](#head-to-head-comparison)
- [Model Metrics Comparison](#model-metrics-comparison)
- [Domain & Product Comparison](#domain--product-comparison)
  - [Asset](#domain-asset)
  - [Billing](#domain-billing)
  - [Customer](#domain-customer)
  - [Der](#domain-der)
  - [Distribution](#domain-distribution)
  - [Engagement](#domain-engagement)
  - [Finance](#domain-finance)
  - [Generation](#domain-generation)
  - [Gridops](#domain-gridops)
  - [Market](#domain-market)
  - [Metering](#domain-metering)
  - [Product](#domain-product)
  - [Property](#domain-property)
  - [Regulatory](#domain-regulatory)
  - [Safety](#domain-safety)
  - [Supply](#domain-supply)
  - [Technology](#domain-technology)
  - [Trading](#domain-trading)
  - [Transmission](#domain-transmission)
  - [Workforce](#domain-workforce)

## Business Description

I am an electric and gas utility with energy generation, transmission, and distribution to serve residential and commercial customers

## Model Scope Variations

This data model is available in **two scope variations** — the **MVM (Minimum Viable Model)** and the **ECM (Expanded Coverage Model)** — each designed for different organizational needs and use cases. Both models share the same attribute depth per table; the difference is in breadth (number of domains and tables).

### MVM (Minimum Viable Model) — `v1_mvm`

The **MVM** is a production-ready, focused data model covering the core operational and business functions of an electric and gas utility — generation, transmission, distribution, metering, customer, billing, supply, asset, market, regulatory, finance, and workforce — with full attribute depth. It is the recommended starting point for utilities that want to deploy quickly and expand incrementally. Ideal for:

- **Targeted utility analytics** — meter-to-cash, outage management, asset health, regulatory reporting
- **Production-Ready Foundation** — deploy from day one and grow as business needs evolve
- **Proof-of-Concept & Demos** — quick stand-up for stakeholder presentations
- **Rapid onboarding** — simplified structure for teams getting started
- **Development & Testing** — lightweight model for non-prod environments

The MVM prioritizes **Operations** and **Business** division domains, minimizes association tables, and relies on direct foreign key relationships for simplicity.

### ECM (Expanded Coverage Model) — `v1_ecm`

The **ECM** is a comprehensive, full-coverage data model designed for enterprise utilities operating across the full grid value chain. It expands on the MVM with additional domains for **DER & DERMS** (`der`), **grid operations / EMS-DMS-OMS-ADMS** (`gridops`), **product catalog** (`product`), **real estate & rights-of-way** (`property`), **safety & EHS** (`safety`), **technology & IT-OT** (`technology`), **wholesale energy trading** (`trading`), and **customer engagement / DSM/EE programs** (`engagement`).

It is designed for:

- **Enterprise-Scale Utilities** — full vertically-integrated electric + gas operators
- **Full grid value chain** — generation, T&D, retail, wholesale trading, DER orchestration
- **Regulatory & Compliance** — NERC/FERC, state PUC rate cases, environmental, EHS
- **Cross-Functional Analytics** — analysis spanning ops, finance, customer, safety, IT-OT

## Head-to-Head Comparison

| Dimension | MVM (Minimum Viable Model) | ECM (Expanded Coverage Model) |
|---|---|---|
| **Folder Convention** | `mvm_v1` | `ecm_v1` |
| **Target Organization** | Mid-size IOUs/munis/coops, focused teams | Large vertically-integrated utilities |
| **Domain Coverage** | Core ops + business domains | All domains incl. DER, gridops, trading, safety, IT-OT, property |
| **Divisions Included** | Operations, Business | Operations, Business, Corporate |
| **Attribute Depth** | Full (same as ECM) | Full |
| **M:N Associations** | Minimized (direct FKs preferred) | Comprehensive junction tables |
| **Growth Path** | Start here, enlarge to ECM as needed | Complete from day one |
| **Best For** | Quick deployments, focused analytics, POCs | Enterprise-wide analytics, compliance, full grid value chain |

## Model Metrics Comparison

| Metric | MVM (Minimum Viable Model) | ECM (Expanded Coverage Model) |
|---|---|---|
| Domains | 12 | 19 |
| Subdomains | 28 | 64 |
| Products (Tables) | 188 | 375 |
| Attributes (Columns) | 7375 | 13900 |
| Foreign Keys | 889 | 1914 |
| Metric Views | 113 | 87 |
| Avg Attributes/Product | 39.2 | 37.1 |

## Domain & Product Comparison

<a id="domain-asset"></a>
### asset

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_registry | facility | ❌ | ✅ | MVM only (stub or new) |
| asset_registry | hierarchy | ❌ | ✅ | MVM only (stub or new) |
| asset_registry | location | ❌ | ✅ | MVM only (stub or new) |
| asset_registry | master | ❌ | ✅ | MVM only (stub or new) |
| asset_registry | warranty | ❌ | ✅ | MVM only (stub or new) |
| capital_finance | asset_capex_project | ✅ | ❌ | Excluded from MVM |
| capital_finance | compliance_document | ✅ | ❌ | Excluded from MVM |
| capital_finance | depreciation_schedule | ✅ | ❌ | Excluded from MVM |
| condition_monitoring | condition | ❌ | ✅ | MVM only (stub or new) |
| condition_monitoring | failure_event | ❌ | ✅ | MVM only (stub or new) |
| condition_monitoring | inspection_crew | ❌ | ✅ | MVM only (stub or new) |
| condition_monitoring | inspection_record | ❌ | ✅ | MVM only (stub or new) |
| condition_monitoring | inspector | ❌ | ✅ | MVM only (stub or new) |
| health_monitoring | condition_assessment | ✅ | ❌ | Excluded from MVM |
| health_monitoring | failure_event | ✅ | ❌ | Excluded from MVM |
| health_monitoring | operational_reading | ✅ | ❌ | Excluded from MVM |
| health_monitoring | risk_assessment | ✅ | ❌ | Excluded from MVM |
| maintenance_operations | inspection | ✅ | ❌ | Excluded from MVM |
| maintenance_operations | lifecycle_event | ✅ | ❌ | Excluded from MVM |
| maintenance_operations | pm_schedule | ✅ | ✅ |  |
| maintenance_operations | work_order | ✅ | ✅ |  |
| maintenance_operations | work_order_material | ❌ | ✅ | MVM only (stub or new) |
| maintenance_operations | work_order_task | ✅ | ❌ | Excluded from MVM |
| master_registry | classification | ✅ | ❌ | Excluded from MVM |
| master_registry | hierarchy | ✅ | ❌ | Excluded from MVM |
| master_registry | job_plan | ✅ | ❌ | Excluded from MVM |
| master_registry | location | ✅ | ❌ | Excluded from MVM |
| master_registry | parcel_allocation | ✅ | ❌ | Excluded from MVM |
| master_registry | registry | ✅ | ❌ | Excluded from MVM |

<a id="domain-billing"></a>
### billing

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_settlement | collections_action | ❌ | ✅ | MVM only (stub or new) |
| account_settlement | collections_case | ❌ | ✅ | MVM only (stub or new) |
| account_settlement | credit_adjustment | ❌ | ✅ | MVM only (stub or new) |
| account_settlement | payment | ❌ | ✅ | MVM only (stub or new) |
| account_settlement | payment_arrangement | ❌ | ✅ | MVM only (stub or new) |
| billing_operations | adjustment | ✅ | ❌ | Excluded from MVM |
| billing_operations | bill | ✅ | ❌ | Excluded from MVM |
| billing_operations | bill_line_item | ✅ | ❌ | Excluded from MVM |
| billing_operations | billing_account | ✅ | ❌ | Excluded from MVM |
| billing_operations | billing_rate_component | ✅ | ❌ | Excluded from MVM |
| billing_operations | cycle | ✅ | ❌ | Excluded from MVM |
| payment_management | assistance | ✅ | ❌ | Excluded from MVM |
| payment_management | billing_program_enrollment | ✅ | ❌ | Excluded from MVM |
| payment_management | collection_action | ✅ | ❌ | Excluded from MVM |
| payment_management | deposit | ✅ | ❌ | Excluded from MVM |
| payment_management | dispute | ✅ | ❌ | Excluded from MVM |
| payment_management | payment | ✅ | ❌ | Excluded from MVM |
| payment_management | payment_arrangement | ✅ | ❌ | Excluded from MVM |
| revenue_pricing | bill_cycle | ❌ | ✅ | MVM only (stub or new) |
| revenue_pricing | bill_dispute | ❌ | ✅ | MVM only (stub or new) |
| revenue_pricing | billing_service_agreement | ❌ | ✅ | MVM only (stub or new) |
| revenue_pricing | invoice | ❌ | ✅ | MVM only (stub or new) |
| revenue_pricing | invoice_line | ❌ | ✅ | MVM only (stub or new) |
| revenue_pricing | rate_schedule | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-customer"></a>
### customer

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_management | account | ❌ | ✅ | MVM only (stub or new) |
| account_management | account_hierarchy | ❌ | ✅ | MVM only (stub or new) |
| account_management | account_relationship | ✅ | ❌ | Excluded from MVM |
| account_management | business_entity | ✅ | ❌ | Excluded from MVM |
| account_management | contact | ✅ | ✅ |  |
| account_management | credit_profile | ✅ | ❌ | Excluded from MVM |
| account_management | customer_account | ✅ | ❌ | Excluded from MVM |
| account_management | customer_account_plan | ✅ | ❌ | Excluded from MVM |
| account_management | customer_service_agreement | ❌ | ✅ | MVM only (stub or new) |
| account_management | party | ❌ | ✅ | MVM only (stub or new) |
| account_management | person | ✅ | ❌ | Excluded from MVM |
| account_management | preference | ❌ | ✅ | MVM only (stub or new) |
| account_management | premise | ❌ | ✅ | MVM only (stub or new) |
| account_management | segment | ✅ | ❌ | Excluded from MVM |
| account_management | third_party_access | ✅ | ❌ | Excluded from MVM |
| customer_interaction | communication_preference | ✅ | ❌ | Excluded from MVM |
| customer_interaction | complaint | ✅ | ❌ | Excluded from MVM |
| customer_interaction | interaction | ✅ | ❌ | Excluded from MVM |
| program_enrollment | budget_billing_plan | ✅ | ❌ | Excluded from MVM |
| program_enrollment | dr_enrollment | ✅ | ❌ | Excluded from MVM |
| program_enrollment | enrollment | ✅ | ❌ | Excluded from MVM |
| program_enrollment | medical_baseline | ✅ | ❌ | Excluded from MVM |
| program_enrollment | nem_agreement | ✅ | ❌ | Excluded from MVM |
| service_delivery | customer_service_point | ✅ | ❌ | Excluded from MVM |
| service_delivery | move_order | ✅ | ❌ | Excluded from MVM |
| service_delivery | premise | ✅ | ❌ | Excluded from MVM |
| service_delivery | service_agreement | ✅ | ❌ | Excluded from MVM |
| service_delivery | service_territory | ✅ | ❌ | Excluded from MVM |
| service_operations | credit_deposit | ❌ | ✅ | MVM only (stub or new) |
| service_operations | enrollment | ❌ | ✅ | MVM only (stub or new) |
| service_operations | interaction | ❌ | ✅ | MVM only (stub or new) |
| service_operations | move_order | ❌ | ✅ | MVM only (stub or new) |
| service_operations | segment | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-der"></a>
### der

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_registry | aggregation_group | ✅ | ❌ | Domain not in MVM |
| asset_registry | aggregator | ✅ | ❌ | Domain not in MVM |
| asset_registry | community_solar_subscription | ✅ | ❌ | Domain not in MVM |
| asset_registry | microgrid | ✅ | ❌ | Domain not in MVM |
| asset_registry | resource | ✅ | ❌ | Domain not in MVM |
| interconnection_service | interconnection_request | ✅ | ❌ | Domain not in MVM |
| interconnection_service | interconnection_study | ✅ | ❌ | Domain not in MVM |
| interconnection_service | program_zone_assignment | ✅ | ❌ | Domain not in MVM |
| market_operations | bess_operation | ✅ | ❌ | Domain not in MVM |
| market_operations | dispatch_event | ✅ | ❌ | Domain not in MVM |
| market_operations | ev_charging_session | ✅ | ❌ | Domain not in MVM |
| market_operations | nem_true_up | ✅ | ❌ | Domain not in MVM |
| market_operations | performance_summary | ✅ | ❌ | Domain not in MVM |
| program_enrollment | der_program | ✅ | ❌ | Domain not in MVM |
| program_enrollment | der_program_enrollment | ✅ | ❌ | Domain not in MVM |
| program_enrollment | nem_account | ✅ | ❌ | Domain not in MVM |

<a id="domain-distribution"></a>
### distribution

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| electric_network | conductor_span | ✅ | ❌ | Excluded from MVM |
| electric_network | distribution_service_point | ✅ | ❌ | Excluded from MVM |
| electric_network | distribution_substation | ✅ | ❌ | Excluded from MVM |
| electric_network | distribution_transformer | ✅ | ❌ | Excluded from MVM |
| electric_network | feeder | ✅ | ❌ | Excluded from MVM |
| electric_network | load_profile | ✅ | ❌ | Excluded from MVM |
| electric_network | meter_set | ✅ | ❌ | Excluded from MVM |
| electric_network | pole | ✅ | ❌ | Excluded from MVM |
| electric_network | protective_device | ✅ | ❌ | Excluded from MVM |
| electric_network | structure | ✅ | ❌ | Excluded from MVM |
| electric_network | vault | ✅ | ❌ | Excluded from MVM |
| gas_distribution | gas_leak | ✅ | ❌ | Excluded from MVM |
| gas_distribution | gas_main | ✅ | ❌ | Excluded from MVM |
| gas_distribution | gas_network_node | ✅ | ❌ | Excluded from MVM |
| gas_distribution | gas_pressure_district | ✅ | ❌ | Excluded from MVM |
| gas_distribution | gas_service_line | ✅ | ❌ | Excluded from MVM |
| network_infrastructure | bus | ❌ | ✅ | MVM only (stub or new) |
| network_infrastructure | city_gate_station | ❌ | ✅ | MVM only (stub or new) |
| network_infrastructure | der_interconnection | ❌ | ✅ | MVM only (stub or new) |
| network_infrastructure | distribution_substation | ❌ | ✅ | MVM only (stub or new) |
| network_infrastructure | district | ❌ | ✅ | MVM only (stub or new) |
| network_infrastructure | feeder | ❌ | ✅ | MVM only (stub or new) |
| network_infrastructure | gas_main | ❌ | ✅ | MVM only (stub or new) |
| network_infrastructure | gas_network_node | ❌ | ✅ | MVM only (stub or new) |
| network_infrastructure | gas_service_lateral | ❌ | ✅ | MVM only (stub or new) |
| network_infrastructure | network_model | ❌ | ✅ | MVM only (stub or new) |
| network_infrastructure | pole | ❌ | ✅ | MVM only (stub or new) |
| network_infrastructure | protective_device | ❌ | ✅ | MVM only (stub or new) |
| network_infrastructure | service_area | ❌ | ✅ | MVM only (stub or new) |
| network_infrastructure | service_point | ❌ | ✅ | MVM only (stub or new) |
| network_infrastructure | service_territory | ❌ | ✅ | MVM only (stub or new) |
| network_infrastructure | service_transformer | ❌ | ✅ | MVM only (stub or new) |
| network_infrastructure | voltage_regulation_device | ❌ | ✅ | MVM only (stub or new) |
| network_infrastructure | zone | ❌ | ✅ | MVM only (stub or new) |
| operational_events | crew_dispatch | ❌ | ✅ | MVM only (stub or new) |
| operational_events | demand_response_event | ❌ | ✅ | MVM only (stub or new) |
| operational_events | der_dispatch | ❌ | ✅ | MVM only (stub or new) |
| operational_events | distribution_outage_event | ❌ | ✅ | MVM only (stub or new) |
| operational_events | gas_leak_survey | ❌ | ✅ | MVM only (stub or new) |
| operational_events | load_profile | ❌ | ✅ | MVM only (stub or new) |
| operational_events | reliability_index | ❌ | ✅ | MVM only (stub or new) |
| operational_events | service_point_dr_participation | ❌ | ✅ | MVM only (stub or new) |
| operational_events | switching_operation | ❌ | ✅ | MVM only (stub or new) |
| operations_management | distribution_outage_event | ✅ | ❌ | Excluded from MVM |
| operations_management | distribution_switching_order | ✅ | ❌ | Excluded from MVM |
| operations_management | feeder_crew_assignment | ✅ | ❌ | Excluded from MVM |
| operations_management | gas_leak_survey | ✅ | ❌ | Excluded from MVM |
| operations_management | service_connection_order | ✅ | ❌ | Excluded from MVM |

<a id="domain-engagement"></a>
### engagement

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| account_management | ci_account | ✅ | ❌ | Domain not in MVM |
| account_management | engagement_account_plan | ✅ | ❌ | Domain not in MVM |
| account_management | key_account_manager | ✅ | ❌ | Domain not in MVM |
| account_management | large_customer_contract | ✅ | ❌ | Domain not in MVM |
| account_management | opportunity | ✅ | ❌ | Domain not in MVM |
| customer_engagement | crm_interaction | ✅ | ❌ | Domain not in MVM |
| customer_engagement | outreach_campaign | ✅ | ❌ | Domain not in MVM |
| customer_engagement | satisfaction_survey | ✅ | ❌ | Domain not in MVM |
| demand_programs | dr_event_participation | ✅ | ❌ | Domain not in MVM |
| demand_programs | dsm_incentive_payment | ✅ | ❌ | Domain not in MVM |
| demand_programs | dsm_program | ✅ | ❌ | Domain not in MVM |
| demand_programs | energy_audit | ✅ | ❌ | Domain not in MVM |
| demand_programs | vpp_agreement | ✅ | ❌ | Domain not in MVM |

<a id="domain-finance"></a>
### finance

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| accounting_operations | cost_center | ❌ | ✅ | MVM only (stub or new) |
| accounting_operations | financial_period | ❌ | ✅ | MVM only (stub or new) |
| accounting_operations | gl_account | ❌ | ✅ | MVM only (stub or new) |
| accounting_operations | journal_entry | ❌ | ✅ | MVM only (stub or new) |
| accounting_operations | journal_entry_line | ❌ | ✅ | MVM only (stub or new) |
| accounting_operations | journal_entry_template | ❌ | ✅ | MVM only (stub or new) |
| accounting_operations | opex_transaction | ❌ | ✅ | MVM only (stub or new) |
| accounting_operations | organization | ❌ | ✅ | MVM only (stub or new) |
| accounting_operations | profit_center | ❌ | ✅ | MVM only (stub or new) |
| asset_accounting | depreciation_area | ✅ | ❌ | Excluded from MVM |
| asset_accounting | depreciation_run | ✅ | ❌ | Excluded from MVM |
| asset_accounting | finance_capex_project | ✅ | ❌ | Excluded from MVM |
| asset_accounting | fixed_asset | ✅ | ❌ | Excluded from MVM |
| asset_accounting | rate_base | ✅ | ❌ | Excluded from MVM |
| asset_accounting | regulatory_asset | ✅ | ❌ | Excluded from MVM |
| asset_accounting | wbs_element | ✅ | ❌ | Excluded from MVM |
| capital_management | budget | ❌ | ✅ | MVM only (stub or new) |
| capital_management | capex_expenditure | ❌ | ✅ | MVM only (stub or new) |
| capital_management | capex_project | ❌ | ✅ | MVM only (stub or new) |
| capital_management | depreciation_run | ❌ | ✅ | MVM only (stub or new) |
| capital_management | depreciation_study | ❌ | ✅ | MVM only (stub or new) |
| capital_management | fixed_asset | ❌ | ✅ | MVM only (stub or new) |
| capital_management | wbs_element | ❌ | ✅ | MVM only (stub or new) |
| cash_operations | ap_invoice | ✅ | ❌ | Excluded from MVM |
| cash_operations | ar_transaction | ✅ | ❌ | Excluded from MVM |
| cash_operations | bank_account | ✅ | ❌ | Excluded from MVM |
| cash_operations | finance_lease | ✅ | ❌ | Excluded from MVM |
| cash_operations | fund | ✅ | ❌ | Excluded from MVM |
| cash_operations | intercompany_transaction | ✅ | ❌ | Excluded from MVM |
| cash_operations | legal_entity | ✅ | ❌ | Excluded from MVM |
| cash_operations | payment_run | ✅ | ❌ | Excluded from MVM |
| cash_operations | profit_center | ✅ | ❌ | Excluded from MVM |
| cost_control | budget | ✅ | ❌ | Excluded from MVM |
| cost_control | budget_line | ✅ | ❌ | Excluded from MVM |
| cost_control | cost_allocation | ✅ | ❌ | Excluded from MVM |
| cost_control | cost_center | ✅ | ❌ | Excluded from MVM |
| cost_control | internal_order | ✅ | ❌ | Excluded from MVM |
| general_ledger | chart_of_accounts | ✅ | ❌ | Excluded from MVM |
| general_ledger | financial_statement | ✅ | ❌ | Excluded from MVM |
| general_ledger | gl_account | ✅ | ❌ | Excluded from MVM |
| general_ledger | journal_entry | ✅ | ❌ | Excluded from MVM |
| general_ledger | journal_entry_line | ✅ | ❌ | Excluded from MVM |
| general_ledger | tax_provision | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | rate_case_cost_study | ❌ | ✅ | MVM only (stub or new) |
| regulatory_compliance | regulatory_asset_entry | ❌ | ✅ | MVM only (stub or new) |
| regulatory_compliance | regulatory_deferral | ❌ | ✅ | MVM only (stub or new) |
| regulatory_compliance | tax_provision | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-generation"></a>
### generation

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_operations | dispatch_schedule | ❌ | ✅ | MVM only (stub or new) |
| asset_operations | generating_unit | ❌ | ✅ | MVM only (stub or new) |
| asset_operations | generation_outage_event | ❌ | ✅ | MVM only (stub or new) |
| asset_operations | plant | ❌ | ✅ | MVM only (stub or new) |
| asset_operations | unit_output | ❌ | ✅ | MVM only (stub or new) |
| fuel_management | fuel_consumption | ❌ | ✅ | MVM only (stub or new) |
| fuel_management | fuel_contract | ❌ | ✅ | MVM only (stub or new) |
| fuel_management | fuel_inventory | ❌ | ✅ | MVM only (stub or new) |
| generation_operations | energy_output | ✅ | ❌ | Excluded from MVM |
| generation_operations | forecast | ✅ | ❌ | Excluded from MVM |
| generation_operations | generation_outage | ✅ | ❌ | Excluded from MVM |
| generation_operations | startup_shutdown_event | ✅ | ❌ | Excluded from MVM |
| generation_operations | unit_availability | ✅ | ❌ | Excluded from MVM |
| market_compliance | allocation | ✅ | ❌ | Excluded from MVM |
| market_compliance | audit_plant_assignment | ✅ | ❌ | Excluded from MVM |
| market_compliance | emissions_record | ✅ | ❌ | Excluded from MVM |
| market_compliance | fuel_consumption | ✅ | ❌ | Excluded from MVM |
| market_compliance | ppa_delivery | ✅ | ❌ | Excluded from MVM |
| market_compliance | rec_certificate | ✅ | ❌ | Excluded from MVM |
| plant_management | capacity_resource | ✅ | ❌ | Excluded from MVM |
| plant_management | generating_unit | ✅ | ❌ | Excluded from MVM |
| plant_management | nuclear_fuel_cycle | ✅ | ❌ | Excluded from MVM |
| plant_management | plant | ✅ | ❌ | Excluded from MVM |
| plant_management | renewable_resource | ✅ | ❌ | Excluded from MVM |
| regulatory_compliance | capacity_resource | ❌ | ✅ | MVM only (stub or new) |
| regulatory_compliance | emissions_record | ❌ | ✅ | MVM only (stub or new) |
| regulatory_compliance | environmental_permit | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-gridops"></a>
### gridops

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_management | balancing_area | ✅ | ❌ | Domain not in MVM |
| asset_management | control_center | ✅ | ❌ | Domain not in MVM |
| asset_management | control_zone | ✅ | ❌ | Domain not in MVM |
| asset_management | grid_contingency | ✅ | ❌ | Domain not in MVM |
| asset_management | scada_point | ✅ | ❌ | Domain not in MVM |
| asset_management | switching_order_material_allocation | ✅ | ❌ | Domain not in MVM |
| asset_management | transmission_limit | ✅ | ❌ | Domain not in MVM |
| operational_planning | dispatch_participation | ✅ | ❌ | Domain not in MVM |
| operational_planning | ems_dispatch_instruction | ✅ | ❌ | Domain not in MVM |
| operational_planning | energy_balance | ✅ | ❌ | Domain not in MVM |
| operational_planning | load_forecast | ✅ | ❌ | Domain not in MVM |
| operational_planning | operator_log | ✅ | ❌ | Domain not in MVM |
| operational_planning | weather_forecast | ✅ | ❌ | Domain not in MVM |
| reliability_operations | alarm_event | ✅ | ❌ | Domain not in MVM |
| reliability_operations | dr_dispatch_event | ✅ | ❌ | Domain not in MVM |
| reliability_operations | dr_resource_response | ✅ | ❌ | Domain not in MVM |
| reliability_operations | frequency_regulation_event | ✅ | ❌ | Domain not in MVM |
| reliability_operations | gridops_outage_event | ✅ | ❌ | Domain not in MVM |
| reliability_operations | gridops_switching_order | ✅ | ❌ | Domain not in MVM |
| reliability_operations | outage_restoration_log | ✅ | ❌ | Domain not in MVM |
| reliability_operations | reliability_event | ✅ | ❌ | Domain not in MVM |
| reliability_operations | scada_reading | ✅ | ❌ | Domain not in MVM |
| reliability_operations | security_assessment | ✅ | ❌ | Domain not in MVM |
| reliability_operations | switching_step | ✅ | ❌ | Domain not in MVM |
| reliability_operations | voltage_control_action | ✅ | ❌ | Domain not in MVM |

<a id="domain-market"></a>
### market

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| capacity_management | ancillary_service_award | ❌ | ✅ | MVM only (stub or new) |
| capacity_management | capacity_market_auction | ❌ | ✅ | MVM only (stub or new) |
| capacity_management | capacity_obligation | ❌ | ✅ | MVM only (stub or new) |
| capacity_management | capacity_transfer_agreement | ❌ | ✅ | MVM only (stub or new) |
| capacity_management | demand_response_program | ❌ | ✅ | MVM only (stub or new) |
| capacity_management | rec_inventory | ❌ | ✅ | MVM only (stub or new) |
| capacity_management | rec_transaction | ❌ | ✅ | MVM only (stub or new) |
| capacity_management | transmission_right | ❌ | ✅ | MVM only (stub or new) |
| capacity_management | transmission_rights_portfolio | ❌ | ✅ | MVM only (stub or new) |
| energy_trading | dispatch_award | ❌ | ✅ | MVM only (stub or new) |
| energy_trading | energy_bid | ❌ | ✅ | MVM only (stub or new) |
| energy_trading | lmp_price | ❌ | ✅ | MVM only (stub or new) |
| energy_trading | market_zone | ❌ | ✅ | MVM only (stub or new) |
| energy_trading | participant_registration | ❌ | ✅ | MVM only (stub or new) |
| energy_trading | ppa_contract | ❌ | ✅ | MVM only (stub or new) |
| energy_trading | pricing_node | ❌ | ✅ | MVM only (stub or new) |
| energy_trading | rto_iso | ❌ | ✅ | MVM only (stub or new) |
| energy_trading | wholesale_counterparty | ❌ | ✅ | MVM only (stub or new) |
| financial_settlement | settlement_line_item | ❌ | ✅ | MVM only (stub or new) |
| financial_settlement | settlement_statement | ❌ | ✅ | MVM only (stub or new) |

<a id="domain-metering"></a>
### metering

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_registry | ami_endpoint | ❌ | ✅ | MVM only (stub or new) |
| asset_registry | meter | ❌ | ✅ | MVM only (stub or new) |
| asset_registry | meter_channel | ❌ | ✅ | MVM only (stub or new) |
| asset_registry | meter_configuration | ❌ | ✅ | MVM only (stub or new) |
| asset_registry | meter_premise | ❌ | ✅ | MVM only (stub or new) |
| asset_registry | read_cycle | ❌ | ✅ | MVM only (stub or new) |
| asset_registry | tou_schedule | ❌ | ✅ | MVM only (stub or new) |
| asset_registry | vee_rule_set | ❌ | ✅ | MVM only (stub or new) |
| consumption_operations | daily_usage_summary | ❌ | ✅ | MVM only (stub or new) |
| consumption_operations | interval_read | ❌ | ✅ | MVM only (stub or new) |
| consumption_operations | meter_event | ❌ | ✅ | MVM only (stub or new) |
| consumption_operations | meter_program_enrollment | ❌ | ✅ | MVM only (stub or new) |
| consumption_operations | meter_test | ❌ | ✅ | MVM only (stub or new) |
| consumption_operations | register_read | ❌ | ✅ | MVM only (stub or new) |
| consumption_operations | remote_service_action | ❌ | ✅ | MVM only (stub or new) |
| consumption_operations | vee_event | ❌ | ✅ | MVM only (stub or new) |
| data_collection | interval_read | ✅ | ❌ | Excluded from MVM |
| data_collection | meter_event | ✅ | ❌ | Excluded from MVM |
| data_collection | register_read | ✅ | ❌ | Excluded from MVM |
| meter_asset | load_profile | ✅ | ❌ | Excluded from MVM |
| meter_asset | meter | ✅ | ❌ | Excluded from MVM |
| meter_asset | meter_configuration | ✅ | ❌ | Excluded from MVM |
| meter_asset | meter_premise | ✅ | ❌ | Excluded from MVM |
| meter_asset | metering_service_point | ✅ | ❌ | Excluded from MVM |
| meter_asset | register | ✅ | ❌ | Excluded from MVM |
| validation_rules | meter_test | ✅ | ❌ | Excluded from MVM |
| validation_rules | vee_result | ✅ | ❌ | Excluded from MVM |
| validation_rules | vee_rule | ✅ | ❌ | Excluded from MVM |
| work_scheduling | meter_read_schedule | ✅ | ❌ | Excluded from MVM |
| work_scheduling | meter_work_order_assignment | ✅ | ❌ | Excluded from MVM |
| work_scheduling | metering_enrollment | ✅ | ❌ | Excluded from MVM |
| work_scheduling | tou_schedule | ✅ | ❌ | Excluded from MVM |

<a id="domain-product"></a>
### product

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| program_administration | ee_measure | ✅ | ❌ | Domain not in MVM |
| program_administration | eligibility_rule | ✅ | ❌ | Domain not in MVM |
| program_administration | product_program | ✅ | ❌ | Domain not in MVM |
| program_administration | program_measure | ✅ | ❌ | Domain not in MVM |
| program_administration | service_plan | ✅ | ❌ | Domain not in MVM |
| program_administration | special_contract | ✅ | ❌ | Domain not in MVM |
| rate_management | product_rate_component | ✅ | ❌ | Domain not in MVM |
| rate_management | product_tariff_rider | ✅ | ❌ | Domain not in MVM |
| rate_management | rate_schedule | ✅ | ❌ | Domain not in MVM |
| rate_management | rate_schedule_applicability | ✅ | ❌ | Domain not in MVM |
| rate_management | rate_schedule_version | ✅ | ❌ | Domain not in MVM |
| rate_management | rate_season_calendar | ✅ | ❌ | Domain not in MVM |
| rate_management | rate_tier | ✅ | ❌ | Domain not in MVM |
| rate_management | tou_period | ✅ | ❌ | Domain not in MVM |

<a id="domain-property"></a>
### property

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_management | document | ✅ | ❌ | Domain not in MVM |
| asset_management | easement | ✅ | ❌ | Domain not in MVM |
| asset_management | facility | ✅ | ❌ | Domain not in MVM |
| asset_management | gis_boundary | ✅ | ❌ | Domain not in MVM |
| asset_management | land_right | ✅ | ❌ | Domain not in MVM |
| asset_management | parcel | ✅ | ❌ | Domain not in MVM |
| asset_management | site | ✅ | ❌ | Domain not in MVM |
| asset_management | space_allocation | ✅ | ❌ | Domain not in MVM |
| asset_management | survey | ✅ | ❌ | Domain not in MVM |
| asset_management | title_record | ✅ | ❌ | Domain not in MVM |
| financial_operations | acquisition | ✅ | ❌ | Domain not in MVM |
| financial_operations | appraisal | ✅ | ❌ | Domain not in MVM |
| financial_operations | disposition | ✅ | ❌ | Domain not in MVM |
| financial_operations | lease_payment | ✅ | ❌ | Domain not in MVM |
| financial_operations | property_lease | ✅ | ❌ | Domain not in MVM |
| financial_operations | tax_record | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | condemnation_proceeding | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | encroachment | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | environmental_condition | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | facility_inspection | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | license_agreement | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | permit | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | remediation_activity | ✅ | ❌ | Domain not in MVM |
| regulatory_compliance | zoning_classification | ✅ | ❌ | Domain not in MVM |

<a id="domain-regulatory"></a>
### regulatory

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_management | cip_asset_classification | ✅ | ❌ | Excluded from MVM |
| compliance_management | cip_standard | ✅ | ❌ | Excluded from MVM |
| compliance_management | compliance_evidence | ✅ | ❌ | Excluded from MVM |
| compliance_management | compliance_obligation | ✅ | ❌ | Excluded from MVM |
| compliance_management | emission_allowance | ✅ | ❌ | Excluded from MVM |
| compliance_management | environmental_permit | ✅ | ❌ | Excluded from MVM |
| compliance_management | mitigation_plan | ✅ | ❌ | Excluded from MVM |
| compliance_management | rab_asset | ✅ | ❌ | Excluded from MVM |
| compliance_management | rec_inventory | ✅ | ❌ | Excluded from MVM |
| compliance_management | regulatory_audit | ✅ | ❌ | Excluded from MVM |
| compliance_management | rps_obligation | ✅ | ❌ | Excluded from MVM |
| compliance_management | violation_notice | ✅ | ❌ | Excluded from MVM |
| obligation_tracking | compliance_event | ❌ | ✅ | MVM only (stub or new) |
| obligation_tracking | compliance_obligation | ❌ | ✅ | MVM only (stub or new) |
| obligation_tracking | corrective_action_plan | ❌ | ✅ | MVM only (stub or new) |
| obligation_tracking | emissions_report | ❌ | ✅ | MVM only (stub or new) |
| obligation_tracking | violation | ❌ | ✅ | MVM only (stub or new) |
| proceeding_management | commission_order | ❌ | ✅ | MVM only (stub or new) |
| proceeding_management | compliance_calendar | ❌ | ✅ | MVM only (stub or new) |
| proceeding_management | cost_recovery_mechanism | ❌ | ✅ | MVM only (stub or new) |
| proceeding_management | cpcn_application | ❌ | ✅ | MVM only (stub or new) |
| proceeding_management | docket | ❌ | ✅ | MVM only (stub or new) |
| proceeding_management | filing | ❌ | ✅ | MVM only (stub or new) |
| proceeding_management | irp_portfolio | ❌ | ✅ | MVM only (stub or new) |
| proceeding_management | irp_submission | ❌ | ✅ | MVM only (stub or new) |
| proceeding_management | prudency_review | ❌ | ✅ | MVM only (stub or new) |
| proceeding_management | rate_case | ❌ | ✅ | MVM only (stub or new) |
| proceeding_management | rider_charge | ❌ | ✅ | MVM only (stub or new) |
| proceeding_management | rps_program | ❌ | ✅ | MVM only (stub or new) |
| proceeding_management | tariff_schedule | ❌ | ✅ | MVM only (stub or new) |
| regulatory_filings | cpcn_application | ✅ | ❌ | Excluded from MVM |
| regulatory_filings | docket | ✅ | ❌ | Excluded from MVM |
| regulatory_filings | eia_report | ✅ | ❌ | Excluded from MVM |
| regulatory_filings | ferc_form | ✅ | ❌ | Excluded from MVM |
| regulatory_filings | filing | ✅ | ❌ | Excluded from MVM |
| regulatory_filings | irp_submission | ✅ | ❌ | Excluded from MVM |
| regulatory_filings | rate_case | ✅ | ❌ | Excluded from MVM |
| regulatory_filings | regulatory_tariff_rider | ✅ | ❌ | Excluded from MVM |
| regulatory_filings | tariff_schedule | ✅ | ❌ | Excluded from MVM |
| stakeholder_communication | body | ✅ | ❌ | Excluded from MVM |
| stakeholder_communication | commission_order | ✅ | ❌ | Excluded from MVM |
| stakeholder_communication | correspondence | ✅ | ❌ | Excluded from MVM |
| stakeholder_communication | rate_case_testimony | ✅ | ❌ | Excluded from MVM |

<a id="domain-safety"></a>
### safety

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| compliance_records | cip_compliance_record | ✅ | ❌ | Domain not in MVM |
| compliance_records | emergency_drill | ✅ | ❌ | Domain not in MVM |
| compliance_records | emergency_response_plan | ✅ | ❌ | Domain not in MVM |
| environmental_monitoring | environmental_compliance | ✅ | ❌ | Domain not in MVM |
| environmental_monitoring | environmental_emission | ✅ | ❌ | Domain not in MVM |
| environmental_monitoring | pipeline_integrity_assessment | ✅ | ❌ | Domain not in MVM |
| hazard_management | hazmat_inventory | ✅ | ❌ | Domain not in MVM |
| hazard_management | hazmat_release | ✅ | ❌ | Domain not in MVM |
| hazard_management | job_hazard_analysis | ✅ | ❌ | Domain not in MVM |
| incident_response | audit_finding | ✅ | ❌ | Domain not in MVM |
| incident_response | corrective_action | ✅ | ❌ | Domain not in MVM |
| incident_response | incident | ✅ | ❌ | Domain not in MVM |
| incident_response | safety_audit | ✅ | ❌ | Domain not in MVM |
| safety_programs | observation | ✅ | ❌ | Domain not in MVM |
| safety_programs | permit_to_work | ✅ | ❌ | Domain not in MVM |
| safety_programs | safety_program | ✅ | ❌ | Domain not in MVM |
| safety_programs | training | ✅ | ❌ | Domain not in MVM |

<a id="domain-supply"></a>
### supply

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| fuel_logistics | fuel_receipt | ✅ | ❌ | Excluded from MVM |
| fuel_logistics | fuel_supply_schedule | ✅ | ❌ | Excluded from MVM |
| fuel_logistics | shipment | ✅ | ❌ | Excluded from MVM |
| inventory_operations | goods_issue | ❌ | ✅ | MVM only (stub or new) |
| inventory_operations | goods_receipt | ❌ | ✅ | MVM only (stub or new) |
| inventory_operations | inventory_stock | ❌ | ✅ | MVM only (stub or new) |
| inventory_operations | material_master | ❌ | ✅ | MVM only (stub or new) |
| inventory_operations | material_reservation | ❌ | ✅ | MVM only (stub or new) |
| inventory_operations | stock_transfer | ❌ | ✅ | MVM only (stub or new) |
| inventory_operations | warehouse | ❌ | ✅ | MVM only (stub or new) |
| procurement_transactions | fuel_delivery | ❌ | ✅ | MVM only (stub or new) |
| procurement_transactions | po_line_item | ❌ | ✅ | MVM only (stub or new) |
| procurement_transactions | purchase_order | ❌ | ✅ | MVM only (stub or new) |
| procurement_transactions | purchase_requisition | ❌ | ✅ | MVM only (stub or new) |
| purchase_execution | goods_receipt | ✅ | ❌ | Excluded from MVM |
| purchase_execution | inventory_stock | ✅ | ❌ | Excluded from MVM |
| purchase_execution | invoice_verification | ✅ | ❌ | Excluded from MVM |
| purchase_execution | material_master | ✅ | ❌ | Excluded from MVM |
| purchase_execution | po_line_item | ✅ | ❌ | Excluded from MVM |
| purchase_execution | procurement_contract | ✅ | ❌ | Excluded from MVM |
| purchase_execution | purchase_order | ✅ | ❌ | Excluded from MVM |
| purchase_execution | requisition | ✅ | ❌ | Excluded from MVM |
| purchase_execution | rfq | ✅ | ❌ | Excluded from MVM |
| purchase_execution | service_entry_sheet | ✅ | ❌ | Excluded from MVM |
| purchase_execution | stock_movement | ✅ | ❌ | Excluded from MVM |
| purchase_execution | warehouse | ✅ | ❌ | Excluded from MVM |
| vendor_management | procurement_contract | ❌ | ✅ | MVM only (stub or new) |
| vendor_management | vendor | ❌ | ✅ | MVM only (stub or new) |
| vendor_management | vendor_invoice | ❌ | ✅ | MVM only (stub or new) |
| vendor_management | vendor_performance | ❌ | ✅ | MVM only (stub or new) |
| vendor_relations | vendor | ✅ | ❌ | Excluded from MVM |
| vendor_relations | vendor_performance | ✅ | ❌ | Excluded from MVM |
| vendor_relations | vendor_qualification | ✅ | ❌ | Excluded from MVM |
| vendor_relations | vendor_quotation | ✅ | ❌ | Excluded from MVM |

<a id="domain-technology"></a>
### technology

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_management | application | ✅ | ❌ | Domain not in MVM |
| asset_management | it_asset | ✅ | ❌ | Domain not in MVM |
| asset_management | network_device | ✅ | ❌ | Domain not in MVM |
| asset_management | ot_asset | ✅ | ❌ | Domain not in MVM |
| asset_management | scada_system | ✅ | ❌ | Domain not in MVM |
| asset_management | software_license | ✅ | ❌ | Domain not in MVM |
| asset_management | telecom_circuit | ✅ | ❌ | Domain not in MVM |
| project_finance | disaster_recovery_plan | ✅ | ❌ | Domain not in MVM |
| project_finance | dr_test_event | ✅ | ❌ | Domain not in MVM |
| project_finance | project_milestone | ✅ | ❌ | Domain not in MVM |
| project_finance | tech_project | ✅ | ❌ | Domain not in MVM |
| project_finance | tech_spend | ✅ | ❌ | Domain not in MVM |
| project_finance | tech_vendor | ✅ | ❌ | Domain not in MVM |
| security_governance | access_entitlement | ✅ | ❌ | Domain not in MVM |
| security_governance | access_review | ✅ | ❌ | Domain not in MVM |
| security_governance | cyber_incident | ✅ | ❌ | Domain not in MVM |
| security_governance | cyber_vulnerability | ✅ | ❌ | Domain not in MVM |
| security_governance | patch_deployment | ✅ | ❌ | Domain not in MVM |
| security_governance | scada_configuration | ✅ | ❌ | Domain not in MVM |
| security_governance | supply_chain_risk | ✅ | ❌ | Domain not in MVM |
| service_operations | change_request | ✅ | ❌ | Domain not in MVM |
| service_operations | digital_platform | ✅ | ❌ | Domain not in MVM |
| service_operations | incident_ticket | ✅ | ❌ | Domain not in MVM |
| service_operations | it_service | ✅ | ❌ | Domain not in MVM |
| service_operations | it_sla | ✅ | ❌ | Domain not in MVM |
| service_operations | platform_release | ✅ | ❌ | Domain not in MVM |
| service_operations | service_request_ticket | ✅ | ❌ | Domain not in MVM |

<a id="domain-trading"></a>
### trading

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| portfolio_analytics | counterparty | ✅ | ❌ | Domain not in MVM |
| portfolio_analytics | lmp_price | ✅ | ❌ | Domain not in MVM |
| portfolio_analytics | market | ✅ | ❌ | Domain not in MVM |
| portfolio_analytics | portfolio | ✅ | ❌ | Domain not in MVM |
| portfolio_analytics | position | ✅ | ❌ | Domain not in MVM |
| portfolio_analytics | ppa_contract | ✅ | ❌ | Domain not in MVM |
| portfolio_analytics | pricing_node | ✅ | ❌ | Domain not in MVM |
| portfolio_analytics | rec_transaction | ✅ | ❌ | Domain not in MVM |
| risk_governance | credit_exposure | ✅ | ❌ | Domain not in MVM |
| risk_governance | hedge_program | ✅ | ❌ | Domain not in MVM |
| risk_governance | mtm_valuation | ✅ | ❌ | Domain not in MVM |
| risk_governance | risk_limit | ✅ | ❌ | Domain not in MVM |
| trade_operations | ancillary_award | ✅ | ❌ | Domain not in MVM |
| trade_operations | market_bid | ✅ | ❌ | Domain not in MVM |
| trade_operations | settlement | ✅ | ❌ | Domain not in MVM |
| trade_operations | trade | ✅ | ❌ | Domain not in MVM |
| trade_operations | trade_leg | ✅ | ❌ | Domain not in MVM |

<a id="domain-transmission"></a>
### transmission

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| asset_infrastructure | bus | ❌ | ✅ | MVM only (stub or new) |
| asset_infrastructure | grid_topology | ❌ | ✅ | MVM only (stub or new) |
| asset_infrastructure | line | ❌ | ✅ | MVM only (stub or new) |
| asset_infrastructure | nerc_cip_asset | ❌ | ✅ | MVM only (stub or new) |
| asset_infrastructure | protection_system | ❌ | ✅ | MVM only (stub or new) |
| asset_infrastructure | transformer | ❌ | ✅ | MVM only (stub or new) |
| asset_infrastructure | transmission_substation | ❌ | ✅ | MVM only (stub or new) |
| asset_management | bus | ✅ | ❌ | Excluded from MVM |
| asset_management | line | ✅ | ❌ | Excluded from MVM |
| asset_management | line_rating | ✅ | ❌ | Excluded from MVM |
| asset_management | protection_relay | ✅ | ❌ | Excluded from MVM |
| asset_management | right_of_way | ✅ | ❌ | Excluded from MVM |
| asset_management | right_of_way_agreement | ✅ | ❌ | Excluded from MVM |
| asset_management | transmission_substation | ✅ | ❌ | Excluded from MVM |
| asset_management | transmission_transformer | ✅ | ❌ | Excluded from MVM |
| asset_management | vegetation_inspection | ✅ | ❌ | Excluded from MVM |
| network_operations | contingency | ✅ | ❌ | Excluded from MVM |
| network_operations | contingency_violation | ✅ | ❌ | Excluded from MVM |
| network_operations | interchange_schedule | ✅ | ❌ | Excluded from MVM |
| network_operations | power_flow_snapshot | ✅ | ❌ | Excluded from MVM |
| network_operations | relay_test_event | ✅ | ❌ | Excluded from MVM |
| network_operations | service_request | ✅ | ❌ | Excluded from MVM |
| network_operations | topology | ✅ | ❌ | Excluded from MVM |
| network_operations | transmission_outage | ✅ | ❌ | Excluded from MVM |
| network_operations | transmission_switching_order | ✅ | ❌ | Excluded from MVM |
| operational_coordination | balancing_authority | ❌ | ✅ | MVM only (stub or new) |
| operational_coordination | congestion_event | ❌ | ✅ | MVM only (stub or new) |
| operational_coordination | constrained_element | ❌ | ✅ | MVM only (stub or new) |
| operational_coordination | contingency_scenario | ❌ | ✅ | MVM only (stub or new) |
| operational_coordination | control_area | ❌ | ✅ | MVM only (stub or new) |
| operational_coordination | control_center | ❌ | ✅ | MVM only (stub or new) |
| operational_coordination | crew | ❌ | ✅ | MVM only (stub or new) |
| operational_coordination | flowgate | ❌ | ✅ | MVM only (stub or new) |
| operational_coordination | interchange_schedule | ❌ | ✅ | MVM only (stub or new) |
| operational_coordination | interconnection_request | ❌ | ✅ | MVM only (stub or new) |
| operational_coordination | operator | ❌ | ✅ | MVM only (stub or new) |
| operational_coordination | outage | ❌ | ✅ | MVM only (stub or new) |
| operational_coordination | service_request | ❌ | ✅ | MVM only (stub or new) |
| operational_coordination | switching_order | ❌ | ✅ | MVM only (stub or new) |
| operational_coordination | tariff_rate | ❌ | ✅ | MVM only (stub or new) |
| operational_coordination | transfer_capability | ❌ | ✅ | MVM only (stub or new) |
| planning_engineering | interconnection_agreement | ✅ | ❌ | Excluded from MVM |
| planning_engineering | line_project_assignment | ✅ | ❌ | Excluded from MVM |
| planning_engineering | planning_study | ✅ | ❌ | Excluded from MVM |
| planning_engineering | tariff | ✅ | ❌ | Excluded from MVM |

<a id="domain-workforce"></a>
### workforce

| Subdomain | Product | ECM | MVM | Notes |
|---|---|:---:|:---:|---|
| crew_operations | asset_technician_authorization | ✅ | ❌ | Excluded from MVM |
| crew_operations | crew | ✅ | ❌ | Excluded from MVM |
| crew_operations | crew_member | ✅ | ❌ | Excluded from MVM |
| crew_operations | depot | ✅ | ❌ | Excluded from MVM |
| crew_operations | dispatch_zone | ✅ | ❌ | Excluded from MVM |
| crew_operations | line_crew_assignment | ✅ | ❌ | Excluded from MVM |
| crew_operations | technician | ✅ | ❌ | Excluded from MVM |
| crew_operations | vehicle | ✅ | ❌ | Excluded from MVM |
| crew_operations | work_order_assignment | ✅ | ❌ | Excluded from MVM |
| labor_management | absence | ✅ | ❌ | Excluded from MVM |
| labor_management | employee | ✅ | ❌ | Excluded from MVM |
| labor_management | labor_rate | ✅ | ❌ | Excluded from MVM |
| labor_management | payroll_period | ✅ | ❌ | Excluded from MVM |
| labor_management | qualification | ✅ | ❌ | Excluded from MVM |
| labor_management | technician_qualification | ✅ | ❌ | Excluded from MVM |
| labor_management | union_agreement | ✅ | ❌ | Excluded from MVM |
| storm_response | storm_assignment | ✅ | ❌ | Excluded from MVM |
| storm_response | storm_event | ✅ | ❌ | Excluded from MVM |
| storm_response | storm_parcel_impact | ✅ | ❌ | Excluded from MVM |
| workforce_core | department | ❌ | ✅ | MVM only (stub or new) |
| workforce_core | employee | ❌ | ✅ | MVM only (stub or new) |
| workforce_scheduling | on_call_rotation | ✅ | ❌ | Excluded from MVM |
| workforce_scheduling | schedule | ✅ | ❌ | Excluded from MVM |
| workforce_scheduling | shift | ✅ | ❌ | Excluded from MVM |
| workforce_scheduling | time_entry | ✅ | ❌ | Excluded from MVM |

