CREATE OR REPLACE FORCE VIEW apex_application_page_ir (workspace,application_id,application_name,page_id,interactive_report_id,region_id,number_of_columns,number_of_column_groups,number_of_saved_reports,max_row_count,max_row_count_message,no_data_found_message,max_rows_per_page,search_button_label,page_items_to_submit,sort_asc_image,sort_asc_image_attr,sort_desc_image,sort_desc_image_attr,sql_query,show_nulls_as,pagination_scheme,pagination_display_position,button_template,show_finder_drop_down,show_display_row_count,show_search_bar,show_search_textbox,show_actions_menu,actions_menu_icon,finder_icon,show_reports_as_tabs,show_select_columns,show_filter,show_sort,show_control_break,show_highlight,show_compute,show_aggregate,show_chart,show_flashback,show_save,show_reset,show_download,show_help,download_formats,filename,separator,enclosed_by,detail_link_type,detail_link_target,detail_link_text,detail_link_attributes,detail_link_checksum_type,detail_link_condition_type,detail_link_cond_expression,detail_link_cond_expression2,detail_link_auth_scheme,detail_link_auth_scheme_id,"ALIAS",report_id_item,max_query_cost,created_on,created_by,updated_on,updated_by,component_signature) AS
select
w.short_name                 workspace,
f.id                         application_id,
f.name                       application_name,
ir.page_id                   page_id,
ir.id                        interactive_report_id,
ir.region_id                 region_id,
--
(select count(*) from wwv_flow_worksheet_columns where worksheet_id = ir.id) number_of_columns,
(select count(*) from wwv_flow_worksheet_col_groups where worksheet_id = ir.id) number_of_column_groups,
(select count(*) from wwv_flow_worksheet_rpts where worksheet_id = ir.id and session_id is null and nvl(is_default,'N')='N') number_of_saved_reports,
ir.max_row_count             ,
ir.max_row_count_message     ,
ir.no_data_found_message     ,
ir.max_rows_per_page         ,
ir.search_button_label       ,
ir.page_items_to_submit      ,
ir.sort_asc_image            ,
ir.sort_asc_image_attr       ,
ir.sort_desc_image           ,
ir.sort_desc_image_attr      ,
-- base table
ir.sql_query                 ,
--
ir.show_nulls_as             ,
decode(ir.pagination_type,
   'ROWS_X_TO_Y_OF_Z','Row Ranges X to Y of Z (no pagination)',
   'ROWS_X_TO_Y','Row Ranges X to Y (no pagination)',
   'SEARCH_ENGINE','Search Engine 1,2,3,4 (set based pagination)',
   'COMPUTED_BUT_NOT_DISPLAYED','Use Externally Created Pagination Buttons',
   'ROW_RANGES','Row Ranges 1-15 16-30 (with set pagination)',
   'ROW_RANGES_IN_SELECT_LIST','Row Ranges 1-15 16-30 in select list (with pagination)',
   'ROW_RANGES_WITH_LINKS','Row Ranges X to Y of Z (with pagination)',
   'NEXT_PREVIOUS_LINKS','Row Ranges X to Y (with next and previous links)',
   ir.pagination_type)       pagination_scheme,
decode(ir.pagination_display_position,
  'BOTTOM_LEFT','Bottom - Left',
  'BOTTOM_RIGHT','Bottom - Right',
  'TOP_LEFT','Top - Left',
  'TOP_RIGHT','Top - Right',
  'TOP_AND_BOTTOM_LEFT','Top and Bottom - Left',
  'TOP_AND_BOTTOM_RIGHT','Top and Bottom - Right',
  ir.pagination_display_position)     pagination_display_position,
(select template_name
 from wwv_flow_button_templates
 where ir.button_template = id
 and flow_id = f.id)          button_template,
--
decode(ir.show_finder_drop_down ,'Y','Yes','N','No',ir.show_finder_drop_down ) show_finder_drop_down ,
decode(ir.show_display_row_count,'Y','Yes','N','No',ir.show_display_row_count) show_display_row_count,
decode(ir.show_search_bar       ,'Y','Yes','N','No',ir.show_search_bar       ) show_search_bar       ,
decode(ir.show_search_textbox   ,'Y','Yes','N','No',ir.show_search_textbox   ) show_search_textbox   ,
decode(ir.show_actions_menu     ,'Y','Yes','N','No',ir.show_actions_menu     ) show_actions_menu     ,
ir.actions_menu_icon         ,
ir.finder_icon               ,
decode(ir.report_list_mode,
       'TABS', 'YES',
       'NO')                 show_reports_as_tabs,
