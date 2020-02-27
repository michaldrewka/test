CREATE OR REPLACE package wwv_flow_f4000_util
as

function validate_form_dbsource (
   p_mask         in varchar2 default null,
   p_app_id       in number   default null,
   p_page_id      in number   default null,
   p_item_type    in varchar2 default null,
   p_request      in varchar2 default null,
   p_source_type  in varchar2 default null)
   return varchar2
   ;

function validate_blob_mask (
   p_mask         in varchar2 default null,
   p_app_id       in number   default null)
   return varchar2
   ;

function get_next_app_page (
    p_request      in varchar2 default null,
    p_current_app  in number   default null,
    p_current_page in number   default null)
    return number
    ;

function get_build_opt_util
    return varchar2
    ;

procedure show_popup_images (
    p_image_size    in number   default null,
    p_show          in varchar2 default null)
    ;

function interactive_rpt_src_changed (
    p_flow_id    in number,
    p_region_id  in number,
    p_new_source in varchar2
    ) return boolean;

procedure save_interactive_rpt_region (
    p_region_id                in number,
    p_flow_id                  in number,
    p_plug_name                in varchar2 default null,
    p_region_name              in varchar2 default null,
    p_region_template          in number default null,
    p_display_seq              in number default null,
    p_display_column           in number default null,
    p_display_point            in varchar2 default null,
    p_region_source            in varchar2 default null,
    p_breadcrumb_template      in number default null,
    p_list_template            in number default null,
    p_region_display_error_msg in varchar2 default null,
    p_required_role            in varchar2 default null,
    p_display_when_cond        in varchar2 default null,
    p_display_when_cond2       in varchar2 default null,
    p_display_cond_type        in varchar2 default null,
    p_region_header            in varchar2 default null,
    p_region_footer            in varchar2 default null,
    p_region_column_width      in varchar2 default null,
    p_customized               in varchar2 default null,
    p_customized_name          in varchar2 default null,
    p_requied_patch            in number   default null,
    p_url_text_begin           in varchar2 default null,
    p_url_text_end             in varchar2 default null,
    p_translate_title          in varchar2 default null,
    p_comment                  in varchar2 default null);

procedure require_flow_id
   ;

procedure set_developer_preferences (
   p_set_view_mode in varchar2 default 'ICON',
   p_display       in varchar2 default '15')
   ;

-- for popup pages to implement help links
procedure show_help_link (
   p_lang           in varchar2 default null,
   p_session_id     in varchar2 default null,
   p_application_id in varchar2 default null,
   p_page_id        in varchar2 default null)
   ;

-- application level process
procedure set_flow_page
;

-- page 4000.602
procedure copy_list (
    p_copy_from_list_id   in number,
    p_new_list_name       in varchar2)
    ;

-- page 4000.663
procedure copy_list_from_app (
    p_copy_from_app_id    in number,
    p_copy_from_list_id   in number,
    p_new_list_name       in varchar2,
    p_new_application_id  in number)
    ;


-- 4000.4651
procedure show_list_source (
   p_list_id        in number,
   p_application_id in number,
   p_session        in number)
   ;

-- 4000.4651
procedure show_region_tree_source (
   p_application    in number,
   p_id             in number,
   p_session        in number)
   ;

-- 4000.819
procedure del_auth_scheme_conf (
   p_application_id    in number,
   p_id                in number)
   ;

-- 4000.500
procedure create_login_page (
    p_p500_page_id                     in varchar2 default null,
    p_fb_flow_id                       in varchar2 default null,
    p_p500_name                        in varchar2 default null,
    p_p500_template                    in varchar2 default null,
    p_fb_theme_id                      in varchar2 default null,
    p_p500_username                    in varchar2 default null,
    p_p500_password                    in varchar2 default null,
    p_p500_after_login_page            in varchar2 default null,
    p_p500_cookie                      in varchar2 default null,
    p_p500_usepage                     in varchar2 default null );

-- 4000.826
procedure CREATE_LOGIN_PAGE2 (
    P_FB_FLOW_ID                       in varchar2 default null,
    P_FB_THEME_ID                      in varchar2 default null,
    P_P826_LOGIN_PAGE                  in varchar2 default null );

