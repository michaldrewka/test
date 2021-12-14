CREATE MATERIALIZED VIEW oc_michael_b.column_alias_different ("HelloNewColumn")
ORGANIZATION HEAP 
AS SELECT answer FROM oc_michael_b.master_table;