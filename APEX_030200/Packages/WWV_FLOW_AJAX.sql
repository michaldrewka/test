CREATE OR REPLACE package wwv_flow_ajax as

empty_vc_arr wwv_flow_global.vc_arr2;

type col_attr_t is record (
    db_column_name       varchar2(255),
    report_label         varchar2(255),
    column_type          varchar2(255),
    format_mask          varchar2(255),
    computation_expr_1   varchar2(4000));

type col_arr is table of col_attr_t index by binary_integer;

function json_replace(
    p_text     in varchar2 default null
)return varchar2;

procedure json_from_array (
    p_rows   in number default null,
    p_cols   in number default null,
    p_name01 in varchar2 default null,
    p_name02 in varchar2 default null,
    p_name03 in varchar2 default null,
    p_name04 in varchar2 default null,
    p_name05 in varchar2 default null,
    p_name06 in varchar2 default null,
    p_name07 in varchar2 default null,
    p_name08 in varchar2 default null,
    p_name09 in varchar2 default null,
    p_name10 in varchar2 default null,
    p_f01    in wwv_flow_global.vc_arr2 default wwv_flow.empty_vc_arr,
    p_f02    in wwv_flow_global.vc_arr2 default wwv_flow.empty_vc_arr,
    p_f03    in wwv_flow_global.vc_arr2 default wwv_flow.empty_vc_arr,
    p_f04    in wwv_flow_global.vc_arr2 default wwv_flow.empty_vc_arr,
    p_f05    in wwv_flow_global.vc_arr2 default wwv_flow.empty_vc_arr,
    p_f06    in wwv_flow_global.vc_arr2 default wwv_flow.empty_vc_arr,
    p_f07    in wwv_flow_global.vc_arr2 default wwv_flow.empty_vc_arr,
    p_f08    in wwv_flow_global.vc_arr2 default wwv_flow.empty_vc_arr,
    p_f09    in wwv_flow_global.vc_arr2 default wwv_flow.empty_vc_arr,
    p_f10    in wwv_flow_global.vc_arr2 default wwv_flow.empty_vc_arr,
    p_sub    in varchar2 default 'N');

procedure sort_widget_html(
	p_worksheet     in varchar2 default null,
	p_col			in varchar2 default null,
	p_col_state     in varchar2 default null,
	p_filter		in varchar2 default null
);

procedure json_from_sql (
    sqlq     in varchar2 default null,
    p_sub    in varchar2 default 'N',
    p_owner  in varchar2 default null,
    p_do_worksheet_binds in varchar2 default 'N',
    p_aliases in wwv_flow_global.vc_arr2 default empty_vc_arr
);

procedure json_from_items(
    p_items      in varchar2 default null,
    p_separator  in varchar2 default ':',
    p_sub        in varchar2 default 'N'
);

procedure json_from_string(
    p_items      in varchar2 default null,
    p_separator  in varchar2 default ':',
    p_sub        in varchar2 default 'N'
);
/*
procedure sort_widget_html(
	p_worksheet     in varchar2 default null,
	p_col			in varchar2 default null,
	p_col_state     in varchar2 default null,
	p_filter		in varchar2 default null
);
*/
procedure print_widget_debug;

procedure ajax_collection(
	p_collection    in varchar2 default null,
	p_action		in varchar2 default null,
	p_format		in varchar2 default null,
	p_item			in varchar2 default null
);

procedure widget;

end wwv_flow_ajax;
/