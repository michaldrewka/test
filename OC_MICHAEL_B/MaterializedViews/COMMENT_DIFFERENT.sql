CREATE MATERIALIZED VIEW oc_michael_b.comment_different (answer)
ORGANIZATION HEAP 
AS ( 
-- Comment in MVIEW_A
SELECT answer FROM oc_michael_b.master_table
);