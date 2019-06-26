CREATE TABLE oc_michael_a.table1 (
  col1 NUMBER(10) NOT NULL,
  col2_numeric NUMBER(10),
  col3_date DATE,
  col4_timestamp TIMESTAMP,
  col5_timestamp_wtz TIMESTAMP WITH TIME ZONE,
  col6_timestamp_wltz TIMESTAMP WITH LOCAL TIME ZONE,
  col7_varchar VARCHAR2(3 BYTE),
  col8_char CHAR,
  col9_number NUMBER(8,2),
  CONSTRAINT col1_pk PRIMARY KEY (col1)
);