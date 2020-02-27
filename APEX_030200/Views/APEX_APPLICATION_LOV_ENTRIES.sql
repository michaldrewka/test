CREATE OR REPLACE FORCE VIEW apex_application_lov_entries (workspace,application_id,application_name,list_of_values_name,display_sequence,display_value,return_value,lov_entry_template,condition_type,condition_expression1,condition_expression2,build_option,last_updated_by,last_updated_on,component_comment,lov_id,lov_entry_id,component_signature) AS
select
    w.short_name                     workspace,
    f.ID                             application_id,
    f.NAME                           application_name,
    --
    (select lov_name from wwv_flow_lists_of_values$ where id = l.lov_id) list_of_values_name,
    l.LOV_DISP_SEQUENCE              display_sequence,
    l.LOV_DISP_VALUE                 display_value,
    l.LOV_RETURN_VALUE               return_value,
    --
    l.LOV_TEMPLATE                   lov_entry_template,
    -- conditionality
    nvl((select r from apex_standard_conditions where d = l.LOV_DISP_COND_TYPE),l.LOV_DISP_COND_TYPE)
                                     condition_type,
    l.LOV_DISP_COND                  condition_expression1,
    l.LOV_DISP_COND2                 condition_expression2,
    (select case when l.required_patch > 0 then PATCH_NAME else '{Not '||PATCH_NAME||'}' end PATCH_NAME
     from   wwv_flow_patches
     where  id =abs(l.REQUIRED_PATCH))    build_option,
    --
    l.LAST_UPDATED_BY                last_updated_by,
    l.LAST_UPDATED_ON                last_updated_on,
    l.LOV_DATA_COMMENT               component_comment,
    --
    l.LOV_ID                         lov_id,
    l.id                             lov_entry_id,
    --
    (select lov_name from wwv_flow_lists_of_values$ where id = l.lov_id)
    ||' seq='||lpad(l.LOV_DISP_SEQUENCE,5,'00000')
    ||' v='||substr(l.LOV_DISP_VALUE,1,30)||length(l.LOV_DISP_VALUE)
    ||' r='||substr(l.LOV_RETURN_VALUE,1,30)||length(l.LOV_RETURN_VALUE)
    ||' t='||l.LOV_TEMPLATE
    ||' cond='||l.LOV_DISP_COND_TYPE
    ||substr(l.LOV_DISP_COND,1,30)||length(l.LOV_DISP_COND)
    ||substr(l.LOV_DISP_COND2,1,30)||length(l.LOV_DISP_COND2)
    ||' bo='||(select PATCH_NAME
     from   wwv_flow_patches
     where  id =abs(l.REQUIRED_PATCH))
    component_signature
from wwv_flow_list_of_values_data l,
     wwv_flows f,
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(nv('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = s.security_group_id) and
      f.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.schema = f.owner and
      f.id = l.flow_id and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      w.PROVISIONING_COMPANY_ID != 0 and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10);
COMMENT ON TABLE apex_application_lov_entries IS 'Identifies the List of Values Entries which comprise a shared List of Values';
COMMENT ON COLUMN apex_application_lov_entries.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_lov_entries.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_lov_entries.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_lov_entries.list_of_values_name IS 'Identifies the name of the List of Values';
COMMENT ON COLUMN apex_application_lov_entries.display_sequence IS 'List of Values display sequence';
COMMENT ON COLUMN apex_application_lov_entries.display_value IS 'Value displayed to end users';
COMMENT ON COLUMN apex_application_lov_entries.return_value IS 'Value returned and stored in session state';
COMMENT ON COLUMN apex_application_lov_entries.lov_entry_template IS 'Identifies a template used to display a List of Values Entry';
COMMENT ON COLUMN apex_application_lov_entries.condition_type IS 'Identifies the condition type used to conditionally execute the List of Values Entry';
COMMENT ON COLUMN apex_application_lov_entries.condition_expression1 IS 'Specifies an expression based on the specific condition type selected.';
COMMENT ON COLUMN apex_application_lov_entries.condition_expression2 IS 'Specifies an expression based on the specific condition type selected.';
COMMENT ON COLUMN apex_application_lov_entries.build_option IS 'List of Values Entry will be displayed if the Build Option is enabled';
COMMENT ON COLUMN apex_application_lov_entries.last_updated_by IS 'Apex developer who made last update';
COMMENT ON COLUMN apex_application_lov_entries.last_updated_on IS 'Date of last update';
COMMENT ON COLUMN apex_application_lov_entries.component_comment IS 'Developer Comment';
COMMENT ON COLUMN apex_application_lov_entries.lov_id IS 'Foreign Key of the List of Values';
COMMENT ON COLUMN apex_application_lov_entries.lov_entry_id IS 'Primary Key of the List of Values Entry';
COMMENT ON COLUMN apex_application_lov_entries.component_signature IS 'Identifies attributes defined at a given component level to facilitate application comparisons';