CREATE TABLE oc_michael_b.more_then_one_primary_key (
  col1 NUMBER(10) NOT NULL,
  col2 NUMBER(10) NOT NULL,
  col3 NUMBER(10) NOT NULL,
  CONSTRAINT pk_col2 PRIMARY KEY (col1,col2,col3)
);