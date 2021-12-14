CREATE MATERIALIZED VIEW oc_michael_b.index_mv_target (answer,tea)
ORGANIZATION HEAP 
AS SELECT ANSWER, TEA FROM oc_michael_b.INDEX_TABLE;