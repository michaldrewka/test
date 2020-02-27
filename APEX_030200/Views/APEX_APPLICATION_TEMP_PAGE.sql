CREATE OR REPLACE FORCE VIEW apex_application_temp_page (workspace,application_id,application_name,template_name,header_template,page_body,footer_template,success_message,current_tab,current_tab_font_attr,non_current_tab,non_current_tab_font_attr,current_image_tab,non_current_image_tab,current_parent_tab,current_parent_tab_attr,noncurrent_parent_tab,noncurrent_parent_tab_attr,navigation_bar,navbar_entry,message,multicolumn_region_table_attr,error_page_template,is_subscribed,subscribed_from,theme_number,theme_class,last_updated_by,last_updated_on,translatable,component_comment,template_id,component_signature) AS
select
    w.short_name                     workspace,
    f.ID                             application_id,
    f.NAME                           application_name,
    --
    t.NAME                           template_name,
    --t.LOOK
    --
    t.HEADER_TEMPLATE                ,
    t.BOX                            page_body,
    t.FOOTER_TEMPLATE                ,
    --
    t.SUCCESS_MESSAGE                ,
    t.CURRENT_TAB                    ,
    t.CURRENT_TAB_FONT_ATTR          ,
    t.NON_CURRENT_TAB                ,
    t.NON_CURRENT_TAB_FONT_ATTR      ,
    t.CURRENT_IMAGE_TAB              ,
    t.NON_CURRENT_IMAGE_TAB          ,
    t.TOP_CURRENT_TAB                Current_Parent_Tab,
    t.TOP_CURRENT_TAB_FONT_ATTR      Current_Parent_Tab_attr,
    t.TOP_NON_CURRENT_TAB            NonCurrent_Parent_Tab,
    t.TOP_NON_CURRENT_TAB_FONT_ATTR  NonCurrent_Parent_Tab_attr,
    --
    t.NAVIGATION_BAR                 ,
    t.NAVBAR_ENTRY                   ,
    --t.BODY_TITLE                     ,
    t.MESSAGE                        ,
    --t.ATTRIBUTE1                     ,
    --t.ATTRIBUTE2                     ,
    --t.ATTRIBUTE3                     ,
    --t.ATTRIBUTE4                     ,
    --t.ATTRIBUTE5                     ,
    --t.ATTRIBUTE6                     ,
    --t.DEFAULT_BUTTON_POSITION        ,
    --t.TABLE_BGCOLOR                  ,
    --t.HEADING_BGCOLOR                ,
    --t.TABLE_CATTRIBUTES              ,
    --t.FONT_SIZE                      ,
    --t.FONT_FACE                      ,
    t.REGION_TABLE_CATTRIBUTES         MultiColumn_Region_Table_Attr,
    --t.APP_TAB_BEFORE_TABS            ,
    --t.APP_TAB_CURRENT_TAB            ,
    --t.APP_TAB_NON_CURRENT_TAB        ,
    --t.APP_TAB_AFTER_TABS             ,
    t.ERROR_PAGE_TEMPLATE            ,
    --
    decode(t.REFERENCE_ID,
    null,'No','Yes')                 is_subscribed,
    (select flow_id||'. '||name
     from wwv_flow_templates
     where id = t.REFERENCE_ID)      subscribed_from,
    --
    --t.BREADCRUMB_DEF_REG_POS         ,
    --t.SIDEBAR_DEF_REG_POS            ,
    --t.REQUIRED_PATCH                 ,
    t.THEME_ID                       theme_number,
    decode(t.THEME_CLASS_ID,
      '1', 'One Level Tabs',
      '2', 'Two Level Tabs',
      '3', 'No Tabs',
      '4', 'Popup',
      '5', 'Printer Friendly',
      '6', 'Login',
      '7', 'Unknown',
      '8',  'Custom 1',
      '9',  'Custom 2',
      '10', 'Custom 3',
      '11', 'Custom 4',
      '12', 'Custom 5',
      '13', 'Custom 6',
      '14', 'Custom 7',
      '15', 'Custom 8',
      '16', 'One Level Tabs with Sidebar',
      '17', 'No Tabs with Sidebar',
      '18', 'Two Level Tabs with Sidebar',
      t.THEME_CLASS_ID)              theme_class,
    t.LAST_UPDATED_BY                last_updated_by,
    t.LAST_UPDATED_ON                last_updated_on,
    decode(
       t.TRANSLATE_THIS_TEMPLATE,
       'N','No','Y','Yes','Yes')     translatable,
    t.TEMPLATE_COMMENT               component_comment,
    t.id                             template_id,
    --
    substr(t.NAME,1,40)||'.'||length(t.NAME)
    ||' h='||dbms_lob.substr(t.HEADER_TEMPLATE                  ,40,1)||'.'||dbms_lob.getlength(t.HEADER_TEMPLATE                )
    ||' b='||dbms_lob.substr(t.BOX                              ,40,1)||'.'||dbms_lob.getlength(t.BOX                            )
    ||' f='||dbms_lob.substr(t.FOOTER_TEMPLATE                  ,40,1)||'.'||dbms_lob.getlength(t.FOOTER_TEMPLATE                )
    ||' s='||substr(t.SUCCESS_MESSAGE                  ,1,40)||'.'||length(t.SUCCESS_MESSAGE                )
    ||' t='||substr(t.CURRENT_TAB                      ,1,40)||'.'||length(t.CURRENT_TAB                    )
    ||' t='||substr(t.CURRENT_TAB_FONT_ATTR            ,1,40)||'.'||length(t.CURRENT_TAB_FONT_ATTR          )
    ||' n='||substr(t.NON_CURRENT_TAB                  ,1,40)||'.'||length(t.NON_CURRENT_TAB                )
    ||' n='||substr(t.NON_CURRENT_TAB_FONT_ATTR        ,1,40)||'.'||length(t.NON_CURRENT_TAB_FONT_ATTR      )
    ||' i='||substr(t.CURRENT_IMAGE_TAB                ,1,40)||'.'||length(t.CURRENT_IMAGE_TAB              )
    ||' i='||substr(t.NON_CURRENT_IMAGE_TAB            ,1,40)||'.'||length(t.NON_CURRENT_IMAGE_TAB          )
    ||' t='||substr(t.TOP_CURRENT_TAB                  ,1,40)||'.'||length(t.TOP_CURRENT_TAB                )
    ||' t='||substr(t.TOP_CURRENT_TAB_FONT_ATTR        ,1,40)||'.'||length(t.TOP_CURRENT_TAB_FONT_ATTR      )
    ||' t='||substr(t.TOP_NON_CURRENT_TAB              ,1,40)||'.'||length(t.TOP_NON_CURRENT_TAB            )
    ||' t='||substr(t.TOP_NON_CURRENT_TAB_FONT_ATTR    ,1,40)||'.'||length(t.TOP_NON_CURRENT_TAB_FONT_ATTR  )
    ||' n='||substr(t.NAVIGATION_BAR                   ,1,40)||'.'||length(t.NAVIGATION_BAR                 )
    ||' n='||substr(t.NAVBAR_ENTRY                     ,1,40)||'.'||length(t.NAVBAR_ENTRY                   )
    ||' m='||substr(t.MESSAGE                          ,1,40)||'.'||length(t.MESSAGE                        )
    ||' e='||substr(t.ERROR_PAGE_TEMPLATE              ,1,40)||'.'||length(t.ERROR_PAGE_TEMPLATE            )
    --
    ||' s='||decode(t.REFERENCE_ID,null,'No','Yes')
    ||' t='||t.THEME_ID
    ||' c='||decode(t.THEME_CLASS_ID,
      '1', 'One Level Tabs',
      '2', 'Two Level Tabs',
      '3', 'No Tabs',
      '4', 'Popup',
      '5', 'Printer Friendly',
      '6', 'Login',
      '7', 'Unknown',
      '8',  'Custom 1',
      '9',  'Custom 2',
      '10', 'Custom 3',
      '11', 'Custom 4',
      '12', 'Custom 5',
      '13', 'Custom 6',
      '14', 'Custom 7',
      '15', 'Custom 8',
      '16', 'One Level Tabs with Sidebar',
      '17', 'No Tabs with Sidebar',
      '18', 'Two Level Tabs with Sidebar',
      t.THEME_CLASS_ID)
    ||' t='||t.TRANSLATE_THIS_TEMPLATE
    component_signature
