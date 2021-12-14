CREATE MATERIALIZED VIEW oc_michael_b.mv_index_constraint (col1_id,col2)
ORGANIZATION HEAP 
AS SELECT v.col1_id, v.col2 from oc_michael_b.v_index_constraint v;
ALTER TABLE oc_michael_b.mv_index_constraint ADD CONSTRAINT pk_mv_col1_id PRIMARY KEY (col1_id);