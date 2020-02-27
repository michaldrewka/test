CREATE OR REPLACE FORCE VIEW apex_application_list_entries (workspace,application_id,application_name,list_name,parent_entry_text,display_sequence,entry_text,entry_target,entry_image,entry_image_attributes,current_for_pages_type,current_for_pages_expression,condition_type,condition_expression1,condition_expression2,count_clicks,click_count_category,entry_attribute_01,entry_attribute_02,entry_attribute_03,entry_attribute_04,entry_attribute_05,entry_attribute_06,entry_attribute_07,entry_attribute_08,entry_attribute_09,entry_attribute_10,build_option,authorization_scheme,authorization_scheme_id,last_updated_by,last_updated_on,component_comment,list_id,list_entry_parent_id,list_entry_id,component_signature) AS
select
    w.short_name                     workspace,
    f.ID                             application_id,
    f.NAME                           application_name,
    --
    l.NAME                           list_name,
    --
    --e.SUB_ITEM_COUNT                 ,
    --e.PARENT_LIST_ITEM_ID            ,
    (select list_item_link_text
     from   wwv_flow_list_items
     where  id = e.PARENT_LIST_ITEM_ID and
            flow_id = e.flow_id)     parent_entry_text,
    --e.LIST_ITEM_TYPE                 ,
    --e.LIST_ITEM_STATUS               ,
    --e.ITEM_DISPLAYED                 ,
    e.LIST_ITEM_DISPLAY_SEQUENCE     display_sequence,
    e.LIST_ITEM_LINK_TEXT            entry_text,
    e.LIST_ITEM_LINK_TARGET          entry_target,
    --
    e.LIST_ITEM_ICON                 entry_image,
    e.LIST_ITEM_ICON_ATTRIBUTES      entry_image_attributes,
    --e.LIST_ITEM_ICON_EXP             ,
    --e.LIST_ITEM_ICON_EXP_ATTR        ,
    --e.LIST_ITEM_OWNER                ,
    --
    decode(e.LIST_ITEM_CURRENT_TYPE,
      'ALWAYS',                      'Always',
      'COLON_DELIMITED_PAGE_LIST',   'Colon Delimited Page List',
      'EXISTS',                      'Exists SQL Query',
      'NEVER',                       'Never',
      'NOT_EXISTS',                  'Not Exists SQL Query',
      'PLSQL_EXPRESSION',            'PL/SQL Expression',
      e.LIST_ITEM_CURRENT_TYPE)      current_for_pages_type,
    e.LIST_ITEM_CURRENT_FOR_PAGES    current_for_pages_expression,
    --
    nvl((select r from apex_standard_conditions where d = e.LIST_ITEM_DISP_COND_TYPE),e.LIST_ITEM_DISP_COND_TYPE)
                                     condition_type,
    e.LIST_ITEM_DISP_CONDITION       condition_expression1,
    --e.LIST_ITEM_DISP_COND_TYPE2      ,
    e.LIST_ITEM_DISP_CONDITION2      condition_expression2,
    --
    decode(e.LIST_COUNTCLICKS_Y_N,
      'Y','Yes','N','No',
      e.LIST_COUNTCLICKS_Y_N)        count_clicks,
    e.LIST_COUNTCLICKS_CAT           click_count_category,
    --
    e.LIST_TEXT_01                   entry_attribute_01,
    e.LIST_TEXT_02                   entry_attribute_02,
    e.LIST_TEXT_03                   entry_attribute_03,
    e.LIST_TEXT_04                   entry_attribute_04,
    e.LIST_TEXT_05                   entry_attribute_05,
    e.LIST_TEXT_06                   entry_attribute_06,
    e.LIST_TEXT_07                   entry_attribute_07,
    e.LIST_TEXT_08                   entry_attribute_08,
    e.LIST_TEXT_09                   entry_attribute_09,
    e.LIST_TEXT_10                   entry_attribute_10,
    --e.LIST_TEXT_11                   entry_attribute_11,
    --e.LIST_TEXT_12                   entry_attribute_12,
    --e.LIST_TEXT_13                   entry_attribute_13,
    --e.LIST_TEXT_14                   entry_attribute_14,
    --e.LIST_TEXT_15                   entry_attribute_15,
    --e.LIST_TEXT_16                   entry_attribute_16,
    --e.LIST_TEXT_17                   entry_attribute_17,
    --e.LIST_TEXT_18                   entry_attribute_18,
    --e.LIST_TEXT_19                   entry_attribute_19,
    --e.LIST_TEXT_20                   entry_attribute_20,
    --
    (select case when e.required_patch > 0 then PATCH_NAME else '{Not '||PATCH_NAME||'}' end PATCH_NAME
     from   wwv_flow_patches
     where  id =abs(e.REQUIRED_PATCH))    build_option,
    --
    decode(substr(e.SECURITY_SCHEME,1,1),'!','Not ')||
    nvl((select name
     from   wwv_flow_security_schemes
     where  to_char(id) = ltrim(e.SECURITY_SCHEME,'!')
     and    flow_id = f.id),
     e.SECURITY_SCHEME)              authorization_scheme,
    e.SECURITY_SCHEME                authorization_scheme_id,
    --
    e.LAST_UPDATED_BY                last_updated_by,
    e.LAST_UPDATED_ON                last_updated_on,
    e.LIST_ITEM_COMMENT              component_comment,
    e.list_id                        list_id,
    e.PARENT_LIST_ITEM_ID            list_entry_parent_id,
    e.id                             list_entry_id,
    --
    l.NAME
    ||' p='||(select list_item_link_text from wwv_flow_list_items where  id = e.PARENT_LIST_ITEM_ID and flow_id = e.flow_id)
    ||' '||lpad(e.LIST_ITEM_DISPLAY_SEQUENCE,5,'00000')
    ||' '||substr(e.LIST_ITEM_LINK_TEXT      ,1,30)
    ||' '||substr(e.LIST_ITEM_LINK_TARGET    ,1,30)||length(e.LIST_ITEM_LINK_TARGET)
    ||' '||substr(e.LIST_ITEM_ICON           ,1,30)
    ||' '||substr(e.LIST_ITEM_ICON_ATTRIBUTES,1,30)||length(e.LIST_ITEM_ICON_ATTRIBUTES)
    ||' '||decode(e.LIST_ITEM_CURRENT_TYPE,
      'ALWAYS',                      'Always',
      'COLON_DELIMITED_PAGE_LIST',   'Colon Delimited Page List',
      'EXISTS',                      'Exists SQL Query',
      'NEVER',                       'Never',
      'NOT_EXISTS',                  'Not Exists SQL Query',
      'PLSQL_EXPRESSION',            'PL/SQL Expression',
      e.LIST_ITEM_CURRENT_TYPE)
    ||' '||substr(e.LIST_ITEM_CURRENT_FOR_PAGES,1,30)||length(e.LIST_ITEM_CURRENT_FOR_PAGES)
    ||' c='||e.LIST_ITEM_DISP_COND_TYPE
    ||substr(e.LIST_ITEM_DISP_CONDITION,1,30)||length(e.LIST_ITEM_DISP_CONDITION)
    ||substr(e.LIST_ITEM_DISP_CONDITION2,1,30)||length(e.LIST_ITEM_DISP_CONDITION2)
    ||' c='||decode(e.LIST_COUNTCLICKS_Y_N,
      'Y','Yes','N','No',
      e.LIST_COUNTCLICKS_Y_N)
    ||' c='||e.LIST_COUNTCLICKS_CAT
    ||' t='
    ||length(e.LIST_TEXT_01)
    ||length(e.LIST_TEXT_02)
    ||length(e.LIST_TEXT_03)
    ||length(e.LIST_TEXT_04)
    ||length(e.LIST_TEXT_05)
    ||length(e.LIST_TEXT_06)
    ||length(e.LIST_TEXT_07)
    ||length(e.LIST_TEXT_08)
    ||length(e.LIST_TEXT_09)
    ||length(e.LIST_TEXT_10)
    ||' b='||(select PATCH_NAME
     from   wwv_flow_patches
     where  id =abs(e.REQUIRED_PATCH))
    ||' s='||decode(substr(e.SECURITY_SCHEME,1,1),'!','Not ')||
    nvl((select name
     from   wwv_flow_security_schemes
     where  to_char(id) = ltrim(e.SECURITY_SCHEME,'!')
     and    flow_id = f.id),
     e.SECURITY_SCHEME)
    component_signature
