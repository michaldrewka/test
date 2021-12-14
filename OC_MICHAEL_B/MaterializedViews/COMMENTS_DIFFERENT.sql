CREATE MATERIALIZED VIEW oc_michael_b.comments_different (answer)
ORGANIZATION HEAP 
AS ( SELECT answer FROM oc_michael_b.master_table);
COMMENT ON MATERIALIZED VIEW oc_michael_b.comments_different IS 'This is a comment on the materialized view in A';
COMMENT ON COLUMN oc_michael_b.comments_different.answer IS 'This is a comment on the owner column in A';