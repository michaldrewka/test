CREATE OR REPLACE FORCE VIEW apex_application_page_flash_s (workspace,application_id,application_name,page_id,page_name,region_id,region_name,chart_id,series_id,series_seq,series_name,series_query,series_query_type,series_query_parse_opt,series_query_no_data_found,series_query_row_count_max,last_updated_on,last_updated_by,component_signature) AS
select
    w.short_name                     workspace,
    f.id                             application_id,
    f.name                           application_name,
    c.page_id                        page_id,
    (select name
     from wwv_flow_steps
     where id = c.page_id
     and flow_id = c.flow_id)        page_name,
    c.region_id                      region_id,
    (select plug_name
     from wwv_flow_page_plugs
     where id = c.region_id
     and flow_id = c.flow_id)        region_name,
    --
    cs.chart_id                      chart_id,
    cs.id                            series_id,
    cs.series_seq                    series_seq,
    cs.series_name                   series_name,
    cs.series_query                  series_query,
    cs.series_query_type             series_query_type,
    cs.series_query_parse_opt        series_query_parse_opt,
    cs.series_query_no_data_found    series_query_no_data_found,
    cs.series_query_row_count_max    series_query_row_count_max,
    cs.updated_on                    last_updated_on,
    cs.updated_by                    last_updated_by,
    --
    cs.series_name
    ||' seq='||lpad(cs.series_seq,5,'00000')
    ||' q='||dbms_lob.substr(cs.series_query,20,1)||'.'||dbms_lob.getlength(cs.series_query)
    ||' max='||cs.series_query_row_count_max
    ||' nd_msg='|| substr(cs.series_query_no_data_found ,1,20)||length(cs.series_query_no_data_found)
    component_signature
from wwv_flow_flash_chart_series cs,
     wwv_flow_flash_charts c,
     wwv_flows f,
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(nv('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = s.security_group_id) and
      f.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.schema = f.owner and
      f.id = cs.flow_id and
      c.id = cs.chart_id and
      c.flow_id = cs.flow_id and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      w.PROVISIONING_COMPANY_ID != 0 and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10);
COMMENT ON TABLE apex_application_page_flash_s IS 'Identifies the Flash chart series which comprise a Flash chart';
COMMENT ON COLUMN apex_application_page_flash_s.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_page_flash_s.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_page_flash_s.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_page_flash_s.page_id IS 'ID of the application page';
COMMENT ON COLUMN apex_application_page_flash_s.page_name IS 'Name of the application page';
COMMENT ON COLUMN apex_application_page_flash_s.region_id IS 'Identifies the Page Region foreign key to the apex_application_page_regions view';
COMMENT ON COLUMN apex_application_page_flash_s.region_name IS 'Identifies the region name in which this Flash chart series is displayed';
COMMENT ON COLUMN apex_application_page_flash_s.chart_id IS 'Foreign key of the Flash chart';
COMMENT ON COLUMN apex_application_page_flash_s.series_id IS 'Primary Key of the Flash chart series';
COMMENT ON COLUMN apex_application_page_flash_s.series_seq IS 'Identifies the series sequence to determine the order of evaluation';
COMMENT ON COLUMN apex_application_page_flash_s.series_name IS 'Flash chart series name';
COMMENT ON COLUMN apex_application_page_flash_s.series_query IS 'SQL statement that will return the data to display the chart series';
COMMENT ON COLUMN apex_application_page_flash_s.series_query_type IS 'The query source type';
COMMENT ON COLUMN apex_application_page_flash_s.series_query_parse_opt IS 'A flag to perform query validation	when saving chart query';
COMMENT ON COLUMN apex_application_page_flash_s.series_query_no_data_found IS 'Defines the text message that displays when the query does not return any rows.';
COMMENT ON COLUMN apex_application_page_flash_s.series_query_row_count_max IS 'Defines the maximum number of rows to query.';
COMMENT ON COLUMN apex_application_page_flash_s.last_updated_on IS 'Date of last update';
COMMENT ON COLUMN apex_application_page_flash_s.last_updated_by IS 'Apex developer who made last update';
COMMENT ON COLUMN apex_application_page_flash_s.component_signature IS 'Identifies attributes defined at a given component level to facilitate application comparisons';