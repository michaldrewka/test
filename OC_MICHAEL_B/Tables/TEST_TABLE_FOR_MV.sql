CREATE TABLE oc_michael_b.test_table_for_mv (
  construction_id NUMBER(6) NOT NULL,
  dw_eff_beg_date DATE NOT NULL,
  CONSTRAINT pk_oc_michael_a PRIMARY KEY (construction_id)
)
ENABLE ROW MOVEMENT;