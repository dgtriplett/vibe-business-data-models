-- Metric views for domain: workforce | Business: Power and Utilities | Version: 1 | Generated on: 2026-05-05 03:39:44

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`workforce_absence`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key absence KPIs to monitor workforce availability and paid leave utilization"
  source: "`power_and_utilities_v2`.`workforce`.`absence`"
  dimensions:
    - name: "absence_category"
      expr: absence_category
      comment: "Category of the absence (e.g., sick, vacation)"
    - name: "absence_type_name"
      expr: type_name
      comment: "Descriptive type name of the absence"
    - name: "start_date"
      expr: start_date
      comment: "Date when the absence started"
    - name: "crew_id"
      expr: crew_id
      comment: "Crew associated with the absent employee"
    - name: "employee_id"
      expr: employee_id
      comment: "Identifier of the absent employee"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center linked to the absence"
    - name: "union_code"
      expr: union_code
      comment: "Union code of the employee"
    - name: "work_center_code"
      expr: work_center_code
      comment: "Work center code where the employee is assigned"
  measures:
    - name: "total_absence_days"
      expr: SUM(CAST(duration_days AS DOUBLE))
      comment: "Total number of absence days recorded"
    - name: "total_absence_hours"
      expr: SUM(CAST(duration_hours AS DOUBLE))
      comment: "Total number of absence hours recorded"
    - name: "absence_count"
      expr: COUNT(1)
      comment: "Number of absence records"
    - name: "paid_absence_count"
      expr: SUM(CASE WHEN paid_flag THEN 1 ELSE 0 END)
      comment: "Count of paid absences"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`workforce_time_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Time‑entry aggregates to assess labor utilization and overtime exposure"
  source: "`power_and_utilities_v2`.`workforce`.`time_entry`"
  dimensions:
    - name: "employee_id"
      expr: employee_id
      comment: "Employee who submitted the time entry"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center charged by the time entry"
    - name: "work_date"
      expr: work_date
      comment: "Date the work was performed"
    - name: "time_type"
      expr: time_type
      comment: "Classification of the time entry (e.g., regular, holiday)"
    - name: "work_activity_code"
      expr: work_activity_code
      comment: "Code representing the activity performed"
  measures:
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Sum of regular (non‑overtime) hours logged"
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Sum of overtime hours logged"
    - name: "total_double_time_hours"
      expr: SUM(CAST(double_time_hours AS DOUBLE))
      comment: "Sum of double‑time hours logged"
    - name: "total_hours"
      expr: SUM(CAST(total_hours AS DOUBLE))
      comment: "Sum of all hours logged (regular + overtime + double)"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`workforce_work_order_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational view of work order assignments to monitor workload and overtime risk"
  source: "`power_and_utilities_v2`.`workforce`.`work_order_assignment`"
  dimensions:
    - name: "crew_id"
      expr: crew_id
      comment: "Crew assigned to the work order"
    - name: "technician_id"
      expr: technician_id
      comment: "Technician assigned to the work order"
    - name: "work_order_id"
      expr: work_order_id
      comment: "Identifier of the underlying work order"
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the assignment"
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of assignment (e.g., emergency, routine)"
    - name: "priority_code"
      expr: priority_code
      comment: "Priority code indicating urgency"
  measures:
    - name: "assignment_count"
      expr: COUNT(1)
      comment: "Number of work order assignments"
    - name: "total_scheduled_duration_minutes"
      expr: SUM(CAST(work_duration_minutes AS DOUBLE))
      comment: "Total scheduled work duration in minutes"
    - name: "average_scheduled_duration_minutes"
      expr: AVG(CAST(work_duration_minutes AS DOUBLE))
      comment: "Average scheduled work duration per assignment"
    - name: "overtime_eligible_assignment_count"
      expr: SUM(CASE WHEN overtime_eligible_flag THEN 1 ELSE 0 END)
      comment: "Count of assignments flagged as overtime‑eligible"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`workforce_storm_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs to evaluate storm response effort, cost, and labor utilization"
  source: "`power_and_utilities_v2`.`workforce`.`storm_assignment`"
  dimensions:
    - name: "storm_event_id"
      expr: storm_event_id
      comment: "Identifier of the storm event"
    - name: "crew_id"
      expr: crew_id
      comment: "Crew assigned to the storm response"
    - name: "technician_id"
      expr: technician_id
      comment: "Technician assigned to the storm response"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the storm assignment"
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the storm assignment"
  measures:
    - name: "storm_assignment_count"
      expr: COUNT(1)
      comment: "Number of storm‑related assignments"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_total_cost AS DOUBLE))
      comment: "Total actual cost incurred for storm assignments"
    - name: "total_overtime_hours"
      expr: SUM(CAST(overtime_hours AS DOUBLE))
      comment: "Sum of overtime hours worked on storm assignments"
    - name: "total_regular_hours"
      expr: SUM(CAST(regular_hours AS DOUBLE))
      comment: "Sum of regular hours worked on storm assignments"
    - name: "total_hours_worked"
      expr: SUM(CAST(total_hours_worked AS DOUBLE))
      comment: "Sum of all hours (regular + overtime) for storm assignments"
    - name: "mutual_aid_assignment_count"
      expr: SUM(CASE WHEN is_mutual_aid_crew THEN 1 ELSE 0 END)
      comment: "Count of assignments that are mutual‑aid crews"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`workforce_shift`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shift performance metrics to support labor planning and overtime monitoring"
  source: "`power_and_utilities_v2`.`workforce`.`shift`"
  dimensions:
    - name: "shift_type"
      expr: shift_type
      comment: "Type of shift (e.g., day, night)"
    - name: "shift_category"
      expr: shift_category
      comment: "Category of shift (e.g., regular, holiday)"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center associated with the shift"
    - name: "facility_id"
      expr: facility_id
      comment: "Facility where the shift is scheduled"
  measures:
    - name: "shift_count"
      expr: COUNT(1)
      comment: "Number of shift records"
    - name: "total_shift_hours"
      expr: SUM(CAST(duration_hours AS DOUBLE))
      comment: "Total scheduled shift hours"
    - name: "average_shift_hours"
      expr: AVG(CAST(duration_hours AS DOUBLE))
      comment: "Average shift duration in hours"
    - name: "overtime_eligible_shift_count"
      expr: SUM(CASE WHEN overtime_eligible_flag THEN 1 ELSE 0 END)
      comment: "Count of shifts flagged as overtime‑eligible"
$$;