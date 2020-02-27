CREATE OR REPLACE FORCE VIEW apex_application_nav_bar (workspace,application_id,application_name,display_sequence,begins_on_new_line,cell_column_span,icon_image,icon_subtext,icon_target,icon_image_alt,icon_height,icon_width,condition_type,condition_expression1,condition_expression2,onclick_javascript,build_option,authorization_scheme,authorization_scheme_id,is_subscribed,subscribed_from,last_updated_by,last_updated_on,component_comment,nav_bar_id,referenced_nav_bar_id,component_signature) AS
select
    w.short_name                     workspace,
    f.ID                             application_id,
    f.NAME                           application_name,
    --
    n.ICON_SEQUENCE                  display_sequence,
    decode(n.BEGINS_ON_NEW_LINE,
       'YES','Yes',
       'NO','No',
       n.BEGINS_ON_NEW_LINE)         begins_on_new_line,
    n.CELL_COLSPAN                   cell_column_span,
    --
    n.ICON_IMAGE                     ,
    --n.ICON_IMAGE2                    ,
    --n.ICON_IMAGE3                    ,
    n.ICON_SUBTEXT                   ,
    --n.ICON_SUBTEXT2                  ,
    --n.ICON_SUBTEXT3                  ,
    n.ICON_TARGET                    ,
    n.ICON_IMAGE_ALT                 ,
    n.ICON_HEIGHT                    ,
    n.ICON_WIDTH                     ,
    --n.ICON_HEIGHT2                   ,
    --n.ICON_WIDTH2                    ,
    --n.ICON_HEIGHT3                   ,
    --n.ICON_WIDTH3                    ,
    --
    nvl((select r from apex_standard_conditions where d = n.ICON_BAR_DISP_COND_TYPE),n.ICON_BAR_DISP_COND_TYPE)
                                     condition_type,
    n.ICON_BAR_DISP_COND             condition_expression1,
    n.ICON_BAR_FLOW_COND_INSTR       condition_expression2,
    --
    n.ONCLICK                        onclick_javascript,
    --
    (select case when n.required_patch > 0 then PATCH_NAME else '{Not '||PATCH_NAME||'}' end PATCH_NAME
     from   wwv_flow_patches
     where  id =abs(n.REQUIRED_PATCH))    build_option,
     --
    decode(substr(n.SECURITY_SCHEME,1,1),'!','Not ')||
    nvl((select name
     from    wwv_flow_security_schemes
     where   to_char(id)= ltrim(n.SECURITY_SCHEME,'!')
     and     flow_id = f.id),
     n.SECURITY_SCHEME)              authorization_scheme,
    n.SECURITY_SCHEME                authorization_scheme_id,
    --
    decode(n.REFERENCE_ID,
    null,'No','Yes')                 is_subscribed,
    (select flow_id||'. '||name n
     from wwv_flow_icon_bar
     where id = n.reference_id)      subscribed_from,
    --
    n.LAST_UPDATED_BY                last_updated_by,
    n.LAST_UPDATED_ON                last_updated_on,
    n.ICON_BAR_COMMENT               component_comment,
    n.id                             nav_bar_id,
    n.REFERENCE_ID                   referenced_nav_bar_id,
    --
    lpad(n.ICON_SEQUENCE,5,'00000')
    ||decode(n.BEGINS_ON_NEW_LINE,
       'YES','Yes',
       'NO','No',
       n.BEGINS_ON_NEW_LINE)
    ||n.CELL_COLSPAN
    ||' img='||n.ICON_IMAGE
    ||' '||substr(n.ICON_SUBTEXT,1,30)||length(n.ICON_SUBTEXT)
    ||' t='||substr(n.ICON_TARGET,1,30)||length(n.ICON_TARGET)
    ||' a='||substr(n.ICON_IMAGE_ALT,1,20)||length(n.ICON_IMAGE_ALT)
    ||n.ICON_HEIGHT
    ||n.ICON_WIDTH
    ||' c='||n.ICON_BAR_DISP_COND_TYPE
    ||substr(n.ICON_BAR_DISP_COND,1,30)||length(n.ICON_BAR_DISP_COND)
    ||substr(n.ICON_BAR_FLOW_COND_INSTR,1,30)||length(n.ICON_BAR_FLOW_COND_INSTR)
    ||' ck='||substr(n.ONCLICK,1,20)||length(n.onclick)
    ||' bo='||
    (select PATCH_NAME
     from   wwv_flow_patches
     where  id =abs(n.REQUIRED_PATCH))
    ||' a='||decode(substr(n.SECURITY_SCHEME,1,1),'!','Not ')||
    nvl((select name
     from    wwv_flow_security_schemes
     where   to_char(id)= ltrim(n.SECURITY_SCHEME,'!')
     and     flow_id = f.id),
     n.SECURITY_SCHEME)
    ||' s='||decode(n.REFERENCE_ID,
    null,'No','Yes')
    component_signature
