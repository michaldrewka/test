CREATE OR REPLACE FORCE NONEDITIONABLE VIEW oc_michael_b.v_index_constraint (col1_id,col2) AS
SELECT tic.col1 AS col1_id , tic.col2 FROM oc_michael_b.t_index_constraint tic;