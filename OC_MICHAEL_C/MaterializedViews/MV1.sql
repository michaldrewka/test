CREATE MATERIALIZED VIEW oc_michael_c.mv1 (col1,col2)
ORGANIZATION HEAP 
AS SELECT "TABLE1"."COL1" "COL1","TABLE1"."COL2" "COL2" FROM oc_michael_c."TABLE1" "TABLE1";