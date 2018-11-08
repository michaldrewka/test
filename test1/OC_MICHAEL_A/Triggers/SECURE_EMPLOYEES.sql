CREATE OR REPLACE TRIGGER oc_michael_a.secure_employees
  BEFORE INSERT OR UPDATE OR DELETE ON oc_michael_a.employees
DISABLE BEGIN
  secure_dml;
END secure_employees;
/