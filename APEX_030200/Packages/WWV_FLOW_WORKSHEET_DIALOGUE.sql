CREATE OR REPLACE package wwv_flow_worksheet_dialogue
as

function get_valid_sql_functions return wwv_flow_global.vc_arr2;

procedure show_format_mask (
    p_worksheet_id in number,
    p_app_user     in varchar2,
    p_report_id    in varchar2);

procedure show_column_list (
    p_worksheet_id in number,
    p_app_user     in varchar2,
    p_report_id    in varchar2,
    p_column_type  in varchar2 default null);

procedure show_select_columns (
    p_worksheet_id in number,
    p_app_user     in varchar2,
    p_report_id    in varchar2);

procedure save_column_list (
    p_worksheet_id in number,
    p_app_user     in varchar2,
    p_report_id    in varchar2,
    p_column_list  in wwv_flow_global.vc_arr2);

procedure show_highlight (
    p_worksheet_id in number,
    p_app_user     in varchar2,
    p_report_id    in number,
    p_condition_id in varchar2 default null);

procedure show_filter (
    p_worksheet_id in number,
    p_app_user     in varchar2,
    p_report_id    in number,
    p_condition_id in varchar2 default null);

procedure show_ordering (
    p_worksheet_id in number,
    p_app_user     in varchar2,
    p_report_id    in number);

procedure show_save (
    p_worksheet_id in number,
    p_app_user     in varchar2,
    p_report_id    in number,
    p_save_type    in varchar2 default 'SAVE');

procedure show_save_default (
    p_worksheet_id in number,
    p_app_user     in varchar2,
    p_report_id    in number);

procedure show_chart (
    p_worksheet_id in number,
    p_app_user     in varchar2,
    p_report_id    in number);

procedure show_calendar (
    p_worksheet_id in number,
    p_app_user     in varchar2,
    p_report_id    in number);

procedure show_delete (
    p_worksheet_id in number,
    p_app_user     in varchar2,
    p_report_id    in number);

procedure show_aggregate (
    p_worksheet_id in number,
    p_app_user     in varchar2,
    p_report_id    in number,
    p_aggregate    in varchar2 default null);

procedure show_flashback (
    p_worksheet_id in number,
    p_app_user     in varchar2,
    p_report_id    in number);

procedure show_reset (
    p_worksheet_id in number,
    p_app_user     in varchar2,
    p_report_id    in number);

procedure show_computation (
    p_worksheet_id   in number,
    p_app_user       in varchar2,
    p_report_id      in number,
    p_computation_id in varchar2 default null);

procedure show_download (
    p_worksheet_id in number,
    p_app_user     in varchar2,
    p_report_id    in number);

procedure show_control_break (
    p_worksheet_id in number,
    p_app_user     in varchar2,
    p_report_id    in number);
end  wwv_flow_worksheet_dialogue;
/