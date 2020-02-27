CREATE OR REPLACE package wwv_flow_theme_manager is

    empty_vc_arr wwv_flow_global.vc_arr2;

    procedure create_new_public_theme (
       p_workspace_id    in number,
       p_app_id          in number,
       p_app_theme_id    in number,
       p_theme_name      in varchar2,
       p_theme_number    in number,
       p_theme_desc      in varchar2 default null);

    function get_theme_image_icon (
       p_theme_id               in number,
       p_application_id         in number)
       return varchar2;

    procedure add_theme_to_application (
        p_application_id         in number,
        p_theme_number           in number,
        p_theme_id               in number default null);

    procedure delete_workspace_theme (
        p_id              in number);

    procedure delete_public_theme (
        p_id              in number);

    procedure change_workspace_theme (
        p_id              in number,
        p_theme_name      in varchar2,
        p_theme_number    in number,
        p_theme_desc      in varchar2 default null);

    procedure change_public_theme (
        p_id              in number,
        p_theme_name      in varchar2,
        p_theme_number    in number,
        p_theme_desc      in varchar2 default null);

    procedure create_new_workspace_theme (
        p_app_id          in number,
        p_app_theme_id    in number,
        p_theme_name      in varchar2,
        p_theme_number    in number,
        p_theme_desc      in varchar2 default null);

    function count_consolidation (
        p_application_id       in number,
        p_consolidate_from     in number default 0,
        p_consolidate_to       in number default 0,
        p_template_type        in varchar2 default null)
        return number;
    procedure consolidate_templates (
        p_application_id       in number,
        p_consolidate_from     in number default 0,
        p_consolidate_to       in number default 0,
        p_template_type        in varchar2 default null);
    procedure switch_theme(p_flow_id in number, p_to_theme in number);
    procedure switch_theme_defaults(p_flow_id in number, p_to_theme in number);
    procedure delete_theme(p_flow_id in number, p_theme_id in number, p_import in varchar2 default 'N');
    procedure renumber_theme(p_flow_id in number, p_to_theme in number, p_from_theme in number);
    procedure copy_theme(p_from_flow_id in number, p_to_flow_id in number, p_from_theme in number, p_to_theme in number);
    procedure initialize_flow(p_flow_id in number, p_to_theme in number);
    procedure set_globals(p_flow_id in number, p_to_theme in number default null);
    function  get_new_theme_id(p_flow_id in number) return number;
    function  get_button_postion(p_template_id in number, p_position in varchar2) return varchar2;
    procedure set_defaults(p_flow_id in number);
    function get_page_util(p_flow_id in number, p_id in number) return varchar2;
    function get_region_util(p_flow_id in number, p_id in number) return varchar2;
    function get_report_util(p_flow_id in number, p_id in number) return varchar2;
    function get_list_util(p_flow_id in number, p_id in number) return varchar2;
    function get_field_util(p_flow_id in number, p_id in number) return varchar2;
    function get_button_util(p_flow_id in number, p_id in number) return varchar2;
    function get_menu_util(p_flow_id in number, p_id in number) return varchar2;
    function get_cal_util(p_flow_id in number, p_id in number) return varchar2;

    procedure f4000_process_theme_image (
        p_id           in number   default null,
        p_THEME_IMAGE  in varchar2 default null,
        P_CUSTOM_IMAGE in varchar2 default null)
        ;
end;
/