CREATE OR REPLACE FORCE VIEW apex_application_bc_entries (workspace,application_id,application_name,parent_breadcrumb_id,breadcrumb_id,entry_label,entry_long_label,url,defined_for_page,current_for_pages,condition_type,condition_expression1,condition_expression2,authorization_scheme,authorization_scheme_id,build_option,last_updated_by,last_updated_on,component_comment,breadcrumb_entry_id,component_signature) AS
select
    w.short_name                     workspace,
    f.ID                             application_id,
    f.NAME                           application_name,
    --
    m.PARENT_ID                      parent_breadcrumb_id,
    m.MENU_ID                        breadcrumb_id,
    --m.OPTION_SEQUENCE                display_sequence,
    m.SHORT_NAME                     entry_label,
    m.LONG_NAME                      entry_long_label,
    m.LINK                           url,
    m.PAGE_ID                        defined_for_page,
    m.ALSO_CURRENT_FOR_PAGES         current_for_pages,
    --
    nvl((select r from apex_standard_conditions where d = m.DISPLAY_WHEN_COND_TYPE),m.DISPLAY_WHEN_COND_TYPE)
                                     condition_type,
    m.DISPLAY_WHEN_CONDITION         condition_expression1,
    m.DISPLAY_WHEN_CONDITION2        condition_expression2,
    --
    decode(substr(m.SECURITY_SCHEME,1,1),'!','Not ')||
    nvl((select name
     from    wwv_flow_security_schemes
     where   to_char(id)= ltrim(m.SECURITY_SCHEME,'!')
     and     flow_id = f.id),
     m.SECURITY_SCHEME)              authorization_scheme,
    m.SECURITY_SCHEME                authorization_scheme_id,
     --
    (select case when m.required_patch > 0 then PATCH_NAME else '{Not '||PATCH_NAME||'}' end PATCH_NAME
     from   wwv_flow_patches
     where  id =abs(m.REQUIRED_PATCH) )   build_option,
    m.LAST_UPDATED_BY                last_updated_by,
    m.LAST_UPDATED_ON                last_updated_on,
    m.MENU_OPTION_COMMENT            component_comment,
    m.id                             breadcrumb_entry_id,
    --
    substr(m.SHORT_NAME,1,30)||length(m.SHORT_NAME)
    ||substr(m.LONG_NAME,1,30)||length(m.LONG_NAME)
    ||' l='||substr(m.LINK,1,30)||length(m.LINK)
    ||' p='||PAGE_ID
    ||' c='||substr(m.ALSO_CURRENT_FOR_PAGES,1,30)||length(m.ALSO_CURRENT_FOR_PAGES)
    ||' cond='||m.DISPLAY_WHEN_COND_TYPE
    ||substr(m.DISPLAY_WHEN_CONDITION,1,30)||length(m.DISPLAY_WHEN_CONDITION)
    ||substr(m.DISPLAY_WHEN_CONDITION2,1,30)||length(m.DISPLAY_WHEN_CONDITION2)
    ||' sec='||decode(substr(m.SECURITY_SCHEME,1,1),'!','Not ')||
      nvl((select name from wwv_flow_security_schemes where   to_char(id)= ltrim(m.SECURITY_SCHEME,'!') and flow_id = f.id), m.SECURITY_SCHEME)
    ||' bo='||(select PATCH_NAME
     from   wwv_flow_patches
     where  id =abs(m.REQUIRED_PATCH) )
    component_signature
from wwv_flow_menu_options m,
     wwv_flows f,
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(v('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = s.security_group_id) and
      f.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.schema = f.owner and
      f.id = m.flow_id and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      w.PROVISIONING_COMPANY_ID != 0 and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10);
COMMENT ON TABLE apex_application_bc_entries IS 'Identifies Breadcrumb Entries which map to a Page and identify a pages parent';
COMMENT ON COLUMN apex_application_bc_entries.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_bc_entries.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_bc_entries.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_bc_entries.parent_breadcrumb_id IS 'Identifies the Parent Breadcrumb ID.';
COMMENT ON COLUMN apex_application_bc_entries.breadcrumb_id IS 'Identifies the Primary Key of this Breadcrumb Entry';
COMMENT ON COLUMN apex_application_bc_entries.entry_label IS 'Identifies the label which will be displayed for this Breadcrumb Entry';
COMMENT ON COLUMN apex_application_bc_entries.entry_long_label IS 'Identifies an optional longer version of the Breadcrumb Entry';
COMMENT ON COLUMN apex_application_bc_entries.url IS 'The URL corresponding to a breadcrumb entry.  When a user clicks the breadcrumb they will navigate to this URL.';
COMMENT ON COLUMN apex_application_bc_entries.defined_for_page IS 'Identifies the pages for which this Breadcrumb Entry is defined';
COMMENT ON COLUMN apex_application_bc_entries.current_for_pages IS 'Identifies a page or pages for which this breadcrumb is current.  Current and non current breadcrumbs have different templates and may be rendered differently.';
COMMENT ON COLUMN apex_application_bc_entries.condition_type IS 'For breadcrumbs that are displayed conditionally identifies the condition type';
COMMENT ON COLUMN apex_application_bc_entries.condition_expression1 IS 'Specifies an expression based on the specific condition type selected.';
COMMENT ON COLUMN apex_application_bc_entries.condition_expression2 IS 'Specifies an expression based on the specific condition type selected.';
COMMENT ON COLUMN apex_application_bc_entries.authorization_scheme IS 'An authorization scheme must evaluate to TRUE in order for this page to be displayed';
COMMENT ON COLUMN apex_application_bc_entries.authorization_scheme_id IS 'Foreign Key';
COMMENT ON COLUMN apex_application_bc_entries.build_option IS 'Breadcrumb Entry will be displayed if the Build Option is enabled';
COMMENT ON COLUMN apex_application_bc_entries.last_updated_by IS 'Apex developer who made last update';
COMMENT ON COLUMN apex_application_bc_entries.last_updated_on IS 'Date of last update';
COMMENT ON COLUMN apex_application_bc_entries.component_comment IS 'Developer comment';
COMMENT ON COLUMN apex_application_bc_entries.breadcrumb_entry_id IS 'Foreign key identifying the Breadcrumb definition';
COMMENT ON COLUMN apex_application_bc_entries.component_signature IS 'Identifies attributes defined at a given component level to facilitate application comparisons';