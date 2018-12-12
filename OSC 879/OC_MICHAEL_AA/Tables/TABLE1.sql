CREATE TABLE oc_michael_aa.table1 (
  col1 NUMBER(10) NOT NULL,
  col2 NUMBER(10) NOT NULL,
  col3 NUMBER(10),
  CONSTRAINT pk_tbl1_col1 PRIMARY KEY (col1) USING INDEX oc_michael_aa.idx_tbl1_col1,
  CONSTRAINT pk_tbl1_col2 UNIQUE (col2) USING INDEX oc_michael_aa.idx_tbl1_col2
);