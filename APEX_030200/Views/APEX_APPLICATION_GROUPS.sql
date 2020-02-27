CREATE OR REPLACE FORCE VIEW apex_application_groups (workspace,application_group_id,group_name,group_comment,workspace_id) AS
select
    w.short_name                 workspace,
    g.ID                         application_group_id,
    g.group_name                 group_name,
    g.group_comment              group_comment,
    w.PROVISIONING_COMPANY_ID    workspace_id
from
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     wwv_flow_application_groups g,
     (select nvl(nv('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = w.PROVISIONING_COMPANY_ID) and
      s.security_group_id = w.PROVISIONING_COMPANY_ID and
      w.PROVISIONING_COMPANY_ID != 0 and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10) and
      w.PROVISIONING_COMPANY_ID = g.security_group_id
group by  w.PROVISIONING_COMPANY_ID, w.short_name, w.FIRST_SCHEMA_PROVISIONED,g.id, g.group_name, g.group_comment;
COMMENT ON TABLE apex_application_groups IS 'Application Groups defined per workspace.  Applications can be associated with an application group.';
COMMENT ON COLUMN apex_application_groups.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_groups.application_group_id IS 'Identifies the ID of the application group this application is associated with';
COMMENT ON COLUMN apex_application_groups.group_name IS 'Identifies the application group';
COMMENT ON COLUMN apex_application_groups.group_comment IS 'Identifies comments for a given application group';