-- 4000.826
procedure create_auth_setup;

-- 4000.12
procedure POPULATE_LINK_COL (
    P_P5_CREATE_JOINS                  in varchar2 default null,
    P_P4_MASTER_OWNER                  in varchar2 default null,
    P_P4_MASTER_TABLE                  in varchar2 default null,
    P_P5_DETAIL_OWNER                  in varchar2 default null,
    P_P5_DETAIL_TABLE                  in varchar2 default null );

-- 4000.327
procedure P327_CREATE_REPORT (
    p_f4000_p4701_tab_options          in varchar2 default null,
    p_f4000_p4701_tab_text             in varchar2 default null,
    p_f4000_p4701_tab_name             in varchar2 default null,
    p_fb_flow_id                       in varchar2 default null,
    p_f4000_p4701_flow_step_id         in varchar2 default null,
    p_f4000_p4701_page_name            in varchar2 default null,
    p_f4000_p4701_report_sql           in varchar2 default null,
    p_p4796_report_template            in varchar2 default null,
    p_f4000_p4701_tab_set              in varchar2 default null,
    p_f4000_p4701_plug_template        in varchar2 default null,
    p_f4000_p4701_plug_name            in varchar2 default null,
    p_f4000_p4701_plug_column          in varchar2 default null,
    p_f4000_p4701_max_rows             in varchar2 default null,
    p_f4000_p4701_rpt_type             in varchar2 default null,
    p_p4701_breadcrumb_id              in varchar2 default null,
    p_p4701_region_template            in varchar2 default null,
    p_p4701_breadcrumb_name            in varchar2 default null,
    p_p4701_display_point              in varchar2 default null,
    p_p4701_breadcrumb_template        in varchar2 default null,
    p_p4701_parent_id                  in varchar2 default null,
    p_f4000_p4795_query_options        in varchar2 default null,
    p_f4000_p4795_max_cols             in varchar2  default null,
    p_f4000_p4796_break_cols           in varchar2 default null,
    p_f4000_p4796_sorting              in varchar2 default null,
    p_f4000_p4796_csv_output           in varchar2 default null,
    p_f4000_p4796_csv_link_text        in varchar2 default null,
    p_f4000_p4796_print_output         in varchar2 default null,
    p_f4000_p4796_print_format         in varchar2 default null,
    p_f4000_p4796_print_label          in varchar2 default null,
    p_f4000_p4796_enable_search        in varchar2 default null,
    p_search_list                      in varchar2 default null);

procedure create_list_entry_as_copy (
   p_id           in number,
   p_list_id      in number,
   p_new_sequence in number,
   p_new_text     in varchar2);

procedure show_standard_images (
   p_icon_size     in varchar2 default '64',
   p_search        in varchar2 default null,
   p_current_image in varchar2 default null,
   p_columns       in number default 3,
   p_show          in varchar2 default 'STANDARD')
   ;

procedure show_workspace_images (
   p_search        in varchar2 default null,
   p_current_icon  in varchar2 default null,
   p_columns       in number default 3)
   ;
procedure show_application_images (
   p_search        in varchar2 default null,
   p_current_icon  in varchar2 default null,
   p_columns       in number default 3)
   ;

function is_valid_chart_query (
    p_flow_id            in number,
    p_security_group_id  in number,
    p_query              in varchar2
  ) return varchar2;

function is_valid_dial_chart_query (
    p_flow_id            in number,
    p_security_group_id  in number,
    p_query              in varchar2
  ) return varchar2;

function is_valid_lov_query (
    p_query varchar2
) return boolean;

function check_plsql (
    p_sql               in varchar2,
    p_flow_id           in number,
    p_security_group_id in number
) return varchar2;

procedure run_block
     ( p_sql       in varchar2,
       p_user      in varchar2,
       p_use_roles in boolean default FALSE);

function select_num( p_sql in varchar2, p_user in varchar2 ) return number;

procedure run_ddl
     ( p_sql    in sys.dbms_sql.varchar2s,
       p_user   in varchar2 );

function countem( p_sql in varchar2,
                  p_user in varchar2 ) return varchar2;

end wwv_flow_f4000_util;
/