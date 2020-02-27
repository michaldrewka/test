CREATE OR REPLACE package wwv_flow_theme_globals
as

    g_theme_id                    number;
    -- page
    g_default_page_template       number;
    g_error_template              number;
    g_printer_friendly_template   number;
    g_breadcrumb_display_point    varchar2(2000);
    g_sidebar_display_point       varchar2(2000);
    g_login_template              number;
    -- region
    g_default_button_template     number;
    g_default_region_template     number;
    g_default_chart_template      number;
    g_default_form_template       number;
    g_default_reportr_template    number;
    g_default_tabform_template    number;
    g_default_wizard_template     number;
    g_default_menur_template      number;
    g_default_listr_template      number;
    --row/report
    g_default_report_template     number;
    -- field/label
    g_default_label_template      number;
    -- menu
    g_default_menu_template       number;
    -- calendar
    g_default_calendar_template   number;
    -- lists
    g_default_list_template       number;
    g_default_option_label        number;
    g_default_required_label      number;
    -- list globals
    g_default_chart_list          number;
    g_default_report_list         number;
    g_default_ul_wo_bullet_list   number;
    --
    g_default_breadcrumb_region   number;

    g_default_sb_page_template    number;
    g_default_sb_region_template  number;
    g_default_sb_nav_template     number;

end wwv_flow_theme_globals;
/