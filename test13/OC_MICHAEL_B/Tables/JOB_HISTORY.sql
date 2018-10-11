CREATE TABLE oc_michael_b.job_history (
  employee_id NUMBER(6) NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  job_id VARCHAR2(10 BYTE) NOT NULL,
  department_id NUMBER(4),
  CONSTRAINT jhist_date_check CHECK (end_date > start_date),
  CONSTRAINT jhist_id_date_pk PRIMARY KEY (employee_id,start_date) USING INDEX oc_michael_b.jhist_id_date_pkx,
  CONSTRAINT jhist_dept_fk FOREIGN KEY (department_id) REFERENCES oc_michael_b.departments (department_id),
  CONSTRAINT jhist_emp_fk FOREIGN KEY (employee_id) REFERENCES oc_michael_b.employees (employee_id),
  CONSTRAINT jhist_job_fk FOREIGN KEY (job_id) REFERENCES oc_michael_b.jobs (job_id)
);
COMMENT ON COLUMN oc_michael_b.job_history.employee_id IS 'A not null column in the complex primary key employee_id+start_date.
Foreign key to employee_id column of the employee table';
COMMENT ON COLUMN oc_michael_b.job_history.start_date IS 'A not null column in the complex primary key employee_id+start_date.
Must be less than the end_date of the job_history table. (enforced by
constraint jhist_date_interval)';
COMMENT ON COLUMN oc_michael_b.job_history.end_date IS 'Last day of the employee in this job role. A not null column. Must be
greater than the start_date of the job_history table.
(enforced by constraint jhist_date_interval)';
COMMENT ON COLUMN oc_michael_b.job_history.job_id IS 'Job role in which the employee worked in the past; foreign key to
job_id column in the jobs table. A not null column.';
COMMENT ON COLUMN oc_michael_b.job_history.department_id IS 'Department id in which the employee worked in the past; foreign key to deparment_id column in the departments table';