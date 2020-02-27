CREATE OR REPLACE FORCE VIEW apex_workspace_access_log (workspace,application_id,application_name,user_name,authentication_method,application_schema_owner,access_date,seconds_ago,ip_address,authentication_result,custom_status_text,workspace_id) AS
select
    w.short_name             workspace,
    l.APPLICATION            application_id,
    f.name                   application_name,
    upper(l.LOGIN_NAME)      user_name,
    l.AUTHENTICATION_METHOD  authentication_method,
    l.OWNER                  application_schema_owner,
    l.ACCESS_DATE,
    86400 * (sysdate - l.access_date) seconds_ago,
    l.IP_ADDRESS,
    --l.REMOTE_USER,
    decode(nvl(l.authentication_result,0),
        0,'AUTH_SUCCESS',
        1,'AUTH_UNKNOWN_USER',
        2,'AUTH_ACCOUNT_LOCKED',
        3,'AUTH_ACCOUNT_EXPIRED',
        4,'AUTH_PASSWORD_INCORRECT',
        5,'AUTH_PASSWORD_FIRST_USE',
        6,'AUTH_ATTEMPTS_EXCEEDED',
        7,'AUTH_INTERNAL_ERROR',
        authentication_result) authentication_result,
    l.CUSTOM_STATUS_TEXT       custom_status_text,
    l.SECURITY_GROUP_ID        workspace_id
from WWV_FLOW_USER_ACCESS_LOG_V l,
     wwv_flow_companies w,
     wwv_flows f,
     (select nvl(v('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (l.security_group_id in (select security_group_id from  wwv_flow_company_schemas where schema = user) or
       user in ('SYS','SYSTEM', 'APEX_030200')  or
       d.sgid = l.security_group_id) and
       --
      l.security_group_id = w.PROVISIONING_COMPANY_ID and
      l.application = f.id(+) and
      l.ACCESS_DATE > sysdate - 14 and
      w.PROVISIONING_COMPANY_ID != 0 and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10);
COMMENT ON TABLE apex_workspace_access_log IS 'One row is logged for each login attempt.';
COMMENT ON COLUMN apex_workspace_access_log.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_workspace_access_log.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_workspace_access_log.application_name IS 'Name of Application';
COMMENT ON COLUMN apex_workspace_access_log.user_name IS 'Identifies the Application Express username';
COMMENT ON COLUMN apex_workspace_access_log.authentication_method IS 'Identifies the authentication method';
COMMENT ON COLUMN apex_workspace_access_log.application_schema_owner IS 'Identifies the parse as schema owner for the application';
COMMENT ON COLUMN apex_workspace_access_log.access_date IS 'Date of login attempt';
COMMENT ON COLUMN apex_workspace_access_log.seconds_ago IS 'Elapsed seconds since event occured';
COMMENT ON COLUMN apex_workspace_access_log.ip_address IS 'IP Address of user';
COMMENT ON COLUMN apex_workspace_access_log.authentication_result IS 'Status of authentication attempt';
COMMENT ON COLUMN apex_workspace_access_log.custom_status_text IS 'Identifies the status of the authentication attempt';
COMMENT ON COLUMN apex_workspace_access_log.workspace_id IS 'Workspace numeric identifier';