CREATE OR REPLACE FORCE VIEW apex_application_page_ir_cgrps (workspace,application_id,application_name,interactive_report_id,column_group_name,column_group_description,display_sequence,"COLUMNS",created_on,created_by,updated_on,updated_by) AS
select
w.short_name                workspace,
f.id                        application_id,
f.name                      application_name,
cg.worksheet_id             interactive_report_id,
cg.name                     column_group_name,
cg.description              column_group_description,
cg.display_sequence         display_sequence,
--
(select count(*) from wwv_flow_worksheet_columns where group_id = cg.id) columns,
--
cg.created_on                ,
cg.created_by                ,
cg.updated_on                ,
cg.updated_by
from wwv_flow_worksheet_col_groups cg,
     wwv_flow_worksheets ws,
     wwv_flows f,
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(nv('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = s.security_group_id) and
      f.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.schema = f.owner and
      f.security_group_id = cg.security_group_id and
      f.id = ws.flow_id and ws.id = cg.worksheet_id and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      w.PROVISIONING_COMPANY_ID != 0 and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10);
COMMENT ON TABLE apex_application_page_ir_cgrps IS 'Column group definitions for interactive report columns';
COMMENT ON COLUMN apex_application_page_ir_cgrps.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_page_ir_cgrps.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_page_ir_cgrps.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_page_ir_cgrps.interactive_report_id IS 'ID of the interactive report';
COMMENT ON COLUMN apex_application_page_ir_cgrps.column_group_name IS 'Name of this column group, displayed on the single row view of this report and in the Select Columns dialog box';
COMMENT ON COLUMN apex_application_page_ir_cgrps.column_group_description IS 'Description of this column group';
COMMENT ON COLUMN apex_application_page_ir_cgrps.display_sequence IS 'Display sequence of this column group';
COMMENT ON COLUMN apex_application_page_ir_cgrps."COLUMNS" IS 'Number of columns in this column group';
COMMENT ON COLUMN apex_application_page_ir_cgrps.created_on IS 'Auditing; date the record was created.';
COMMENT ON COLUMN apex_application_page_ir_cgrps.created_by IS 'Auditing; user that created the record.';
COMMENT ON COLUMN apex_application_page_ir_cgrps.updated_on IS 'Auditing; date the record was last modified.';
COMMENT ON COLUMN apex_application_page_ir_cgrps.updated_by IS 'Auditing; user that last modified the record.';