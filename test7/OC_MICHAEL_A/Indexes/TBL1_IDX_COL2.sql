CREATE BITMAP INDEX oc_michael_a.tbl1_idx_col2 ON oc_michael_a.table1(oc_michael_a.table1.col1)
FROM oc_michael_a.table1,oc_michael_a.table2
WHERE oc_michael_a.table1.col1 = oc_michael_a.table2.col1;