CREATE OR REPLACE package wwv_flow_worksheet_form
as

function get_lov_query (
    p_worksheet_id      in number,
    p_column_id         in number default null,
    p_db_column_name    in varchar2 default null) return varchar2;

procedure form_navigation (
    p_worksheet_id     in number,
    p_app_user         in varchar2,
    p_pk               in varchar2 default null,
    p_base_report_id   in number   default null,
    p_init             in varchar2 default 'N',
    p_next_pk          out varchar2,
    p_prev_pk          out varchar2,
    p_row_cnt          out number,
    p_total_row_cnt    out number
    );

procedure show (
    p_flow_id            in number,
    p_worksheet_id       in number,
    p_app_user           in varchar2,
    p_row_id             in varchar2 default null,
    p_show_column_edit   in varchar2 default 'N',
    p_show_stickies      in varchar2 default 'Y',
    p_session            in number   default null,
    p_base_report_id     in number   default null,
	  p_style				       in varchar2 default 'REPLACE',
	  p_display_button_bar in varchar2 default 'Y'
    );

end wwv_flow_worksheet_form;
/