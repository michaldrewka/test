CREATE OR REPLACE FORCE VIEW apex_application_page_ir_cond (workspace,application_id,application_name,page_id,interactive_report_id,report_id,application_user,report_name,condition_id,condition_name,condition_type,condition_column_name,condition_operator,condition_expression,condition_expression2,condition_sql,condition_display,condition_enabled,highlight_sequence,highlight_row_color,highlight_row_font_color,highlight_cell_color,highlight_cell_font_color,created_on,created_by,last_updated_on,last_updated_by) AS
select
w.short_name          workspace,
f.id                  application_id,
f.name                application_name,
r.page_id             page_id,
r.worksheet_id        interactive_report_id,
r.id                  report_id,
r.application_user    application_user,
r.name                report_name,
c.id                  condition_id,
c.name                condition_name,
decode(c.condition_type,'FILTER','Filter','HIGHLIGHT','Highlight','SEARCH','Search',c.condition_type)
                      condition_type,
-- filter expression
c.column_name         condition_column_name,
c.operator            condition_operator,
c.expr                condition_expression,
c.expr2               condition_expression2,
c.condition_sql       condition_sql,
c.condition_display   condition_display,
-- enabled?
decode(c.enabled,'Y','Yes','N','No',c.enabled)
                      condition_enabled,
-- highlighting settings
c.highlight_sequence  ,
c.row_bg_color        highlight_row_color,
c.row_font_color      highlight_row_font_color,
c.column_bg_color     highlight_cell_color,
c.column_font_color   highlight_cell_font_color,
-- audit
--
c.created_on        ,
c.created_by        ,
c.updated_on        last_updated_on,
c.updated_by        last_updated_by
--
from wwv_flow_worksheet_conditions c,
     wwv_flow_worksheet_rpts r,
     wwv_flow_worksheets ws,
     wwv_flows f,
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(nv('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = s.security_group_id) and
      f.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.schema = f.owner and
      f.security_group_id = r.security_group_id and
      f.id = ws.flow_id and ws.id = r.worksheet_id and r.id = c.report_id and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      w.PROVISIONING_COMPANY_ID != 0 and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10);
COMMENT ON TABLE apex_application_page_ir_cond IS 'Identifies filters and highlights defined in user-level report settings for an interactive report';
COMMENT ON COLUMN apex_application_page_ir_cond.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_page_ir_cond.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_page_ir_cond.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_page_ir_cond.page_id IS 'Identifies page number';
COMMENT ON COLUMN apex_application_page_ir_cond.interactive_report_id IS 'ID of the interactive report';
COMMENT ON COLUMN apex_application_page_ir_cond.report_id IS 'ID of the report';
COMMENT ON COLUMN apex_application_page_ir_cond.application_user IS 'The user these report settings are used by';
COMMENT ON COLUMN apex_application_page_ir_cond.report_name IS 'The name of these report settings';
COMMENT ON COLUMN apex_application_page_ir_cond.condition_id IS 'ID of this filter or highlight';
COMMENT ON COLUMN apex_application_page_ir_cond.condition_name IS 'Name of this filter or highlight';
COMMENT ON COLUMN apex_application_page_ir_cond.condition_type IS 'Identifies this as a filter or highlight condtiion';
COMMENT ON COLUMN apex_application_page_ir_cond.condition_column_name IS 'Alias of the column this condition is based on';
COMMENT ON COLUMN apex_application_page_ir_cond.condition_operator IS 'Operator used in this condition';
COMMENT ON COLUMN apex_application_page_ir_cond.condition_expression IS 'Expression used for this condition, depending on condition type.  This will be included in the report SQL as a bind variable';
COMMENT ON COLUMN apex_application_page_ir_cond.condition_expression2 IS 'Expression used for this condition, depending on condition type.  This will be included in the report SQL as a bind variable';
COMMENT ON COLUMN apex_application_page_ir_cond.condition_sql IS 'Stored SQL expression to be used for this condition';
COMMENT ON COLUMN apex_application_page_ir_cond.condition_display IS 'Stored text expression representing this condition';
COMMENT ON COLUMN apex_application_page_ir_cond.condition_enabled IS 'Identifies whether this condition is enabled in the current report settings';
COMMENT ON COLUMN apex_application_page_ir_cond.highlight_sequence IS 'Determines the order a highlight rule is applied';
COMMENT ON COLUMN apex_application_page_ir_cond.highlight_row_color IS 'Determines the row background color for a row-level highlight rule';
COMMENT ON COLUMN apex_application_page_ir_cond.highlight_row_font_color IS 'Determines the row font color for a row-level highlight rule';
COMMENT ON COLUMN apex_application_page_ir_cond.highlight_cell_color IS 'Determines the cell background color for a cell-level highlight rule';
COMMENT ON COLUMN apex_application_page_ir_cond.highlight_cell_font_color IS 'Determines the cell font color for a cell-level highlight rule';
COMMENT ON COLUMN apex_application_page_ir_cond.created_on IS 'Auditing; date the record was created.';
COMMENT ON COLUMN apex_application_page_ir_cond.created_by IS 'Auditing; user that created the record.';
COMMENT ON COLUMN apex_application_page_ir_cond.last_updated_on IS 'Auditing; date the record was last modified.';
COMMENT ON COLUMN apex_application_page_ir_cond.last_updated_by IS 'Auditing; user that last modified the record.';