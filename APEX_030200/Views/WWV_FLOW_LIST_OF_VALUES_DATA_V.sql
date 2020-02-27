CREATE OR REPLACE FORCE VIEW wwv_flow_list_of_values_data_v ("ID",lov_id,lov_disp_sequence,lov_disp_value,lov_return_value,lov_template,required_patch) AS
select id, lov_id, lov_disp_sequence, lov_disp_value, lov_return_value, lov_template, required_patch
  from wwv_flow_list_of_values_data w,
       (select wwv_flow_security.get_translated_flow_id flow_id from dual) f
  where w.flow_id = f.flow_id;