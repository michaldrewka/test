CREATE OR REPLACE FORCE VIEW apex_workspace_apex_users (workspace_id,workspace_name,first_schema_provisioned,user_name,email,date_created,date_last_updated,available_schemas,is_admin,is_application_developer) AS
select
    workspace_id,
    workspace_name,
    first_schema_provisioned,
    user_name,
    email,
    date_created,
    date_last_updated,
    available_schemas,
    substr(decode(instr(nvl(role_privs,'x'),'ADMIN'),0,'No','Yes'),1,3)  is_admin,
    substr(decode(instr(nvl(role_privs,'x'),'EDIT'),0,'No','Yes'),1,3)   is_application_developer
from (
select
    w.PROVISIONING_COMPANY_ID                                         workspace_id,
    w.short_name                                                      workspace_name,
    w.FIRST_SCHEMA_PROVISIONED                                        first_schema_provisioned,
    u.user_name                                                       user_name,
    u.EMAIL_address                                                   email,
    u.CREATION_DATE                                                   date_created,
    u.LAST_UPDATE_DATE                                                date_last_updated,
    count(distinct s.schema)                                          available_schemas,
    (select developer_role
     from wwv_flow_developers
     where userid = u.user_name and
           security_group_id = w.PROVISIONING_COMPANY_ID)
                                                                      role_privs
from
     wwv_flow_fnd_user u,
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(v('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = w.PROVISIONING_COMPANY_ID) and
      s.security_group_id = w.PROVISIONING_COMPANY_ID and
      u.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.security_group_id = u.security_group_id and
      w.PROVISIONING_COMPANY_ID != 0 and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10)
group by  w.PROVISIONING_COMPANY_ID, w.short_name, w.FIRST_SCHEMA_PROVISIONED, u.user_name, u.EMAIL_address, u.CREATION_DATE, u.LAST_UPDATE_DATE
) ilv;
COMMENT ON TABLE apex_workspace_apex_users IS 'Application Express (Apex) users';
COMMENT ON COLUMN apex_workspace_apex_users.workspace_id IS 'Primary key that identifies the workspace';
COMMENT ON COLUMN apex_workspace_apex_users.workspace_name IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_workspace_apex_users.first_schema_provisioned IS 'The associated database schema identified when this workspace was created';
COMMENT ON COLUMN apex_workspace_apex_users.user_name IS 'The Apex user name used to authenticate to an Apex web page or Apex application';
COMMENT ON COLUMN apex_workspace_apex_users.email IS 'The email associated with this Apex user';
COMMENT ON COLUMN apex_workspace_apex_users.date_created IS 'The date the Apex user was created';
COMMENT ON COLUMN apex_workspace_apex_users.date_last_updated IS 'The date the Apex user definition was last updated';
COMMENT ON COLUMN apex_workspace_apex_users.available_schemas IS 'The number of database schemas available to the workspace developer';
COMMENT ON COLUMN apex_workspace_apex_users.is_admin IS 'Identifies if the Apex user has Apex workspace administration privilege';
COMMENT ON COLUMN apex_workspace_apex_users.is_application_developer IS 'Identifies if the Apex user has Apex application development privilege';