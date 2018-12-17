CREATE TABLE oc_michael_a.table1 (
  col1 NUMBER(10) NOT NULL,
  col2 NUMBER(10),
  col3 NUMBER(10),
  CONSTRAINT col1_pk PRIMARY KEY (col1)
);
COMMENT ON COLUMN oc_michael_a.table1.col1 IS 'this is a comment';
COMMENT ON COLUMN oc_michael_a.table1.col2 IS 'this is a comment 
';