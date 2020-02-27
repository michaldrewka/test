CREATE OR REPLACE FORCE VIEW apex_application_page_ir_cat (workspace,application_id,application_name,interactive_report_id,category_id,category_name,application_user,parent_category_id,display_sequence) AS
select
w.short_name         workspace,
f.id                 application_id,
f.name               application_name,
c.worksheet_id       interactive_report_id,
c.id                 category_id,
c.name               category_name,
c.application_user   application_user,
c.base_cat_id        parent_category_id,
c.display_sequence   display_sequence
from wwv_flow_worksheet_categories c,
     wwv_flow_worksheets ws,
     wwv_flows f,
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(nv('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = s.security_group_id) and
      f.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.schema = f.owner and
      f.security_group_id = c.security_group_id and
      f.id = ws.flow_id and ws.id = c.worksheet_id and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      w.PROVISIONING_COMPANY_ID != 0 and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10);
COMMENT ON TABLE apex_application_page_ir_cat IS 'Report column category definitions for interactive report columns';
COMMENT ON COLUMN apex_application_page_ir_cat.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_page_ir_cat.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_page_ir_cat.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_page_ir_cat.interactive_report_id IS 'ID of the interactive report';
COMMENT ON COLUMN apex_application_page_ir_cat.category_id IS 'ID of the category';
COMMENT ON COLUMN apex_application_page_ir_cat.category_name IS 'The name of the column category';
COMMENT ON COLUMN apex_application_page_ir_cat.parent_category_id IS 'The id of the parent category';
COMMENT ON COLUMN apex_application_page_ir_cat.display_sequence IS 'The order the category will appear in a list';