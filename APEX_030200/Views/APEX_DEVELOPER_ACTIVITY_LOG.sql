CREATE OR REPLACE FORCE VIEW apex_developer_activity_log (workspace,application_id,application_name,developer,audit_date,audit_action,page_id,page_name,"COMPONENT",component_name,workspace_id,component_id) AS
select
    w.short_name           workspace,
    f.ID                   application_id,
    f.NAME                 application_name,
    a.flow_user            developer,
    a.audit_date           audit_date,
    decode(a.audit_action,
       'I','Insert',
       'U','Update',
       'D','Delete',
       a.audit_action)     audit_action,
    a.page_id              page_id,
    (select name
     from wwv_flow_steps
     where flow_id = a.flow_id and
         id = a.page_id) page_name,
    --
    decode(a.flow_table,
       'WWV_FLOWS'	 	                , 'Application Attributes',
       'WWV_FLOW_COMPUTATIONS'        , 'Application Computation',
       'WWV_FLOW_CUSTOM_AUTH_SETUPS'  , 'Authentication Setups',
       'WWV_FLOW_DEVELOPERS'          , 'Application Developers (Administration)',
       'WWV_FLOW_EFFECTIVE_USERID_MAP', 'Effective User ID (Administration)',
       'WWV_FLOW_ENTRY_POINTS'        , 'Entry Points',
       'WWV_FLOW_ENTRY_POINT_ARGS'    , 'Entry Point Arguments',
       'WWV_FLOW_ICON_BAR'            , 'Navigation Bar',
       'WWV_FLOW_LISTS'               , 'Lists',
       'WWV_FLOW_ITEMS'               , 'Application Items',
       'WWV_FLOW_LISTS_OF_VALUES$'    , 'List of Values',
       'WWV_FLOW_LISTS_OF_VALUES_DATA', 'List of Values Entry',
       'WWV_FLOW_LIST_ITEMS'          , 'List Item',
       'WWV_FLOW_LIST_TEMPLATES'      , 'List Template',
       'WWV_FLOW_MENU_OPTIONS'        , 'Breadcrumb Entry',
       'WWV_FLOW_MESSAGES$'           , 'Messages',
       'WWV_FLOW_PAGE_PLUGS'          , 'Region Attributes',
       'WWV_FLOW_PAGE_PLUG_TEMPLATES' , 'Region Template',
       'WWV_FLOW_PATCHES'             , 'Build Options',
       'WWV_FLOW_PROCESSING'          , 'Application Process',
       'WWV_FLOW_ROW_TEMPLATES'       , 'Row Template',
       'WWV_FLOW_SHORTCUTS'           , 'Shortcuts',
       'WWV_FLOW_STEPS'               , 'Page Attributes',
       'WWV_FLOW_STEP_BRANCHES'       , 'Page Branch',
       'WWV_FLOW_STEP_BRANCH_ARGS'    , 'Page Branch Arguments',
       'WWV_FLOW_STEP_BUTTONS'        , 'Page Button',
       'WWV_FLOW_STEP_COMPUTATIONS'   , 'Page Computation',
       'WWV_FLOW_STEP_ITEMS'          , 'Page Item',
       'WWV_FLOW_STEP_ITEM_HELP'      , 'Page Item Help Text',
       'WWV_FLOW_STEP_PROCESSING'     , 'Page Process',
       'WWV_FLOW_STEP_VALIDATIONS'    , 'Page Validation',
       'WWV_FLOW_TABS'                , 'Tabs',
       'WWV_FLOW_TEMPLATES'           , 'Page Template',
       'WWV_FLOW_THEMES'              , 'Themes',
       'WWV_FLOW_TOPLEVEL_TABS'       , 'Parent Tab',
       a.flow_table) component,
       decode(FLOW_TABLE,
'WWV_FLOW_PAGE_PLUGS',(select plug_name from wwv_flow_page_plugs where id = a.flow_table_pk),
'WWV_FLOW_ITEMS',(select name from wwv_flow_items where id = a.flow_table_pk),
'WWV_FLOW_STEP_BRANCHES',(select substr(BRANCH_ACTION,1,50) BRANCH_ACTION from wwv_flow_step_branches where id=a.flow_table_pk),
'WWV_FLOW_PROCESSING',(select process_name from wwv_flow_processing where id=a.flow_table_pk),
'WWV_FLOW_TOPLEVEL_TABS',(select TAB_NAME from WWV_FLOW_TOPLEVEL_TABS where id=a.flow_table_pk),
'WWV_FLOW_LISTS_OF_VALUES_DATA',(select lov_return_value from WWV_FLOW_LIST_OF_VALUES_DATA where id=a.flow_table_pk),
'WWV_FLOW_STEP_ITEM_HELP',(select name from wwv_flow_step_items where id = (select flow_item_id from WWV_FLOW_STEP_ITEM_HELP where id=a.flow_table_pk)),
'WWV_FLOW_DEVELOPERS',(select USERID from WWV_FLOW_DEVELOPERS where id=a.flow_table_pk),
'WWV_FLOW_LISTS_OF_VALUES$',(select LOV_NAME from WWV_FLOW_LISTS_OF_VALUES$ where id=a.flow_table_pk),
'WWV_FLOW_PAGE_PLUG_TEMPLATES',(select PAGE_PLUG_TEMPLATE_NAME from WWV_FLOW_PAGE_PLUG_TEMPLATES where id=a.flow_table_pk),
'WWV_FLOWS',flow_id,
'WWV_FLOW_STEP_COMPUTATIONS',(select COMPUTATION_ITEM from WWV_FLOW_STEP_COMPUTATIONS where id=a.flow_table_pk),
'WWV_FLOW_CUSTOM_AUTH_SETUPS',(select NAME from WWV_FLOW_CUSTOM_AUTH_SETUPS where id=a.flow_table_pk),
'WWV_FLOW_ICON_BAR',(select ICON_SEQUENCE||'. '||ICON_SUBTEXT n from WWV_FLOW_ICON_BAR where id=a.flow_table_pk),
'WWV_FLOW_STEP_BUTTONS',(select BUTTON_NAME||' "'||BUTTON_IMAGE_ALT||'"' n from wwv_flow_step_buttons where id=a.flow_table_pk),
'WWV_FLOW_STEPS',flow_table_pk,
'WWV_FLOW_COMPUTATIONS',(select COMPUTATION_SEQUENCE||'. '||COMPUTATION_ITEM n from WWV_FLOW_COMPUTATIONS where id=a.flow_table_pk),
'WWV_FLOW_TEMPLATES',(select NAME from WWV_FLOW_TEMPLATES where id=a.flow_table_pk),
'WWV_FLOW_TABS',(select TAB_NAME||' "'||tab_text||'"' n from WWV_FLOW_TABS where id=a.flow_table_pk),
'WWV_FLOW_STEP_ITEMS',(select name from wwv_flow_step_items where id = a.flow_table_pk),
'WWV_FLOW_MESSAGES$',(select NAME from WWV_FLOW_MESSAGES$ where id = a.flow_table_pk),
'WWV_FLOW_LIST_ITEMS',(select LIST_ITEM_LINK_TEXT from wwv_flow_list_items where id=a.flow_table_pk),
'WWV_FLOW_STEP_VALIDATIONS',(select VALIDATION_SEQUENCE||'. '||VALIDATION_NAME n from WWV_FLOW_STEP_VALIDATIONS where id = a.flow_table_pk),
'WWV_FLOW_STEP_PROCESSING',(select process_name from wwv_flow_step_processing where id=a.flow_table_pk),
'WWV_FLOW_ROW_TEMPLATES',(select ROW_TEMPLATE_NAME from WWV_FLOW_ROW_TEMPLATES where id=a.flow_table_pk),
'WWV_FLOW_LISTS',(select NAME from WWV_FLOW_LISTS where id=a.flow_table_pk),
'WWV_FLOW_THEMES',(select theme_id||'. '||THEME_NAME n from WWV_FLOW_THEMES where id=a.flow_table_pk),
'WWV_FLOW_SHORTCUTS',(select SHORTCUT_NAME from WWV_FLOW_SHORTCUTS where id=a.flow_table_pk),
'WWV_FLOW_MENU_OPTIONS',(select short_name from wwv_flow_menu_options where id = a.flow_table_pk),
'WWV_FLOW_LIST_TEMPLATES',(select LIST_TEMPLATE_NAME from WWV_FLOW_LIST_TEMPLATES where id=a.flow_table_pk),
FLOW_TABLE_PK) component_name,
    a.security_group_id   workspace_id,
    a.flow_table_pk       component_id
