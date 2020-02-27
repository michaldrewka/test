CREATE OR REPLACE FORCE VIEW apex_application_page_groups (workspace,application_id,application_name,page_group_name,page_group_description,"GROUP_ID") AS
select
    w.short_name                          workspace,
    g.flow_id                             application_id,
    f.name                                application_name,
    g.group_name                          page_group_name,
    g.group_desc                          page_group_description,
    g.id                                  group_id
from wwv_flow_page_groups g,
     wwv_flows f,
     wwv_flow_company_schemas s,
     wwv_flow_companies w,
     (select nvl(v('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = s.security_group_id) and
      f.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.schema = f.owner and
      f.security_group_id = g.security_group_id and
      f.id = g.flow_id and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      w.PROVISIONING_COMPANY_ID != 0 and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10);
COMMENT ON TABLE apex_application_page_groups IS 'Identifies page groups';
COMMENT ON COLUMN apex_application_page_groups.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_page_groups.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_page_groups.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_page_groups.page_group_name IS 'page group name';
COMMENT ON COLUMN apex_application_page_groups.page_group_description IS 'Page group description';
COMMENT ON COLUMN apex_application_page_groups."GROUP_ID" IS 'Unique numeric identifier';