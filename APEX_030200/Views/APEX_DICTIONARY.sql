CREATE OR REPLACE FORCE VIEW apex_dictionary (apex_view_name,column_id,column_name,comments,comment_type,parent_view) AS
select apex_view_name,
       column_id,
       column_name,
       comments,
       comment_type,
       parent_view
from
(
select t.table_name   apex_view_name,
       t.column_id    column_id,
       t.column_name  column_name,
       c.comments     comments,
       'Column'       comment_type,
       case
         when        t.table_name      ='APEX_APPLICATIONS'             then 'APEX_WORKSPACES'
         when        t.table_name      ='APEX_APPLICATION_LOV_ENTRIES'  then 'APEX_APPLICATION_LOVS'
         when        t.table_name      ='APEX_APPLICATION_PAGE_ITEMS'   then 'APEX_APPLICATION_PAGE_REGIONS'
         when        t.table_name      ='APEX_APPLICATION_PAGE_BUTTONS' then 'APEX_APPLICATION_PAGE_REGIONS'
         when        t.table_name      ='APEX_APPLICATION_LIST_ENTRIES' then 'APEX_APPLICATION_LISTS'
         when        t.table_name      ='APEX_APPLICATION_TEMPLATES'    then 'APEX_APPLICATION_THEMES'
         when substr(t.table_name,1,26)='APEX_APPLICATION_SUPP_OBJ_'    then 'APEX_APPLICATION_SUPP_OBJECTS'
         when substr(t.table_name,1,18)='APEX_WORKSPACE_LOG'            then 'APEX_WORKSPACE_ACTIVITY_LOG'
         when substr(t.table_name,1,21)='APEX_APPLICATION_TEMP'         then 'APEX_APPLICATION_THEMES'
         when substr(t.table_name,1,30)='APEX_APPLICATION_PAGE_RPT_COLS' then 'APEX_APPLICATION_PAGE_RPT'
         when substr(t.table_name,1,25)='APEX_APPLICATION_PAGE_RPT'     then 'APEX_APPLICATION_PAGE_REGIONS'
         when substr(t.table_name,1,29)='APEX_APPLICATION_PAGE_FLASH_S' then 'APEX_APPLICATION_PAGE_FLASH_CH'
         when substr(t.table_name,1,25)='APEX_APPLICATION_PAGE_IR_'     then 'APEX_APPLICATION_PAGE_IR'
         when        t.table_name      ='APEX_APPLICATION_PAGE_IR'      then 'APEX_APPLICATION_PAGE_REGIONS'
         when substr(t.table_name,1,27)='APEX_APPLICATION_PAGE_FLASH'   then 'APEX_APPLICATION_PAGE_REGIONS'
         when substr(t.table_name,1,22)='APEX_APPLICATION_PAGE_'        then 'APEX_APPLICATION_PAGES'
         when substr(t.table_name,1,15)='APEX_WORKSPACE_'               then 'APEX_WORKSPACES'
         when substr(t.table_name,1,17)='APEX_APPLICATION_'             then 'APEX_APPLICATIONS'
         end         parent_view,
       case
         when        t.table_name      ='APEX_WORKSPACES'               then null
         when        t.table_name      ='APEX_APPLICATIONS'             then 'APEX_WORKSPACES/'
         when        t.table_name      ='APEX_APPLICATION_LOV_ENTRIES'  then 'APEX_WORKSPACES/APEX_APPLICATIONS/APEX_APPLICATION_LOVS/'
         when        t.table_name      ='APEX_APPLICATION_PAGE_ITEMS'   then 'APEX_WORKSPACES/APEX_APPLICATIONS/APEX_APPLICATION_PAGE_REGIONS/'
         when        t.table_name      ='APEX_APPLICATION_PAGE_BUTTONS' then 'APEX_WORKSPACES/APEX_APPLICATIONS/APEX_APPLICATION_PAGE_REGIONS/'
         when        t.table_name      ='APEX_APPLICATION_LIST_ENTRIES' then 'APEX_WORKSPACES/APEX_APPLICATIONS/APEX_APPLICATION_LISTS/'
         when        t.table_name      ='APEX_APPLICATION_TEMPLATES'    then 'APEX_WORKSPACES/APEX_APPLICATIONS/APEX_APPLICATION_THEMES/'
         when substr(t.table_name,1,18)='APEX_WORKSPACE_LOG'            then 'APEX_WORKSPACES/APEX_WORKSPACE_ACTIVITY_LOG/'
         when substr(t.table_name,1,26)='APEX_APPLICATION_SUPP_OBJ_'    then 'APEX_WORKSPACES/APEX_APPLICATIONS/APEX_APPLICATION_SUPP_OBJECTS/'
         when substr(t.table_name,1,21)='APEX_APPLICATION_TEMP'         then 'APEX_WORKSPACES/APEX_APPLICATIONS/APEX_APPLICATION_THEMES/'
         when substr(t.table_name,1,30)='APEX_APPLICATION_PAGE_RPT_COLS' then 'APEX_WORKSPACES/APEX_APPLICATIONS/APEX_APPLICATION_PAGES/APEX_APPLICATION_PAGE_REGIONS/APEX_APPLICATION_PAGE_RPT/'
         when substr(t.table_name,1,25)='APEX_APPLICATION_PAGE_RPT'     then 'APEX_WORKSPACES/APEX_APPLICATIONS/APEX_APPLICATION_PAGES/APEX_APPLICATION_PAGE_REGIONS/'
         when substr(t.table_name,1,29)='APEX_APPLICATION_PAGE_FLASH_S' then 'APEX_WORKSPACES/APEX_APPLICATIONS/APEX_APPLICATION_PAGES/APEX_APPLICATION_PAGE_REGIONS/APEX_APPLICATION_PAGE_FLASH_CH/'
         when substr(t.table_name,1,25)='APEX_APPLICATION_PAGE_IR_'     then 'APEX_WORKSPACES/APEX_APPLICATIONS/APEX_APPLICATION_PAGES/APEX_APPLICATION_PAGE_REGIONS/APEX_APPLICATION_PAGE_IR/'
         when        t.table_name      ='APEX_APPLICATION_PAGE_IR'      then 'APEX_WORKSPACES/APEX_APPLICATIONS/APEX_APPLICATION_PAGES/APEX_APPLICATION_PAGE_REGIONS/'
         when substr(t.table_name,1,27)='APEX_APPLICATION_PAGE_FLASH'   then 'APEX_WORKSPACES/APEX_APPLICATIONS/APEX_APPLICATION_PAGES/APEX_APPLICATION_PAGE_REGIONS/'
         when substr(t.table_name,1,22)='APEX_APPLICATION_PAGE_'        then 'APEX_WORKSPACES/APEX_APPLICATIONS/APEX_APPLICATION_PAGES/'
         when substr(t.table_name,1,15)='APEX_WORKSPACE_'               then 'APEX_WORKSPACES/'
         when substr(t.table_name,1,17)='APEX_APPLICATION_'             then 'APEX_WORKSPACES/APEX_APPLICATIONS/'
         end ||t.table_name        path
from  sys.all_tab_columns t, sys.all_col_comments c
where t.owner = 'APEX_030200' and
      t.owner = c.owner and
      t.table_name = c.table_name and
      t.column_Name = c.column_name and
      (t.table_name like 'APEX_APPLICATION%' or t.table_name like 'APEX_WORKSPACE%' or t.table_name = 'APEX_THEMES') and
      t.table_name != 'apex_dictionary'
union all
select t.view_name   apex_view_name,
       0             column_id,
       null          column_name,
       c.comments    apex_view_comments,
       'View'        comment_type,
       case
         when        t.view_name      ='APEX_APPLICATIONS'             then 'APEX_WORKSPACES'
         when        t.view_name      ='APEX_APPLICATION_LOV_ENTRIES'  then 'APEX_APPLICATION_LOVS'
         when        t.view_name      ='APEX_APPLICATION_PAGE_ITEMS'   then 'APEX_APPLICATION_PAGE_REGIONS'
         when        t.view_name      ='APEX_APPLICATION_PAGE_BUTTONS' then 'APEX_APPLICATION_PAGE_REGIONS'
         when        t.view_name      ='APEX_APPLICATION_LIST_ENTRIES' then 'APEX_APPLICATION_LISTS'
         when        t.view_name      ='APEX_APPLICATION_TEMPLATES'    then 'APEX_APPLICATION_THEMES'
         when substr(t.view_name,1,26)='APEX_APPLICATION_SUPP_OBJ_'    then 'APEX_APPLICATION_SUPP_OBJECTS'
         when substr(t.view_name,1,18)='APEX_WORKSPACE_LOG'            then 'APEX_WORKSPACE_ACTIVITY_LOG'
         when substr(t.view_name,1,21)='APEX_APPLICATION_TEMP'         then 'APEX_APPLICATION_THEMES'
         when substr(t.view_name,1,30)='APEX_APPLICATION_PAGE_RPT_COLS' then 'APEX_APPLICATION_PAGE_RPT'
         when substr(t.view_name,1,25)='APEX_APPLICATION_PAGE_RPT'     then 'APEX_APPLICATION_PAGE_REGIONS'
         when substr(t.view_name,1,29)='APEX_APPLICATION_PAGE_FLASH_S' then 'APEX_APPLICATION_PAGE_FLASH_CH'
         when substr(t.view_name,1,25)='APEX_APPLICATION_PAGE_IR_'     then 'APEX_APPLICATION_PAGE_IR'
         when        t.view_name      ='APEX_APPLICATION_PAGE_IR'      then 'APEX_APPLICATION_PAGE_PAGE_REGIONS'
         when substr(t.view_name,1,27)='APEX_APPLICATION_PAGE_FLASH'   then 'APEX_APPLICATION_PAGE_REGIONS'
         when substr(t.view_name,1,22)='APEX_APPLICATION_PAGE_'        then 'APEX_APPLICATION_PAGES'
         when substr(t.view_name,1,15)='APEX_WORKSPACE_'               then 'APEX_WORKSPACES'
         when substr(t.view_name,1,17)='APEX_APPLICATION_'             then 'APEX_APPLICATIONS'
         end         parent_view,
       case
         when        t.view_name      ='APEX_WORKSPACES'               then null
         when        t.view_name      ='APEX_APPLICATIONS'             then 'APEX_WORKSPACES/'
         when        t.view_name      ='APEX_APPLICATION_LOV_ENTRIES'  then 'APEX_WORKSPACES/APEX_APPLICATIONS/APEX_APPLICATION_LOVS/'
         when        t.view_name      ='APEX_APPLICATION_PAGE_ITEMS'   then 'APEX_WORKSPACES/APEX_APPLICATIONS/APEX_APPLICATION_PAGE_REGIONS/'
         when        t.view_name      ='APEX_APPLICATION_PAGE_BUTTONS' then 'APEX_WORKSPACES/APEX_APPLICATIONS/APEX_APPLICATION_PAGE_REGIONS/'
         when        t.view_name      ='APEX_APPLICATION_LIST_ENTRIES' then 'APEX_WORKSPACES/APEX_APPLICATIONS/APEX_APPLICATION_LISTS/'
         when        t.view_name      ='APEX_APPLICATION_TEMPLATES'    then 'APEX_WORKSPACES/APEX_APPLICATIONS/APEX_APPLICATION_THEMES/'
         when substr(t.view_name,1,18)='APEX_WORKSPACE_LOG'            then 'APEX_WORKSPACES/APEX_WORKSPACE_ACTIVITY_LOG/'
         when substr(t.view_name,1,26)='APEX_APPLICATION_SUPP_OBJ_'    then 'APEX_WORKSPACES/APEX_APPLICATIONS/APEX_APPLICATION_SUPP_OBJECTS/'
         when substr(t.view_name,1,21)='APEX_APPLICATION_TEMP'         then 'APEX_WORKSPACES/APEX_APPLICATIONS/APEX_APPLICATION_THEMES/'
         when substr(t.view_name,1,30)='APEX_APPLICATION_PAGE_RPT_COLS' then 'APEX_WORKSPACES/APEX_APPLICATIONS/APEX_APPLICATION_PAGES/APEX_APPLICATION_PAGE_REGIONS/APEX_APPLICATION_PAGE_RPT/'
         when substr(t.view_name,1,25)='APEX_APPLICATION_PAGE_RPT'     then 'APEX_WORKSPACES/APEX_APPLICATIONS/APEX_APPLICATION_PAGES/APEX_APPLICATION_PAGE_REGIONS/'
         when substr(t.view_name,1,29)='APEX_APPLICATION_PAGE_FLASH_S' then 'APEX_WORKSPACES/APEX_APPLICATIONS/APEX_APPLICATION_PAGES/APEX_APPLICATION_PAGE_REGIONS/APEX_APPLICATION_PAGE_FLASH_CH/'
         when substr(t.view_name,1,25)='APEX_APPLICATION_PAGE_IR_'     then 'APEX_WORKSPACES/APEX_APPLICATIONS/APEX_APPLICATION_PAGES/APEX_APPLICATION_PAGE_REGIONS/APEX_APPLICATION_PAGE_IR/'
         when        t.view_name      ='APEX_APPLICATION_PAGE_IR'      then 'APEX_WORKSPACES/APEX_APPLICATIONS/APEX_APPLICATION_PAGES/APEX_APPLICATION_PAGE_REGIONS/'
         when substr(t.view_name,1,27)='APEX_APPLICATION_PAGE_FLASH'   then 'APEX_WORKSPACES/APEX_APPLICATIONS/APEX_APPLICATION_PAGES/APEX_APPLICATION_PAGE_REGIONS/'
         when substr(t.view_name,1,22)='APEX_APPLICATION_PAGE_'        then 'APEX_WORKSPACES/APEX_APPLICATIONS/APEX_APPLICATION_PAGES/'
         when substr(t.view_name,1,15)='APEX_WORKSPACE_'               then 'APEX_WORKSPACES/'
         when substr(t.view_name,1,17)='APEX_APPLICATION_'             then 'APEX_WORKSPACES/APEX_APPLICATIONS/'
         end ||t.view_name        path
from  sys.all_views t, sys.all_tab_comments c
where t.owner = 'APEX_030200' and
      t.owner = c.owner and
      t.view_name = c.table_name and
      (t.view_name like 'APEX_APPLICATION%' or t.view_name like 'APEX_WORKSPACE%' or t.view_name = 'APEX_THEMES')
order by 7,2
) x;
COMMENT ON TABLE apex_dictionary IS 'Identifies the comment associated with each Apex view and view column';
COMMENT ON COLUMN apex_dictionary.apex_view_name IS 'Name of the Apex dictionary view';
COMMENT ON COLUMN apex_dictionary.column_id IS 'Display order of the Apex dictionary column within the dictionary view';
COMMENT ON COLUMN apex_dictionary.column_name IS 'Identifies the column name for column dictionary comments, null for view dictionary comments';
COMMENT ON COLUMN apex_dictionary.comments IS 'Description of the Apex view name or column name';
COMMENT ON COLUMN apex_dictionary.comment_type IS 'Type of dictionary comment, View or Column';
COMMENT ON COLUMN apex_dictionary.parent_view IS 'Identifies the component parent';