CREATE OR REPLACE FORCE VIEW apex_ui_defaults_tables ("SCHEMA",table_name,form_region_title,report_region_title,created_by,created_on,last_updated_by,last_updated_on) AS
select schema,
       table_name,
       form_region_title,
       report_region_title,
       created_by,
       created_on,
       last_updated_by,
       last_updated_on
  from wwv_flow_hnt_table_info
 where schema = user;
COMMENT ON TABLE apex_ui_defaults_tables IS 'The User Interface Defaults for the tables within this schema.  Used by the wizards when generating applications.';
COMMENT ON COLUMN apex_ui_defaults_tables."SCHEMA" IS 'Schema owning table.';
COMMENT ON COLUMN apex_ui_defaults_tables.table_name IS 'Name of table in the schema.';
COMMENT ON COLUMN apex_ui_defaults_tables.form_region_title IS 'When creating a form based upon this table, this title will be used as the resulting region title.';
COMMENT ON COLUMN apex_ui_defaults_tables.report_region_title IS 'When creating a report or tabular form based upon this table, this title will be used as the resulting region title.';
COMMENT ON COLUMN apex_ui_defaults_tables.created_by IS 'Auditing; user that created the record.';
COMMENT ON COLUMN apex_ui_defaults_tables.created_on IS 'Auditing; date the record was created.';
COMMENT ON COLUMN apex_ui_defaults_tables.last_updated_by IS 'Auditing; user that last modified the record.';
COMMENT ON COLUMN apex_ui_defaults_tables.last_updated_on IS 'Auditing; date the record was last modified.';