CREATE OR REPLACE FORCE VIEW apex_application_build_options (workspace,application_id,application_name,build_option_name,build_option_status,status_on_export,last_updated_by,last_updated_on,component_comment,build_option_id,component_signature) AS
select
    w.short_name                     workspace,
    f.ID                             application_id,
    f.NAME                           application_name,
    --
    b.PATCH_NAME                     build_option_name,
    decode(b.PATCH_STATUS,
        'INCLUDE','Include',
        'EXCLUDE','Exclude',
        b.patch_status)              build_option_status,
    decode(nvl(b.DEFAULT_ON_EXPORT,
        b.patch_status),
        'INCLUDE','Include',
        'EXCLUDE','Exclude',
        b.DEFAULT_ON_EXPORT)         status_on_export,
    --b.ATTRIBUTE1                   attribute1,
    --b.ATTRIBUTE2                   attribute2,
    --b.ATTRIBUTE3                   attribute3,
    --b.ATTRIBUTE4                   attribute4,
    b.LAST_UPDATED_BY                last_updated_by,
    b.LAST_UPDATED_ON                last_updated_on,
    b.PATCH_COMMENT                  component_comment,
    b.id                             build_option_id,
    --
    b.PATCH_NAME
    ||' s='||decode(b.PATCH_STATUS,
        'INCLUDE','Include',
        'EXCLUDE','Exclude',
        b.patch_status)
    ||' e='||decode(nvl(b.DEFAULT_ON_EXPORT,
        b.patch_status),
        'INCLUDE','Include',
        'EXCLUDE','Exclude',
        b.DEFAULT_ON_EXPORT)
    component_signature
from wwv_flow_patches b,
     wwv_flows f,
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(v('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = s.security_group_id) and
      f.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.schema = f.owner and
      f.id = b.flow_id and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      w.PROVISIONING_COMPANY_ID != 0 and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10);
COMMENT ON TABLE apex_application_build_options IS 'Identifies Build Options available to an application';
COMMENT ON COLUMN apex_application_build_options.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_build_options.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_build_options.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_build_options.build_option_name IS 'Identifies the build option';
COMMENT ON COLUMN apex_application_build_options.build_option_status IS 'Identifies the current status of the Build option; Include or Exclude.';
COMMENT ON COLUMN apex_application_build_options.status_on_export IS 'Identifies the status (Include or Exclude) of this Build Option when the build option is exported.';
COMMENT ON COLUMN apex_application_build_options.last_updated_by IS 'Apex developer who made last update';
COMMENT ON COLUMN apex_application_build_options.last_updated_on IS 'Date of last update';
COMMENT ON COLUMN apex_application_build_options.component_comment IS 'Developer Comment';
COMMENT ON COLUMN apex_application_build_options.build_option_id IS 'Identifies the primary key of this component';
COMMENT ON COLUMN apex_application_build_options.component_signature IS 'Identifies attributes defined at a given component level to facilitate application comparisons';