decode(ir.show_select_columns,'Y','Yes','N','No',ir.show_select_columns) show_select_columns,
decode(ir.show_filter        ,'Y','Yes','N','No',ir.show_filter        ) show_filter        ,
decode(ir.show_sort          ,'Y','Yes','N','No',ir.show_sort          ) show_sort          ,
decode(ir.show_control_break ,'Y','Yes','N','No',ir.show_control_break ) show_control_break ,
decode(ir.show_highlight     ,'Y','Yes','N','No',ir.show_highlight     ) show_highlight     ,
decode(ir.show_computation   ,'Y','Yes','N','No',ir.show_computation   ) show_compute       ,
decode(ir.show_aggregate     ,'Y','Yes','N','No',ir.show_aggregate     ) show_aggregate     ,
decode(ir.show_chart         ,'Y','Yes','N','No',ir.show_chart         ) show_chart         ,
decode(ir.show_flashback     ,'Y','Yes','N','No',ir.show_flashback     ) show_flashback     ,
decode(ir.allow_report_saving,'Y','Yes','N','No',ir.allow_report_saving) show_save          ,
decode(ir.show_reset         ,'Y','Yes','N','No',ir.show_reset         ) show_reset         ,
decode(ir.show_download      ,'Y','Yes','N','No',ir.show_download      ) show_download      ,
decode(ir.show_help          ,'Y','Yes','N','No',ir.show_help          ) show_help          ,
ir.download_formats          ,
ir.download_filename         filename,
ir.csv_output_separator      separator,
ir.csv_output_enclosed_by    enclosed_by,
--
decode(ir.show_detail_link,
       'Y', 'Single Row View',
       'C', 'Custom Link target',
       'N', 'No Link Column') detail_link_type,
ir.detail_link                detail_link_target,
ir.detail_link_text           detail_link_text,
ir.detail_link_attr           detail_link_attributes,
ir.detail_link_checksum_type  detail_link_checksum_type,
nvl((select r from apex_standard_conditions where d = ir.detail_link_condition_type),ir.detail_link_condition_type)
                                     detail_link_condition_type,
ir.detail_link_cond           detail_link_cond_expression,
ir.detail_link_cond2          detail_link_cond_expression2,
decode(substr(ir.detail_link_auth_SCHEME,1,1),'!','Not ')||
nvl((select name
 from   wwv_flow_security_schemes
 where  to_char(id) = ltrim(ir.detail_link_auth_scheme,'!')
 and    flow_id = f.id),
 ir.detail_link_auth_scheme)  detail_link_auth_scheme,
