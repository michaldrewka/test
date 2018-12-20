CREATE OR REPLACE FORCE VIEW oc_michael_a.view1 ("ID",col1,col2) AS
select id, col1, col2 from oc_michael_a.Tab1;
COMMENT ON TABLE oc_michael_a.view1 IS 'this is a comment on view View1';
COMMENT ON COLUMN oc_michael_a.view1.col1 IS 'this is a comment for View1 col1';
COMMENT ON COLUMN oc_michael_a.view1.col2 IS 'this is a comment for View1 col2';