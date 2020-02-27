CREATE OR REPLACE package wwv_flow_wiz_confirm as
--  Copyright (c) Oracle Corporation 2006-2007. All Rights Reserved.
--
--    DESCRIPTION
--     This package displays wizard confirmation pages.
--
--
--    SECURITY
--      No grants, must be run as FLOW schema owner.
--

procedure copy_application (
    p_old_app_id      in number default null,
    p_old_app_name    in varchar2 default null,
    p_new_app_id      in number default null,
    p_new_app_name    in varchar2 default null,
    p_copy_deployment in varchar2 default 'N'
    );

procedure create_application (
    p_application_id      in number default null,
    p_application         in varchar2 default null,
    p_application_name    in varchar2 default null,
    p_schema              in varchar2 default null,
    p_language            in varchar2 default null,
    p_authentication      in varchar2 default null,
    p_create_tabs         in varchar2 default null,
    p_shared_components   in varchar2 default null,
    p_copy_options        in varchar2 default null,
    p_theme               in varchar2 default null,
    p_theme_id            in number default null);

procedure create_form_on_ws_rpt (
    p_flow_id            in number default null,
    p_region_template    in number default null,
    p_region_template2   in number default null,
    p_report_template    in number default null,
    p_page_id            in number default null,
    p_page_name          in varchar2 default null,
    p_tab_set            in varchar2 default null,
    p_tab_text           in varchar2 default null,
    p_region_name        in varchar2 default null,
    p_region_name2       in varchar2 default null,
    p_ws_id              in number default null,
    p_operation_id       in number default null,
    p_collection_name    in varchar2 default null,
    p_array              in number default null);

procedure create_standard_tab (
    p_flow_id                      in number default null,
    p_new_parent_tabset            in varchar2 default null,
    p_new_parent_tab_text          in varchar2 default null,
    p_parent_tab_set               in varchar2 default null,
    p_tab_set_choice               in varchar2 default null,
    p_tab_set                      in varchar2 default null,
    p_new_tab_display_text         in varchar2 default null,
    p_tab_sequence                 in varchar2 default null,
    p_current_page                 in varchar2 default null,
    p_current_image                in varchar2 default null,
    p_non_current_page             in varchar2 default null,
    p_image_attributes             in varchar2 default null,
    p_display_condition            in varchar2 default null,
    p_condition_type               in varchar2 default null,
    p_display_condition_text       in varchar2 default null,
    p_build_option                 in varchar2 default null);


procedure create_acl (
    p_flow_id     in number default null,
    p_page_id     in number default null,
    p_tab_options in varchar2 default null,
    p_tab_set     in varchar2 default null,
    p_tab_name    in varchar2 default null,
    p_tab_text    in varchar2 default null);


procedure create_query_and_update (
    p_flow_id            in number default null,
    p_columns            in varchar2 default null,
    p_rpt_select_list   in varchar2 default null,
    p_insert             in varchar2 default null,
    p_update             in varchar2 default null,
    p_delete             in varchar2 default null,
    p_rpt_page_id        in number default null,
    p_rpt_page_name      in varchar2 default null,
    p_rpt_implementation in varchar2 default null,
    p_rpt_tab_set        in varchar2 default null,
    p_rpt_tab_text       in varchar2 default null,
    p_form_page_id       in number default null,
    p_form_page_name     in varchar2 default null,
    p_table_owner        in varchar2 default null,
    p_table_name         in varchar2 default null,
    p_pk1                in varchar2 default null,
    p_pk2                in varchar2 default null,
    p_where_clause       in varchar2 default null);

procedure create_tree (
    p_flow_id          in number default null,
    p_region_template  in number default null,
    p_start_option     in varchar2 default null,
    p_owner            in varchar2 default null,
    p_table_name       in varchar2 default null,
    p_id               in varchar2 default null,
    p_pid              in varchar2 default null,
    p_name             in varchar2 default null,
    p_link_option      in varchar2 default null,
    p_link_page_id     in number default null,
    p_link_item        in varchar2 default null,
    p_where            in varchar2 default null,
    p_order_by         in varchar2 default null,
    p_page_id          in number default null,
    p_page_name        in varchar2 default null,
    p_tab_set          in varchar2 default null,
    p_tab_text         in varchar2 default null,
    p_region_name      in varchar2 default null,
    p_tree_name        in varchar2 default null,
    p_tree_type        in varchar2 default null,
    p_max_levels       in number default null);

procedure create_structured_report (
    p_flow_id         in number default null,
    p_report_template in number default null,
    p_region_template in number default null,
    p_sorting         in varchar2 default null,
    p_page_id         in number default null,
    p_page_name       in varchar2 default null,
    p_region_name     in varchar2 default null,
    p_tab_set         in varchar2 default null,
    p_tab_text        in varchar2 default null);

procedure  create_demo_app (
    p_schema   in varchar2 default null,
    p_demo_app in varchar2 default null);

