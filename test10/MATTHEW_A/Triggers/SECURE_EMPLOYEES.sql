CREATE OR REPLACE TRIGGER matthew_a.secure_employees
  BEFORE INSERT OR UPDATE OR DELETE ON matthew_a.employees
DISABLE BEGIN
  secure_dml;
END secure_employees;
/