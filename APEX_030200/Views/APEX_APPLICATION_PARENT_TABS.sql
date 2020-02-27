CREATE OR REPLACE FORCE VIEW apex_application_parent_tabs (workspace,application_id,application_name,tab_set,display_sequence,tab_name,when_current_image,when_non_current_image,image_attributes,tab_label,tab_target,condition_type,condition_expression1,condition_expression2,current_for_tabset,build_option,authorization_scheme,authorization_scheme_id,last_updated_by,last_updated_on,component_comment,parent_tab_id,component_signature) AS
select
    w.short_name                     workspace,
    f.ID                             application_id,
    f.NAME                           application_name,
    --
    t.TAB_SET                        tab_set,
    t.TAB_SEQUENCE                   display_sequence,
    t.TAB_NAME                       tab_name,
    t.TAB_IMAGE                      when_current_image,
    t.TAB_NON_CURRENT_IMAGE          when_non_current_image,
    t.TAB_IMAGE_ATTRIBUTES           image_attributes,
    t.TAB_TEXT                       tab_label,
    t.TAB_TARGET                     tab_target,
    --
    nvl((select r from apex_standard_conditions where d = t.DISPLAY_CONDITION_TYPE),t.DISPLAY_CONDITION_TYPE)
                                     condition_type,
    t.DISPLAY_CONDITION              condition_expression1,
    t.DISPLAY_CONDITION2             condition_expression2,
    --
    t.CURRENT_ON_TABSET              current_for_tabset,
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
    t.id                             parent_tab_id,
    --
    t.TAB_SET
    ||' '||lpad(t.TAB_SEQUENCE,5,'00000')
    ||' '||substr(t.TAB_NAME              ,1,30)||length(t.TAB_NAME             )
    ||' '||substr(t.TAB_IMAGE             ,1,30)||length(t.TAB_IMAGE            )
    ||' '||substr(t.TAB_NON_CURRENT_IMAGE ,1,30)||length(t.TAB_NON_CURRENT_IMAGE)
    ||' '||substr(t.TAB_IMAGE_ATTRIBUTES  ,1,30)||length(t.TAB_IMAGE_ATTRIBUTES )
    ||' '||substr(t.TAB_TEXT              ,1,30)||length(t.TAB_TEXT             )
    ||' '||substr(t.TAB_TARGET            ,1,30)||length(t.TAB_TARGET           )
    ||' cond='||t.DISPLAY_CONDITION_TYPE
    ||substr(t.DISPLAY_CONDITION,1,30)||length(t.DISPLAY_CONDITION)
    ||substr(t.DISPLAY_CONDITION2,1,30)||length(t.DISPLAY_CONDITION2)
    ||' ct='||t.CURRENT_ON_TABSET
    ||' bo='||(select PATCH_NAME
     from   wwv_flow_patches
     where  id =abs(t.REQUIRED_PATCH))
    ||' sec='||decode(substr(t.SECURITY_SCHEME,1,1),'!','Not ')||
    nvl((select name
     from    wwv_flow_security_schemes
     where   to_char(id)= ltrim(t.SECURITY_SCHEME,'!')
     and     flow_id = f.id),
     t.SECURITY_SCHEME)
    component_signature
from wwv_flow_toplevel_tabs t,
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
COMMENT ON TABLE apex_application_parent_tabs IS 'Identifies a collection of tabs called a Tab Set.  Each tab is part of a tab set and can be current for one or more pages.  Each tab can also have a corresponding Parent Tab if two levels of Tabs are defined.';
COMMENT ON COLUMN apex_application_parent_tabs.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_parent_tabs.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_parent_tabs.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_parent_tabs.tab_set IS 'Identifies a collection of Parent Tabs that are displayed together.';
COMMENT ON COLUMN apex_application_parent_tabs.display_sequence IS 'Identifies the display sequence within the Tab Set';
COMMENT ON COLUMN apex_application_parent_tabs.tab_name IS 'Identifies the Tab Name';
COMMENT ON COLUMN apex_application_parent_tabs.when_current_image IS 'For tabs displayed using images and not a Tab Label, identifies the current tab image';
COMMENT ON COLUMN apex_application_parent_tabs.when_non_current_image IS 'For tabs displayed using images and not a Tab Label, identifies the non current tab image';
COMMENT ON COLUMN apex_application_parent_tabs.image_attributes IS 'Identifies the HTML IMG tag image attributes';
COMMENT ON COLUMN apex_application_parent_tabs.tab_label IS 'Identifies the display Tab Label for tabs that are not based on image';
COMMENT ON COLUMN apex_application_parent_tabs.tab_target IS 'Identifies the Page or URL to branch to when this Parent Tab is pressed';
COMMENT ON COLUMN apex_application_parent_tabs.condition_type IS 'Identifies the condition type used to conditionally display the tab.';
COMMENT ON COLUMN apex_application_parent_tabs.condition_expression1 IS 'Specifies an expression based on the specific condition type selected.';
COMMENT ON COLUMN apex_application_parent_tabs.condition_expression2 IS 'Specifies an expression based on the specific condition type selected.';
COMMENT ON COLUMN apex_application_parent_tabs.current_for_tabset IS 'Identifies the child (corresponding standard tab) of this parent tab.';
COMMENT ON COLUMN apex_application_parent_tabs.build_option IS 'Tab will be displayed if the Build Option is enabled';
COMMENT ON COLUMN apex_application_parent_tabs.authorization_scheme IS 'An authorization scheme must evaluate to TRUE in order for this tab to be displayed';
COMMENT ON COLUMN apex_application_parent_tabs.authorization_scheme_id IS 'Foreign Key';
COMMENT ON COLUMN apex_application_parent_tabs.last_updated_by IS 'Apex developer who made last update';
COMMENT ON COLUMN apex_application_parent_tabs.last_updated_on IS 'Date of last update';
COMMENT ON COLUMN apex_application_parent_tabs.component_comment IS 'Developer comment';
COMMENT ON COLUMN apex_application_parent_tabs.parent_tab_id IS 'Primary key of the Parent Tab component';
COMMENT ON COLUMN apex_application_parent_tabs.component_signature IS 'Identifies attributes defined at a given component level to facilitate application comparisons';