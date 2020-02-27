CREATE OR REPLACE FORCE VIEW apex_application_temp_report (workspace,application_id,application_name,template_name,template_type,before_column_heading,column_heading_template,after_column_heading,col_template1,col_template_condition1,col_template_display_cond1,col_template2,col_template_condition2,col_template_display_cond2,col_template3,col_template_condition3,col_template_display_cond3,col_template4,col_template_condition4,col_template_display_cond4,col_template_before_rows,col_template_after_rows,col_template_before_first,col_template_after_last,pagination_template,next_page_template,previous_page_template,next_set_template,previous_set_template,row_style_mouse_over,row_style_checked,is_subscribed,subscribed_from,last_updated_by,last_updated_on,theme_number,theme_class,translate_this_template,component_comment,component_signature,template_id) AS
select
    w.short_name                     workspace,
    f.ID                             application_id,
    f.NAME                           application_name,
    --
    t.ROW_TEMPLATE_NAME              template_name,
    decode(t.ROW_TEMPLATE_TYPE,
      'GENERIC_COLUMNS','Generic Columns (column template)',
      'NAMED_COLUMNS','Named Column (row template)',
      t.ROW_TEMPLATE_TYPE)           template_type,
      --
    t.before_column_heading          ,
    t.COLUMN_HEADING_TEMPLATE        ,
    t.after_column_heading           ,
    t.ROW_TEMPLATE1                  col_TEMPLATE1                ,
    t.ROW_TEMPLATE_CONDITION1        col_TEMPLATE_CONDITION1      ,
    t.ROW_TEMPLATE_DISPLAY_COND1     col_TEMPLATE_DISPLAY_COND1   ,
    t.ROW_TEMPLATE2                  col_TEMPLATE2                ,
    t.ROW_TEMPLATE_CONDITION2        col_TEMPLATE_CONDITION2      ,
    t.ROW_TEMPLATE_DISPLAY_COND2     col_TEMPLATE_DISPLAY_COND2   ,
    t.ROW_TEMPLATE3                  col_TEMPLATE3                ,
    t.ROW_TEMPLATE_CONDITION3        col_TEMPLATE_CONDITION3      ,
    t.ROW_TEMPLATE_DISPLAY_COND3     col_TEMPLATE_DISPLAY_COND3   ,
    t.ROW_TEMPLATE4                  col_TEMPLATE4                ,
    t.ROW_TEMPLATE_CONDITION4        col_TEMPLATE_CONDITION4      ,
    t.ROW_TEMPLATE_DISPLAY_COND4     col_TEMPLATE_DISPLAY_COND4   ,
    t.ROW_TEMPLATE_BEFORE_ROWS       col_TEMPLATE_BEFORE_ROWS     ,
    t.ROW_TEMPLATE_AFTER_ROWS        col_TEMPLATE_AFTER_ROWS      ,
    t.ROW_TEMPLATE_BEFORE_FIRST      col_TEMPLATE_BEFORE_FIRST    ,
    t.ROW_TEMPLATE_AFTER_LAST        col_TEMPLATE_AFTER_LAST      ,
    --t.ROW_TEMPLATE_TABLE_ATTRIBUTES  col_TEMPLATE_TABLE_ATTRIBUTES,
    t.PAGINATION_TEMPLATE            ,
    t.NEXT_PAGE_TEMPLATE             ,
    t.PREVIOUS_PAGE_TEMPLATE         ,
    t.NEXT_SET_TEMPLATE              ,
    t.PREVIOUS_SET_TEMPLATE          ,
    t.ROW_STYLE_MOUSE_OVER           ,
    --t.ROW_STYLE_MOUSE_OUT            ,
    t.ROW_STYLE_CHECKED              ,
    --t.ROW_STYLE_UNCHECKED            ,
    --
    decode(t.REFERENCE_ID,
    null,'No','Yes')                 is_subscribed,
    (select flow_id||'. '||name
     from WWV_FLOW_ROW_TEMPLATES
     where id = t.REFERENCE_ID)      subscribed_from,
    --
    t.LAST_UPDATED_BY                ,
    t.LAST_UPDATED_ON                ,
    t.THEME_ID                       theme_number,
    --
    decode(t.THEME_CLASS_ID,
      '1','Borderless',
      '2','Horizontal Border',
      '3','One Column Unordered List',
      '4','Standard',
      '5','Standard, Alternating Row Colors',
      '6','Value Attribute Pairs',
      '7','Custom 1',
      '8','Custom 2',
      '9','Custom 3',
      '10','Custom 4',
      '11','Custom 5',
      '12','Custom 6',
      '13','Custom 7',
      '14','Custom 8',
      t.THEME_CLASS_ID)              theme_class,
    decode(t.TRANSLATE_THIS_TEMPLATE,
       'Y','Yes','N','No','Yes')     translate_this_template,
    t.ROW_TEMPLATE_COMMENT           component_comment,
    --
    t.ROW_TEMPLATE_NAME
    ||' t='||t.THEME_ID
    ||' c='||t.THEME_CLASS_ID
    ||' t='||t.ROW_TEMPLATE_TYPE
    ||' 1='||dbms_lob.substr(t.ROW_TEMPLATE1,1,40)||dbms_lob.getlength(t.ROW_TEMPLATE1)
    ||' c='||substr(t.ROW_TEMPLATE_CONDITION1   ,1,20)||length(t.ROW_TEMPLATE_CONDITION1)
    ||' c='||substr(t.ROW_TEMPLATE_DISPLAY_COND1,1,20)||length(t.ROW_TEMPLATE_DISPLAY_COND1)
    ||' 2='||dbms_lob.substr(t.ROW_TEMPLATE2,1,40)||dbms_lob.getlength(t.ROW_TEMPLATE2)
    ||' c='||substr(t.ROW_TEMPLATE_CONDITION2   ,1,20)||length(t.ROW_TEMPLATE_CONDITION2)
    ||' c='||substr(t.ROW_TEMPLATE_DISPLAY_COND2,1,20)||length(t.ROW_TEMPLATE_DISPLAY_COND2)
    ||' 3='||dbms_lob.substr(t.ROW_TEMPLATE3,1,40)||dbms_lob.getlength(t.ROW_TEMPLATE3)
    ||' c='||substr(t.ROW_TEMPLATE_CONDITION3   ,1,20)||length(t.ROW_TEMPLATE_CONDITION3)
    ||' c='||substr(t.ROW_TEMPLATE_DISPLAY_COND3,1,20)||length(t.ROW_TEMPLATE_DISPLAY_COND3)
    ||' 4='||dbms_lob.substr(t.ROW_TEMPLATE4,1,40)||dbms_lob.getlength(t.ROW_TEMPLATE4)
    ||decode(t.REFERENCE_ID,null,'N','Y')
    component_signature,
    t.id template_id
