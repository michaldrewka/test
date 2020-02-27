CREATE OR REPLACE FORCE VIEW apex_ui_defaults_lov_data ("SCHEMA",table_name,column_name,lov_disp_sequence,lov_disp_value,lov_return_value,last_updated_by,last_updated_on) AS
select t.schema,
       t.table_name,
       c.column_name,
       l.lov_disp_sequence,
       l.lov_disp_value,
       l.lov_return_value,
       l.last_updated_by,
       l.last_updated_on
  from wwv_flow_hnt_lov_data l,
       wwv_flow_hnt_column_info c,
       wwv_flow_hnt_table_info t
 where t.schema    = user
   and l.column_id = c.column_id
   and c.table_id  = t.table_id;
COMMENT ON TABLE apex_ui_defaults_lov_data IS 'If you create a form, report, or tabular form that includes this column and if the appropriate Display As Type is set to use a list of values (Radio Group or Select List) then a Named List of Values will be created within the application and will be referenced by the resulting item or report column.';
COMMENT ON COLUMN apex_ui_defaults_lov_data."SCHEMA" IS 'Schema owning table.';
COMMENT ON COLUMN apex_ui_defaults_lov_data.table_name IS 'The table associated with the user interface defaults.';
COMMENT ON COLUMN apex_ui_defaults_lov_data.column_name IS 'The column associated with the user interface defaults.';
COMMENT ON COLUMN apex_ui_defaults_lov_data.lov_disp_sequence IS 'The display sequence of the static list of values record.';
COMMENT ON COLUMN apex_ui_defaults_lov_data.lov_disp_value IS 'The display value of the static list of values record.';
COMMENT ON COLUMN apex_ui_defaults_lov_data.lov_return_value IS 'The return value of the static list of values record.';
COMMENT ON COLUMN apex_ui_defaults_lov_data.last_updated_by IS 'Auditing; user that last modified the record.';
COMMENT ON COLUMN apex_ui_defaults_lov_data.last_updated_on IS 'Auditing; date the record was last modified.';