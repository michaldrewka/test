CREATE OR REPLACE package wwv_flow_worksheet_ui
as
procedure show_folders (
    p_display           in number,
    p_application_id    in number,
    p_current_page      in number,
    p_session           in number,
    p_search            in varchar2 default null,
    p_folder_id         in number default null,
    p_first_row         in number default 1,
    p_icons_per_row     in number default 5,
    p_show_icons        in varchar2 default null)
    ;

procedure show_breadcrumb (
    p_application_id    in number,
    p_current_page      in number,
    p_session           in number,
    p_folder_id         in number default null
    );

end wwv_flow_worksheet_ui;
/