from WWV_FLOW_ROW_TEMPLATES t,
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
COMMENT ON TABLE apex_application_temp_report IS 'Identifies the HTML template markup used to render a Report Headings and Rows';
COMMENT ON COLUMN apex_application_temp_report.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_temp_report.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_temp_report.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_temp_report.template_name IS 'Identifies a name for this template';
COMMENT ON COLUMN apex_application_temp_report.template_type IS 'Displays the type of the template - either Named columns or Generic Columns';
COMMENT ON COLUMN apex_application_temp_report.before_column_heading IS 'Emit this before the column header cell.';
COMMENT ON COLUMN apex_application_temp_report.column_heading_template IS 'This attribute is only applicable to generic column templates. Use this template to colorize each column header cell.';
COMMENT ON COLUMN apex_application_temp_report.after_column_heading IS 'Emit this after the column header cell.';
COMMENT ON COLUMN apex_application_temp_report.col_template1 IS 'Defines the column template, use #COLUMN_VALUE#, #ALIGNMENT#, #COLNUM#, #COLUMN_HEADER#, #COLCOUNT#, #ROW_NUM# substitutions';
COMMENT ON COLUMN apex_application_temp_report.col_template_condition1 IS 'Optionally select a condition type that must be met in order to apply this column template';
COMMENT ON COLUMN apex_application_temp_report.col_template_display_cond1 IS 'A condition that must be met in order to apply this column template';
COMMENT ON COLUMN apex_application_temp_report.col_template2 IS 'Defines the column template, use #COLUMN_VALUE#, #ALIGNMENT#, #COLNUM#, #COLUMN_HEADER#, #COLCOUNT#, #ROW_NUM# substitutions';
COMMENT ON COLUMN apex_application_temp_report.col_template_condition2 IS 'Optionally select a condition type that must be met in order to apply this column template';
COMMENT ON COLUMN apex_application_temp_report.col_template_display_cond2 IS 'A condition that must be met in order to apply this column template';
COMMENT ON COLUMN apex_application_temp_report.col_template3 IS 'Defines the column template, use #COLUMN_VALUE#, #ALIGNMENT#, #COLNUM#, #COLUMN_HEADER#, #COLCOUNT#, #ROW_NUM# substitutions';
COMMENT ON COLUMN apex_application_temp_report.col_template_condition3 IS 'Optionally select a condition type that must be met in order to apply this column template';
COMMENT ON COLUMN apex_application_temp_report.col_template_display_cond3 IS 'A condition that must be met in order to apply this column template';
COMMENT ON COLUMN apex_application_temp_report.col_template4 IS 'Defines the column template, use #COLUMN_VALUE#, #ALIGNMENT#, #COLNUM#, #COLUMN_HEADER#, #COLCOUNT#, #ROW_NUM# substitutions';
COMMENT ON COLUMN apex_application_temp_report.col_template_condition4 IS 'Optionally select a condition type that must be met in order to apply this column template';
COMMENT ON COLUMN apex_application_temp_report.col_template_display_cond4 IS 'A condition that must be met in order to apply this column template';
COMMENT ON COLUMN apex_application_temp_report.col_template_before_rows IS 'HTML which will be displayed one time at the beginning of a report template';
COMMENT ON COLUMN apex_application_temp_report.col_template_after_rows IS 'HTML which will be displayed one time at the beginning of a report template';
COMMENT ON COLUMN apex_application_temp_report.col_template_before_first IS 'Display this text before displaying all columns for the report. Use this attribute to open a new HTML row';
COMMENT ON COLUMN apex_application_temp_report.col_template_after_last IS 'Display this HTML after all columns for the report display. Typically used to close an HTML table row';
COMMENT ON COLUMN apex_application_temp_report.pagination_template IS 'This attribute will be applied to the entire pagination subtemplate.';
COMMENT ON COLUMN apex_application_temp_report.next_page_template IS 'HTML that will modify how the "Next Page" portion of the pagination subtemplate will appear';
COMMENT ON COLUMN apex_application_temp_report.previous_page_template IS 'HTML that will modify how the "Previous Page" portion of the pagination subtemplate will appear';
COMMENT ON COLUMN apex_application_temp_report.next_set_template IS 'HTML that will modify how the "Next Set" portion of the pagination subtemplate will appear';
COMMENT ON COLUMN apex_application_temp_report.previous_set_template IS 'HTML that will modify how the "Previous Set" portion of the pagination subtemplate will appear';
COMMENT ON COLUMN apex_application_temp_report.row_style_mouse_over IS 'This attribute controls the background color of a report row when the user moves the mouse over the row';
COMMENT ON COLUMN apex_application_temp_report.row_style_checked IS 'This attribute controls the background color of a report row when the row selector is checked';
COMMENT ON COLUMN apex_application_temp_report.is_subscribed IS 'Identifies if this Report Template is subscribed from another Report Template';
COMMENT ON COLUMN apex_application_temp_report.subscribed_from IS 'Identifies the master component from which this component is subscribed';
COMMENT ON COLUMN apex_application_temp_report.last_updated_by IS 'Apex developer who made last update';
COMMENT ON COLUMN apex_application_temp_report.last_updated_on IS 'Date of last update';
COMMENT ON COLUMN apex_application_temp_report.theme_number IS 'Identifies the numeric identifier of this theme to which this template is associated';
COMMENT ON COLUMN apex_application_temp_report.theme_class IS 'Identifies a specific usage for this template';
COMMENT ON COLUMN apex_application_temp_report.translate_this_template IS 'Identifies if this template should be translated';
COMMENT ON COLUMN apex_application_temp_report.component_comment IS 'Developer Comment';
COMMENT ON COLUMN apex_application_temp_report.component_signature IS 'Identifies attributes defined at a given component level to facilitate application comparisons';
COMMENT ON COLUMN apex_application_temp_report.template_id IS 'Unique ID of report template';