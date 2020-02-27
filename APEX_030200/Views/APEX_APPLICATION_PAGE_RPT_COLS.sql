CREATE OR REPLACE FORCE VIEW apex_application_page_rpt_cols (workspace,application_id,application_name,page_id,page_name,region_name,column_alias,display_sequence,heading,format_mask,html_expression,css_class,css_style,highlight_words,column_link_url,column_link_text,column_link_attributes,page_checksum,column_alignment,heading_alignment,default_sort_sequence,default_sort_direction,sortable_column,sum_column,column_is_hidden,condition_type,condition_expression1,condition_expression2,authorization_scheme,authorization_scheme_id,last_updated_by,last_updated_on,display_as,named_list_of_values,inline_list_of_values,lov_show_nulls,lov_display_extra_values,lov_null_text,lov_null_value,form_element_width,form_element_height,form_element_attributes,form_element_option_attributes,primary_key_column_source_type,primary_key_column_source,derived_column,column_default,column_default_type,reference_schema,reference_table_name,reference_column_name,include_in_export,print_column_width,print_column_alignment,column_comment,region_id,region_report_column_id,component_signature) AS
select
     w.short_name                          workspace,
     p.flow_id                             application_id,
     f.name                                application_name,
     p.id                                  page_id,
     p.name                                page_name,
     region.plug_Name                      region_name,
     --
     --r.QUERY_COLUMN_ID                     ,
     --r.FORM_ELEMENT_ID                     ,
     r.COLUMN_ALIAS                        column_alias,
     r.COLUMN_DISPLAY_SEQUENCE             display_sequence,
     r.COLUMN_HEADING                      heading,
     r.COLUMN_FORMAT                       format_mask,
     r.COLUMN_HTML_EXPRESSION              html_expression,
     r.COLUMN_CSS_CLASS                    css_class,
     r.COLUMN_CSS_STYLE                    css_style,
     r.COLUMN_HIT_HIGHLIGHT                highlight_words,
     --
     r.COLUMN_LINK                         column_link_url,
     r.COLUMN_LINKTEXT                     column_link_text,
     r.COLUMN_LINK_ATTR                    column_link_attributes,
     --
     r.COLUMN_LINK_CHECKSUM_TYPE           page_checksum,
     --
     r.COLUMN_ALIGNMENT                    column_alignment,
     r.HEADING_ALIGNMENT                   heading_alignment,
     --
     r.DEFAULT_SORT_COLUMN_SEQUENCE        default_sort_sequence,
     r.DEFAULT_SORT_DIR                    default_sort_direction,
     decode(r.DISABLE_SORT_COLUMN,
       'Y','Yes','N','No',
       r.DISABLE_SORT_COLUMN)              sortable_column,
     decode(r.SUM_COLUMN,
       'Y','Yes','N','No',
       r.SUM_COLUMN)                       sum_column,
     decode(r.HIDDEN_COLUMN ,
       'Y','Yes','N','No',
       r.HIDDEN_COLUMN )                   column_is_hidden,
     --
     r.DISPLAY_WHEN_COND_TYPE              condition_type,
     r.DISPLAY_WHEN_CONDITION              condition_expression1,
     r.DISPLAY_WHEN_CONDITION2             condition_expression2,
     --
     decode(substr(r.REPORT_COLUMN_REQUIRED_ROLE,1,1),'!','Not ')||
     nvl((select name
     from   wwv_flow_security_schemes
     where  to_char(id) = ltrim(r.REPORT_COLUMN_REQUIRED_ROLE,'!')
     and    flow_id = f.id),
            r.REPORT_COLUMN_REQUIRED_ROLE)
                                           authorization_scheme,
     r.REPORT_COLUMN_REQUIRED_ROLE         authorization_scheme_id,
     --
     r.LAST_UPDATED_BY                     last_updated_by,
     r.LAST_UPDATED_ON                     last_updated_on,
     --
     decode(r.DISPLAY_AS,
        'WITHOUT_MODIFICATION','Standard Report Column',
        'TEXT_FROM_LOV','Display as Text (based on LOV, does not save state)',
        'DISPLAY_AND_SAVE','Display as Text (saves state)',
        'ESCAPE_SC','Display as Text (escape special characters, does not save state)',
        'DATE_POPUP','Date Picker',
        'TEXT','Text Field',
        'TEXTAREA','Text Area',
        'SELECT_LIST','Select List (static LOV)',
        'SELECT_LIST_FROM_LOV','Select List (named LOV)',
        'SELECT_LIST_FROM_QUERY','Select List (query based LOV)',
        'HIDDEN','Hidden',
        'POPUP','Popup LOV (named LOV)',
        'POPUP_QUERY','Popup LOV (query based LOV)',
        r.DISPLAY_AS)                      display_as,
     --
     decode((select lov_name
      from wwv_flow_lists_of_values$
      where id = r.NAMED_LOV),null,null,
      (select lov_name
      from wwv_flow_lists_of_values$
      where id = r.NAMED_LOV))                            named_list_of_values,
     r.INLINE_LOV                          inline_list_of_values,
     decode(r.LOV_SHOW_NULLS,
       'YES','Yes','NO','No',
       r.LOV_SHOW_NULLS)                   LOV_SHOW_NULLS,
     decode(r.LOV_DISPLAY_EXTRA,
       'YES','Yes','NO','No',
       r.LOV_DISPLAY_EXTRA)                LOV_DISPLAY_EXTRA_VALUES,
     r.LOV_NULL_TEXT                       lov_null_text,
     r.LOV_NULL_VALUE                      lov_null_value,
     --
     r.COLUMN_WIDTH                        form_element_width,
     r.COLUMN_HEIGHT                       form_element_height,
     r.CATTRIBUTES                         form_Element_Attributes,
     r.CATTRIBUTES_ELEMENT                 form_Element_Option_Attributes,
     --
     --r.COLUMN_COMMENT                      ,
     r.PK_COL_SOURCE_TYPE                  primary_key_column_source_type,
     r.PK_COL_SOURCE                       primary_key_column_source,
     decode(r.DERIVED_COLUMN,
       'Y','Yes',
        r.DERIVED_COLUMN)                  derived_column,
     --
     r.COLUMN_DEFAULT                      column_default,
     r.COLUMN_DEFAULT_TYPE                 column_default_type,
     --
     r.REF_SCHEMA                          reference_schema,
     r.REF_TABLE_NAME                      reference_table_name,
     r.REF_COLUMN_NAME                     reference_column_name,
     --
     decode(include_in_export,'Y','Yes','N','No') include_in_export,
     print_col_width                       print_column_width,
     print_col_align                       print_column_alignment,
     COLUMN_COMMENT                        column_comment,
     --
     region.id                             region_id,
     r.id                                  region_report_column_id,
     --
     substr(r.COLUMN_ALIAS,1,30)
     ||' s='||r.COLUMN_DISPLAY_SEQUENCE
     ||' h='||substr(r.COLUMN_HEADING,1,15)||length(r.COLUMN_HEADING)
     ||substr(r.COLUMN_FORMAT,1,15)||length(r.COLUMN_FORMAT)
     ||' e='||substr(r.COLUMN_HTML_EXPRESSION,1,15)||length(r.COLUMN_HTML_EXPRESSION)
     ||substr(r.COLUMN_CSS_CLASS,1,20)
     ||substr(r.COLUMN_CSS_STYLE,1,20)
     ||substr(r.COLUMN_HIT_HIGHLIGHT,1,15)||length(r.COLUMN_HIT_HIGHLIGHT)
     ||' l='||substr(r.COLUMN_LINK,1,20)||length(r.COLUMN_LINK)
     ||substr(r.COLUMN_LINKTEXT,1,15)||length(r.COLUMN_LINKTEXT)
     ||substr(r.COLUMN_LINK_ATTR,1,15)||length(r.COLUMN_LINK_ATTR)
     ||substr(r.COLUMN_LINK_CHECKSUM_TYPE,1,15)
     ||' a='||substr(r.COLUMN_ALIGNMENT,1,6)||substr(r.HEADING_ALIGNMENT,1,6)
     ||' s='||DEFAULT_SORT_COLUMN_SEQUENCE
     ||substr(DEFAULT_SORT_DIR,1,6)
     ||substr(r.DISABLE_SORT_COLUMN,1,10)
     ||substr(r.SUM_COLUMN,1,10)
     ||substr(r.HIDDEN_COLUMN,1,15)
     ||' c='||substr(r.DISPLAY_WHEN_COND_TYPE,1,20)
	   ||substr(r.DISPLAY_WHEN_CONDITION,1,15)||length(r.DISPLAY_WHEN_CONDITION)
     ||substr(r.DISPLAY_WHEN_CONDITION2,1,15)||length(r.DISPLAY_WHEN_CONDITION2)
     ||' a='||substr(decode(substr(r.REPORT_COLUMN_REQUIRED_ROLE,1,1),'!','Not ')||
     nvl((select name
     from   wwv_flow_security_schemes
     where  to_char(id) = ltrim(r.REPORT_COLUMN_REQUIRED_ROLE,'!')
     and    flow_id = f.id),
            r.REPORT_COLUMN_REQUIRED_ROLE),1,30)
     ||' d='||substr(r.DISPLAY_AS,1,20)
     ||' l='||substr(decode((select lov_name
      from wwv_flow_lists_of_values$
      where id = r.NAMED_LOV),null,null,
      (select lov_name
      from wwv_flow_lists_of_values$
      where id = r.NAMED_LOV)),1,30)
     ||substr(r.INLINE_LOV,1,30)||substr(r.LOV_SHOW_NULLS,1,20)||substr(r.LOV_DISPLAY_EXTRA,1,6)||substr(r.LOV_NULL_VALUE,1,20)||r.COLUMN_WIDTH||r.COLUMN_HEIGHT
     ||' c='||substr(r.CATTRIBUTES,1,20)||length(r.CATTRIBUTES)
     ||' c='||substr(r.CATTRIBUTES_ELEMENT,1,20)||length(r.CATTRIBUTES_ELEMENT)
     ||' pk='||r.PK_COL_SOURCE_TYPE||dbms_lob.substr(r.PK_COL_SOURCE,20,1)||dbms_lob.getlength(r.PK_COL_SOURCE)
     ||' d='||substr(r.DERIVED_COLUMN,1,6)
     ||' d='||substr(r.COLUMN_DEFAULT,1,20)||length(r.COLUMN_DEFAULT)
     ||' t='||r.COLUMN_DEFAULT_TYPE||include_in_export||print_col_width||print_col_align
     component_signature