procedure create_sql_report (
    p_flow_id         in number default null,
    p_page_id         in number default null,
    p_region_template in number default null,
    p_report_template in number default null,
    p_tab_set         in varchar2 default null,
    p_tab_name        in varchar2 default null,
    p_tab_text        in varchar2 default null,
    p_region_name     in varchar2 default null,
    p_region_column   in varchar2 default null,
    p_col_headings    in varchar2 default null,
    p_max_columns     in varchar2 default null,
    p_max_rows        in varchar2 default null,
    p_break_cols      in varchar2 default null,
    p_csv_output      in varchar2 default null,
    p_csv_text        in varchar2 default null,
    p_print_output    in varchar2 default null,
    p_print_label     in varchar2 default null,
    p_print_format    in varchar2 default null,
    p_enable_sorting  in varchar2 default null,
    p_enable_search   in varchar2 default null);

procedure create_page (
    p_flow_id              in number default null,
    p_page_id              in number default null,
    p_page_name            in varchar2 default null,
    p_page_title           in varchar2 default null,
    p_new_parent_tabset    in varchar2 default null,
    p_new_parent_tab_text  in varchar2 default null,
    p_parent_tabset        in varchar2 default null,
    p_tab_set_choice       in varchar2 default null,
    p_tab_set              in varchar2 default null,
    p_new_tab_display_text in varchar2 default null,
    p_current_tab          in varchar2 default null);

procedure create_page_zero (
    p_flow_id              in number default null) ;

procedure copy_page_other_app (
    p_flow_id_from         in number default null,
    p_page_id_from         in number default null,
    p_flow_id_to           in number default null,
    p_page_id_to           in number default null,
    p_page_name_to         in varchar2 default null,
    --
    p_new_parent_tabset    in varchar2 default null,
    p_new_parent_tab_text  in varchar2 default null,
    p_parent_tab_set       in varchar2 default null,
    p_tab_set_choice       in varchar2 default null,
    p_tabset               in varchar2 default null,
    p_new_tab_display_text in varchar2 default null,
    p_breadcrumb_id        in number default null,
    p_breadcrumb_name      in varchar2 default null,
    p_parent_breadcrumb    in varchar2 default null
    );
procedure create_form_on_table (
    p_flow_id         in number default null,
    p_page_id         in number default null,
    p_page_name       in varchar2 default null,
    p_columns         in varchar2 default null,
    p_region_template in number default null,
    p_insert          in varchar2 default null,
    p_update          in varchar2 default null,
    p_delete          in varchar2 default null,
    p_tab_set         in varchar2 default null,
    p_tab_text        in varchar2 default null,
    p_region_name     in varchar2 default null,
    p_schema          in varchar2 default null,
    p_table_name      in varchar2 default null,
    p_pk1             in varchar2 default null,
    p_pk2             in varchar2 default null);

procedure create_wizard (
    p_flow_id              in number default null,
    p_region_template      in number default null,
    p_info_region          in varchar2 default null,
    p_info_region_template in number default null,
    p_default_info_text    in varchar2 default null,
    p_cancel               in varchar2 default null,
    p_finish               in varchar2 default null,
    p_previous             in varchar2 default null,
    p_next                 in varchar2 default null,
    p_cancel_branch        in varchar2 default null,
    p_finish_branch        in varchar2 default null);

procedure create_breadcrumb_region (
    p_flow_id         in number default null,
    p_page_id         in number default null,
    p_region_type     in varchar2 default null,
    p_region_template in number default null,
    p_menu_template   in number default null,
    p_menu_template2  in number default null,
    p_parent_menu     in number default null,
    p_menu_text       in varchar2 default null,
    p_display_point   in varchar2 default null);

procedure copy_page (
    p_flow_id              in number default null,
    p_new_parent_tabset    in varchar2 default null,
    p_new_parent_tab_text  in varchar2 default null,
    p_parent_tab_set       in varchar2 default null,
    p_tab_set_choice       in varchar2 default null,
    p_tabset               in varchar2 default null,
    p_new_tab_display_text in varchar2 default null,
    p_copy_to_page_id      in number default null,
    p_copy_to_page_name    in varchar2 default null);

procedure create_auth_scheme (
    p_invalid_sess_target     in varchar2 default null,
    p_invalid_session_url     in varchar2 default null,
    p_invalid_session_page    in varchar2 default null,
    p_name                    in varchar2 default null,
    p_pg_sentry_function      in varchar2 default null,
    p_session_verify_function in varchar2 default null,
    p_pre_auth_process        in varchar2 default null,
    p_auth_type               in varchar2 default null,
    p_auth_function           in varchar2 default null,
    p_ldap_host               in varchar2 default null,
    p_ldap_port               in varchar2 default null,
    p_ldap_string             in varchar2 default null,
    p_ldap_username_edit      in varchar2 default null,
    p_post_auth_process       in varchar2 default null,
    p_cookie_name             in varchar2 default null,
    p_cookie_path             in varchar2 default null,
    p_cookie_domain           in varchar2 default null,
    p_use_secure_cookie_yn    in varchar2 default null,
    p_logout_url              in varchar2 default null);

procedure regular_exp;

