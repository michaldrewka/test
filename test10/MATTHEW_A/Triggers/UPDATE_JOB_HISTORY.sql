CREATE OR REPLACE TRIGGER matthew_a.update_job_history
  AFTER UPDATE OF job_id, department_id ON matthew_a.employees
  FOR EACH ROW
BEGIN
  add_job_history(:old.employee_id, :old.hire_date, sysdate,
                  :old.job_id, :old.department_id);
END;
/