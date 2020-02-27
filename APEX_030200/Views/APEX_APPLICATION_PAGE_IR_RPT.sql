CREATE OR REPLACE FORCE VIEW apex_application_page_ir_rpt (workspace,application_id,application_name,page_id,interactive_report_id,report_id,application_user,report_name,session_id,base_report_id,report_description,display_sequence,report_view_mode,status,category_id,report_type,display_rows,report_columns,sort_column_1,sort_direction_1,sort_column_2,sort_direction_2,sort_column_3,sort_direction_3,sort_column_4,sort_direction_4,sort_column_5,sort_direction_5,sort_column_6,sort_direction_6,break_on,break_enabled_on,sum_columns_on_break,avg_columns_on_break,max_columns_on_break,min_columns_on_break,median_columns_on_break,count_columns_on_break,flashback_minutes,flashback_enabled,chart_type,chart_label_column,chart_label_title,chart_value_column,chart_aggregate,chart_value_title,chart_sort_order,created_on,created_by,last_updated_on,last_updated_by) AS
select
w.short_name                 workspace,
f.id                         application_id,
f.name                       application_name,
r.page_id                    page_id,
r.worksheet_id               interactive_report_id,
r.id                         report_id,
r.application_user           application_user,
r.name                       report_name,
r.session_id                 ,
r.base_report_id             ,
r.description                report_description,
r.report_seq                 display_sequence,
r.report_type                report_view_mode,
r.status                     ,
r.category_id                ,
(case when r.is_default = 'Y' then 'DEFAULT'
      when r.session_id is null then 'USER SAVED'
 else 'SESSION' end)         report_type,
--
r.display_rows               ,
r.report_columns             ,
--
r.sort_column_1              ,
r.sort_direction_1           ,
r.sort_column_2              ,
r.sort_direction_2           ,
r.sort_column_3              ,
r.sort_direction_3           ,
r.sort_column_4              ,
r.sort_direction_4           ,
r.sort_column_5              ,
r.sort_direction_5           ,
r.sort_column_6              ,
r.sort_direction_6           ,
--
r.break_on                   ,
r.break_enabled_on           ,
--
r.sum_columns_on_break       ,
r.avg_columns_on_break       ,
r.max_columns_on_break       ,
r.min_columns_on_break       ,
r.median_columns_on_break    ,
r.count_columns_on_break     ,
--
r.flashback_mins_ago         flashback_minutes,
decode(r.flashback_enabled,'Y','Yes','N','No',r.flashback_enabled) flashback_enabled,
--
r.chart_type                 ,
r.chart_label_column         ,
r.chart_label_title          ,
r.chart_value_column         ,
r.chart_aggregate            ,
r.chart_value_title          ,
decode(r.chart_sorting,
       'DEFAULT','Default',
       'VALUE_DESC','Value - Descending',
       'VALUE_ASC','Value - Ascending',
       'LABEL_DESC','Label - Descending',
       'LAVEL_ASC','Label - Ascending',
       r.chart_sorting)  chart_sort_order,
