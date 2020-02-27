CREATE OR REPLACE package wwv_flow_worksheet_expr
as

function is_valid_format_mask (
    p_format_mask in varchar2,
    p_string_type in varchar2 default 'BOTH',
    p_allow_since in varchar2 default 'Y')
return boolean;

function tokenize (
    p_expression in varchar2)
return wwv_flow_global.vc_arr2;

function validate_comp_expression (
    p_token_list           in  wwv_flow_global.vc_arr2,
    p_valid_token_list     in  wwv_flow_global.vc_arr2,
    p_allow_literals       in  varchar2 default 'Y',
    p_invalid_token_return out varchar2)
return boolean;

function get_compute_sql (
    p_expression   in varchar2,
    p_columns_by_identifier  in wwv_flow_worksheet_standard.bind_arr)
return varchar2;

function get_compute_sql2 (
    p_worksheet_id in number,
    p_expression   in varchar2)
return varchar2;

function in_list (
    p_in_expr in varchar2)
return wwv_flow_global.vc_arr2;

function highlight_expr(
    p_val1 in varchar2,
    p_val2 in varchar2,
    p_expression_type in varchar2,
    p_highlight_rule in number)
return number;

end wwv_flow_worksheet_expr;
/