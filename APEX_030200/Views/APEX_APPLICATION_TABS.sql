CREATE OR REPLACE FORCE VIEW apex_application_tabs (workspace,application_id,application_name,tab_set,display_sequence,tab_name,when_current_tab_image,when_not_current_tab_image,tab_image_attributes,tab_label,tab_page,tab_also_current_for_pages,parent_tabset,condition_type,condition_expression1,condition_expression2,build_option,authorization_scheme,authorization_scheme_id,last_updated_by,last_updated_on,component_comment,tab_id,component_signature) AS
select
    w.short_name                     workspace,
    f.ID                             application_id,
    f.NAME                           application_name,
    --
    t.TAB_SET                        tab_set,
    t.TAB_SEQUENCE                   display_sequence,
    t.TAB_NAME                       tab_name,
    t.TAB_IMAGE                      when_current_tab_image,
    t.TAB_NON_CURRENT_IMAGE          when_not_current_tab_image,
    t.TAB_IMAGE_ATTRIBUTES           tab_image_attributes,
    t.TAB_TEXT                       tab_label,
    t.TAB_STEP                       tab_page,
    t.TAB_ALSO_CURRENT_FOR_PAGES     tab_also_current_for_pages,
    t.TAB_PARENT_TABSET              parent_tabset,
    --
    nvl((select r from apex_standard_conditions where d = t.DISPLAY_CONDITION_TYPE),t.DISPLAY_CONDITION_TYPE)
                                     condition_type,
    t.TAB_PLSQL_CONDITION            condition_expression1,
    t.TAB_DISP_COND_TEXT             condition_expression2,
    --
    (select case when t.required_patch > 0 then PATCH_NAME else '{Not '||PATCH_NAME||'}' end PATCH_NAME
     from   wwv_flow_patches
     where  id =abs(t.REQUIRED_PATCH))    build_option,
     --
    decode(substr(t.SECURITY_SCHEME,1,1),'!','Not ')||
    nvl((select name
     from    wwv_flow_security_schemes
     where   to_char(id)= ltrim(t.SECURITY_SCHEME,'!')
     and     flow_id = f.id),
     t.SECURITY_SCHEME)              authorization_scheme,
    t.SECURITY_SCHEME                authorization_scheme_id,
    --
    t.LAST_UPDATED_BY                last_updated_by,
    t.LAST_UPDATED_ON                last_updated_on,
    t.TAB_COMMENT                    component_comment,
    t.id                             tab_id,
    --
    t.TAB_SET
    ||' '||lpad(t.TAB_SEQUENCE,5,'00000')
    ||' '||t.TAB_NAME
    ||substr(t.TAB_IMAGE,1,30)||length(t.TAB_IMAGE)
    ||substr(t.TAB_NON_CURRENT_IMAGE,1,30)||length(t.TAB_NON_CURRENT_IMAGE)
    ||substr(t.TAB_IMAGE_ATTRIBUTES,1,30)||length(t.TAB_IMAGE_ATTRIBUTES)
    ||' text='||substr(t.TAB_TEXT,1,30)||length(t.TAB_TEXT)
    ||' p='||t.TAB_STEP
    ||' a='||substr(t.TAB_ALSO_CURRENT_FOR_PAGES,1,30)||length(t.TAB_ALSO_CURRENT_FOR_PAGES)
    ||substr(t.TAB_PARENT_TABSET,1,30)||length(t.TAB_PARENT_TABSET)
    ||' c='||t.DISPLAY_CONDITION_TYPE
    ||substr(t.TAB_PLSQL_CONDITION,1,30)||length(t.TAB_PLSQL_CONDITION)
    ||substr(t.TAB_DISP_COND_TEXT,1,30)||length(t.TAB_DISP_COND_TEXT)
    ||(select PATCH_NAME
     from   wwv_flow_patches
     where  id =abs(t.REQUIRED_PATCH))
    ||decode(substr(t.SECURITY_SCHEME,1,1),'!','Not ')||
    nvl((select name
     from    wwv_flow_security_schemes
     where   to_char(id)= ltrim(t.SECURITY_SCHEME,'!')
     and     flow_id = f.id),
     t.SECURITY_SCHEME)
    component_signature
from wwv_flow_tabs t,
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
COMMENT ON TABLE apex_application_tabs IS 'Identifies a set of tabs collected into tab sets which are associated with a Standard Tab Entry';
COMMENT ON COLUMN apex_application_tabs.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_tabs.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_tabs.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_tabs.tab_set IS 'Identifies a collection of tabs that will be displayed together.  If an application uses tabs each page identifies the Tab Set to be displayed with the page.';
COMMENT ON COLUMN apex_application_tabs.display_sequence IS 'Identifies the display sequence of the Tab within the Tab Set';
COMMENT ON COLUMN apex_application_tabs.tab_name IS 'Identifies the name of the tab; which will be the value of the REQUEST when the tab is pressed';
COMMENT ON COLUMN apex_application_tabs.when_current_tab_image IS 'For tabs displayed using images and not a Tab Label, identifies the current tab image';
COMMENT ON COLUMN apex_application_tabs.when_not_current_tab_image IS 'For tabs displayed using images and not a Tab Label, identifies the non current tab image';
COMMENT ON COLUMN apex_application_tabs.tab_image_attributes IS 'Identifies the HTML IMG tag image attributes';
COMMENT ON COLUMN apex_application_tabs.tab_label IS 'Identifies the display Tab Label for tabs that are not based on image';
COMMENT ON COLUMN apex_application_tabs.tab_page IS 'Identifies the page which is current and associated with this tab.';
COMMENT ON COLUMN apex_application_tabs.tab_also_current_for_pages IS 'Identifies one or more other page ID''s which are also current for this tab';
COMMENT ON COLUMN apex_application_tabs.parent_tabset IS 'Identifies the Parent Tab Tab-Set to be displayed when this tab is current.  Used only when using two levels of tabs.';
COMMENT ON COLUMN apex_application_tabs.condition_type IS 'Identifies the condition type used to conditionally display the tab.';
COMMENT ON COLUMN apex_application_tabs.condition_expression1 IS 'Specifies an expression based on the specific condition type selected.';
COMMENT ON COLUMN apex_application_tabs.condition_expression2 IS 'Specifies an expression based on the specific condition type selected.';
COMMENT ON COLUMN apex_application_tabs.build_option IS 'Tab will be displayed if the Build Option is enabled';
COMMENT ON COLUMN apex_application_tabs.authorization_scheme IS 'An authorization scheme must evaluate to TRUE in order for this tab to be displayed';
COMMENT ON COLUMN apex_application_tabs.authorization_scheme_id IS 'Foreign Key';
COMMENT ON COLUMN apex_application_tabs.last_updated_by IS 'Apex developer who made last update';
COMMENT ON COLUMN apex_application_tabs.last_updated_on IS 'Date of last update';
COMMENT ON COLUMN apex_application_tabs.component_comment IS 'Developer comment';
COMMENT ON COLUMN apex_application_tabs.tab_id IS 'Primary key of this tab';
COMMENT ON COLUMN apex_application_tabs.component_signature IS 'Identifies attributes defined at a given component level to facilitate application comparisons';