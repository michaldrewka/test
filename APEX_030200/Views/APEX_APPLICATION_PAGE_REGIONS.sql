CREATE OR REPLACE FORCE VIEW apex_application_page_regions (workspace,application_id,application_name,page_id,page_name,region_name,"TEMPLATE",template_id,static_id,display_sequence,region_attributes_substitution,display_column,display_position,display_position_code,region_source,breadcrumb_template,breadcrumb_template_id,list_template_override,list_template_override_id,source_type,on_error_message,authorization_scheme,authorization_scheme_id,condition_type,condition_expression1,condition_expression2,region_header_text,region_footer_text,report_template,report_template_id,report_column_headings,headings_type,maximum_rows_to_query,pagination_scheme,pagination_display_position,ajax_enabled,number_of_rows_item,no_data_found_message,more_data_found_message,maximum_row_count,report_null_values_as,breaks,ascending_image,ascending_image_attributes,descending_image,descending_image_attributes,filename,separator,enclosed_by,strip_html,report_column_source_type,max_dynamic_report_cols,html_table_cell_attributes,customization,customization_name,build_option,build_option_id,region_caching,timeout_cache_after,cache_when,cache_when_expression_1,cache_when_expression_2,sum_display_text,break_display_text,before_break_display_text,break_column_display_text,after_break_display_text,break_display_flag,repeat_heading_break_format,enable_csv_output,csv_link_label,url,link_label,translate_region_title,last_updated_by,last_updated_on,component_comment,region_id,items,buttons,component_signature) AS
select
    w.short_name                         workspace,
    p.flow_id                            application_id,
    f.name                               application_name,
    p.id                                 page_id,
    p.name                               page_name,
    --
    r.plug_name                          region_name,
    nvl(decode(nvl(r.PLUG_TEMPLATE,0),0,
     'No Template',
     (select PAGE_PLUG_TEMPLATE_NAME
     from wwv_flow_page_plug_templates
     where id = r.PLUG_TEMPLATE)),'No Template') template,
    r.PLUG_TEMPLATE                      template_id,
    r.region_name                        static_id,
    r.PLUG_DISPLAY_SEQUENCE              display_sequence,
    r.REGION_ATTRIBUTES_SUBSTITUTION     REGION_ATTRIBUTES_SUBSTITUTION,
    r.PLUG_DISPLAY_COLUMN                display_column,
    decode(r.PLUG_DISPLAY_POINT,
       'AFTER_HEADER',       'After Header',
       'BEFORE_BOX_BODY',    'Page Template Body (1. items below region content)',
       'BEFORE_SHOW_ITEMS',  'Page Template Body (2. items below region content)',
       'AFTER_SHOW_ITEMS',   'Page Template Body (3. items above region content)',
       'BEFORE_FOOTER',      'Before Footer',
       'REGION_POSITION_01', 'Page Template Region Position 1',
       'REGION_POSITION_02', 'Page Template Region Position 2',
       'REGION_POSITION_03', 'Page Template Region Position 3',
       'REGION_POSITION_04', 'Page Template Region Position 4',
       'REGION_POSITION_05', 'Page Template Region Position 5',
       'REGION_POSITION_06', 'Page Template Region Position 6',
       'REGION_POSITION_07', 'Page Template Region Position 7',
       'REGION_POSITION_08', 'Page Template Region Position 8',
       r.PLUG_DISPLAY_POINT)
                                         display_position,
    r.plug_display_point                 display_position_code,
    --
    r.PLUG_SOURCE                        region_source,
    (select name
    from   wwv_flow_menu_templates
    where  id = to_char(r.MENU_TEMPLATE_ID)
    and    flow_id = f.id)                 breadcrumb_template,
    r.MENU_TEMPLATE_ID                     breadcrumb_template_id,
    --
    (select list_template_name
    from wwv_flow_list_templates
    where id = r.LIST_TEMPLATE_ID)         list_template_override,
    r.LIST_TEMPLATE_ID                     list_template_override_id,
    --
    decode(r.PLUG_SOURCE_TYPE,
        'PLSQL_PROCEDURE','PL/SQL',
        'SIMPLE_CHART','HTML Chart',
        'SQL_QUERY','Report',
        'DYNAMIC_QUERY','Interactive Report',
        'STATIC_TEXT','HTML/Text',
        'STATIC_TEXT_ESCAPE_SC','HTML/Text (escape special characters)',
        'STATIC_TEXT_WITH_SHORTCUTS','HTML/Text (with shortcuts)',
        'STRUCTURED_QUERY','Report',
        'FUNCTION_RETURNING_SQL_QUERY','Report',
        'SVG_CHART','SVG Chart',
        'TREE','Tree',
        'UPDATABLE_SQL_QUERY','Tabular Form',
        'URL','URL',
        decode(substr(r.PLUG_SOURCE_TYPE,1,1),'M','Breadcrumb','List'))
                                         source_type,
    --
    r.PLUG_DISPLAY_ERROR_MESSAGE         on_error_message,
    --
    decode(substr(r.PLUG_REQUIRED_ROLE,1,1),'!','Not ')||
    nvl((select name
     from   wwv_flow_security_schemes
     where  to_char(id) = ltrim(r.PLUG_REQUIRED_ROLE,'!')
     and    flow_id = f.id),
     r.PLUG_REQUIRED_ROLE)               authorization_scheme,
    r.PLUG_REQUIRED_ROLE                 authorization_scheme_id,
    nvl((select r from apex_standard_conditions where d = r.PLUG_DISPLAY_CONDITION_TYPE),r.PLUG_DISPLAY_CONDITION_TYPE)
                                         condition_type,
    r.PLUG_DISPLAY_WHEN_CONDITION        condition_expression1,
    r.PLUG_DISPLAY_WHEN_COND2            condition_expression2,
    --
    r.PLUG_HEADER                        region_header_text,
    r.PLUG_FOOTER                        region_footer_text,
    (select row_template_name from wwv_flow_row_templates where id = r.PLUG_QUERY_ROW_TEMPLATE)
                                         report_template,
    r.PLUG_QUERY_ROW_TEMPLATE            report_template_id,
    r.PLUG_QUERY_HEADINGS                report_column_headings,
    r.PLUG_QUERY_HEADINGS_TYPE           headings_type,
    r.PLUG_QUERY_NUM_ROWS                maximum_rows_to_query,
    decode(r.PLUG_QUERY_NUM_ROWS_TYPE,
       'ROWS_X_TO_Y_OF_Z','Row Ranges X to Y of Z (no pagination)',
       'ROWS_X_TO_Y','Row Ranges X to Y (no pagination)',
       'SEARCH_ENGINE','Search Engine 1,2,3,4 (set based pagination)',
       'COMPUTED_BUT_NOT_DISPLAYED','Use Externally Created Pagination Buttons',
       'ROW_RANGES','Row Ranges 1-15 16-30 (with set pagination)',
       'ROW_RANGES_IN_SELECT_LIST','Row Ranges 1-15 16-30 in select list (with pagination)',
       'ROW_RANGES_WITH_LINKS','Row Ranges X to Y of Z (with pagination)',
       'NEXT_PREVIOUS_LINKS','Row Ranges X to Y (with next and previous links)',
       r.PLUG_QUERY_NUM_ROWS_TYPE)       pagination_scheme,
    decode(r.PAGINATION_DISPLAY_POSITION,
      'BOTTOM_LEFT','Bottom - Left',
      'BOTTOM_RIGHT','Bottom - Right',
      'TOP_LEFT','Top - Left',
      'TOP_RIGHT','Top - Right',
      'TOP_AND_BOTTOM_LEFT','Top and Bottom - Left',
      'TOP_AND_BOTTOM_RIGHT','Top and Bottom - Right',
      r.PAGINATION_DISPLAY_POSITION)     pagination_display_position,
    decode(r.ajax_enabled,'Y','Yes','N','No',r.ajax_enabled) ajax_enabled,
    r.PLUG_QUERY_NUM_ROWS_ITEM           number_of_rows_item,
    r.PLUG_QUERY_NO_DATA_FOUND           no_data_found_message,
    r.PLUG_QUERY_MORE_DATA               more_data_found_message,
    r.PLUG_QUERY_ROW_COUNT_MAX           maximum_row_count,
    --r.PLUG_QUERY_FORMAT_OUT              query_format_out,
    r.PLUG_QUERY_SHOW_NULLS_AS           report_null_values_as,
    --r.PLUG_QUERY_COL_ALLIGNMENTS         ,
    r.PLUG_QUERY_BREAK_COLS              breaks,
    --r.PLUG_QUERY_SUM_COLS                ,
    --r.PLUG_QUERY_NUMBER_FORMATS          ,
    --r.PLUG_QUERY_TABLE_BORDER            ,
    --r.PLUG_QUERY_HIT_HIGHLIGHTING        ,
    r.PLUG_QUERY_ASC_IMAGE               ascending_image,
    r.PLUG_QUERY_ASC_IMAGE_ATTR          ascending_image_attributes,
    r.PLUG_QUERY_DESC_IMAGE              descending_image,
    r.PLUG_QUERY_DESC_IMAGE_ATTR         descending_image_attributes,
    r.PLUG_QUERY_EXP_FILENAME            filename,
    r.PLUG_QUERY_EXP_SEPARATOR           separator,
    r.PLUG_QUERY_EXP_ENCLOSED_BY         enclosed_by,
    decode(r.PLUG_QUERY_STRIP_HTML,
      'Y','Yes',
      'N','No',
      r.PLUG_QUERY_STRIP_HTML)           strip_html,
    r.PLUG_QUERY_OPTIONS                 report_column_source_type,
    r.PLUG_QUERY_MAX_COLUMNS             max_dynamic_report_cols,
    r.PLUG_COLUMN_WIDTH                  HTML_table_cell_attributes,
    decode(r.PLUG_CUSTOMIZED,
       null,'None',
       '2','Customizable and Not Shown By Default',
       '1','Customizable and Shown By Default',
       '0','Not Customizable By End Users',
       r.PLUG_CUSTOMIZED)                 customization,
    r.PLUG_CUSTOMIZED_NAME                customization_name,
    --r.PLUG_OVERRIDE_REG_POS              ,
    (select case when r.required_patch > 0 then PATCH_NAME else '{Not '||PATCH_NAME||'}' end PATCH_NAME
     from wwv_flow_patches
     where id=abs(r.REQUIRED_PATCH) )         build_option,
    r.required_patch                     build_option_id,
    --
    --r.PLUG_URL_TEXT_BEGIN                ,
    --r.PLUG_URL_TEXT_END                  ,
    --
    -- region caching
    --
    nvl(decode(r.PLUG_CACHING,
    'CACHED','Cached',
    'CACHED_BY_USER','Cached by User',
    'NOT_CACHED','Not Cached',
    null,'Not Cached'),'Not Cached')     region_caching,
    --r.PLUG_CACHING_SESSION_STATE         ,
    r.PLUG_CACHING_MAX_AGE_IN_SEC        timeout_cache_after,
    r.PLUG_CACHE_WHEN                    cache_when,
    r.PLUG_CACHE_EXPRESSION1             cache_when_expression_1,
    r.PLUG_CACHE_EXPRESSION2             cache_when_expression_2,
    --r.PLUG_IGNORE_PAGINATION             ,
    --r.PLUG_CHART_FONT_SIZE               ,
    --r.PLUG_CHART_MAX_ROWS                ,
    --r.PLUG_CHART_NUM_MASK                ,
    --r.PLUG_CHART_SCALE                   ,
    --r.PLUG_CHART_AXIS                    ,
    --r.PLUG_CHART_SHOW_SUMMARY            ,
    r.REPORT_TOTAL_TEXT_FORMAT           sum_display_text,
    r.BREAK_COLUMN_TEXT_FORMAT           break_display_text,
    r.BREAK_BEFORE_ROW                   before_break_display_text,
    r.BREAK_GENERIC_COLUMN               break_column_display_text,
    r.BREAK_AFTER_ROW                    after_break_display_text,
    decode(
       r.BREAK_TYPE_FLAG,
       'REPEAT_HEADINGS_ON_BREAK_1','Repeat Headings on Break',
       'DEFAULT_BREAK_FORMATTING','Default Break Formatting',
       r.BREAK_TYPE_FLAG)                break_display_flag,
    r.BREAK_REPEAT_HEADING_FORMAT        repeat_heading_break_format,
    decode(r.CSV_OUTPUT,
    'Y','Yes','N','No',r.CSV_OUTPUT)     enable_csv_output,
    r.CSV_OUTPUT_LINK_TEXT               csv_link_label,
    r.PRINT_URL                          URL,
    r.PRINT_URL_LABEL                    link_label,
    decode(r.TRANSLATE_TITLE,
    'Y','Yes','N','No','Yes')            translate_region_title,
    --
    r.LAST_UPDATED_BY                    last_updated_by,
    r.LAST_UPDATED_ON                    last_updated_on,
    r.PLUG_COMMENT                       component_comment,
    r.id                                 region_id,
    --
    (select count(*) from wwv_flow_step_items where r.id = ITEM_PLUG_ID and r.flow_id = flow_id and nvl(display_as,'x') != 'BUTTON') items,
    ((select count(*) from wwv_flow_step_items where r.id = ITEM_PLUG_ID and r.flow_id = flow_id and nvl(display_as,'x') = 'BUTTON') +
     (select count(*) from wwv_flow_step_buttons where r.id = button_plug_id and r.flow_id = flow_id)) buttons,
     --
     region_name||'.'||
     lpad(r.plug_display_sequence,5,'00000')
     ||',c='||r.PLUG_DISPLAY_column
     ||',temp='||nvl(decode(nvl(r.PLUG_TEMPLATE,0),0,'No Template',(select PAGE_PLUG_TEMPLATE_NAME from wwv_flow_page_plug_templates where id = r.PLUG_TEMPLATE)),'No Template')
     ||',pos='||decode(r.PLUG_DISPLAY_POINT,
       'AFTER_HEADER',       'After Header',
       'BEFORE_BOX_BODY',    'Page Template Body (1. items below region content)',
       'BEFORE_SHOW_ITEMS',  'Page Template Body (2. items below region content)',
       'AFTER_SHOW_ITEMS',   'Page Template Body (3. items above region content)',
       'BEFORE_FOOTER',      'Before Footer',
       'REGION_POSITION_01', 'Page Template Region Position 1',
       'REGION_POSITION_02', 'Page Template Region Position 2',
       'REGION_POSITION_03', 'Page Template Region Position 3',
       'REGION_POSITION_04', 'Page Template Region Position 4',
       'REGION_POSITION_05', 'Page Template Region Position 5',
       'REGION_POSITION_06', 'Page Template Region Position 6',
       'REGION_POSITION_07', 'Page Template Region Position 7',
       'REGION_POSITION_08', 'Page Template Region Position 8',
       r.PLUG_DISPLAY_POINT)
     ||',src='||decode(translate(dbms_lob.substr(r.PLUG_SOURCE,1,1),'M0123456789.','000000000000'),'0','Ref',dbms_lob.substr(r.PLUG_SOURCE,30,1)||'.'||dbms_lob.getlength(r.PLUG_SOURCE))
     ||(select ',bo='||PATCH_NAME b from wwv_flow_patches where id=abs(r.REQUIRED_PATCH))
     ||decode(r.PLUG_DISPLAY_ERROR_MESSAGE,null,null,',ErrMsg='||length(r.PLUG_DISPLAY_ERROR_MESSAGE))
     ||nvl((select ',auth='||name n from wwv_flow_security_schemes where to_char(id) = ltrim(r.PLUG_REQUIRED_ROLE,'!') and flow_id = f.id),r.PLUG_REQUIRED_ROLE)
     ||decode(r.PAGINATION_DISPLAY_POSITION,
      'BOTTOM_LEFT','Bottom-L',
      'BOTTOM_RIGHT','Bottom-R',
      'TOP_LEFT','Top-L',
      'TOP_RIGHT','Top-R',
      'TOP_AND_BOTTOM_LEFT','Top+Bottom-L',
      'TOP_AND_BOTTOM_RIGHT','Top+Bottom-R',
      r.PAGINATION_DISPLAY_POSITION)
      ||r.PLUG_QUERY_NUM_ROWS_TYPE
      ||r.PLUG_DISPLAY_CONDITION_TYPE
      ||substr(r.PLUG_DISPLAY_WHEN_CONDITION,1,20)||'.'||length(r.PLUG_DISPLAY_WHEN_CONDITION)
      ||substr(r.PLUG_DISPLAY_WHEN_COND2,1,20)||'.'||length(r.PLUG_DISPLAY_WHEN_COND2)
      ||decode(
       r.BREAK_TYPE_FLAG,
       'REPEAT_HEADINGS_ON_BREAK_1','RepHead on Br',
       'DEFAULT_BREAK_FORMATTING','DefBreakFor',
       r.BREAK_TYPE_FLAG)
      ||decode(r.CSV_OUTPUT,'Y','Yes','N','No',r.CSV_OUTPUT)
      ||(select ',rtmp='||row_template_name t from wwv_flow_row_templates where id = r.PLUG_QUERY_ROW_TEMPLATE)
      ||decode(r.PLUG_QUERY_NUM_ROWS,null,null,'mr='||r.PLUG_QUERY_NUM_ROWS)
      ||r.BREAK_REPEAT_HEADING_FORMAT
      ||r.CSV_OUTPUT_LINK_TEXT
      ||substr(r.PRINT_URL,1,10)||length(r.PRINT_URL)
      ||length(PRINT_URL_LABEL)
      ||decode(r.TRANSLATE_TITLE,'Y','Yes','N','No','Yes')||
      length(PLUG_HEADER)||length(PLUG_FOOTER)
      ||r.PLUG_CUSTOMIZED
      ||length(r.PLUG_COLUMN_WIDTH)
      ||substr(r.region_name,1,15)
      ||length(REGION_ATTRIBUTES_SUBSTITUTION)
     component_signature
