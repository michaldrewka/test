CREATE OR REPLACE package wwv_flow_templates_util
as
--  Copyright (c) Oracle Corporation 1999 - 2002. All Rights Reserved.
--
--    DESCRIPTION
--      Flow template rendering engine
--
--    SECURITY
--      Publicly executable
--
--    RUNTIME DEPLOYMENT: YES
--
--    NOTES
--      This program shows an html page header and footer.
--      Templates can have the following pound sign "#" based substitutions:
--      1. #TITLE#           -- HTML body title
--      2. #NAVIGATION_BAR#  -- Location of navigation Bar
--      3. #FORM_OPEN#       -- Opens HTML form used by flows
--      4. #FORM_CLOSE#      -- Closes HTML form opened
--      5. #SUCCESS_MESSAGE# -- If set by flow engine display here
--      Templates can also reference any flow variable using &VARIABLE syntax
--      Tab templates use #TAB_TEXT#
--


-------------------
-- Global Variables
--
g_template  number := null;


------------------------------------
-- Template Procedures and Functions
--

function get_template_id (
    p_template_name    in varchar2)
    return number
    ;

function get_page_template_name (
    p_template_id      in varchar2 default null)
    return varchar2
    ;

procedure fetch_tab_info (
    p_template_id      in number)
    ;

function get_header (
    p_template_name    in varchar2,
    p_page_title       in varchar2 default null)
    return varchar2
    ;

function get_footer (
    p_template_name    in varchar2)
    return varchar2
    ;

procedure copy_template (
    p_copy_from_flow_id  in number,
    p_flow_id            in varchar2,
    p_from_template_id   in number,
    p_to_theme_id        in number default null,
    p_to_template_name   in varchar2 default null,
    p_to_template_id     in number default null,
    p_show_errors        in boolean default true );

procedure copy_plug (
    p_copy_from_flow_id  in number,
    p_flow_id            in varchar2,
    p_from_template_id   in number,
    p_to_theme_id        in number default null,
    p_to_template_name   in varchar2 default null,
    p_to_template_id     in number default null,
    p_show_errors        in boolean default true)
    ;

procedure copy_row_template (
    p_copy_from_flow_id  in number,
    p_to_flow_id         in varchar2,
    p_from_template_id   in number,
    p_to_theme_id        in number default null,
    p_to_template_name   in varchar2 default null,
    p_to_template_id     in number default null,
    p_show_errors        in boolean default true)
    ;

procedure copy_list_template (
    p_copy_from_flow_id  in number,
    p_to_flow_id         in number,
    p_from_template_id   in number,
    p_to_theme_id        in number default null,
    p_to_template_name   in varchar2 default null,
    p_to_template_id     in number default null,
    p_show_errors        in boolean default true)
    ;

procedure copy_field_template (
    p_copy_from_flow_id  in number,
    p_flow_id            in varchar2,
    p_from_template_id   in number,
    p_to_theme_id        in number default null,
    p_to_template_name   in varchar2 default null,
    p_to_template_id     in number default null,
    p_show_errors        in boolean default true)
    ;

procedure copy_menu_template (
    p_copy_from_flow_id  in number,
    p_flow_id            in varchar2,
    p_from_template_id   in number,
    p_to_theme_id        in number default null,
    p_to_template_name   in varchar2 default null,
    p_to_template_id     in number default null,
    p_show_errors        in boolean default true)
    ;

procedure copy_button_template (
    p_copy_from_flow_id  in number,
    p_flow_id            in varchar2,
    p_from_template_id   in number,
    p_to_theme_id        in number default null,
    p_to_template_name   in varchar2 default null,
    p_to_template_id     in number default null,
    p_show_errors        in boolean default true)
    ;

procedure copy_calendar_template (
    p_copy_from_flow_id  in number,
    p_flow_id            in varchar2,
    p_from_template_id   in number,
    p_to_theme_id        in number default null,
    p_to_template_name   in varchar2 default null,
    p_to_template_id     in number default null,
    p_show_errors        in boolean default true)
    ;

procedure copy_popup_template (
    p_copy_from_flow_id  in number,
    p_flow_id            in varchar2,
    p_from_template_id   in number,
    p_to_theme_id        in number default null,
    p_to_template_name   in varchar2 default null,
    p_to_template_id     in number default null,
    p_show_errors        in boolean default true)
    ;

procedure set_user_template_preference (
    p_flow_id               in number,
    p_user_id               in varchar2,
    p_template_name         in varchar2 default null,
    p_printer_template_name in varchar2 default null)
    ;

function get_user_template_preference (
    p_flow_id               in number,
    p_user_id               in varchar2,
    p_template_type         in varchar2 default 'STANDARD')
    return varchar2
    ;

--------------------------------------------------------------------
-- utility functions for backward compatability and upgrade services
--

procedure set_page_template_names_2_ids (
    p_flow_id               in number,
    p_page_id               in number)
    ;

procedure set_page_region_names_2_ids (
    p_flow_id               in number,
    p_page_id               in number)
    ;

procedure replace_template (
    p_from_flow_id       in number,
    p_to_flow_id         in varchar2,
    p_from_template_id   in number,
    p_to_template_id     in number)
    ;

procedure replace_region_template (
    p_from_flow_id       in number,
    p_to_flow_id         in varchar2,
    p_from_template_id   in number,
    p_to_template_id     in number)
    ;

procedure replace_report_template (
    p_from_flow_id       in number,
    p_to_flow_id         in varchar2,
    p_from_template_id   in number,
    p_to_template_id     in number)
    ;

procedure replace_list_template (
    p_from_flow_id       in number,
    p_to_flow_id         in number,
    p_from_template_id   in number,
    p_to_template_id     in number)
    ;

procedure replace_field_template (
    p_from_flow_id       in number,
    p_to_flow_id         in varchar2,
    p_from_template_id   in number,
    p_to_template_id     in number)
    ;

procedure replace_menu_template (
    p_from_flow_id       in number,
    p_to_flow_id         in varchar2,
    p_from_template_id   in number,
    p_to_template_id     in number)
    ;

procedure replace_popup_lov_template (
    p_from_flow_id       in number,
    p_to_flow_id         in varchar2,
    p_from_template_id   in number,
    p_to_template_id     in number)
    ;

procedure replace_button_template (
    p_from_flow_id       in number,
    p_to_flow_id         in varchar2,
    p_from_template_id   in number,
    p_to_template_id     in number)
    ;

procedure replace_calendar_template (
    p_from_flow_id       in number,
    p_to_flow_id         in varchar2,
    p_from_template_id   in number,
    p_to_template_id     in number)
    ;

procedure page_template_popup_preview (
    p_flow               in number,
    p_template           in varchar2 default null,
    p_template_id        in number default null,
    p_passback           in varchar2 default null)
    ;

procedure list_template_sub_str (
    p_list_template_id in number default null)
    ;

procedure breadcrumb_template_sub_str (
    p_template_id   in number default null)
    ;

procedure label_template_sub_str (
    p_template_id in number default null)
    ;

procedure button_template_sub_str (
    p_template_id in number default null)
    ;

procedure page_template_utilization (
    p_flow_id      in number default null,
    p_template_id  in number default null)
    ;
end wwv_flow_templates_util;
/