from wwv_flow_list_items e,
     wwv_flow_lists l,
     wwv_flows f,
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(nv('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = s.security_group_id) and
      f.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.schema = f.owner and
      f.id = l.flow_id and
      l.id = e.list_Id and
      f.id = e.flow_id and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      w.PROVISIONING_COMPANY_ID != 0 and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10);
COMMENT ON TABLE apex_application_list_entries IS 'Identifies the List Entries which define a List.  List Entries can be hierarchical or flat.';
COMMENT ON COLUMN apex_application_list_entries.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_list_entries.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_list_entries.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_list_entries.list_name IS 'Name of the Application List this List Entry is part of';
COMMENT ON COLUMN apex_application_list_entries.parent_entry_text IS 'Identifies the Parent of this List Entry';
COMMENT ON COLUMN apex_application_list_entries.display_sequence IS 'Identifies the display sequence';
COMMENT ON COLUMN apex_application_list_entries.entry_text IS 'Identifies the Link Text which will be displayed to the end user of the application';
COMMENT ON COLUMN apex_application_list_entries.entry_target IS 'Identifies the URL target of this List Entry';
COMMENT ON COLUMN apex_application_list_entries.entry_image IS 'Identifies an optional image associated with this List Entry';
COMMENT ON COLUMN apex_application_list_entries.entry_image_attributes IS 'Identifies image attributes that will be rendered within the HTML IMG tag for list entries that include Link Images';
COMMENT ON COLUMN apex_application_list_entries.current_for_pages_type IS 'Identifies a Condition Type used to determine if this List Entry is current; reference Current For Pages Expression attribute';
COMMENT ON COLUMN apex_application_list_entries.current_for_pages_expression IS 'Identifies a page or pages (or other condition) used to determine if this List Entry is to be rendered as a Current List Entry';
COMMENT ON COLUMN apex_application_list_entries.condition_type IS 'For conditionally displayed list entries; identifies the condition type.  The condition is specified in the Expression 1 and Expression 2 attributes.';
COMMENT ON COLUMN apex_application_list_entries.condition_expression1 IS 'Specifies an expression based on the specific condition type selected.';
COMMENT ON COLUMN apex_application_list_entries.condition_expression2 IS 'Specifies an expression based on the specific condition type selected.';
COMMENT ON COLUMN apex_application_list_entries.count_clicks IS 'Determines if the Apex click counter log should record a click entry when this list entry is clicked';
COMMENT ON COLUMN apex_application_list_entries.click_count_category IS 'Determines the Apex click counter category used to provide greater context to the click count log';
COMMENT ON COLUMN apex_application_list_entries.entry_attribute_01 IS 'Identifies attributes which may be referenced in the corresponding List Template';
COMMENT ON COLUMN apex_application_list_entries.entry_attribute_02 IS 'Identifies attributes which may be referenced in the corresponding List Template';
COMMENT ON COLUMN apex_application_list_entries.entry_attribute_03 IS 'Identifies attributes which may be referenced in the corresponding List Template';
COMMENT ON COLUMN apex_application_list_entries.entry_attribute_04 IS 'Identifies attributes which may be referenced in the corresponding List Template';
COMMENT ON COLUMN apex_application_list_entries.entry_attribute_05 IS 'Identifies attributes which may be referenced in the corresponding List Template';
COMMENT ON COLUMN apex_application_list_entries.entry_attribute_06 IS 'Identifies attributes which may be referenced in the corresponding List Template';
COMMENT ON COLUMN apex_application_list_entries.entry_attribute_07 IS 'Identifies attributes which may be referenced in the corresponding List Template';
COMMENT ON COLUMN apex_application_list_entries.entry_attribute_08 IS 'Identifies attributes which may be referenced in the corresponding List Template';
COMMENT ON COLUMN apex_application_list_entries.entry_attribute_09 IS 'Identifies attributes which may be referenced in the corresponding List Template';
COMMENT ON COLUMN apex_application_list_entries.entry_attribute_10 IS 'Identifies attributes which may be referenced in the corresponding List Template';
COMMENT ON COLUMN apex_application_list_entries.build_option IS 'List Entry will be displayed if the Build Option is enabled';
COMMENT ON COLUMN apex_application_list_entries.authorization_scheme IS 'An authorization scheme must evaluate to TRUE in order for this page to be displayed';
COMMENT ON COLUMN apex_application_list_entries.authorization_scheme_id IS 'Foreign Key';
COMMENT ON COLUMN apex_application_list_entries.last_updated_by IS 'Apex developer who made last update';
COMMENT ON COLUMN apex_application_list_entries.last_updated_on IS 'Date of last update';
COMMENT ON COLUMN apex_application_list_entries.component_comment IS 'Developer Comment';
COMMENT ON COLUMN apex_application_list_entries.list_id IS 'Foreign key of the List';
COMMENT ON COLUMN apex_application_list_entries.list_entry_parent_id IS 'Foreign key of the Parent List Entry';
COMMENT ON COLUMN apex_application_list_entries.list_entry_id IS 'Primary Key of this List Entry';
COMMENT ON COLUMN apex_application_list_entries.component_signature IS 'Identifies attributes defined at a given component level to facilitate application comparisons';