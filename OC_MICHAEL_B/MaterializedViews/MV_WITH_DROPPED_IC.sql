CREATE MATERIALIZED VIEW oc_michael_b.mv_with_dropped_ic (construction_id,dw_eff_beg_date)
ORGANIZATION HEAP 
AS SELECT test_table_for_mv."CONSTRUCTION_ID", test_table_for_mv."DW_EFF_BEG_DATE"
FROM oc_michael_b.test_table_for_mv;
ALTER TABLE OC_MICHAEL_B.MV_WITH_DROPPED_IC DROP PRIMARY KEY;