CREATE OR REPLACE FORCE VIEW apex_workspace_sessions (workspace_id,workspace_name,apex_session_id,user_name,session_created) AS
select
    w.workspace_id                                      workspace_id,
    w.workspace_name                                    workspace_name,
    s.id                                                apex_session_id,
    s.cookie                                            user_name,
    s.created_on                                        session_created
from
    wwv_flow_sessions$ s,
(
select
    w.PROVISIONING_COMPANY_ID                           workspace_id,
    w.short_name                                        workspace_name,
    w.FIRST_SCHEMA_PROVISIONED                          first_schema_provisioned
from
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(nv('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = w.PROVISIONING_COMPANY_ID) and
      s.security_group_id = w.PROVISIONING_COMPANY_ID and
      w.PROVISIONING_COMPANY_ID != 0 and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10)
group by  w.PROVISIONING_COMPANY_ID, w.short_name, w.FIRST_SCHEMA_PROVISIONED
) w
where s.SECURITY_GROUP_ID = w.workspace_id;
COMMENT ON TABLE apex_workspace_sessions IS 'Application Express (Apex) sessions by workspace and Apex user';
COMMENT ON COLUMN apex_workspace_sessions.workspace_id IS 'Primary key that identifies the workspace';
COMMENT ON COLUMN apex_workspace_sessions.workspace_name IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_workspace_sessions.apex_session_id IS 'Primary key of the apex session';
COMMENT ON COLUMN apex_workspace_sessions.user_name IS 'Name of the authenticated or public user';
COMMENT ON COLUMN apex_workspace_sessions.session_created IS 'Date the Apex session was created';