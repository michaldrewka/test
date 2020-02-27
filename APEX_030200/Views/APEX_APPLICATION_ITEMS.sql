CREATE OR REPLACE FORCE VIEW apex_application_items (workspace,application_id,application_name,item_name,data_type,session_state_protection,build_option,last_updated_by,last_updated_on,component_comment,application_item_id,component_signature) AS
select
    w.short_name                     workspace,
    f.ID                             application_id,
    f.NAME                           application_name,
    --
    i.NAME                           item_name,
    --i.NAME_LENGTH
    i.DATA_TYPE                      data_type,
    --i.IS_PERSISTENT                  ,
    i.PROTECTION_LEVEL               Session_State_Protection,
    (select case when i.required_patch > 0 then PATCH_NAME else '{Not '||PATCH_NAME||'}' end PATCH_NAME
     from   wwv_flow_patches
     where  id =abs(i.REQUIRED_PATCH))    build_option,
    i.LAST_UPDATED_BY                ,
    i.LAST_UPDATED_ON                ,
    i.ITEM_COMMENT                   component_comment,
    i.id                             application_item_id,
    --
    i.NAME
    ||' dt='||i.DATA_TYPE
    ||' prot='||i.PROTECTION_LEVEL
    ||' bo='||(select PATCH_NAME
     from   wwv_flow_patches
     where  id =i.REQUIRED_PATCH)
    component_signature
from wwv_flow_items i,
     wwv_flows f,
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(nv('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = s.security_group_id) and
      f.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.schema = f.owner and
      s.security_group_id = w.PROVISIONING_COMPANY_ID and
      f.id = i.flow_id and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      w.PROVISIONING_COMPANY_ID != 0 and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10);
COMMENT ON TABLE apex_application_items IS 'Identifies Application Items used to maintain session state that are not associated with a page';
COMMENT ON COLUMN apex_application_items.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_items.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_items.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_items.item_name IS 'Name of the Application Item used to maintain session state';
COMMENT ON COLUMN apex_application_items.data_type IS 'Datatype (Varchar or Number) of the Application Item.  Use a numeric data type to limit exposure to URL hackers for management of numeric session state';
COMMENT ON COLUMN apex_application_items.session_state_protection IS 'Identifies the Session State Protection for this item.  If the item is "Unrestricted" the item may be set by passing the item name/value in a URL or in a form.  Other protection levels provide enhanced protection of session state.';
COMMENT ON COLUMN apex_application_items.build_option IS 'Application Item will be available if the Build Option is enabled';
COMMENT ON COLUMN apex_application_items.last_updated_by IS 'Apex developer who made last update';
COMMENT ON COLUMN apex_application_items.last_updated_on IS 'Date of last update';
COMMENT ON COLUMN apex_application_items.component_comment IS 'Developer comment';
COMMENT ON COLUMN apex_application_items.application_item_id IS 'Primary key of this Application Item';
COMMENT ON COLUMN apex_application_items.component_signature IS 'Identifies attributes defined at a given component level to facilitate application comparisons';