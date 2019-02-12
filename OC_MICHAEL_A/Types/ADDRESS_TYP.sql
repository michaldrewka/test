CREATE OR REPLACE TYPE oc_michael_a.address_typ FORCE AS OBJECT (
   street          VARCHAR2(30),
   city            VARCHAR2(20),
   state           CHAR(2),
   postal_code     VARCHAR2(6));
/