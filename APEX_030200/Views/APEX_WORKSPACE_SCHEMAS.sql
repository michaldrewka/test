CREATE OR REPLACE FORCE VIEW apex_workspace_schemas (workspace_id,workspace_name,first_schema_provisioned,"SCHEMA",schema_created,applications) AS
select
    w.PROVISIONING_COMPANY_ID                           workspace_id,
    w.short_name                                        workspace_name,
    w.FIRST_SCHEMA_PROVISIONED                          first_schema_provisioned,
    s.schema                                            schema,
    (select created
     from   all_users
     where  username = s.schema)                        schema_created,
    (select count(*)
     from wwv_flows
     where security_group_id=w.PROVISIONING_COMPANY_ID
      and s.schema = owner)                             applications
from wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(nv('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where
     (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = w.PROVISIONING_COMPANY_ID) and
      s.security_group_id = w.PROVISIONING_COMPANY_ID and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10);
COMMENT ON TABLE apex_workspace_schemas IS 'Database Schemas mapped to Apex workspaces';
COMMENT ON COLUMN apex_workspace_schemas.workspace_id IS 'Primary key that identifies the workspace';
COMMENT ON COLUMN apex_workspace_schemas.workspace_name IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_workspace_schemas.first_schema_provisioned IS 'The associated database schema identified when this workspace was created';
COMMENT ON COLUMN apex_workspace_schemas."SCHEMA" IS 'Database schema name mapped to workspace';
COMMENT ON COLUMN apex_workspace_schemas.schema_created IS 'Identifies the date that the database schema was created';
COMMENT ON COLUMN apex_workspace_schemas.applications IS 'Number of applications within the current workspace and schema';