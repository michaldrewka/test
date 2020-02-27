CREATE OR REPLACE FORCE VIEW apex_application_temp_bc (workspace,application_id,application_name,theme_number,theme_class,template_name,before_first,current_page_option,non_current_page_option,breadcrumb_link_attributes,between_levels,after_last,max_levels,start_with,is_subscribed,subscribed_from,last_updated_by,last_updated_on,translatable,component_comments,breadcrumb_template_id,component_signature) AS
select
    w.short_name                     workspace,
    f.ID                             application_id,
    f.NAME                           application_name,
    --
    t.THEME_ID                       theme_number,
    --
    decode(t.THEME_CLASS_ID,
      '1','Breadcrumb',
      '2','Hierarchical',
      '3','Custom 1',
      '4','Custom 2',
      '5','Custom 3',
      '6','Custom 4',
      '7','Custom 5',
      '8','Custom 6',
      '9','Custom 7',
      '10','Custom 10',
      t.THEME_CLASS_ID)              theme_class,
    --
    t.NAME                           template_name,
    t.BEFORE_FIRST                   ,
    t.CURRENT_PAGE_OPTION            ,
    t.NON_CURRENT_PAGE_OPTION        ,
    t.MENU_LINK_ATTRIBUTES           breadcrumb_link_attributes,
    t.BETWEEN_LEVELS                 ,
    t.AFTER_LAST                     ,
    t.MAX_LEVELS                     ,
    decode(t.START_WITH_NODE,
       'CHILD_MENU','Child Breadcrumb Entries',
       'CURRENT_MENU','Current Breadcrumb',
       'PARENT_MENU','Parent Breadcrumb Entries',
       'PARENT_TO_LEAF','Parent to Leaf (breadcrumb style)',
       t.START_WITH_NODE)            start_with,
    --
    decode(t.REFERENCE_ID,
    null,'No','Yes')                 is_subscribed,
    (select flow_id||'. '||name
     from WWV_FLOW_MENU_TEMPLATES
     where id = t.REFERENCE_ID)      subscribed_from,
    --
    t.LAST_UPDATED_BY                last_updated_by,
    t.LAST_UPDATED_ON                last_updated_on,
    decode(t.TRANSLATE_THIS_TEMPLATE,
      'Y','Yes','N','No','Yes')      translatable,
    t.TEMPLATE_COMMENTS              component_comments,
    t.id                             breadcrumb_template_id,
    --
    t.NAME
    ||' t='||t.THEME_ID
    ||' c='||t.THEME_CLASS_ID
    ||' 1='||substr(t.BEFORE_FIRST           ,1,30)||length(t.BEFORE_FIRST           )
    ||' 2='||substr(t.CURRENT_PAGE_OPTION    ,1,30)||length(t.CURRENT_PAGE_OPTION    )
    ||' 3='||substr(t.NON_CURRENT_PAGE_OPTION,1,30)||length(t.NON_CURRENT_PAGE_OPTION)
    ||' 4='||substr(t.MENU_LINK_ATTRIBUTES   ,1,30)||length(t.MENU_LINK_ATTRIBUTES   )
    ||' 5='||substr(t.BETWEEN_LEVELS         ,1,30)||length(t.BETWEEN_LEVELS         )
    ||' 6='||substr(t.AFTER_LAST             ,1,30)||length(t.AFTER_LAST             )
    ||' l='||t.MAX_LEVELS
    ||' r='||decode(t.REFERENCE_ID,null,'N','Y')
    ||' n='||t.START_WITH_NODE
    component_signature
from WWV_FLOW_MENU_TEMPLATES t,
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
COMMENT ON TABLE apex_application_temp_bc IS 'Identifies the HTML template markup used to render a Breadcrumb';
COMMENT ON COLUMN apex_application_temp_bc.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_temp_bc.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_temp_bc.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_temp_bc.theme_number IS 'Identifies the theme number associated with all templates within the theme';
COMMENT ON COLUMN apex_application_temp_bc.theme_class IS 'Identifies a specific usage for this template';
COMMENT ON COLUMN apex_application_temp_bc.template_name IS 'Identifies the name of this template';
COMMENT ON COLUMN apex_application_temp_bc.before_first IS 'Defines text that displays before the first breadcrumb entry.';
COMMENT ON COLUMN apex_application_temp_bc.current_page_option IS 'Defines current entry, use #LINK#, #NAME#, #NAME_ESC_SC#, #LONG_NAME# substitution strings';
COMMENT ON COLUMN apex_application_temp_bc.non_current_page_option IS 'Defines non current entry, use #LINK#, #NAME#, #NAME_ESC_SC#, #LONG_NAME# substitution strings';
COMMENT ON COLUMN apex_application_temp_bc.breadcrumb_link_attributes IS 'Displayed within the HTML "A" tag';
COMMENT ON COLUMN apex_application_temp_bc.between_levels IS 'Defines text that displays between levels of breadcrumb entries';
COMMENT ON COLUMN apex_application_temp_bc.after_last IS 'Defines text that displays after the last breadcrumb entry.';
COMMENT ON COLUMN apex_application_temp_bc.max_levels IS 'Specifies the number of levels that appear when displaying breadcrumbs in a breadcrumb style.';
COMMENT ON COLUMN apex_application_temp_bc.start_with IS 'Defines the breadcrumb display style';
COMMENT ON COLUMN apex_application_temp_bc.is_subscribed IS 'Identifies if this Breadcrumb Template is subscribed from another Breadcrumb Template';
COMMENT ON COLUMN apex_application_temp_bc.subscribed_from IS 'Identifies the master component from which this component is subscribed';
COMMENT ON COLUMN apex_application_temp_bc.last_updated_by IS 'Apex developer who made last update';
COMMENT ON COLUMN apex_application_temp_bc.last_updated_on IS 'Date of last update';
COMMENT ON COLUMN apex_application_temp_bc.translatable IS 'Identifies if this component is to be identified as translatable (yes or no)';
COMMENT ON COLUMN apex_application_temp_bc.component_comments IS 'Developer Comments';
COMMENT ON COLUMN apex_application_temp_bc.breadcrumb_template_id IS 'Primary Key of this Breadcrumb Template';
COMMENT ON COLUMN apex_application_temp_bc.component_signature IS 'Identifies attributes defined at a given component level to facilitate application comparisons';