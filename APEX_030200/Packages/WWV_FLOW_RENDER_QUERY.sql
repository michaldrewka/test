CREATE OR REPLACE package wwv_flow_render_query as

    g_status varchar2(32767) := null;
    empty_vc_arr                wwv_flow_global.vc_arr2;
    g_dbms_output               dbms_output.chararr;
    g_max_size_reached          boolean := false;

    -----------------------------------------------------------------------------------------------
    -- get varchar2 array of report results
    -- p_owner:  owner / schema name
    -- p_query:  SQL statement
    -- p_format: CSV, HTML or XML
    -- p_values: bind values
    -- p_max_rows: number of report rows processed
    -- p_dbms_output_lines: number of dbms output lines

    function get_report (
        p_owner             varchar2,
        p_query             varchar2,
        p_format            varchar2 default 'HTML',
        p_values            in wwv_flow_global.vc_arr2 default empty_vc_arr,
        p_max_size          number   default 10000,
        p_max_rows          number   default 10,
        p_limit_type        varchar2 default 'S', -- 'S' for size 'R' for rows
        p_dbms_output_lines number   default 10000,
        p_headers           in wwv_flow_global.vc_arr2 default empty_vc_arr,
        p_header_align      in wwv_flow_global.vc_arr2 default empty_vc_arr,
        p_column_align      in wwv_flow_global.vc_arr2 default empty_vc_arr
    ) return wwv_flow_global.vc_arr2;

    -----------------------------------------------------------------------------------------------
    -- print report results via htp.p or dbms_output
    -- p_owner:  owner / schema name
    -- p_query:  SQL statement
    -- p_format: CSV, HTML or XML
    -- p_output: HTP or DBMS_OUTPUT
    -- p_max_rows: number of report rows processed
    -- p_dbms_output_lines: number of dbms output lines

    procedure print (
        p_owner             varchar2,
        p_query             varchar2,
        p_format            varchar2 default 'HTML',
        p_output            varchar2 default 'DBMS_OUTPUT',
        p_max_size          number   default 10000,
        p_dbms_output_lines number   default 10000

    );

    -----------------------------------------------------------------------------------------------
    -- print report results via htp.p or dbms_output
    -- p_owner:  owner / schema name
    -- p_query:  SQL statement
    -- p_format: CSV, HTML or XML
    -- p_output: HTP or DBMS_OUTPUT
    -- p_values: bind values array
    -- p_max_rows: number of report rows processed
    -- p_dbms_output_lines: number of dbms output lines

    procedure print_with_binds (
        p_owner             varchar2,
        p_query             varchar2,
        p_format            varchar2 default 'HTML',
        p_output            varchar2 default 'DBMS_OUTPUT',
        p_values            wwv_flow_global.vc_arr2 default empty_vc_arr,
        p_max_size          number   default 10000,
        p_dbms_output_lines number   default 10000

    );

    ----------------------------------------------------------------------------------------------
    -- print_interactive_report

    procedure print_interactive_report (
        p_flow_id       in number,
        p_region_id     in number,
        p_format        in varchar2 default null,
        p_content_disposition in varchar2 default null,
        p_query_text    in varchar2 default null,
        p_query_name    in varchar2 default null,
        p_query_owner   in varchar2 default null,
        p_values        wwv_flow_global.vc_arr2 default empty_vc_arr,
        p_headers       wwv_flow_global.vc_arr2 default empty_vc_arr,
        p_header_align  wwv_flow_global.vc_arr2 default empty_vc_arr,
        p_column_align  wwv_flow_global.vc_arr2 default empty_vc_arr
    );

    ----------------------------------------------------------------------------------------------
    -- get report query

    function get_report_query (
        p_flow_id       in varchar2 default null,
        p_shared_query  in varchar2 default null,
        p_query_name    in varchar2 default null,
        p_query_owner   in varchar2 default null,
        p_sql_stmnts    in wwv_flow_global.vc_arr2 default empty_vc_arr,
        p_xml_structure in varchar2 default null,
        p_layout_id     in number   default null,
        p_layout_type   in varchar2 default null,
        p_layout        in clob     default null,
        p_format        in varchar2 default null,
        p_items         in varchar2 default null,
        p_binds         in wwv_flow_global.vc_arr2 default empty_vc_arr,
        p_values        in wwv_flow_global.vc_arr2 default empty_vc_arr
    ) return blob;

    ----------------------------------------------------------------------------------------------
    -- print_report_query

    procedure print_report_query (
        p_flow_id       in varchar2 default null,
        p_shared_query  in varchar2 default null,
        p_query_name    in varchar2 default null,
        p_query_owner   in varchar2 default null,
        p_sql_stmnts    in wwv_flow_global.vc_arr2 default empty_vc_arr,
        p_xml_structure in varchar2 default null,
        p_layout_id     in number   default null,
        p_layout_type   in varchar2 default null,
        p_layout        in clob     default null,
        p_format        in varchar2 default null,
        p_items         in varchar2 default null,
        p_binds         in wwv_flow_global.vc_arr2 default empty_vc_arr,
        p_values        in wwv_flow_global.vc_arr2 default empty_vc_arr
    );

end;
/