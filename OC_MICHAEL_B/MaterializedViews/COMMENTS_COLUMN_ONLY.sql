CREATE MATERIALIZED VIEW oc_michael_b.comments_column_only (hello)
ORGANIZATION HEAP 
AS ( SELECT answer FROM oc_michael_b.master_table);
COMMENT ON COLUMN oc_michael_b.comments_column_only.hello IS 'This is a comment on the owner column that''s got hello as it''s alias';