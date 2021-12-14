CREATE MATERIALIZED VIEW oc_michael_b.precisions_different
ON PREBUILT TABLE
AS SELECT ANSWER FROM oc_michael_b.master_table;