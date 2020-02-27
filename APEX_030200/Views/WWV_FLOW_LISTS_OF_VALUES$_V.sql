CREATE OR REPLACE FORCE VIEW wwv_flow_lists_of_values$_v ("ID") AS
select id from wwv_flow_lists_of_values$ w,
  (select wwv_flow_security.get_flow_id flow_id from dual) f
  where   w.flow_id = f.flow_id;