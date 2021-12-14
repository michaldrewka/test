CREATE MATERIALIZED VIEW oc_michael_b.comments (hello)
ORGANIZATION HEAP 
AS ( SELECT answer FROM oc_michael_b.master_table);
COMMENT ON MATERIALIZED VIEW oc_michael_b.comments IS 'This is a comment on the materialized view';
COMMENT ON COLUMN oc_michael_b.comments.hello IS 'This is a comment on the owner column that''s got hello as it''s alias';