from wwv_flow_templates t,
     wwv_flows f,
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(nv('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = s.security_group_id) and
      f.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.schema = f.owner and
      f.id = t.flow_id and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      w.PROVISIONING_COMPANY_ID != 0 and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10);
COMMENT ON TABLE apex_application_temp_page IS 'The Page Template which identifies the HTML used to organized and render a page content';
COMMENT ON COLUMN apex_application_temp_page.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_temp_page.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_temp_page.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_temp_page.template_name IS 'Name of the Page Template';
COMMENT ON COLUMN apex_application_temp_page.header_template IS 'In the Header is the first of 3 parts of the page template.  Enter the HTML that makes up the HEAD section of the HTML document.  That is, all the required HTML tags before the BODY of the HTML document.';
COMMENT ON COLUMN apex_application_temp_page.page_body IS 'The Body is the second of 3 parts of the page template.  Enter HTML that makes up the BODY of the HTML document.';
COMMENT ON COLUMN apex_application_temp_page.footer_template IS 'The Footer is the third template and displays after the body.';
COMMENT ON COLUMN apex_application_temp_page.success_message IS 'Enter HTML that will substitute the string #SUCCESS_MESSAGE# in the template body';
COMMENT ON COLUMN apex_application_temp_page.current_tab IS 'Enter HTML or text that will be substituted for the currently selected standard tab, use #TAB_LINK#" and #TAB_LABEL# substitutions.';
COMMENT ON COLUMN apex_application_temp_page.current_tab_font_attr IS 'This attribute is part of the Standard Tab subtemplate.  This value replaces the #TAB_FONT_ATTRIBUTES# substitution string.';
COMMENT ON COLUMN apex_application_temp_page.non_current_tab IS 'HTML or text that will be substituted for the unselected standard tabs, use #TAB_LINK#" and #TAB_LABEL# substitutions';
COMMENT ON COLUMN apex_application_temp_page.non_current_tab_font_attr IS 'This attribute is part of the Parent Tab subtemplate and expands the #PARENT_TAB_CELLS# substitution string.';
COMMENT ON COLUMN apex_application_temp_page.current_image_tab IS 'HTML to be used to indicate that an image-based tab is currently selected';
COMMENT ON COLUMN apex_application_temp_page.non_current_image_tab IS 'HTML to be used to indicate that an image-based tab is not currently selected';
COMMENT ON COLUMN apex_application_temp_page.current_parent_tab IS 'HTML or text that will be substituted for the selected parent tabs';
COMMENT ON COLUMN apex_application_temp_page.current_parent_tab_attr IS 'This value replaces the #TAB_FONT_ATTRIBUTES# substitution string';
COMMENT ON COLUMN apex_application_temp_page.noncurrent_parent_tab IS 'HTML or text that will be substituted for the unselected standard tabs, use #TAB_LINK# and #TAB_LABEL# substitutions';
COMMENT ON COLUMN apex_application_temp_page.noncurrent_parent_tab_attr IS 'This value replaces the #TAB_FONT_ATTRIBUTES# substitution string';
COMMENT ON COLUMN apex_application_temp_page.navigation_bar IS 'HTML or text that will be substituted when the string #NAVIGATION_BAR# is referenced in the template header, body or footer';
COMMENT ON COLUMN apex_application_temp_page.navbar_entry IS 'HTML or text that will be substituted into the navigation bar #BAR_BODY# for each navigation bar entry';
COMMENT ON COLUMN apex_application_temp_page.message IS 'HTML or text that will be substituted when the string #NOTIFICATION_MESSAGE# is referenced in the template header, body or footer';
COMMENT ON COLUMN apex_application_temp_page.multicolumn_region_table_attr IS 'This attribute controls the attributes of the HTML table tag used to display regions in multiple columns.';
COMMENT ON COLUMN apex_application_temp_page.error_page_template IS 'Used only when this page template will be designated as an error template.  Use #MESSAGE# to place the error message and #BACK_LINK# to display a link back to the previous page.';
COMMENT ON COLUMN apex_application_temp_page.is_subscribed IS 'Identifies if this template is subscribed from another template';
COMMENT ON COLUMN apex_application_temp_page.subscribed_from IS 'Identifies the Application ID and Template Name this template is subscribed from';
COMMENT ON COLUMN apex_application_temp_page.theme_number IS 'Identifies the theme number associated with all templates within the theme';
COMMENT ON COLUMN apex_application_temp_page.theme_class IS 'Identifies a specific usage for this template';
COMMENT ON COLUMN apex_application_temp_page.last_updated_by IS 'Apex developer who made last update';
COMMENT ON COLUMN apex_application_temp_page.last_updated_on IS 'Date of last update';
COMMENT ON COLUMN apex_application_temp_page.translatable IS 'Identifies if this component is to be identified as translatable (yes or no)';
COMMENT ON COLUMN apex_application_temp_page.component_comment IS 'Developer comment';
COMMENT ON COLUMN apex_application_temp_page.template_id IS 'Primary Key of this Page Template';
COMMENT ON COLUMN apex_application_temp_page.component_signature IS 'Identifies attributes defined at a given component level to facilitate application comparisons';