from wwv_flow_icon_bar n,
     wwv_flows f,
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(nv('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = s.security_group_id) and
      f.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.schema = f.owner and
      f.id = n.flow_id and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      w.PROVISIONING_COMPANY_ID != 0 and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10);
COMMENT ON TABLE apex_application_nav_bar IS 'Identifies navigation bar entries displayed on pages that use a Page Template that include a #NAVIGATION_BAR# substitution string';
COMMENT ON COLUMN apex_application_nav_bar.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_nav_bar.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_nav_bar.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_nav_bar.display_sequence IS 'Identifies the order in which each Navigation Bar Entry will be displayed';
COMMENT ON COLUMN apex_application_nav_bar.begins_on_new_line IS 'Navigation icons are displayed in table cells, if you set begins-on-new-line to YES then a new table row will be created.';
COMMENT ON COLUMN apex_application_nav_bar.cell_column_span IS 'By default each navigation bar entry spans one cell (i.e. the HTML table data colspan=1).  If your HTML requires a different COLSPAN you can set it using this control.';
COMMENT ON COLUMN apex_application_nav_bar.icon_image IS 'Identifies image to be displayed in the Navigation Bar Entry';
COMMENT ON COLUMN apex_application_nav_bar.icon_subtext IS 'Identifies text to be displayed in the Navigation Bar Entry';
COMMENT ON COLUMN apex_application_nav_bar.icon_target IS 'Identifies the URL that this Navigation Bar Entry will link to';
COMMENT ON COLUMN apex_application_nav_bar.icon_image_alt IS 'Identifies the HTML IMG tag ALT value';
COMMENT ON COLUMN apex_application_nav_bar.icon_height IS 'Identifies the HTML IMG tag HEIGHT value';
COMMENT ON COLUMN apex_application_nav_bar.icon_width IS 'Identifies the HTML IMG tag WIDTH value';
COMMENT ON COLUMN apex_application_nav_bar.condition_type IS 'Identifies the condition type used to conditionally display the Navigation Bar Entry';
COMMENT ON COLUMN apex_application_nav_bar.condition_expression1 IS 'Specifies an expression based on the specific condition type selected.';
COMMENT ON COLUMN apex_application_nav_bar.condition_expression2 IS 'Specifies an expression based on the specific condition type selected.';
COMMENT ON COLUMN apex_application_nav_bar.onclick_javascript IS 'The link generated for this icon include the following onClick javascript.';
COMMENT ON COLUMN apex_application_nav_bar.build_option IS 'Navigation Bar Entry will be displayed if the Build Option is enabled';
COMMENT ON COLUMN apex_application_nav_bar.authorization_scheme IS 'An authorization scheme must evaluate to TRUE in order for this Navigation Bar Entry to be displayed';
COMMENT ON COLUMN apex_application_nav_bar.authorization_scheme_id IS 'Foreign Key';
COMMENT ON COLUMN apex_application_nav_bar.is_subscribed IS 'Identifies if this Navigation Bar Entry is subscribed from another Navigation Bar Entry';
COMMENT ON COLUMN apex_application_nav_bar.subscribed_from IS 'Identifies the master component from which this component is subscribed';
COMMENT ON COLUMN apex_application_nav_bar.last_updated_by IS 'Apex developer who made last update';
COMMENT ON COLUMN apex_application_nav_bar.last_updated_on IS 'Date of last update';
COMMENT ON COLUMN apex_application_nav_bar.component_comment IS 'Developer comment';
COMMENT ON COLUMN apex_application_nav_bar.nav_bar_id IS 'Primary Key of this Navigation Bar component';
COMMENT ON COLUMN apex_application_nav_bar.referenced_nav_bar_id IS 'Primary Key of this Navigation Bar component';
COMMENT ON COLUMN apex_application_nav_bar.component_signature IS 'Identifies attributes defined at a given component level to facilitate application comparisons';