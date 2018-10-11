CREATE TABLE oc_michael_a.supplier (
  supplier_id NUMBER(10) NOT NULL,
  supplier_name VARCHAR2(50 BYTE) NOT NULL,
  contact_name VARCHAR2(50 BYTE),
  CONSTRAINT supplier_pk PRIMARY KEY (supplier_id) DISABLE NOVALIDATE
);