from WWV_FLOW_REGION_REPORT_COLUMN r,
     wwv_flow_steps p,
     wwv_flow_page_plugs region,
     wwv_flows f,
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(v('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = f.security_group_id) and
      f.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.schema = f.owner and
      f.security_group_id = p.security_group_id and
      f.security_group_id = r.security_group_id and
      f.id = p.flow_id and
      f.id = region.flow_id and
      p.id = region.page_id and
      region.id = r.region_id and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      w.PROVISIONING_COMPANY_ID != 0 and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10);
COMMENT ON TABLE apex_application_page_rpt_cols IS 'Report column definitions used for report regions';
COMMENT ON COLUMN apex_application_page_rpt_cols.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_page_rpt_cols.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_page_rpt_cols.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_page_rpt_cols.page_id IS 'Identifies the application';
COMMENT ON COLUMN apex_application_page_rpt_cols.page_name IS 'Identifies a page within an application';
COMMENT ON COLUMN apex_application_page_rpt_cols.region_name IS 'Report region name';
COMMENT ON COLUMN apex_application_page_rpt_cols.column_alias IS 'SQL query column alias';
COMMENT ON COLUMN apex_application_page_rpt_cols.display_sequence IS 'Identifies the sequence in the report that this column is to be displayed';
COMMENT ON COLUMN apex_application_page_rpt_cols.heading IS 'Report column heading';
COMMENT ON COLUMN apex_application_page_rpt_cols.format_mask IS 'Number or Date format mask';
COMMENT ON COLUMN apex_application_page_rpt_cols.html_expression IS 'HTML column template used to display this column';
COMMENT ON COLUMN apex_application_page_rpt_cols.css_class IS 'Use this CSS class in the HTML TD tag when displaying this report column';
COMMENT ON COLUMN apex_application_page_rpt_cols.css_style IS 'Use this CSS style in the HTML TD tag when displaying this report column';
COMMENT ON COLUMN apex_application_page_rpt_cols.highlight_words IS 'Identify keywords to highlight, for example "&P1_SEARCH."';
COMMENT ON COLUMN apex_application_page_rpt_cols.column_link_url IS 'URL target of report column';
COMMENT ON COLUMN apex_application_page_rpt_cols.column_link_text IS 'Text displayed for linked columns';
COMMENT ON COLUMN apex_application_page_rpt_cols.column_link_attributes IS 'HTML "A" tag attributes';
COMMENT ON COLUMN apex_application_page_rpt_cols.page_checksum IS 'An appropriate checksum when linking to protected pages';
COMMENT ON COLUMN apex_application_page_rpt_cols.column_alignment IS 'Report column alignment';
COMMENT ON COLUMN apex_application_page_rpt_cols.heading_alignment IS 'Report heading alignment';
COMMENT ON COLUMN apex_application_page_rpt_cols.default_sort_sequence IS 'For reports with column heading sorting, identifies the default sort order';
COMMENT ON COLUMN apex_application_page_rpt_cols.default_sort_direction IS 'Default sort direction, ascending or descending';
COMMENT ON COLUMN apex_application_page_rpt_cols.sortable_column IS 'Identifies if the column is column heading sortable';
COMMENT ON COLUMN apex_application_page_rpt_cols.sum_column IS 'Identifies if this column is to be summed';
COMMENT ON COLUMN apex_application_page_rpt_cols.column_is_hidden IS 'Identifies the column as hidden, the values will be returned to the browser but they will not be displayed.';
COMMENT ON COLUMN apex_application_page_rpt_cols.condition_type IS 'Identifies the condition type used to conditionally display this Report Column';
COMMENT ON COLUMN apex_application_page_rpt_cols.condition_expression1 IS 'Specifies an expression based on the specific condition type selected.';
COMMENT ON COLUMN apex_application_page_rpt_cols.condition_expression2 IS 'Specifies an expression based on the specific condition type selected.';
COMMENT ON COLUMN apex_application_page_rpt_cols.authorization_scheme IS 'An authorization scheme must evaluate to TRUE in order for this component to be displayed';
COMMENT ON COLUMN apex_application_page_rpt_cols.authorization_scheme_id IS 'Foreign Key';
COMMENT ON COLUMN apex_application_page_rpt_cols.last_updated_by IS 'Apex User Name that last updated this report column';
COMMENT ON COLUMN apex_application_page_rpt_cols.last_updated_on IS 'Date of last update';
COMMENT ON COLUMN apex_application_page_rpt_cols.display_as IS 'Identifies how the report column is to be displayed';
COMMENT ON COLUMN apex_application_page_rpt_cols.named_list_of_values IS 'Identifies the Shared List of Values to be used to display this report column';
COMMENT ON COLUMN apex_application_page_rpt_cols.inline_list_of_values IS 'Identifies an inline List of Values to display this column value';
COMMENT ON COLUMN apex_application_page_rpt_cols.lov_show_nulls IS 'For column "Display As" ';
COMMENT ON COLUMN apex_application_page_rpt_cols.lov_display_extra_values IS 'Identifies if the column value is to be displayed if the List of Values domain does not include the column value.';
COMMENT ON COLUMN apex_application_page_rpt_cols.lov_null_text IS 'Identifies the text to be displayed for a null value';
COMMENT ON COLUMN apex_application_page_rpt_cols.lov_null_value IS 'Identifies the text to be returned for a null value';
COMMENT ON COLUMN apex_application_page_rpt_cols.form_element_width IS 'For form elements, identifies the element width';
COMMENT ON COLUMN apex_application_page_rpt_cols.form_element_height IS 'For form elements, identifies the element height';
COMMENT ON COLUMN apex_application_page_rpt_cols.form_element_attributes IS 'Identifies HTML attributes for the HTML form element';
COMMENT ON COLUMN apex_application_page_rpt_cols.form_element_option_attributes IS 'Identifies HTML attributes for the HTML form element options';
COMMENT ON COLUMN apex_application_page_rpt_cols.primary_key_column_source_type IS 'Identifies the datatype of an updatable reports primary key.';
COMMENT ON COLUMN apex_application_page_rpt_cols.primary_key_column_source IS 'Identifies the source value for an updatable reports primary key.';
COMMENT ON COLUMN apex_application_page_rpt_cols.derived_column IS 'Column is generated by the reporting engine and is not derived from the SQL query';
COMMENT ON COLUMN apex_application_page_rpt_cols.column_default IS 'Identifies the default value source for this updatable report column';
COMMENT ON COLUMN apex_application_page_rpt_cols.column_default_type IS 'Identifies the default value source type for an updatable report column';
COMMENT ON COLUMN apex_application_page_rpt_cols.reference_schema IS 'Referenced column';
COMMENT ON COLUMN apex_application_page_rpt_cols.reference_table_name IS 'Referenced column';
COMMENT ON COLUMN apex_application_page_rpt_cols.reference_column_name IS 'Referenced column';
COMMENT ON COLUMN apex_application_page_rpt_cols.include_in_export IS 'Include column in download';
COMMENT ON COLUMN apex_application_page_rpt_cols.print_column_width IS 'Print column width for exact control';
COMMENT ON COLUMN apex_application_page_rpt_cols.print_column_alignment IS 'Print column alignment';
COMMENT ON COLUMN apex_application_page_rpt_cols.column_comment IS 'Comment on Report Column';
COMMENT ON COLUMN apex_application_page_rpt_cols.region_id IS 'Identifies the Primary Key of the report Region';
COMMENT ON COLUMN apex_application_page_rpt_cols.region_report_column_id IS 'Identifies the Primary Key of the Report Column Entry';
COMMENT ON COLUMN apex_application_page_rpt_cols.component_signature IS 'Identifies attributes defined at a given component level to facilitate application comparisons';