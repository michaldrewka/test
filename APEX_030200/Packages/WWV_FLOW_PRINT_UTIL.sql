CREATE OR REPLACE package wwv_flow_print_util
as

function convert (
    p_report_data    in blob,
    p_template       in clob,
    p_template_type  in varchar2,
    p_output         in varchar2,
    p_print_server   in varchar2 default null
) return blob;

function get_header return wwv_flow_global.vc_arr2;

end wwv_flow_print_util;
/