ir.detail_link_auth_scheme    detail_link_auth_scheme_id,
--
ir.alias                      alias,
ir.report_id_item             ,
ir.max_query_cost             ,
--
ir.created_on,
ir.created_by,
ir.updated_on,
ir.updated_by,
--
'Interactive Report'||
' rc='||ir.max_row_count||
' '||length(ir.max_row_count_message)||
length(ir.no_data_found_message)||
ir.max_rows_per_page||
substr(ir.search_button_label,1,30)||
length(page_items_to_submit)||
length(ir.sort_asc_image)||
length(ir.sort_asc_image_attr)||
length(ir.sort_desc_image)||
length(ir.sort_desc_image_attr)||
substr(ir.show_nulls_as,1,30)||
' p='||ir.pagination_type||
' '||ir.pagination_display_position||
' '||substr(ir.actions_menu_icon,1,30)||
' '||substr(ir.finder_icon,1,30)||
' opt='||ir.show_finder_drop_down||
ir.show_display_row_count||
ir.show_search_bar||
ir.show_search_textbox||
ir.show_actions_menu||
ir.show_select_columns||
ir.show_filter||
ir.show_sort||
ir.show_control_break||
ir.show_highlight||
ir.show_computation||
ir.show_aggregate||
ir.show_chart||
ir.show_flashback||
ir.allow_report_saving||
ir.show_reset||
ir.show_download||
ir.show_help||
' rpts='||ir.report_list_mode||
' dl='||substr(ir.download_formats,1,40)||
' fn='||substr(ir.download_filename,1,30)||
ir.csv_output_separator||
ir.csv_output_enclosed_by||
ir.show_detail_link||
' l='||substr(ir.detail_link,1,30)||
' lt='||substr(ir.detail_link_text,1,30)||
substr(ir.detail_link_attr,1,30)||
ir.detail_link_checksum_type||
' lc='||ir.detail_link_condition_type||
length(ir.detail_link_cond)||
length(ir.detail_link_cond2)||
ir.detail_link_auth_SCHEME||
' a='||substr(ir.alias,1,30)||
ir.report_id_item||
ir.max_query_cost
component_signature
--
from wwv_flow_worksheets ir,
     wwv_flows f,
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(nv('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = s.security_group_id) and
      f.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.schema = f.owner and
      f.security_group_id = ir.security_group_id and
      f.id = ir.flow_id and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      w.PROVISIONING_COMPANY_ID != 0 and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10);
COMMENT ON TABLE apex_application_page_ir IS 'Identifies attributes of an interactive report';
COMMENT ON COLUMN apex_application_page_ir.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_page_ir.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_page_ir.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_page_ir.page_id IS 'Identifies page number';
COMMENT ON COLUMN apex_application_page_ir.interactive_report_id IS 'ID of the interactive report';
COMMENT ON COLUMN apex_application_page_ir.region_id IS 'ID of the interactive report region';
COMMENT ON COLUMN apex_application_page_ir.number_of_columns IS 'Total number of columns returned by the query for this report region';
COMMENT ON COLUMN apex_application_page_ir.number_of_column_groups IS 'Number of defined column groups for this report region';
COMMENT ON COLUMN apex_application_page_ir.number_of_saved_reports IS 'Number of user-defined saved reports for this report region';
COMMENT ON COLUMN apex_application_page_ir.max_row_count IS 'Maximum number of rows to query before sorting';
COMMENT ON COLUMN apex_application_page_ir.max_row_count_message IS 'Message to display if the maximum number of rows is exceeded';
COMMENT ON COLUMN apex_application_page_ir.no_data_found_message IS 'Message to display when no rows are returned by the report query';
COMMENT ON COLUMN apex_application_page_ir.max_rows_per_page IS 'Maximum number of rows to display on a single HTML page.  The Rows select list will not display any values higher than this amount.';
COMMENT ON COLUMN apex_application_page_ir.search_button_label IS 'Text to use for the search button label';
COMMENT ON COLUMN apex_application_page_ir.page_items_to_submit IS 'List of page items values which are submitted when the search button is clicked';
COMMENT ON COLUMN apex_application_page_ir.sort_asc_image IS 'Defines the image shown in report headings to sort column values in ascending order.';
COMMENT ON COLUMN apex_application_page_ir.sort_asc_image_attr IS 'Image attributes for sort images used to define attributes such width and height of image.';
COMMENT ON COLUMN apex_application_page_ir.sort_desc_image IS 'Defines the image shown in report headings to sort column values in descending order.';
COMMENT ON COLUMN apex_application_page_ir.sort_desc_image_attr IS 'Image attributes for sort images used to define attributes such width and height of image.';
COMMENT ON COLUMN apex_application_page_ir.sql_query IS 'Query used as the base for this interactive report region.  The original query will be preserved as a subquery in the actual SQL used for the report';
COMMENT ON COLUMN apex_application_page_ir.show_nulls_as IS 'Identifies the text to display for null columns. The default value is "-".';
COMMENT ON COLUMN apex_application_page_ir.pagination_scheme IS 'Identifies the pagination style to use for this report';
COMMENT ON COLUMN apex_application_page_ir.pagination_display_position IS 'Identifies the position of pagination links relative to this report';
COMMENT ON COLUMN apex_application_page_ir.button_template IS 'Optionally identifies the button template to use in place of the generic buttons';
COMMENT ON COLUMN apex_application_page_ir.show_finder_drop_down IS 'Determines whether to display the drop down to the left of the search field';
COMMENT ON COLUMN apex_application_page_ir.show_display_row_count IS 'Determines whether to display the row count selector in the Search Bar';
COMMENT ON COLUMN apex_application_page_ir.show_search_bar IS 'Determines whether to display the Search Bar for the interactive report';
COMMENT ON COLUMN apex_application_page_ir.show_search_textbox IS 'Determines whether to allow searching from the Search Bar';
COMMENT ON COLUMN apex_application_page_ir.show_actions_menu IS 'Determines whether to display the Actions Menu and Actions Menu icon in the Search Bar';
COMMENT ON COLUMN apex_application_page_ir.actions_menu_icon IS 'Identifies the icon used for the Actions Menu.  The default icon is a green gear.';
COMMENT ON COLUMN apex_application_page_ir.finder_icon IS 'Identifies the icon displayed on the left of the Search Bar.  The default icon is a magnifying glass.';
COMMENT ON COLUMN apex_application_page_ir.show_reports_as_tabs IS 'Determines whether saved reports are displayed as tabs.';
COMMENT ON COLUMN apex_application_page_ir.show_select_columns IS 'Determines whether to show the Select Columns option in the Actions Menu';
COMMENT ON COLUMN apex_application_page_ir.show_filter IS 'Determines whether to show the Filter option in the Actions Menu';
COMMENT ON COLUMN apex_application_page_ir.show_sort IS 'Determines whether to show the Sort option in the Actions Menu';
COMMENT ON COLUMN apex_application_page_ir.show_control_break IS 'Determines whether to show the Control option in the Actions Menu';
COMMENT ON COLUMN apex_application_page_ir.show_highlight IS 'Determines whether to show the Highlight option in the Actions Menu';
COMMENT ON COLUMN apex_application_page_ir.show_compute IS 'Determines whether to show the Compute option in the Actions Menu';
COMMENT ON COLUMN apex_application_page_ir.show_aggregate IS 'Determines whether to show the Aggregate option in the Actions Menu';
COMMENT ON COLUMN apex_application_page_ir.show_chart IS 'Determines whether to show the Chart option in the Actions Menu';
COMMENT ON COLUMN apex_application_page_ir.show_flashback IS 'Determines whether to show the Flashback option in the Actions Menu';
COMMENT ON COLUMN apex_application_page_ir.show_save IS 'Determines whether to show the Save Report option in the Actions Menu';
COMMENT ON COLUMN apex_application_page_ir.show_reset IS 'Determines whether to show the Reset option in the Actions Menu';
COMMENT ON COLUMN apex_application_page_ir.show_download IS 'Determines whether to show the Download option in the Actions Menu';
COMMENT ON COLUMN apex_application_page_ir.show_help IS 'Determines whether to show the Help option in the Actions Menu';
COMMENT ON COLUMN apex_application_page_ir.download_formats IS 'Identifies the download formats supported for this interactive report';
COMMENT ON COLUMN apex_application_page_ir.filename IS 'Identifies the filename prefix used when this report data is downloaded';
COMMENT ON COLUMN apex_application_page_ir.separator IS 'Identifies a column separator. If no value is entered, a comma or semicolon is used depending on your current NLS settings.';
COMMENT ON COLUMN apex_application_page_ir.enclosed_by IS 'Identifies a delimiter character. This character is used to delineate the starting and ending boundary of a data value. Default delimiter is double quotes.';
COMMENT ON COLUMN apex_application_page_ir.detail_link_type IS 'Identifies the type of link to display in the Link Column on the left of the interactive report';
COMMENT ON COLUMN apex_application_page_ir.detail_link_target IS 'Target of the Link Column, if a custom target is defined';
COMMENT ON COLUMN apex_application_page_ir.detail_link_text IS 'Text or HTML to display in the Link Column';
COMMENT ON COLUMN apex_application_page_ir.detail_link_attributes IS 'Link attributes for the Link Column.  Displayed within the HTML "A" tag';
COMMENT ON COLUMN apex_application_page_ir.detail_link_checksum_type IS 'An appropriate checksum when linking to protected pages';
COMMENT ON COLUMN apex_application_page_ir.detail_link_condition_type IS 'For conditionally displayed Link Column; identifies the condition type to evaluate';
COMMENT ON COLUMN apex_application_page_ir.detail_link_cond_expression IS 'Specifies an expression based on the specific condition type selected.';
COMMENT ON COLUMN apex_application_page_ir.detail_link_cond_expression2 IS 'Specifies an expression based on the specific condition type selected.';
COMMENT ON COLUMN apex_application_page_ir.detail_link_auth_scheme IS 'This authorization scheme must evaluate to TRUE in order for this page to be displayed';
COMMENT ON COLUMN apex_application_page_ir.detail_link_auth_scheme_id IS 'Foreign Key';
COMMENT ON COLUMN apex_application_page_ir."ALIAS" IS 'Alias for this interactive report, may be used for API references';
COMMENT ON COLUMN apex_application_page_ir.report_id_item IS 'Item which holds the saved report ID to display';
COMMENT ON COLUMN apex_application_page_ir.max_query_cost IS 'Prevent execution of queries that are estimated to take longer than specified amount of time.';
COMMENT ON COLUMN apex_application_page_ir.created_on IS 'Auditing; date the record was created.';
COMMENT ON COLUMN apex_application_page_ir.created_by IS 'Auditing; user that created the record.';
COMMENT ON COLUMN apex_application_page_ir.updated_on IS 'Auditing; date the record was last modified.';
COMMENT ON COLUMN apex_application_page_ir.updated_by IS 'Auditing; user that last modified the record.';
COMMENT ON COLUMN apex_application_page_ir.component_signature IS 'Identifies attributes defined at a given component level to facilitate application comparisons';