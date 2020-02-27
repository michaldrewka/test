CREATE OR REPLACE FORCE VIEW apex_application_page_ir_col (workspace,application_id,application_name,page_id,interactive_report_id,column_id,column_alias,display_order,column_group,column_group_id,report_label,form_label,column_link,column_linktext,column_link_attr,column_link_checksum_type,allow_sorting,allow_filtering,allow_ctrl_breaks,allow_aggregations,allow_computations,allow_charting,column_type,display_text_as,heading_alignment,column_alignment,format_mask,filter_lov_source,rpt_lov,filter_date_ranges,display_condition_type,display_condition,display_condition2,help_text,authorization_scheme,authorization_scheme_id,column_expr,created_on,created_by,updated_on,updated_by,component_signature) AS
select
w.short_name                workspace,
f.id                        application_id,
f.name                      application_name,
c.page_id                   page_id,
ir.id                       interactive_report_id,
c.id                        column_id,
c.db_column_name            column_alias,
c.display_order             display_order,
(select name from wwv_flow_worksheet_col_groups where id = c.group_id) column_group,
c.group_id                  column_group_id,
c.report_label              report_label,
c.column_label              form_label,
c.column_link               ,
c.column_linktext           ,
c.column_link_attr          ,
c.column_link_checksum_type ,
--
decode(c.allow_sorting     ,'Y','Yes','N','No',c.allow_sorting     ) allow_sorting     ,
decode(c.allow_filtering   ,'Y','Yes','N','No',c.allow_filtering   ) allow_filtering   ,
decode(c.allow_ctrl_breaks ,'Y','Yes','N','No',c.allow_ctrl_breaks ) allow_ctrl_breaks ,
decode(c.allow_aggregations,'Y','Yes','N','No',c.allow_aggregations) allow_aggregations,
decode(c.allow_computations,'Y','Yes','N','No',c.allow_computations) allow_computations,
decode(c.allow_charting    ,'Y','Yes','N','No',c.allow_charting    ) allow_charting    ,
--
c.column_type               ,
c.display_text_as           ,
c.heading_alignment         ,
c.column_alignment          ,
c.format_mask               ,
--
decode(c.rpt_show_filter_lov,
       'D','Distinct Values Query',
       'S','Developer Defined LOV',
       'N','None',
       c.rpt_show_filter_lov)
                            filter_lov_source,
c.rpt_lov                   ,
c.rpt_filter_date_ranges    filter_date_ranges,
--
c.display_condition_type    ,
c.display_condition         ,
c.display_condition2        ,
--
c.help_text                 ,
--
decode(substr(c.SECURITY_SCHEME,1,1),'!','Not ')||
nvl((select name
 from   wwv_flow_security_schemes
 where  to_char(id) = ltrim(c.SECURITY_SCHEME,'!')
 and    flow_id = f.id),
 c.SECURITY_SCHEME)             authorization_scheme,
c.security_scheme               authorization_scheme_id,
c.column_expr,
--
c.created_on,
c.created_by,
c.updated_on,
c.updated_by,
--
'Interactive Report Column-'||
c.db_column_name||
' s='||c.display_order||
' g='||(select name from wwv_flow_worksheet_col_groups where id = c.group_id)||
' l='||c.report_label||
substr(c.column_label,1,30)||
substr(c.column_link,1,30)||
substr(c.column_linktext,1,30)||
substr(c.column_link_attr,1,30)||
c.column_link_checksum_type||
c.allow_sorting||
c.allow_filtering||
c.allow_ctrl_breaks||
c.allow_aggregations||
c.allow_computations||
c.allow_charting||
c.column_type||
c.display_text_as||
' ha='||c.heading_alignment||
' ca='||c.column_alignment||
' f='||c.format_mask||
c.rpt_show_filter_lov||
' lov='||length(c.rpt_lov)||
' d='||c.rpt_filter_date_ranges||
' cond='||c.display_condition_type||
length(c.display_condition)||
length(c.display_condition2)||
' h='||length(c.help_text)||
' as='||decode(substr(c.SECURITY_SCHEME,1,1),'!','Not ')||
nvl((select name
 from   wwv_flow_security_schemes
 where  to_char(id) = ltrim(c.SECURITY_SCHEME,'!')
 and    flow_id = f.id),
 c.SECURITY_SCHEME)
