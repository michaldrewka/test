CREATE OR REPLACE FORCE VIEW apex_application_page_db_items (workspace,application_id,application_name,page_id,page_name,region,item_name,display_as,display_sequence,item_label,db_column_name,db_table_name,help_text,item_id) AS
select
    w.short_name                    workspace,
    p.flow_id                       application_id,
    f.name                          application_name,
    p.id                            page_id,
    p.name                          page_name,
    (select plug_name
     from wwv_flow_page_plugs
     where id = i.ITEM_PLUG_ID)     region,
    --
    i.name                          item_name,
    i.display_as                    display_as,
    i.ITEM_SEQUENCE                 display_sequence,
    --
    i.PROMPT                        item_label,
    i.SOURCE                        db_column_name,
    apex_application_get_pg_tname(
    p.flow_id,p.id)                 db_table_name,
    h.help_text                     help_text,
    i.id                            item_id
from wwv_flow_step_items i,
     wwv_flow_step_item_help h,
     wwv_flow_steps p,
     wwv_flows f,
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(v('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = s.security_group_id) and
      f.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.schema = f.owner and
      f.security_group_id = p.security_group_id and
      i.id = h.flow_item_id (+) and
      f.id = p.flow_id and
      f.id = i.flow_id and
      p.id = i.flow_step_id and
      nvl(i.display_as,'x') != 'BUTTON' and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      i.source_type = 'DB_COLUMN' and
      w.PROVISIONING_COMPANY_ID != 0;
COMMENT ON TABLE apex_application_page_db_items IS 'Identifies Page Items which are associated with Database Table Columns.  This view represents a subset of the items in the APEX_APPLICATION_PAGE_ITEMS view.';
COMMENT ON COLUMN apex_application_page_db_items.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_page_db_items.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_page_db_items.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_page_db_items.page_id IS 'Identifies the application';
COMMENT ON COLUMN apex_application_page_db_items.page_name IS 'Identifies a page within an application';
COMMENT ON COLUMN apex_application_page_db_items.region IS 'Identifies the region in which the item will be displayed';
COMMENT ON COLUMN apex_application_page_db_items.item_name IS 'Apex page item name';
COMMENT ON COLUMN apex_application_page_db_items.display_as IS 'Identifies how the item will be displayed in the HTML page';
COMMENT ON COLUMN apex_application_page_db_items.display_sequence IS 'Identifies the sequence the page item will be displayed within a region';
COMMENT ON COLUMN apex_application_page_db_items.item_label IS 'Identifies the item label';
COMMENT ON COLUMN apex_application_page_db_items.db_column_name IS 'Identifies the item source database column name';
COMMENT ON COLUMN apex_application_page_db_items.db_table_name IS 'Identifies the item source database table name';
COMMENT ON COLUMN apex_application_page_db_items.help_text IS 'Identifies the help text for the page item';
COMMENT ON COLUMN apex_application_page_db_items.item_id IS 'Primary key of this component';