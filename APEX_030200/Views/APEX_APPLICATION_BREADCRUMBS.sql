CREATE OR REPLACE FORCE VIEW apex_application_breadcrumbs (workspace,application_id,application_name,breadcrumb_name,breadcrumb_entries,last_updated_by,last_updated_on,component_comment,breadcrumb_id,component_signature) AS
select
    w.short_name                     workspace,
    f.ID                             application_id,
    f.NAME                           application_name,
    --
    m.NAME                           breadcrumb_name,
    --
    (select count(*) from wwv_flow_menu_options where menu_id = m.id) breadcrumb_entries,
    --
    m.LAST_UPDATED_BY                last_updated_by,
    m.LAST_UPDATED_ON                last_updated_on,
    m.MENU_COMMENT                   component_comment,
    m.id                             breadcrumb_id,
    --
    m.NAME
    component_signature
from wwv_flow_menus m,
     wwv_flows f,
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(nv('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = s.security_group_id) and
      f.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.schema = f.owner and
      f.id = m.flow_id and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      w.PROVISIONING_COMPANY_ID != 0 and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10);
COMMENT ON TABLE apex_application_breadcrumbs IS 'Identifies the definition of a collection of Breadcrumb Entries which are used to identify a page Hierarchy';
COMMENT ON COLUMN apex_application_breadcrumbs.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_breadcrumbs.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_breadcrumbs.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_breadcrumbs.breadcrumb_name IS 'Identifies the Breadcrumb Name, a breadcrumb is a collection of Breadcrumb Entries used to show page context.';
COMMENT ON COLUMN apex_application_breadcrumbs.breadcrumb_entries IS 'Count of Entries defined for this Breadcrumb';
COMMENT ON COLUMN apex_application_breadcrumbs.last_updated_by IS 'Apex developer who made last update';
COMMENT ON COLUMN apex_application_breadcrumbs.last_updated_on IS 'Date of last update';
COMMENT ON COLUMN apex_application_breadcrumbs.component_comment IS 'Developer Comment';
COMMENT ON COLUMN apex_application_breadcrumbs.breadcrumb_id IS 'Primary key of this Breadcrumb';
COMMENT ON COLUMN apex_application_breadcrumbs.component_signature IS 'Identifies attributes defined at a given component level to facilitate application comparisons';