--
r.created_on        ,
r.created_by        ,
r.updated_on        last_updated_on,
r.updated_by        last_updated_by
--
from wwv_flow_worksheet_rpts r,
     wwv_flow_worksheets ws,
     wwv_flows f,
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(nv('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = s.security_group_id) and
      f.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.schema = f.owner and
      f.security_group_id = r.security_group_id and
      f.id = ws.flow_id and ws.id = r.worksheet_id and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      w.PROVISIONING_COMPANY_ID != 0 and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10);
COMMENT ON TABLE apex_application_page_ir_rpt IS 'Identifies user-level report settings for an interactive report';
COMMENT ON COLUMN apex_application_page_ir_rpt.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_page_ir_rpt.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_page_ir_rpt.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_page_ir_rpt.page_id IS 'Identifies page number';
COMMENT ON COLUMN apex_application_page_ir_rpt.interactive_report_id IS 'ID of the interactive report';
COMMENT ON COLUMN apex_application_page_ir_rpt.report_id IS 'ID of the report';
COMMENT ON COLUMN apex_application_page_ir_rpt.application_user IS 'The user these report settings are used by';
COMMENT ON COLUMN apex_application_page_ir_rpt.report_name IS 'The name of these report settings';
COMMENT ON COLUMN apex_application_page_ir_rpt.session_id IS 'For session-level report settings, the session ID associated with this record';
COMMENT ON COLUMN apex_application_page_ir_rpt.base_report_id IS 'For session-level report settings, the base report settings this record was derived from';
COMMENT ON COLUMN apex_application_page_ir_rpt.report_description IS 'The description given to the report';
COMMENT ON COLUMN apex_application_page_ir_rpt.display_sequence IS 'The order the report will appear in a list';
COMMENT ON COLUMN apex_application_page_ir_rpt.report_view_mode IS 'Identifies the current view settings of the report';
COMMENT ON COLUMN apex_application_page_ir_rpt.status IS 'The shared status of these settings';
COMMENT ON COLUMN apex_application_page_ir_rpt.category_id IS 'The category_id of the report';
COMMENT ON COLUMN apex_application_page_ir_rpt.report_type IS 'Identifies whether this is a DEFAULT, USER SAVED, or SESSION based set of report settings';
COMMENT ON COLUMN apex_application_page_ir_rpt.display_rows IS 'Number of rows to display in the report';
COMMENT ON COLUMN apex_application_page_ir_rpt.report_columns IS 'List of columns to display in the report';
COMMENT ON COLUMN apex_application_page_ir_rpt.sort_column_1 IS 'First column to sort by';
COMMENT ON COLUMN apex_application_page_ir_rpt.sort_direction_1 IS 'Direction to use for first column sort';
COMMENT ON COLUMN apex_application_page_ir_rpt.sort_column_2 IS 'First column to sort by';
COMMENT ON COLUMN apex_application_page_ir_rpt.sort_direction_2 IS 'Direction to use for first column sort';
COMMENT ON COLUMN apex_application_page_ir_rpt.sort_column_3 IS 'Second column to sort by';
COMMENT ON COLUMN apex_application_page_ir_rpt.sort_direction_3 IS 'Direction to use for first column sort';
COMMENT ON COLUMN apex_application_page_ir_rpt.sort_column_4 IS 'Third column to sort by';
COMMENT ON COLUMN apex_application_page_ir_rpt.sort_direction_4 IS 'Direction to use for first column sort';
COMMENT ON COLUMN apex_application_page_ir_rpt.sort_column_5 IS 'Fourth column to sort by';
COMMENT ON COLUMN apex_application_page_ir_rpt.sort_direction_5 IS 'Direction to use for first column sort';
COMMENT ON COLUMN apex_application_page_ir_rpt.sort_column_6 IS 'Fifth column to sort by';
COMMENT ON COLUMN apex_application_page_ir_rpt.sort_direction_6 IS 'Direction to use for first column sort';
COMMENT ON COLUMN apex_application_page_ir_rpt.break_on IS 'Identifies a set of columns to break on';
COMMENT ON COLUMN apex_application_page_ir_rpt.break_enabled_on IS 'Identifies which control breaks are enabled';
COMMENT ON COLUMN apex_application_page_ir_rpt.sum_columns_on_break IS 'Identifies which columns to aggregate with a sum';
COMMENT ON COLUMN apex_application_page_ir_rpt.avg_columns_on_break IS 'Identifies which columns to aggregate with a avg';
COMMENT ON COLUMN apex_application_page_ir_rpt.max_columns_on_break IS 'Identifies which columns to aggregate with a max';
COMMENT ON COLUMN apex_application_page_ir_rpt.min_columns_on_break IS 'Identifies which columns to aggregate with a min';
COMMENT ON COLUMN apex_application_page_ir_rpt.median_columns_on_break IS 'Identifies which columns to aggregate with a median';
COMMENT ON COLUMN apex_application_page_ir_rpt.count_columns_on_break IS 'Identifies which columns to aggregate with a count';
COMMENT ON COLUMN apex_application_page_ir_rpt.flashback_minutes IS 'Identifies the number of minutes to flashback in the query';
COMMENT ON COLUMN apex_application_page_ir_rpt.flashback_enabled IS 'Identifies whether flashback is enabled';
COMMENT ON COLUMN apex_application_page_ir_rpt.chart_type IS 'Identifies the current chart type';
COMMENT ON COLUMN apex_application_page_ir_rpt.chart_label_column IS 'Identifies the alias of the column to use as labels in a chart';
COMMENT ON COLUMN apex_application_page_ir_rpt.chart_label_title IS 'Text to use as the label axis title for a chart';
COMMENT ON COLUMN apex_application_page_ir_rpt.chart_value_column IS 'Identifies the alias of the column to use as values in a chart';
COMMENT ON COLUMN apex_application_page_ir_rpt.chart_aggregate IS 'Identifies an aggregation function to use on the values in the chart';
COMMENT ON COLUMN apex_application_page_ir_rpt.chart_value_title IS 'Text to use as the value axis title for a chart';
COMMENT ON COLUMN apex_application_page_ir_rpt.chart_sort_order IS 'Identifies the current chart sorting method';
COMMENT ON COLUMN apex_application_page_ir_rpt.created_on IS 'Auditing; date the record was created.';
COMMENT ON COLUMN apex_application_page_ir_rpt.created_by IS 'Auditing; user that created the record.';
COMMENT ON COLUMN apex_application_page_ir_rpt.last_updated_on IS 'Auditing; date the record was last modified.';
COMMENT ON COLUMN apex_application_page_ir_rpt.last_updated_by IS 'Auditing; user that last modified the record.';