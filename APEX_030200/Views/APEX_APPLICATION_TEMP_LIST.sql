CREATE OR REPLACE FORCE VIEW apex_application_temp_list (workspace,application_id,application_name,template_name,list_template_current,list_template_noncurrent,list_template_before_rows,list_template_after_rows,between_items,before_sub_list,after_sub_list,between_sub_list_items,sub_list_item_current,sub_list_item_noncurrent,item_template_curr_w_child,item_template_noncurr_w_child,sub_template_curr_w_child,sub_template_noncurr_w_child,is_subscribed,subscribed_from,last_updated_by,last_updated_on,theme_number,theme_class,translate_this_template,component_comment,list_template_id,component_signature) AS
select
    w.short_name                     workspace,
    f.ID                             application_id,
    f.NAME                           application_name,
    --
    t.LIST_TEMPLATE_NAME             template_name,
    t.LIST_TEMPLATE_CURRENT,
    t.LIST_TEMPLATE_NONCURRENT,
    t.LIST_TEMPLATE_BEFORE_ROWS,
    t.LIST_TEMPLATE_AFTER_ROWS,
    t.BETWEEN_ITEMS,
    t.BEFORE_SUB_LIST,
    t.AFTER_SUB_LIST,
    t.BETWEEN_SUB_LIST_ITEMS,
    t.SUB_LIST_ITEM_CURRENT,
    t.SUB_LIST_ITEM_NONCURRENT,
    t.ITEM_TEMPLATE_CURR_W_CHILD,
    t.ITEM_TEMPLATE_NONCURR_W_CHILD,
    t.SUB_TEMPLATE_CURR_W_CHILD,
    t.SUB_TEMPLATE_NONCURR_W_CHILD,
    --
    decode(t.REFERENCE_ID,
    null,'No','Yes')                 is_subscribed,
    (select flow_id||'. '||name
     from WWV_FLOW_LIST_TEMPLATES
     where id = t.REFERENCE_ID)      subscribed_from,
    --
    t.LAST_UPDATED_BY                ,
    t.LAST_UPDATED_ON                ,
    t.THEME_ID                       theme_number,
    decode(t.THEME_CLASS_ID,
       '1','Vertical Unordered List with Bullets',
       '2','Vertical Ordered List',
       '3','Horizontal Links List',
       '4','Horizontal Images with Label List',
       '5','Vertical Images List',
       '6','Button List',
       '7','Tabbed Navigation List',
       '9','Custom 1',
       '10','Custom 2',
       '11','Custom 3',
       '12','Custom 4',
       '13','Custom 5',
       '14','Custom 6',
       '15','Custom 7',
       '16','Custom 8',
       '17','Wizard Progress List',
       '18','Vertical Unordered List without Bullets',
       '19','Vertical Sidebar List',
       '20','Pull Down Menu',
       '21','Pull Down Menu with Image',
       '22','Hierarchical Expanding',
       '23','Hierarchical Expanded',
       t.THEME_CLASS_ID)             theme_class,
    t.TRANSLATE_THIS_TEMPLATE,
    t.LIST_TEMPLATE_COMMENT          component_comment,
    t.id                             list_template_id,
    --
    t.LIST_TEMPLATE_NAME
    ||' t='||t.THEME_ID
    ||' c='||t.THEME_CLASS_ID
    ||' 1='||dbms_lob.substr(t.LIST_TEMPLATE_CURRENT,40,1)||'.'||dbms_lob.getlength(t.LIST_TEMPLATE_CURRENT)
    ||' 2='||dbms_lob.substr(t.LIST_TEMPLATE_NONCURRENT,40,1)||'.'||dbms_lob.getlength(t.LIST_TEMPLATE_NONCURRENT)
    ||' 3='||dbms_lob.substr(t.SUB_LIST_ITEM_CURRENT,40,1)||'.'||dbms_lob.getlength(t.SUB_LIST_ITEM_CURRENT)
    ||' 4='||dbms_lob.substr(t.SUB_LIST_ITEM_NONCURRENT,40,1)||'.'||dbms_lob.getlength(t.SUB_LIST_ITEM_NONCURRENT)
    ||' 5='||dbms_lob.substr(t.ITEM_TEMPLATE_CURR_W_CHILD,40,1)||'.'||dbms_lob.getlength(t.ITEM_TEMPLATE_CURR_W_CHILD)
    ||' 6='||dbms_lob.substr(t.ITEM_TEMPLATE_NONCURR_W_CHILD,40,1)||'.'||dbms_lob.getlength(t.ITEM_TEMPLATE_NONCURR_W_CHILD)
    ||' 7='||dbms_lob.substr(t.SUB_TEMPLATE_CURR_W_CHILD,40,1)||'.'||dbms_lob.getlength(t.SUB_TEMPLATE_CURR_W_CHILD)
    ||' 8='||dbms_lob.substr(t.SUB_TEMPLATE_NONCURR_W_CHILD,40,1)||'.'||dbms_lob.getlength(t.SUB_TEMPLATE_NONCURR_W_CHILD)
    ||' t='||t.TRANSLATE_THIS_TEMPLATE
    ||' r='||decode(t.REFERENCE_ID,null,'N','Y')
    ||' b='||substr(t.LIST_TEMPLATE_BEFORE_ROWS,1,20)||length(t.LIST_TEMPLATE_BEFORE_ROWS)
    ||' a='||substr(t.LIST_TEMPLATE_AFTER_ROWS,1,20)||length(t.LIST_TEMPLATE_AFTER_ROWS)
    ||' b='||substr(t.BETWEEN_ITEMS,1,20)||length(t.BETWEEN_ITEMS)
    ||' b='||substr(t.BEFORE_SUB_LIST,1,20)||length(t.BEFORE_SUB_LIST)
    ||' a='||substr(t.AFTER_SUB_LIST,1,20)||length(t.AFTER_SUB_LIST)
    ||' b='||substr(t.BETWEEN_SUB_LIST_ITEMS,1,20)||length(t.BETWEEN_SUB_LIST_ITEMS)
    component_signature
