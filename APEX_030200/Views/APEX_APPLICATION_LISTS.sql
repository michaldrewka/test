CREATE OR REPLACE FORCE VIEW apex_application_lists (workspace,application_id,application_name,list_name,"TEMPLATE",build_option,list_entries,last_updated_by,last_updated_on,component_comment,list_id,component_signature) AS
select
    w.short_name                     workspace,
    f.ID                             application_id,
    f.NAME                           application_name,
    --
    l.NAME                           list_name,
    --l.LIST_STATUS                    list_status,
    --l.LIST_DISPLAYED,
    (select list_template_name from wwv_flow_list_templates where id = l.DISPLAY_ROW_TEMPLATE_ID)  template,
    (select case when l.required_patch > 0 then PATCH_NAME else '{Not '||PATCH_NAME||'}' end PATCH_NAME
     from   wwv_flow_patches
     where  id =abs(l.REQUIRED_PATCH))    build_option,
    (select count(*) from wwv_flow_list_items where list_id = l.id) list_entries,
    --
    l.LAST_UPDATED_BY                last_updated_by,
    l.LAST_UPDATED_ON                last_updated_on,
    l.LIST_COMMENT                   component_comment,
    l.ID                             list_id,
    --
    l.NAME
    ||' s='||l.LIST_STATUS
    ||' t='||(select list_template_name from wwv_flow_list_templates where id = l.DISPLAY_ROW_TEMPLATE_ID)
    ||' bo='||(select PATCH_NAME
     from   wwv_flow_patches
     where  id =abs(l.REQUIRED_PATCH))
    component_signature
from wwv_flow_lists l,
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
COMMENT ON TABLE apex_application_lists IS 'Identifies a named collection of Application List Entries which can be included on any page using a region of type List.  Display attributes are controlled using a List Template.';
COMMENT ON COLUMN apex_application_lists.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_lists.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_lists.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_lists.list_name IS 'Identifies the name of the Application List';
COMMENT ON COLUMN apex_application_lists."TEMPLATE" IS 'Identifies the List Template to use by default when rendering this List within a Region.  Regions may override this default template.';
COMMENT ON COLUMN apex_application_lists.build_option IS 'List will be displayed if the Build Option is enabled';
COMMENT ON COLUMN apex_application_lists.list_entries IS 'Number of list entries defined for list';
COMMENT ON COLUMN apex_application_lists.last_updated_by IS 'Apex developer who made last update';
COMMENT ON COLUMN apex_application_lists.last_updated_on IS 'Date of last update';
COMMENT ON COLUMN apex_application_lists.component_comment IS 'Developer Comment';
COMMENT ON COLUMN apex_application_lists.list_id IS 'Identifies the primary key of this component';
COMMENT ON COLUMN apex_application_lists.component_signature IS 'Identifies attributes defined at a given component level to facilitate application comparisons';