-- Metric views for domain: workforce | Business: Power and Utilities | Version: 1 | Generated on: 2026-04-29 23:09:06

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`workforce_employee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core workforce metrics tracking employee headcount, tenure, turnover, and workforce composition for strategic HR planning and operational decision-making"
  source: "`power_and_utilities`.`workforce`.`employee`"
  dimensions:
    - name: "employment_status"
      expr: employment_status
      comment: "Current employment status (active, terminated, leave, etc.) for workforce segmentation"
    - name: "employment_type"
      expr: employment_type
      comment: "Employment type classification (full-time, part-time, contractor, etc.) for workforce mix analysis"
    - name: "job_title"
      expr: job_title
      comment: "Employee job title for role-based workforce analysis"
    - name: "department_id"
      expr: department_id
      comment: "Department identifier for organizational unit analysis"
    - name: "union_member_flag"
      expr: union_member_flag
      comment: "Union membership indicator for labor relations analysis"
    - name: "exempt_status"
      expr: exempt_status
      comment: "FLSA exempt/non-exempt status for compensation and overtime planning"
    - name: "work_schedule_type"
      expr: work_schedule_type
      comment: "Work schedule classification for shift planning and resource allocation"
    - name: "gender"
      expr: gender
      comment: "Gender for diversity and inclusion reporting"
    - name: "ethnicity"
      expr: ethnicity
      comment: "Ethnicity for diversity and inclusion reporting"
    - name: "veteran_status"
      expr: veteran_status
      comment: "Veteran status for compliance and diversity reporting"
    - name: "disability_status"
      expr: disability_status
      comment: "Disability status for compliance and accommodation planning"
    - name: "hire_year"
      expr: YEAR(hire_date)
      comment: "Year of hire for cohort analysis and retention tracking"
    - name: "hire_month"
      expr: DATE_TRUNC('MONTH', hire_date)
      comment: "Month of hire for seasonal hiring pattern analysis"
    - name: "termination_year"
      expr: YEAR(termination_date)
      comment: "Year of termination for turnover trend analysis"
    - name: "security_clearance_level"
      expr: security_clearance_level
      comment: "Security clearance level for sensitive role staffing analysis"
  measures:
    - name: "total_headcount"
      expr: COUNT(DISTINCT employee_id)
      comment: "Total unique employee count - primary workforce sizing metric for capacity planning and budgeting"
    - name: "active_headcount"
      expr: COUNT(DISTINCT CASE WHEN employment_status = 'Active' THEN employee_id END)
      comment: "Count of active employees - key operational metric for current workforce capacity"
    - name: "terminated_headcount"
      expr: COUNT(DISTINCT CASE WHEN termination_date IS NOT NULL THEN employee_id END)
      comment: "Count of employees with termination dates - turnover volume metric for retention strategy"
    - name: "union_member_count"
      expr: COUNT(DISTINCT CASE WHEN union_member_flag = TRUE THEN employee_id END)
      comment: "Count of union members - critical for labor relations planning and contract negotiations"
    - name: "union_penetration_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN union_member_flag = TRUE THEN employee_id END) / NULLIF(COUNT(DISTINCT employee_id), 0), 2)
      comment: "Percentage of workforce that is unionized - strategic metric for labor relations and cost structure"
    - name: "avg_tenure_days"
      expr: AVG(DATEDIFF(COALESCE(termination_date, CURRENT_DATE()), hire_date))
      comment: "Average employee tenure in days - key retention and workforce stability metric"
    - name: "safety_training_compliance_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN last_safety_training_date IS NOT NULL AND DATEDIFF(CURRENT_DATE(), last_safety_training_date) <= 365 THEN employee_id END) / NULLIF(COUNT(DISTINCT employee_id), 0), 2)
      comment: "Percentage of employees with safety training within last 365 days - critical safety compliance and risk mitigation metric for utility operations"
    - name: "performance_review_compliance_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN last_performance_review_date IS NOT NULL AND DATEDIFF(CURRENT_DATE(), last_performance_review_date) <= 365 THEN employee_id END) / NULLIF(COUNT(DISTINCT employee_id), 0), 2)
      comment: "Percentage of employees with performance review within last 365 days - workforce development and talent management effectiveness metric"
    - name: "female_representation_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN gender = 'Female' THEN employee_id END) / NULLIF(COUNT(DISTINCT employee_id), 0), 2)
      comment: "Percentage of workforce identifying as female - diversity and inclusion strategic metric for regulatory compliance and ESG reporting"
    - name: "veteran_representation_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN veteran_status = 'Veteran' THEN employee_id END) / NULLIF(COUNT(DISTINCT employee_id), 0), 2)
      comment: "Percentage of workforce with veteran status - diversity metric for compliance with veteran hiring initiatives and government contracts"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`workforce_department`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Department-level organizational metrics tracking budget utilization, headcount authorization, and operational characteristics for resource allocation and organizational planning"
  source: "`power_and_utilities`.`workforce`.`department`"
  dimensions:
    - name: "department_name"
      expr: department_name
      comment: "Department name for organizational reporting"
    - name: "department_type"
      expr: department_type
      comment: "Department type classification for functional area analysis"
    - name: "business_unit_id"
      expr: business_unit_id
      comment: "Business unit identifier for enterprise-level rollup"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center code for financial planning and budget tracking"
    - name: "status"
      expr: status
      comment: "Department operational status for active/inactive filtering"
    - name: "safety_sensitive_flag"
      expr: safety_sensitive_flag
      comment: "Safety-sensitive designation for regulatory compliance and training requirements"
    - name: "emergency_response_flag"
      expr: emergency_response_flag
      comment: "Emergency response capability indicator for operational readiness planning"
    - name: "union_representation_flag"
      expr: union_representation_flag
      comment: "Union representation indicator for labor relations planning"
    - name: "regulatory_oversight_body"
      expr: regulatory_oversight_body
      comment: "Regulatory body with oversight for compliance tracking"
    - name: "service_area"
      expr: service_area
      comment: "Geographic service area for regional operations analysis"
    - name: "state_province"
      expr: state_province
      comment: "State or province for jurisdictional reporting"
    - name: "country_code"
      expr: country_code
      comment: "Country code for international operations analysis"
  measures:
    - name: "total_departments"
      expr: COUNT(DISTINCT department_id)
      comment: "Total count of departments - organizational complexity metric for span of control analysis"
    - name: "total_annual_budget"
      expr: SUM(CAST(budget_amount_annual AS DOUBLE))
      comment: "Total annual budget across departments - primary financial planning and resource allocation metric"
    - name: "avg_department_budget"
      expr: AVG(CAST(budget_amount_annual AS DOUBLE))
      comment: "Average annual budget per department - benchmark metric for budget sizing and equity analysis"
    - name: "safety_sensitive_department_count"
      expr: COUNT(DISTINCT CASE WHEN safety_sensitive_flag = TRUE THEN department_id END)
      comment: "Count of safety-sensitive departments - risk exposure metric for safety program investment prioritization"
    - name: "emergency_response_department_count"
      expr: COUNT(DISTINCT CASE WHEN emergency_response_flag = TRUE THEN department_id END)
      comment: "Count of departments with emergency response capability - operational resilience metric for crisis readiness"
    - name: "union_represented_department_count"
      expr: COUNT(DISTINCT CASE WHEN union_representation_flag = TRUE THEN department_id END)
      comment: "Count of departments with union representation - labor relations scope metric for collective bargaining planning"
    - name: "safety_sensitive_department_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN safety_sensitive_flag = TRUE THEN department_id END) / NULLIF(COUNT(DISTINCT department_id), 0), 2)
      comment: "Percentage of departments classified as safety-sensitive - risk profile metric for safety investment allocation and regulatory compliance"
    - name: "emergency_response_coverage_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN emergency_response_flag = TRUE THEN department_id END) / NULLIF(COUNT(DISTINCT department_id), 0), 2)
      comment: "Percentage of departments with emergency response capability - operational resilience metric for disaster preparedness and regulatory compliance"
    - name: "union_representation_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN union_representation_flag = TRUE THEN department_id END) / NULLIF(COUNT(DISTINCT department_id), 0), 2)
      comment: "Percentage of departments with union representation - labor relations penetration metric for collective bargaining strategy and cost structure planning"
$$;