from WWV_FLOW_LIST_TEMPLATES t,
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
COMMENT ON TABLE apex_application_temp_list IS 'Identifies HTML template markup used to render a List with List Elements';
COMMENT ON COLUMN apex_application_temp_list.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_temp_list.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_temp_list.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_temp_list.template_name IS 'Identifies the List template name';
COMMENT ON COLUMN apex_application_temp_list.list_template_current IS 'HTML or text to be substituted for the selected (or current) list entry';
COMMENT ON COLUMN apex_application_temp_list.list_template_noncurrent IS 'HTML or text to be substituted for the non selected (or non-current) list entry';
COMMENT ON COLUMN apex_application_temp_list.list_template_before_rows IS 'HTML that displays before any list elements. You can use this attribute to open an HTML table or HTML table row';
COMMENT ON COLUMN apex_application_temp_list.list_template_after_rows IS 'HTML that displays after list elements. You can use this attribute to close an HTML table or HTML table row';
COMMENT ON COLUMN apex_application_temp_list.between_items IS 'HTML that displays between list elements';
COMMENT ON COLUMN apex_application_temp_list.before_sub_list IS 'HTML that displays before any sub list elements. ';
COMMENT ON COLUMN apex_application_temp_list.after_sub_list IS 'HTML that displays after any sub list elements.';
COMMENT ON COLUMN apex_application_temp_list.between_sub_list_items IS 'HTML that displays between sub list elements';
COMMENT ON COLUMN apex_application_temp_list.sub_list_item_current IS 'HTML or text to be substituted for the selected (or current) sub list entry';
COMMENT ON COLUMN apex_application_temp_list.sub_list_item_noncurrent IS 'HTML or text to be substituted for the unselected (or noncurrent) sub list entry';
COMMENT ON COLUMN apex_application_temp_list.item_template_curr_w_child IS 'HTML or text to be substituted for the selected (or current) sub list template used when an item has sub list entries';
COMMENT ON COLUMN apex_application_temp_list.item_template_noncurr_w_child IS 'HTML or text to be substituted for the unselected (or noncurrent) list template used when item has sub list items';
COMMENT ON COLUMN apex_application_temp_list.sub_template_curr_w_child IS 'HTML or text to be substituted for the selected (or current) sub list template used when an item has sub list entries';
COMMENT ON COLUMN apex_application_temp_list.sub_template_noncurr_w_child IS 'HTML or text to be substituted for the unselected (or noncurrent) list template used when item has sub list items';
COMMENT ON COLUMN apex_application_temp_list.is_subscribed IS 'Identifies if this List Template is subscribed from another List Template';
COMMENT ON COLUMN apex_application_temp_list.subscribed_from IS 'Identifies the master component from which this component is subscribed';
COMMENT ON COLUMN apex_application_temp_list.last_updated_by IS 'Apex developer who made last update';
COMMENT ON COLUMN apex_application_temp_list.last_updated_on IS 'Date of last update';
COMMENT ON COLUMN apex_application_temp_list.theme_number IS 'Identifies the numeric identifier of this theme to which this template is associated';
COMMENT ON COLUMN apex_application_temp_list.theme_class IS 'Identifies a specific usage for this template';
COMMENT ON COLUMN apex_application_temp_list.translate_this_template IS 'Identifies if this template should be translated';
COMMENT ON COLUMN apex_application_temp_list.component_comment IS 'Developer comment';
COMMENT ON COLUMN apex_application_temp_list.list_template_id IS 'Primary Key of this template';
COMMENT ON COLUMN apex_application_temp_list.component_signature IS 'Identifies attributes defined at a given component level to facilitate application comparisons';