from wwv_flow_page_plugs r,
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
      f.id = p.flow_id and
      f.id = r.flow_id and
      p.id = r.page_id and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      w.PROVISIONING_COMPANY_ID != 0 and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10);
COMMENT ON TABLE apex_application_page_regions IS 'Identifies a content container associated with a Page and displayed within a position defined by the Page Template';
COMMENT ON COLUMN apex_application_page_regions.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_page_regions.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_page_regions.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_page_regions.page_id IS 'Identifies the application';
COMMENT ON COLUMN apex_application_page_regions.page_name IS 'Identifies a page within an application';
COMMENT ON COLUMN apex_application_page_regions.region_name IS 'Identifies the Region Name.  The display of the region name is controlled by the Region Template substitution string TITLE.';
COMMENT ON COLUMN apex_application_page_regions."TEMPLATE" IS 'Identifies the template used to display the region';
COMMENT ON COLUMN apex_application_page_regions.template_id IS 'Foreign Key';
COMMENT ON COLUMN apex_application_page_regions.static_id IS 'Reference this value using the substitution string #REGION_STATIC_ID#';
COMMENT ON COLUMN apex_application_page_regions.display_sequence IS 'Identifies the Display Sequence of the Region within each Display Position';
COMMENT ON COLUMN apex_application_page_regions.region_attributes_substitution IS 'Identifies text to be substituted by the region template #REGION_ATTRIBUTES# substituion string';
COMMENT ON COLUMN apex_application_page_regions.display_column IS 'Identifies the column used to display the region, allows regions to be positioned in a second column within a single Display Position.';
COMMENT ON COLUMN apex_application_page_regions.display_position IS 'Identifies the position within the Page Template that the Region will be displayed';
COMMENT ON COLUMN apex_application_page_regions.display_position_code IS 'Identifies the coded value of the position within the Page Template that the Region will be displayed';
COMMENT ON COLUMN apex_application_page_regions.region_source IS 'Identifies the source of the region, reference Region Source Type';
COMMENT ON COLUMN apex_application_page_regions.breadcrumb_template IS 'Identifies breadcrumb template';
COMMENT ON COLUMN apex_application_page_regions.breadcrumb_template_id IS 'Identifies breadcrumb template ID';
COMMENT ON COLUMN apex_application_page_regions.list_template_override IS 'Identifies the List Template to be used to display regions of type List.  By default the List Template is defined in the List definition, if a value is specified in this attribute, this template will be used to render the List.';
COMMENT ON COLUMN apex_application_page_regions.list_template_override_id IS 'Foreign key of list template override';
COMMENT ON COLUMN apex_application_page_regions.source_type IS 'Identifies how Apex will interpret the Region Source';
COMMENT ON COLUMN apex_application_page_regions.on_error_message IS 'Identifies the error text to be displayed when the display of a region results in an error';
COMMENT ON COLUMN apex_application_page_regions.authorization_scheme IS 'An authorization scheme must evaluate to TRUE in order for this component to be displayed';
COMMENT ON COLUMN apex_application_page_regions.authorization_scheme_id IS 'Foreign Key';
COMMENT ON COLUMN apex_application_page_regions.condition_type IS 'Identifies the condition type used to conditionally display the region';
COMMENT ON COLUMN apex_application_page_regions.condition_expression1 IS 'Specifies an expression based on the specific condition type selected.';
COMMENT ON COLUMN apex_application_page_regions.condition_expression2 IS 'Specifies an expression based on the specific condition type selected.';
COMMENT ON COLUMN apex_application_page_regions.report_template IS 'Report templates provide control over the results of a row from your SQL query';
COMMENT ON COLUMN apex_application_page_regions.report_template_id IS 'Identifies report template ID';
COMMENT ON COLUMN apex_application_page_regions.report_column_headings IS 'Report column heading override, can be used to define dynamic report column headings';
COMMENT ON COLUMN apex_application_page_regions.headings_type IS 'Identifies the how report column headings are computed';
COMMENT ON COLUMN apex_application_page_regions.maximum_rows_to_query IS 'Specifies the maximum rows that can be retuned by a given query.  Avoids attempting to send millions of rows to a web browser.';
COMMENT ON COLUMN apex_application_page_regions.pagination_scheme IS 'Pagination provides the user with information about the number of rows and the current position within the result set. Pagination also defines the style of links or buttons that are used to navigate to the next or previous page.';
COMMENT ON COLUMN apex_application_page_regions.pagination_display_position IS 'Pagination can be displayed on the left side, right side, at the bottom, or above the report.';
COMMENT ON COLUMN apex_application_page_regions.ajax_enabled IS 'Specifies if the region is ajax enabled.';
COMMENT ON COLUMN apex_application_page_regions.number_of_rows_item IS 'Defines the maximum number of rows to display per page.';
COMMENT ON COLUMN apex_application_page_regions.no_data_found_message IS 'Defines the text message that displays when the query does not return any rows.';
COMMENT ON COLUMN apex_application_page_regions.more_data_found_message IS 'Defines the text message that displays when more rows exist.';
COMMENT ON COLUMN apex_application_page_regions.maximum_row_count IS 'Defines the maximum number of rows to query, relevant for pagination schemes which display "Rows X - Y of Z".  Counting fewer rows can improve performance and counting thousands of rows can degrade performance.';
COMMENT ON COLUMN apex_application_page_regions.report_null_values_as IS 'Identifies the text to display for null columns. The default value is "(null)".';
COMMENT ON COLUMN apex_application_page_regions.breaks IS 'Identifies how breaks should be formatted.';
COMMENT ON COLUMN apex_application_page_regions.ascending_image IS 'Defines the image shown in report headings to sort column values in ascending order.';
COMMENT ON COLUMN apex_application_page_regions.ascending_image_attributes IS 'Image attributes for sort images used to define attributes such width and height of image.';
COMMENT ON COLUMN apex_application_page_regions.descending_image IS 'Defines the image shown in report headings to sort column values in descending order.';
COMMENT ON COLUMN apex_application_page_regions.descending_image_attributes IS 'Image attributes for sort images used to define attributes such width and height of image.';
COMMENT ON COLUMN apex_application_page_regions.filename IS 'Specify a name for the export file. If no name is specified, the region name is used followed by the extension .csv.';
COMMENT ON COLUMN apex_application_page_regions.separator IS 'Identifies a column separator. If no value is entered, a comma or semicolon is used depending on your current NLS settings.';
COMMENT ON COLUMN apex_application_page_regions.enclosed_by IS 'Identifies a delimiter character. This character is used to delineate the starting and ending boundary of a data value. Default delimiter is double quotes.';
COMMENT ON COLUMN apex_application_page_regions.strip_html IS 'Specifies whether or not to remove HTML tags from the original column values for HTML expressions, column links and report data exported as CSV files.';
COMMENT ON COLUMN apex_application_page_regions.report_column_source_type IS 'Determines how report columns will be computed, values include DERIVED_REPORT_COLUMNS and GENERIC_REPORT_COLUMNS';
COMMENT ON COLUMN apex_application_page_regions.max_dynamic_report_cols IS 'Maximum number of dynamic report columns';
COMMENT ON COLUMN apex_application_page_regions.html_table_cell_attributes IS 'When generating HTML to display items use these HTML table cell attributes';
COMMENT ON COLUMN apex_application_page_regions.customization IS 'Identifies level of customization support for this page region';
COMMENT ON COLUMN apex_application_page_regions.customization_name IS 'Name of region to show in popup customization window';
COMMENT ON COLUMN apex_application_page_regions.build_option IS 'Region will be displayed if the Build Option is enabled';
COMMENT ON COLUMN apex_application_page_regions.build_option_id IS 'Foreign Key';
COMMENT ON COLUMN apex_application_page_regions.region_caching IS 'Identifies caching method';
COMMENT ON COLUMN apex_application_page_regions.timeout_cache_after IS 'Identify how long a cached region will remain valid in seconds';
COMMENT ON COLUMN apex_application_page_regions.cache_when IS 'Identifies a condition must be true for the region to be cached or to render from cache';
COMMENT ON COLUMN apex_application_page_regions.cache_when_expression_1 IS 'Identifies expression corresponding to Cache When condition';
COMMENT ON COLUMN apex_application_page_regions.cache_when_expression_2 IS 'Identifies expression corresponding to Cache When condition';
COMMENT ON COLUMN apex_application_page_regions.sum_display_text IS 'Display this text when printing report sums';
COMMENT ON COLUMN apex_application_page_regions.break_display_text IS 'Text displayed on control breaks';
COMMENT ON COLUMN apex_application_page_regions.before_break_display_text IS 'Defines the text that displays before break columns when displaying a break row.';
COMMENT ON COLUMN apex_application_page_regions.break_column_display_text IS 'Defines the column template to use when displaying a column break. Use #COLUMN_VALUE# substitutions.';
COMMENT ON COLUMN apex_application_page_regions.after_break_display_text IS 'Defines the text that displays after break columns when displaying a break row.';
COMMENT ON COLUMN apex_application_page_regions.break_display_flag IS 'Identify how you would like your breaks to be displayed';
COMMENT ON COLUMN apex_application_page_regions.repeat_heading_break_format IS 'Defines the heading template for repeating headings on column 1. Use #COLUMN_VALUE# substitutions.';
COMMENT ON COLUMN apex_application_page_regions.enable_csv_output IS 'Enables the query results to be spooled to a CSV file. To enable this option, you must use a report template with a #CSV_LINK# substitution string and set this option to YES.';
COMMENT ON COLUMN apex_application_page_regions.csv_link_label IS 'Specifies the text for the link which will invoke the CSV download.';
COMMENT ON COLUMN apex_application_page_regions.url IS 'Specifies the URL to a server for post processing of a report. See documentation for instructions.';
COMMENT ON COLUMN apex_application_page_regions.link_label IS 'Specifies the text for the link which will invoke the external processing engine.';
COMMENT ON COLUMN apex_application_page_regions.translate_region_title IS 'Identifies if this region title should be a candidate for translation or not (Yes or No)';
COMMENT ON COLUMN apex_application_page_regions.last_updated_by IS 'Apex developer who made last update';
COMMENT ON COLUMN apex_application_page_regions.last_updated_on IS 'Date of last update';
COMMENT ON COLUMN apex_application_page_regions.component_comment IS 'Developer comment';
COMMENT ON COLUMN apex_application_page_regions.region_id IS 'Primary Key of this Region';
COMMENT ON COLUMN apex_application_page_regions.items IS 'Count of Items corresponding to this region';
COMMENT ON COLUMN apex_application_page_regions.buttons IS 'Count of Buttons corresponding to this region';
COMMENT ON COLUMN apex_application_page_regions.component_signature IS 'Identifies attributes defined at a given component level to facilitate application comparisons';