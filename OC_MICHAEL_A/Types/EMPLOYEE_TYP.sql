CREATE OR REPLACE TYPE oc_michael_a.employee_typ FORCE AS OBJECT (
  employee_id       NUMBER(6),
  first_name        VARCHAR2(20),
  last_name         VARCHAR2(25),
  email             VARCHAR2(25),
  phone_number      VARCHAR2(20),
  hire_date         DATE,
  job_id            VARCHAR2(10),
  salary            NUMBER(8,2),
  commission_pct    NUMBER(2,2),
  manager_id        NUMBER(6),
  department_id     NUMBER(4),
  address           address_typ,
  MAP MEMBER FUNCTION get_idno RETURN NUMBER,
  MEMBER PROCEDURE display_address ( SELF IN OUT NOCOPY employee_typ ) );
/
CREATE OR REPLACE TYPE BODY oc_michael_a.employee_typ AS
  MAP MEMBER FUNCTION get_idno RETURN NUMBER IS
  BEGIN
    RETURN employee_id;
  END;
  MEMBER PROCEDURE display_address ( SELF IN OUT NOCOPY employee_typ ) IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE(first_name || ' '  || last_name);
    DBMS_OUTPUT.PUT_LINE(address.street);
    DBMS_OUTPUT.PUT_LINE(address.city || ', '  || address.state || ' ' ||
                         address.postal_code);  
  END;
END;
/