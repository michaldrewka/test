CREATE OR REPLACE package wwv_flow_item_help
as

procedure show_help(
    p_item_id           in varchar2 default null,
    p_session           in varchar2 default null,
    p_close_button_name in varchar2 default 'Close',
    p_title_bgcolor     in varchar2 default '#cccccc;',
    p_page_bgcolor      in varchar2 default '#FFFFFF')
    ;
end;
/