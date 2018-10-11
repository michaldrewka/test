CREATE TABLE oc_michael_b.regions (
  region_id NUMBER NOT NULL,
  region_name VARCHAR2(25 BYTE),
  CONSTRAINT reg_id_pk PRIMARY KEY (region_id) USING INDEX oc_michael_b.reg_id_pkx
);