CREATE OR REPLACE FORCE VIEW apex_application_page_rpt (workspace,application_id,application_name,page_id,page_name,region_name,source_type,body_background_color,body_font_color,body_font_family,body_font_size,body_font_weight,border_color,border_width,"FORMAT",format_item,page_header,page_header_alignment,page_header_font_color,page_header_font_family,page_header_font_size,page_header_font_weight,header_background_color,header_font_color,header_font_family,header_font_size,header_font_weight,height,orientation,output,print_server_override,output_file_name,content_disposition,document_header,output_link_text,show_output_link,footer,footer_alignment,footer_font_color,footer_font_family,footer_font_size,footer_font_weight,paper_size,template_id,paper_size_units,paper_size_width_units,paper_size_width,last_updated_by,last_updated_on,component_comment,region_id,component_signature) AS
select
    w.short_name                         workspace,
    p.flow_id                            application_id,
    f.name                               application_name,
    p.id                                 page_id,
    p.name                               page_name,
    --
    r.plug_name                          region_name,
    decode(r.PLUG_SOURCE_TYPE,
        'SQL_QUERY','Report',
        'STRUCTURED_QUERY','Report',
        'FUNCTION_RETURNING_SQL_QUERY','Report',
        'UPDATABLE_SQL_QUERY','Tabular Form') source_type,
    PRN_BODY_BG_COLOR                         body_background_color,
    PRN_BODY_FONT_COLOR                       body_font_color,
    PRN_BODY_FONT_FAMILY                      body_font_family,
    PRN_BODY_FONT_SIZE                        body_font_size,
    PRN_BODY_FONT_WEIGHT                      body_font_weight,
    PRN_BORDER_COLOR                          border_color,
    PRN_BORDER_WIDTH                          border_width,
    PRN_FORMAT                                format,
    PRN_FORMAT_ITEM                           format_item,
    PRN_PAGE_HEADER                           page_header,
    PRN_PAGE_HEADER_ALIGNMENT                 page_header_alignment,
    PRN_PAGE_HEADER_FONT_COLOR                page_header_font_color,
    PRN_PAGE_HEADER_FONT_FAMILY               page_header_font_family,
    PRN_PAGE_HEADER_FONT_SIZE                 page_header_font_size,
    PRN_PAGE_HEADER_FONT_WEIGHT               page_header_font_weight,
    PRN_HEADER_BG_COLOR                       header_background_color,
    PRN_HEADER_FONT_COLOR                     header_font_color,
    PRN_HEADER_FONT_FAMILY                    header_font_family,
    PRN_HEADER_FONT_SIZE                      header_font_size,
    PRN_HEADER_FONT_WEIGHT                    header_font_weight,
    PRN_HEIGHT                                height,
    PRN_ORIENTATION                           orientation,
    PRN_OUTPUT                                output,
    prn_print_server_overwrite                print_server_override,
    PRN_OUTPUT_FILE_NAME                      output_file_name,
    prn_content_disposition                   content_disposition,
    prn_document_header                       document_header,
    PRN_OUTPUT_LINK_TEXT                      output_link_text,
    PRN_OUTPUT_SHOW_LINK                      show_output_link,
    PRN_PAGE_FOOTER                           footer,
    PRN_PAGE_FOOTER_ALIGNMENT                 footer_alignment,
    PRN_PAGE_FOOTER_FONT_COLOR                footer_font_color,
    PRN_PAGE_FOOTER_FONT_FAMILY               footer_font_family,
    PRN_PAGE_FOOTER_FONT_SIZE                 footer_font_size,
    PRN_PAGE_FOOTER_FONT_WEIGHT               footer_font_weight,
    --
    PRN_PAPER_SIZE                            paper_size,
    PRN_TEMPLATE_ID                           template_id,
    PRN_UNITS                                 paper_size_units,
    prn_width_units                           paper_size_width_units,
    PRN_WIDTH                                 paper_size_width,
    --
    r.LAST_UPDATED_BY                    last_updated_by,
    r.LAST_UPDATED_ON                    last_updated_on,
    r.PLUG_COMMENT                       component_comment,
    r.id                                 region_id,
    --
     region_name||'.'
     ||PRN_BODY_BG_COLOR
     ||PRN_BODY_FONT_COLOR
     ||PRN_BODY_FONT_FAMILY
     ||PRN_BODY_FONT_SIZE
     ||PRN_BODY_FONT_WEIGHT
     ||PRN_BORDER_COLOR
     ||PRN_BORDER_WIDTH
     ||length(PRN_FORMAT)
     ||PRN_FORMAT_ITEM
     ||length(PRN_PAGE_HEADER)
     ||PRN_PAGE_HEADER_ALIGNMENT
     ||PRN_PAGE_HEADER_FONT_COLOR
     ||PRN_PAGE_HEADER_FONT_FAMILY
     ||PRN_PAGE_HEADER_FONT_SIZE
     ||PRN_PAGE_HEADER_FONT_WEIGHT
     ||PRN_HEADER_BG_COLOR
     ||PRN_HEADER_FONT_COLOR
     ||PRN_HEADER_FONT_FAMILY
     ||PRN_HEADER_FONT_SIZE
     ||PRN_HEADER_FONT_WEIGHT
     ||PRN_HEIGHT
     ||PRN_ORIENTATION
     ||PRN_OUTPUT
     ||PRN_OUTPUT_FILE_NAME
     ||PRN_CONTENT_DISPOSITION
     ||PRN_DOCUMENT_HEADER
     ||PRN_UNITS
     ||PRN_OUTPUT_LINK_TEXT
     ||PRN_OUTPUT_SHOW_LINK
     ||length(PRN_PAGE_FOOTER)
     ||PRN_PAGE_FOOTER_ALIGNMENT
     ||PRN_PAGE_FOOTER_FONT_COLOR
     ||PRN_PAGE_FOOTER_FONT_FAMILY
     ||PRN_PAGE_FOOTER_FONT_SIZE
     ||PRN_PAGE_FOOTER_FONT_WEIGHT
     ||PRN_PAPER_SIZE
     ||PRN_TEMPLATE_ID
     ||PRN_UNITS
     ||PRN_WIDTH
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
      r.PLUG_SOURCE_TYPE in ('SQL_QUERY','STRUCTURED_QUERY','FUNCTION_RETURNING_SQL_QUERY','UPDATABLE_SQL_QUERY') and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10);
COMMENT ON TABLE apex_application_page_rpt IS 'Printing attributes for regions that are reports';
COMMENT ON COLUMN apex_application_page_rpt.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_page_rpt.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_page_rpt.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_page_rpt.page_id IS 'Identifies the application';
COMMENT ON COLUMN apex_application_page_rpt.page_name IS 'Identifies a page within an application';
COMMENT ON COLUMN apex_application_page_rpt.region_name IS 'Identifies the Region Name.  The display of the region name is controlled by the Region Template substitution string TITLE.';
COMMENT ON COLUMN apex_application_page_rpt.component_signature IS 'Identifies attributes defined at a given component level to facilitate application comparisons';