from
     wwv_flow_builder_audit_trail a,
     wwv_flows f,
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(v('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = w.PROVISIONING_COMPANY_ID) and
      f.security_group_id = w.PROVISIONING_COMPANY_ID and
      f.security_group_id = s.SECURITY_GROUP_ID and
      s.schema = f.owner and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      /* developers can not edit translated apps */
      not exists (
        select 1 from wwv_flow_language_map m
        where m.translation_flow_id = f.id) and
      w.PROVISIONING_COMPANY_ID != 0 and
      a.flow_id = f.id;
COMMENT ON TABLE apex_developer_activity_log IS 'Identifies developer changes to applications';
COMMENT ON COLUMN apex_developer_activity_log.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_developer_activity_log.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_developer_activity_log.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_developer_activity_log.developer IS 'Developer who made the change';
COMMENT ON COLUMN apex_developer_activity_log.audit_date IS 'Date of application component change';
COMMENT ON COLUMN apex_developer_activity_log.audit_action IS 'Insert, Update or Delete';
COMMENT ON COLUMN apex_developer_activity_log.page_id IS 'Identifies page number if component corresponds to a specific page';
COMMENT ON COLUMN apex_developer_activity_log.page_name IS 'Identifies corresponding page name';
COMMENT ON COLUMN apex_developer_activity_log."COMPONENT" IS 'The type of component changed';
COMMENT ON COLUMN apex_developer_activity_log.component_name IS 'The name of the affected component';
COMMENT ON COLUMN apex_developer_activity_log.workspace_id IS 'Primary key that identifies the workspace';
COMMENT ON COLUMN apex_developer_activity_log.component_id IS 'The unique ID of the affected component';