procedure create_master_detail (
    p_flow_id      in number default null,
    p_master_owner in varchar2 default null,
    p_master_table in varchar2 default null,
    p_detail_owner in varchar2 default null,
    p_detail_table in varchar2 default null,
    p_master_sort  in varchar2 default null,
    p_tab_set      in varchar2 default null,
    p_tab_text     in varchar2 default null,
    p_layout       in varchar2 default null,
    p_include_master_rpt in varchar2 default 'Y');

procedure create_form_on_ws (
    p_flow_id            in number default null,
    p_region_template_id in number default null,
    p_page_id            in number default null,
    p_page_name          in varchar2 default null,
    p_tab_set            in varchar2 default null,
    p_tab_text           in varchar2 default null,
    p_region_name        in varchar2 default null,
    p_ws_id              in number default null,
    p_operation_id       in number default null);

procedure create_html_chart (
    p_flow_id     in number default null,
    p_region_id   in number default null,
    p_page_id     in number default null,
    p_page_name   in varchar2 default null,
    p_tab_set     in varchar2 default null,
    p_tab_text    in varchar2 default null,
    p_region_name in varchar2 default null,
    p_chart_sql   in varchar2 default null,
    p_axis        in varchar2 default null,
    p_scale       in varchar2 default null,
    p_chart_type  in varchar2 default null,
    p_num_mask    in varchar2 default null);

procedure create_monthly_calendar (
    p_flow_id     in number default null,
    p_region_id   in number default null,
    p_page_id     in number default null,
    p_page_name   in varchar2 default null,
    p_tab_set     in varchar2 default null,
    p_tab_text    in varchar2 default null,
    p_region_name in varchar2 default null,
    p_owner       in varchar2 default null,
    p_table       in varchar2 default null,
    p_date_col    in varchar2 default null,
    p_display     in varchar2 default null,
    p_select_rpt_type in varchar2 default null,
    p_display_type in varchar2 default null);

procedure create_tabular_form (
    p_flow_id      in number default null,
    p_page_id      in number default null,
    p_page_name    in varchar2 default null,
    p_region_title in varchar2 default null,
    p_tab_set      in varchar2 default null,
    p_tab_text     in varchar2 default null,
    p_owner        in varchar2 default null,
    p_table_name   in varchar2 default null,
    p_pk1          in varchar2 default null,
    p_pk2          in varchar2 default null,
    p_columns      in varchar2 default null,
    p_upd_cols     in varchar2 default null);

procedure delete_list_region_warning (
    p_flow_id            in number default null,
    p_session_id         in number default null,
    p_region_id          in number default null,
    p_region_source_type in varchar2 default null);

procedure create_form_on_sp (
    p_flow_id            in number default null,
    p_page_id            in number default null,
    p_page_name          in varchar2 default null,
    p_tab_set            in varchar2 default null,
    p_tab_text           in varchar2 default null,
    p_region_template_id in number default null,
    p_region_name        in varchar2 default null,
    p_owner              in varchar2 default null,
    p_procedure          in varchar2 default null);

procedure create_svg_chart (
    p_flow_id         in number default null,
    p_page_id         in number default null,
    p_page_name       in varchar2 default null,
    p_region_template in number default null,
    p_region_name     in varchar2 default null,
    p_tab_set         in varchar2 default null,
    p_tab_text        in varchar2 default null,
    p_chart_type      in varchar2 default null);

procedure create_flash_chart (
    p_flow_id         in number default null,
    p_page_id         in number default null,
    p_page_name       in varchar2 default null,
    p_region_template in number default null,
    p_region_name     in varchar2 default null,
    p_tab_set         in varchar2 default null,
    p_tab_text        in varchar2 default null,
    p_chart_type      in varchar2 default null);

procedure create_form_on_query (
    p_flow_id         in number default null,
    p_page_id         in number default null,
    p_page_name       in varchar2 default null,
    p_tab_set         in varchar2 default null,
    p_tab_text        in varchar2 default null,
    p_region_template in number default null,
    p_region_name     in varchar2 default null,
    p_query           in varchar2 default null);

procedure select_rpt_template (
    p_theme         in number default null,
    p_checked_items in varchar2 default null);

procedure create_summary_page (
    p_flow_id         in number default null,
    p_page_id         in number default null,
    p_page_name       in varchar2 default null,
    p_tab_set         in varchar2 default null,
    p_tab_text        in varchar2 default null,
    p_region_name     in varchar2 default null,
    p_region_template in varchar2 default null);

procedure migrate_svg_to_flash (
    p_flow_id         in number,
    p_page_id         in number,
    p_region_id       in number);
procedure structured_query_condition;

procedure create_dynamic_query (
    p_flow_id         in number default null,
    p_page_id         in number default null,
    p_page_name       in varchar2 default null,
    p_region_template in number default null,
    p_region_name     in varchar2 default null,
    p_tab_set         in varchar2 default null,
    p_tab_name        in varchar2 default null,
    p_tab_text        in varchar2 default null);

procedure change_interactive_rpt_region (
    p_flow_id         in number,
    p_region_id       in number,
    p_region_source   in varchar2 default null);
end wwv_flow_wiz_confirm;
/