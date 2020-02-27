CREATE OR REPLACE FORCE VIEW apex_ui_defaults_columns ("SCHEMA",table_name,column_name,"LABEL",help_text,mask_form,display_seq_form,display_in_form,display_as_form,display_as_tab_form,display_seq_report,display_in_report,display_as_report,mask_report,aggregate_by,default_value,"REQUIRED",alignment,display_width,max_width,height,"GROUP_BY",searchable,lov_query,created_by,created_on,last_updated_by,last_updated_on) AS
select t.schema,
       t.table_name,
       c.column_name,
       c.label,
       c.help_text,
       c.mask_form,
       c.display_seq_form,
       c.display_in_form,
       c.display_as_form,
       c.display_as_tab_form,
       c.display_seq_report,
       c.display_in_report,
       c.display_as_report,
       c.mask_report,
       c.aggregate_by,
       c.default_value,
       c.required,
       c.alignment,
       c.display_width,
       c.max_width,
       c.height,
       c.group_by,
       c.searchable,
       c.lov_query,
       c.created_by,
       c.created_on,
       c.last_updated_by,
       c.last_updated_on
  from wwv_flow_hnt_column_info c,
       wwv_flow_hnt_table_info t
 where t.schema   = user
   and c.table_id = t.table_id;
COMMENT ON TABLE apex_ui_defaults_columns IS 'The User Interface Defaults for the columns within this schema.';
COMMENT ON COLUMN apex_ui_defaults_columns."SCHEMA" IS 'Schema owning table.';
COMMENT ON COLUMN apex_ui_defaults_columns.table_name IS 'The table associated with the user interface defaults.';
COMMENT ON COLUMN apex_ui_defaults_columns.column_name IS 'The column associated with the user interface defaults.';
COMMENT ON COLUMN apex_ui_defaults_columns."LABEL" IS 'When creating a form against this table or view, this will be used as the label for the item if this column is included. When creating a report or tabular form, this will be used as the column heading if this column is included.';
COMMENT ON COLUMN apex_ui_defaults_columns.help_text IS 'When creating a form against this table or view, this becomes the help text for the resulting item.';
COMMENT ON COLUMN apex_ui_defaults_columns.mask_form IS 'When creating a form against this table or view, this specifies the mask that will be applied to the item, such as 999-99-9999. This is not used for character based items.';
COMMENT ON COLUMN apex_ui_defaults_columns.display_seq_form IS 'When creating a form against this table or view, this determines the sequence in which the columns will be displayed in the resulting form page.';
COMMENT ON COLUMN apex_ui_defaults_columns.display_in_form IS 'When creating a form against this table or view, this determines whether this column will be displayed in the resulting form page.';
COMMENT ON COLUMN apex_ui_defaults_columns.display_as_form IS 'When creating a form against this table or view, this determines the way the column will be displayed, such as text area or text field.';
COMMENT ON COLUMN apex_ui_defaults_columns.display_as_tab_form IS 'When creating a tabular form against this table or view, this determines the way the column will be displayed, such as select list or popup LOV.';
COMMENT ON COLUMN apex_ui_defaults_columns.display_seq_report IS 'When creating a report against this table or view, this determines the sequence in which the columns will be displayed in the resulting report.';
COMMENT ON COLUMN apex_ui_defaults_columns.display_in_report IS 'When creating a report against this table or view, this determines whether this column will be displayed in the resulting report.';
COMMENT ON COLUMN apex_ui_defaults_columns.display_as_report IS 'When creating a report against this table or view, this determines the way the column will be displayed, such as Standard Report Column or Display as Text (based on LOV).';
COMMENT ON COLUMN apex_ui_defaults_columns.mask_report IS 'When creating a report against this table or view, this specifies the mask that will be applied against the data, such as 999-99-9999. This is not used for character based items.';
COMMENT ON COLUMN apex_ui_defaults_columns.aggregate_by IS 'When creating a report against this table or view, this determines whether this column should be used for aggregation in reports and charts.';
COMMENT ON COLUMN apex_ui_defaults_columns.default_value IS 'When creating a form against this table or view, this specifies the default value for the item resulting from this column.';
COMMENT ON COLUMN apex_ui_defaults_columns."REQUIRED" IS 'When creating a form against this table or view, this specifies to generate a validation in which the resulting item must be NOT NULL.';
COMMENT ON COLUMN apex_ui_defaults_columns.alignment IS 'When creating a report against this table or view, this determines the alignment for the resulting report column (left, center, or right).';
COMMENT ON COLUMN apex_ui_defaults_columns.display_width IS 'When creating a form against this table or view, this specifies the display width of the item resulting from this column.';
COMMENT ON COLUMN apex_ui_defaults_columns.max_width IS 'When creating a form against this table or view, this specifies the maximum string length that a user is allowed to enter in the item resulting from this column.';
COMMENT ON COLUMN apex_ui_defaults_columns.height IS 'When creating a form against this table or view, this specifies the display height of the item resulting from this column.';
COMMENT ON COLUMN apex_ui_defaults_columns."GROUP_BY" IS 'When creating a report against this table or view, this determines whether this column should be used for group by functions.';
COMMENT ON COLUMN apex_ui_defaults_columns.searchable IS 'When creating a report against this table or view, this determines whether the resulting report column is searchable.';
COMMENT ON COLUMN apex_ui_defaults_columns.lov_query IS 'A query to be turned into a Named List of Values if this column is included in a Form, Report or Tabular Form and the column is displayed as a type that uses a List of Values (such as Radio Group or Select List).';
COMMENT ON COLUMN apex_ui_defaults_columns.created_by IS 'Auditing; user that created the record.';
COMMENT ON COLUMN apex_ui_defaults_columns.created_on IS 'Auditing; date the record was created.';
COMMENT ON COLUMN apex_ui_defaults_columns.last_updated_by IS 'Auditing; user that last modified the record.';
COMMENT ON COLUMN apex_ui_defaults_columns.last_updated_on IS 'Auditing; date the record was last modified.';