component_signature
from wwv_flow_worksheet_columns c,
     wwv_flow_worksheets ir,
     wwv_flows f,
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(nv('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = s.security_group_id) and
      f.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.schema = f.owner and
      f.security_group_id = c.security_group_id and
      f.id = ir.flow_id and ir.id = c.worksheet_id and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      w.PROVISIONING_COMPANY_ID != 0 and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10);
COMMENT ON TABLE apex_application_page_ir_col IS 'Report column definitions for interactive report columns';
COMMENT ON COLUMN apex_application_page_ir_col.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_page_ir_col.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_page_ir_col.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_page_ir_col.page_id IS 'Identifies the page';
COMMENT ON COLUMN apex_application_page_ir_col.interactive_report_id IS 'ID of the interactive report';
COMMENT ON COLUMN apex_application_page_ir_col.column_id IS 'ID of this column';
COMMENT ON COLUMN apex_application_page_ir_col.column_alias IS 'Database column name or expression to use in SQL query when displaying this worksheet column';
COMMENT ON COLUMN apex_application_page_ir_col.display_order IS 'Default display order of this column';
COMMENT ON COLUMN apex_application_page_ir_col.column_group IS 'Name of the column group for this column';
COMMENT ON COLUMN apex_application_page_ir_col.column_group_id IS 'ID of the column group for this column';
COMMENT ON COLUMN apex_application_page_ir_col.report_label IS 'Report heading label to use for this column';
COMMENT ON COLUMN apex_application_page_ir_col.form_label IS 'Single row view label to use for this column';
COMMENT ON COLUMN apex_application_page_ir_col.column_link IS 'Optional link target for this column';
COMMENT ON COLUMN apex_application_page_ir_col.column_linktext IS 'Text do display if a link is defined';
COMMENT ON COLUMN apex_application_page_ir_col.column_link_attr IS 'Link attributes for the column link.  Displayed within the HTML "A" tag';
COMMENT ON COLUMN apex_application_page_ir_col.column_link_checksum_type IS 'An appropriate checksum when linking to protected pages';
COMMENT ON COLUMN apex_application_page_ir_col.allow_sorting IS 'Determines whether to allow sorting for this column.';
COMMENT ON COLUMN apex_application_page_ir_col.allow_filtering IS 'Determines whether to allow filtering for this column.';
COMMENT ON COLUMN apex_application_page_ir_col.allow_ctrl_breaks IS 'Determines whether to allow control breaks for this column.';
COMMENT ON COLUMN apex_application_page_ir_col.allow_aggregations IS 'Determines whether to allow aggregations for this column.';
COMMENT ON COLUMN apex_application_page_ir_col.allow_computations IS 'Determines whether to allow computations for this column.';
COMMENT ON COLUMN apex_application_page_ir_col.allow_charting IS 'Determines whether to allow charting for this column.';
COMMENT ON COLUMN apex_application_page_ir_col.column_type IS 'Type of data in this column';
COMMENT ON COLUMN apex_application_page_ir_col.display_text_as IS 'Format to display this column';
COMMENT ON COLUMN apex_application_page_ir_col.heading_alignment IS 'Horizontal alignment of this column''s report heading';
COMMENT ON COLUMN apex_application_page_ir_col.column_alignment IS 'Horizontal alignment of this column''s report data';
COMMENT ON COLUMN apex_application_page_ir_col.format_mask IS 'Format mask for this column';
COMMENT ON COLUMN apex_application_page_ir_col.filter_lov_source IS 'Query used to retrieve a list of values for the interactive report.  Displayed in the column header dropdowns, and during filter and highlight creation.';
COMMENT ON COLUMN apex_application_page_ir_col.rpt_lov IS 'LOV query to display in filter dropdown';
COMMENT ON COLUMN apex_application_page_ir_col.filter_date_ranges IS 'Determines the range of dates to display for filters on this column';
COMMENT ON COLUMN apex_application_page_ir_col.display_condition_type IS 'For conditionally displayed this column; identifies the condition type to evaluate';
COMMENT ON COLUMN apex_application_page_ir_col.display_condition IS 'Specifies an expression based on the specific condition type selected.';
COMMENT ON COLUMN apex_application_page_ir_col.display_condition2 IS 'Specifies an expression based on the specific condition type selected.';
COMMENT ON COLUMN apex_application_page_ir_col.help_text IS 'Descriptive help text for this column, displayed when a user clicks on the column information icon';
COMMENT ON COLUMN apex_application_page_ir_col.authorization_scheme IS 'Optional authorization scheme determining whether this column and data is available to a user';
COMMENT ON COLUMN apex_application_page_ir_col.authorization_scheme_id IS 'ID of the authorization scheme';
COMMENT ON COLUMN apex_application_page_ir_col.column_expr IS 'Attribute for internal use only';
COMMENT ON COLUMN apex_application_page_ir_col.created_on IS 'Auditing; date the record was created.';
COMMENT ON COLUMN apex_application_page_ir_col.created_by IS 'Auditing; user that created the record.';
COMMENT ON COLUMN apex_application_page_ir_col.updated_on IS 'Auditing; date the record was last modified.';
COMMENT ON COLUMN apex_application_page_ir_col.updated_by IS 'Auditing; user that last modified the record.';
COMMENT ON COLUMN apex_application_page_ir_col.component_signature IS 'Identifies attributes defined at a given component level to facilitate application comparisons';