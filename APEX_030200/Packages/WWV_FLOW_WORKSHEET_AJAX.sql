CREATE OR REPLACE package wwv_flow_worksheet_ajax as

type col_attr_t is record (
    db_column_name       varchar2(255),
    report_label         varchar2(255),
    column_type          varchar2(255),
    format_mask          varchar2(255),
    computation_expr_1   varchar2(4000));

type col_arr is table of col_attr_t index by binary_integer;

procedure sort_widget(
	p_worksheet_id in varchar2,
	p_app_user     in varchar2,
	p_report_id    in number,
	p_col			     in varchar2 default null,
	p_col_state    in varchar2 default null,
	p_filter		   in varchar2 default null
);

procedure uvalues(
	p_worksheet_id in varchar2,
	p_app_user     in varchar2,
	p_report_id    in number,
	p_col			     in varchar2 default null
);

procedure sort_widget_html(
    p_worksheet     in varchar2 default null,
    p_edit_link     in varchar2 default null);

procedure widget;

end wwv_flow_worksheet_ajax;
/