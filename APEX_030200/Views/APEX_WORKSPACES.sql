CREATE OR REPLACE FORCE VIEW apex_workspaces (workspace,schemas,last_purged_session,sessions,applications,application_pages,apex_users,apex_developers,apex_workspace_administrators,files,sql_scripts,translation_messages,file_storage,last_logged_page_view,page_views,workspace_id) AS
select
    w.short_name                                        workspace,
    --w.FIRST_SCHEMA_PROVISIONED                          first_schema_provisioned,
    --
    count(distinct s.schema)                            schemas,
    max(w.LAST_LOGIN)                                   last_purged_session,
    --
    (select count(*)
     from wwv_flow_sessions$
     where security_group_id =
           w.PROVISIONING_COMPANY_ID)                   sessions,
    --
    (select count(*)
     from   wwv_flows
     where  security_group_id =
            w.PROVISIONING_COMPANY_ID)                  applications,
    --
    (select count(*)
     from   wwv_flow_steps
     where  security_group_id =
            w.PROVISIONING_COMPANY_ID)                  application_pages,
    --
    (select count(*)
     from   wwv_flow_fnd_user
     where  security_group_id =
            w.PROVISIONING_COMPANY_ID)                  apex_users,
    --
    (select count(*)
     from wwv_flow_developers d, wwv_flow_fnd_user u
     where (instr(nvl(d.developer_role,'x'),'EDIT') > 0 or
            instr(nvl(d.developer_role,'x'),'ADMIN') > 0 ) and
           d.security_group_id = w.PROVISIONING_COMPANY_ID and
           u.security_group_id = w.PROVISIONING_COMPANY_ID and
           d.userid = u.user_name)
                                                        apex_developers,
    --
    (select count(*)
     from   wwv_flow_developers d, wwv_flow_fnd_user u
     where  instr(nvl(d.developer_role,'x'),'ADMIN') > 0  and
           d.security_group_id = w.PROVISIONING_COMPANY_ID and
           u.security_group_id = w.PROVISIONING_COMPANY_ID and
           d.userid = u.user_name)
                                                        apex_workspace_administrators,
    --
    (select count(*)
     from    WWV_FLOW_FILE_OBJECTS$
     where   security_group_id =
            w.PROVISIONING_COMPANY_ID and
            to_char(deleted_as_of,
            'MM.DD.YYYY') = '01.01.0001')               files,
    --
    (select count(*)
     from    WWV_FLOW_FILE_OBJECTS$
     where   security_group_id =
            w.PROVISIONING_COMPANY_ID and
            FILE_TYPE = 'SCRIPT' and
            to_char(deleted_as_of,
            'MM.DD.YYYY') = '01.01.0001')               sql_scripts,
    --
    (select count(*)
     from   WWV_FLOW_MESSAGES$
     where  security_group_id =
            w.PROVISIONING_COMPANY_ID)                  translation_messages,
    --
    (select sum(doc_size)
     from    WWV_FLOW_FILE_OBJECTS$
     where   security_group_id =
            w.PROVISIONING_COMPANY_ID)                  file_storage,
    --
    (select max(time_stamp)
     from   wwv_flow_activity_log
     where  security_group_id =
            w.PROVISIONING_COMPANY_ID)                  last_logged_page_view,
     --
     (select count(*)
     from   wwv_flow_activity_log
     where  security_group_id =
            w.PROVISIONING_COMPANY_ID and
            TIME_STAMP > sysdate - 14)                  page_views,
     --
     w.PROVISIONING_COMPANY_ID                          workspace_id
from
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(nv('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = w.PROVISIONING_COMPANY_ID) and
      s.security_group_id = w.PROVISIONING_COMPANY_ID and
      w.PROVISIONING_COMPANY_ID != 0 and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10)
group by  w.PROVISIONING_COMPANY_ID, w.short_name, w.FIRST_SCHEMA_PROVISIONED;
COMMENT ON TABLE apex_workspaces IS 'Available Application Express (Apex) workspaces';
COMMENT ON COLUMN apex_workspaces.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_workspaces.schemas IS 'Number of database schemas currently mapped to this workspace';
COMMENT ON COLUMN apex_workspaces.last_purged_session IS 'Creation date of the most recently purged session.  Used to track last login for workspaces who no longer have entries in the activity log.';
COMMENT ON COLUMN apex_workspaces.sessions IS 'Number of non-purged Apex sessions';
COMMENT ON COLUMN apex_workspaces.applications IS 'Number of applications created in this workspace';
COMMENT ON COLUMN apex_workspaces.application_pages IS 'Number of application pages created in this workspace';
COMMENT ON COLUMN apex_workspaces.apex_users IS 'Number of Apex users created in this workspace';
COMMENT ON COLUMN apex_workspaces.apex_developers IS 'Number of Apex users with developer privilege';
COMMENT ON COLUMN apex_workspaces.apex_workspace_administrators IS 'Number of Apex users with workspace administrator privilege';
COMMENT ON COLUMN apex_workspaces.files IS 'Number of Apex files associated with the workspace';
COMMENT ON COLUMN apex_workspaces.sql_scripts IS 'Number of Apex SQL Scripts associated with the workspace';
COMMENT ON COLUMN apex_workspaces.translation_messages IS 'Number of translatable and translated messages within the workspace';
COMMENT ON COLUMN apex_workspaces.file_storage IS 'Size in bytes of all files associated with the workspace';
COMMENT ON COLUMN apex_workspaces.last_logged_page_view IS 'Date of most recent page view from the Apex activity log';
COMMENT ON COLUMN apex_workspaces.page_views IS 'Count of page views recorded for this workspace in the Apex activity log for the last 2 weeks';
COMMENT ON COLUMN apex_workspaces.workspace_id IS 'Primary key that identifies the workspace';