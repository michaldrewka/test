CREATE OR REPLACE package wwv_flow_api
as

--
empty_vc_arr        wwv_flow_global.vc_arr2;
g_raise_errors      boolean := false;
g_id_offset         number := 0;
g_nls_numeric_chars varchar2(8);


-- Valid modes:
--   CREATE  - only insert
--   REMOVE  - only delete
--   REPLACE - delete and insert
g_mode              varchar2(255) := 'CREATE';

---------------------
-- Compatable Version
-- format: YYYY.MM.DD of most recent build which changed inputs
-- set this to the last schema change date
--
-- *** NOTE ***  The corresponding date in flows_version.sql will need
--               to be modified if this version is changed
--
g_compatable_from_version     varchar2(255) := '2009.01.12';
g_compatible_from_version_30  varchar2(255) := '2007.01.08';
g_compatible_from_version_301 varchar2(255) := '2007.05.25';
g_compatible_from_version_31  varchar2(255) := '2007.09.06';
g_is_compatable               boolean       := true;
g_new_theme_id                number        := null;

empty_varchar2_table          dbms_sql.varchar2_table;
g_varchar2_table              dbms_sql.varchar2_table;
g_list_contents_only          boolean := false;
g_import_script_files         wwv_flow_global.vc_arr2;
g_import_script_status        wwv_flow_global.vc_arr2;
g_fnd_user_password_action    boolean := false;
--
--
--
procedure check_sgid;
procedure check_version;

--
-- S E T   V E R S I O N
--
procedure set_version (
    --
    -- This call is expected to be made before running and procedure within wwv_flow_api.
    -- You are expected to inform the flows API which version of flows created your export.
    -- All flow versions are in the form YYYY.MM.DD.
    -- No API calls will work if the versions are incompatable.
    -- An incompatable version is defined as the wwv_flow_api.g_compatable_from_version
    -- (a static plsql package global that indicates from which date this api is good from)
    -- is less then or equal to the calling version passed to this procedure.
    --
    p_version_yyyy_mm_dd in varchar2,
    p_debug              in varchar2 default 'YES')
    ;

--
-- R E M O V E
--
procedure remove_flow (
    --
    -- This procedure deletes a row from the wwv_flows table
    -- which then cascades to all subordinate flow objects.
    -- Running this procedure removes all flow meta data for
    -- a single flow.
    --
    p_id                        in number   default null)
    ;
procedure remove_page (
    --
    -- This procedure deletes a row from the pages table
    -- which then cascades to delete all subordinate meta
    -- data.
    --
    p_flow_id                   in number   default null,
    p_page_id                   in number   default null)
    ;

-------------------------------------------------
-- C R E A T E   F L O W   A T T R I B U T E S --
-------------------------------------------------

--
-- F L O W
--
procedure create_flow (
    --
    -- This procedure creates the description of a flow.
    -- A flow is made up of zero or more pages as well as
    -- other "flow level" attributes.
    --
    -- obsolete attributes
    --   P_SECURITY_GROUP_ID (derived from "set credentials" call)
    --   P_WEBDB_TEMPLATE (included for compatability replaced with p_default_page_template)
    --   P_WEBDB_LOGGING (included for compatability replaced with p_page_view_logging)
    --   P_PAGE_RANGE_MINIMUM (included so old flows will still create)
    --   P_PAGE_RANGE_MAXIMUM (included so old flows will still create)
    --
    -- new arguments not yet implemented
    --   P_GLOBAL_ID (will allow alternate flow ID reference... a synonym for a flow ID)


    p_id                        in number   default null,
    p_security_group_id         in number   default null, -- obsolete
    p_display_id                in number   default null,
    p_owner                     in varchar2 default null,
    p_name                      in varchar2 default null,
    p_alias                     in varchar2 default null,
    p_webdb_template            in varchar2 default null, -- obsolete
    p_default_page_template     in number   default null,
    p_home_link                 in varchar2 default null,
    p_box_width                 in varchar2 default null,
    p_webdb_logging             in varchar2 default null, -- obsolete
    p_page_view_logging         in varchar2 default null,
    p_flow_language             in varchar2 default null,
    p_flow_language_derived_from in varchar2 default null,
    p_date_format               in varchar2 default null,
    p_flow_image_prefix         in varchar2 default null,
    p_media_type                in varchar2 default null,
    p_printer_friendly_template in number   default null,
    p_default_region_template   in number   default null,
    p_default_label_template    in number   default null,
    p_default_report_template   in number   default null,
    p_default_list_template     in number   default null,
    p_default_menu_template     in number   default null,
    p_default_button_template   in number   default null,
    p_error_template            in number   default null,
    --
    p_default_chart_template    in number   default null,
    p_default_form_template     in number   default null,
    p_default_wizard_template   in number   default null,
    p_default_tabform_template  in number   default null,
    p_default_reportr_template  in number   default null,
    p_default_menur_template    in number   default null,
    p_default_listr_template    in number   default null,
    --
    p_theme_id                  in number   default null,
    p_application_group         in number   default null,
    p_application_group_name    in varchar2 default null,
    p_application_group_comment in varchar2 default null,
    --
    p_documentation_banner      in varchar2 default null,
    p_authentication            in varchar2 default null,
    p_login_url                 in varchar2 default null,
    p_logout_url                in varchar2 default null,
    p_logo_image                in varchar2 default null,
    p_logo_image_attributes     in varchar2 default null,
    p_public_url_prefix         in varchar2 default null,
    p_public_user               in varchar2 default null,
    p_dbauth_url_prefix         in varchar2 default null,
    p_proxy_server              in varchar2 default null,
    p_cust_authentication_process in varchar2 default null,
    p_cust_authentication_page  in varchar2 default null,
    p_custom_auth_login_url     in varchar2 default null,
    p_flow_version              in varchar2 default null,
    p_page_range_minimum        in number   default null, -- obsolete; not in wwv_flows table
    p_page_range_maximum        in number   default null, -- obsolete; not in wwv_flows table
    p_flow_status               in varchar2 default null,
    p_flow_unavailable_text     in varchar2 default null,
    p_restrict_to_user_list     in varchar2 default null,
    p_build_status              in varchar2 default null,
    p_exact_substitutions_only  in varchar2 default null,
    p_vpd                       in varchar2 default null,
    p_security_scheme           in varchar2 default null,
    p_application_tab_set       in number   default null, -- obsolete; reused for debugging flag
    p_rejoin_existing_sessions  in varchar2 default null,
    p_substitution_string_01    in varchar2 default null,
    p_substitution_value_01     in varchar2 default null,
    p_substitution_string_02    in varchar2 default null,
    p_substitution_value_02     in varchar2 default null,
    p_substitution_string_03    in varchar2 default null,
    p_substitution_value_03     in varchar2 default null,
    p_substitution_string_04    in varchar2 default null,
    p_substitution_value_04     in varchar2 default null,
    p_substitution_string_05    in varchar2 default null,
    p_substitution_value_05     in varchar2 default null,
    p_substitution_string_06    in varchar2 default null,
    p_substitution_value_06     in varchar2 default null,
    p_substitution_string_07    in varchar2 default null,
    p_substitution_value_07     in varchar2 default null,
    p_substitution_string_08    in varchar2 default null,
    p_substitution_value_08     in varchar2 default null,
    p_substitution_string_09    in varchar2 default null,
    p_substitution_value_09     in varchar2 default null,
    p_substitution_string_10    in varchar2 default null,
    p_substitution_value_10     in varchar2 default null,
    p_substitution_string_11    in varchar2 default null,
    p_substitution_value_11     in varchar2 default null,
    p_substitution_string_12    in varchar2 default null,
    p_substitution_value_12     in varchar2 default null,
    p_substitution_string_13    in varchar2 default null,
    p_substitution_value_13     in varchar2 default null,
    p_substitution_string_14    in varchar2 default null,
    p_substitution_value_14     in varchar2 default null,
    p_substitution_string_15    in varchar2 default null,
    p_substitution_value_15     in varchar2 default null,
    p_substitution_string_16    in varchar2 default null,
    p_substitution_value_16     in varchar2 default null,
    p_substitution_string_17    in varchar2 default null,
    p_substitution_value_17     in varchar2 default null,
    p_substitution_string_18    in varchar2 default null,
    p_substitution_value_18     in varchar2 default null,
    p_substitution_string_19    in varchar2 default null,
    p_substitution_value_19     in varchar2 default null,
    p_substitution_string_20    in varchar2 default null,
    p_substitution_value_20     in varchar2 default null,
    p_required_roles            in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_global_notification       in varchar2 default null,
    p_global_id                 in number   default null,
    p_charset                   in varchar2 default null,
    p_page_protection_enabled_y_n in varchar2 default null,
    p_checksum_salt             in raw      default null,
    p_checksum_salt_last_reset  in varchar2 default null,
    p_csv_encoding              in varchar2 default null,
    p_max_session_length_sec    in number   default 28800,
    p_on_max_session_timeout_url in varchar2 default null,
    p_max_session_idle_sec      in number    default null,
    p_on_max_idle_timeout_url   in varchar2  default null,
    --
    p_last_updated_by           in varchar2 default null,
    p_last_upd_yyyymmddhh24miss in varchar2 default null,
    p_id_offset                 in number   default 0,
    p_target                    in varchar2 default 'PRIME')
    ;

procedure set_application_name (
    p_flow_id                   in number default null,
    p_name                      in varchar2 default null)
    ;
procedure set_application_alias (
    p_flow_id                   in number default null,
    p_alias                     in varchar2 default null)
    ;
procedure set_exact_subs (
    p_flow_id                   in number default null,
    p_exact_substitutions       in varchar2 default null)
    ;
procedure set_security_scheme (
    p_flow_id                   in number default null,
    p_security_scheme           in varchar2 default null)
    ;
procedure set_proxy_server (
    p_flow_id                   in number default null,
    p_proxy_server              in varchar2 default null)
    ;
procedure set_page_prot_enabled_y_n (
    p_flow_id                   in number default null,
    p_page_protection           in varchar2 default null)
    ;
procedure set_vpd (
    p_flow_id                   in number default null,
    p_vpd                       in varchar2 default null)
    ;
procedure set_application_lock (
    p_flow_id                   in number default null,
    p_locked_by                 in varchar2 default null)
    ;

procedure set_enable_app_debugging (
    p_flow_id                   in number default null,
    p_debugging                 in varchar2 default null)
    ;
procedure set_home_link (
    p_flow_id                   in number default null,
    p_home_link                 in varchar2 default null)
    ;
procedure set_global_notification (
    p_flow_id                   in number default null,
    p_global_notification       in varchar2 default null)
    ;
procedure set_flow_authentication (
    p_flow_id                   in number default null,
    p_authentication            in varchar2 default null)
    ;
procedure set_logout_url (
    p_flow_id                   in number default null,
    p_logout_url                in varchar2 default null)
    ;
procedure set_logo_image (
    p_flow_id                   in number default null,
    p_logo_image                in varchar2 default null,
    p_logo_image_attributes     in varchar2 default null)
    ;
procedure set_login_url (
    p_flow_id                   in number default null,
    p_login_url                 in varchar2 default null)
    ;
procedure set_image_prefix (
    p_flow_id                   in number default null,
    p_image_prefix              in varchar2 default null)
    ;
procedure set_template (
    p_flow_id                   in number default null,
    p_template                  in varchar2 default null)
    ;
procedure set_logging (
    p_flow_id                   in number default null,
    p_logging                   in varchar2 default null)
    ;
procedure set_application_owner (
    p_flow_id                   in number default null,
    p_application_owner         in varchar2 default null)
    ;
function get_application_owner (
    p_flow_id                   in number )
    return varchar2
    ;
procedure set_public_url_prefix (
    p_flow_id                   in number default null,
    p_public_url_prefix         in varchar2 default null)
    ;
procedure set_authenticated_url_prefix (
    p_flow_id                   in number default null,
    p_authenticated_url_prefix  in varchar2 default null)
    ;
procedure create_build_option (
    p_id                        in number   default null,
    p_flow_id                   in number   default null,
    p_build_option_name         in varchar2 default null,
    p_build_option_status       in varchar2 default null,
    p_build_option_comment      in varchar2 default null,
    --
    p_default_on_export         in varchar2 default null,
    p_attribute1                in varchar2 default null,
    p_attribute2                in varchar2 default null,
    p_attribute3                in varchar2 default null,
    p_attribute4                in varchar2 default null,
    --
    p_id_offset                 in number   default 0,
    p_target                    in varchar2 default 'PRIME')
    ;
procedure set_build_option (
    p_id                        in number   default null,
    p_build_option_status       in varchar2 default null)
    ;
procedure set_static_sub_strings (
    p_flow_id                     in number,
    p_substitution_string_01      in varchar2 default null,
    p_substitution_value_01       in varchar2 default null,
    p_substitution_string_02      in varchar2 default null,
    p_substitution_value_02       in varchar2 default null,
    p_substitution_string_03      in varchar2 default null,
    p_substitution_value_03       in varchar2 default null,
    p_substitution_string_04      in varchar2 default null,
    p_substitution_value_04       in varchar2 default null,
    p_substitution_string_05      in varchar2 default null,
    p_substitution_value_05       in varchar2 default null,
    p_substitution_string_06      in varchar2 default null,
    p_substitution_value_06       in varchar2 default null,
    p_substitution_string_07      in varchar2 default null,
    p_substitution_value_07       in varchar2 default null,
    p_substitution_string_08      in varchar2 default null,
    p_substitution_value_08       in varchar2 default null)
    ;
procedure set_flow_status (
    p_flow_id                   in number,
    p_flow_status               in varchar2,
    p_flow_status_message       in varchar2 default null)
    ;

--
-- S E C U R I T Y   S C H E M E S
--
procedure create_security_scheme (
    p_id                       in number   default null,
    p_security_group_id        in number   default null, -- obsolete
    p_flow_id                  in number   default null,
    p_name                     in varchar2 default null,
    p_scheme_type              in varchar2 default null,
    p_scheme                   in varchar2 default null,
    p_scheme_text              in varchar2 default null,
    p_caching                  in varchar2 default null,
    p_error_message            in varchar2 default null,
    p_reference_id             in number default null,
    p_comments                 in varchar2 default null,
    --
    p_id_offset                 in number   default 0,
    p_target                    in varchar2 default 'PRIME')
    ;

--
-- C O N F I G U R A T I O N S
--
procedure create_configuration (
   p_id                       in number,
   p_security_group_id        in number default null, -- obsolete
   p_flow_id                  in number,
   p_name                     in varchar2,
   p_config_comments          in varchar2 default null,
   --
   p_id_offset                 in number   default 0,
   p_target                    in varchar2 default 'PRIME')
   ;

procedure create_configuration_item (
   p_id                       in number,
   p_security_group_id        in number default null, -- obsolete
   p_config                   in number,
   p_table_dot_column         in varchar2,
   p_id_column_value          in varchar2 default null,
   p_new_value                in varchar2 default null,
   p_config_comment           in varchar2 default null,
   --
   p_id_offset                 in number   default 0,
   p_target                    in varchar2 default 'PRIME')
   ;


--
-- N A V I G A T I O N   B A R
--

procedure create_icon_bar (
    p_id                        in number   default null,
    p_flow_id                   in number   default null,
    p_icon_bar_text             in varchar2 default null,
    p_icon_bar_table_width      in varchar2 default null,
    --
    p_id_offset                 in number   default 0,
    p_target                    in varchar2 default 'PRIME')
    ;

procedure create_icon_bar_item (
    p_id                        in number   default null,
    p_flow_id                   in number   default null,
    p_icon_sequence             in number   default null,
    p_icon_image                in varchar2 default null,
    p_icon_image2               in varchar2 default null,
    p_icon_image3               in varchar2 default null,
    p_icon_subtext              in varchar2 default null,
    p_icon_subtext2             in varchar2 default null,
    p_icon_subtext3             in varchar2 default null,
    p_icon_target               in varchar2 default null,
    p_icon_image_alt            in varchar2 default null,
    p_icon_height               in number   default null,
    p_icon_width                in number   default null,
    p_icon_height2              in number   default null,
    p_icon_width2               in number   default null,
    p_icon_height3              in number   default null,
    p_icon_width3               in number   default null,
    p_icon_bar_disp_cond        in varchar2 default null,
    p_icon_bar_disp_cond_type   in varchar2 default null,
    p_icon_bar_flow_cond_instr  in varchar2 default null,
    p_begins_on_new_line        in varchar2 default null,
    p_cell_colspan              in number   default null,
    p_onclick                   in varchar2 default null,
    p_required_patch            in number   default null,
    p_security_scheme           in varchar2 default null,
    p_reference_id              in number   default null,
    p_icon_bar_comment          in varchar2 default null,
    --
    p_id_offset                 in number   default 0,
    p_target                    in varchar2 default 'PRIME')
    ;

procedure set_icon_bar_item (
    p_id                        in number,
    p_icon_sequence             in number   default null,
    p_icon_image                in varchar2 default null,
    p_icon_image2               in varchar2 default null,
    p_icon_image3               in varchar2 default null,
    p_icon_subtext              in varchar2 default null,
    p_icon_subtext2             in varchar2 default null,
    p_icon_subtext3             in varchar2 default null,
    p_icon_target               in varchar2 default null,
    p_icon_image_alt            in varchar2 default null,
    p_icon_height               in number   default null,
    p_icon_width                in number   default null,
    p_icon_height2              in number   default null,
    p_icon_width2               in number   default null,
    p_icon_height3              in number   default null,
    p_icon_width3               in number   default null,
    p_icon_bar_disp_cond        in varchar2 default null,
    p_icon_bar_disp_cond_type   in varchar2 default null,
    p_icon_bar_flow_cond_instr  in varchar2 default null,
    p_begins_on_new_line        in varchar2 default null,
    p_cell_colspan              in number   default null,
    p_required_patch            in number   default null,
    p_icon_bar_comment          in varchar2 default null)
    ;

procedure remove_icon_bar_item (
    p_id                        in number)
    ;

--
-- F L O W   P R O C E S S
--
procedure create_flow_process (
    p_id                        in number   default null,
    p_flow_id                   in number   default null,
    p_process_sequence          in number   default null,
    p_process_point             in varchar2 default null,
    p_process_type              in varchar2 default null,
    p_process_name              in varchar2 default null,
    p_process_sql               in varchar2 default null,
    p_process_sql_clob          in varchar2 default null,
    p_process_error_message     in varchar2 default null,
    p_process_when              in varchar2 default null,
    p_process_when_type         in varchar2 default null,
    p_process_when2             in varchar2 default null,
    p_process_when_type2        in varchar2 default null,
    p_security_scheme           in varchar2 default null,
    p_required_patch            in number   default null,
    p_process_item_name         in varchar2 default null,
    p_process_comment           in varchar2 default null,
    --
    p_id_offset                 in number   default 0,
    p_target                    in varchar2 default 'PRIME')
    ;

procedure set_flow_process_sql (
    p_id                        in number   default null,
    p_process_sql               in varchar2 default null)
    ;


--
-- F L O W   I T E M S
--

procedure create_flow_item (
    p_id                        in number   default null,
    p_flow_id                   in number   default null,
    p_name                      in varchar2 default null,
    p_data_type                 in varchar2 default null,
    p_is_Persistent             in varchar2 default null,
    p_required_patch            in number   default null,
    p_protection_level          in varchar2 default null,
    p_item_comment              in varchar2 default null,
    --
    p_id_offset                 in number   default 0,
    p_target                    in varchar2 default 'PRIME')
    ;

--
-- F L O W   C O M P U T A T I O N S
--
procedure create_flow_computation (
    p_id                        in number   default null,
    p_flow_id                   in number   default null,
    p_computation_sequence      in number   default null,
    p_computation_item          in varchar2 default null,
    p_computation_point         in varchar2 default null,
    p_computation_item_type     in varchar2 default null,
    p_computation_type          in varchar2 default null,
    p_computation_processed     in varchar2 default null,
    p_computation               in varchar2 default null,
    p_security_scheme           in varchar2 default null,
    p_required_patch            in number   default null,
    p_computation_comment       in varchar2 default null,
    p_compute_when              in varchar2 default null,
    p_compute_when_type         in varchar2 default null,
    p_compute_when_text         in varchar2 default null,
    p_computation_error_message in varchar2 default null,
    --
    p_id_offset                 in number   default 0,
    p_target                    in varchar2 default 'PRIME')
    ;




procedure create_tab (
    --
    -- Standard Tabs
    --
    p_id                        in number   default null,
    p_flow_id                   in number   default null,
    p_tab_set                   in varchar2 default null,
    p_tab_sequence              in number   default null,
    p_tab_name                  in varchar2 default null,
    p_tab_image                 in varchar2 default null,
    p_tab_non_current_image     in varchar2 default null,
    p_tab_image_attributes      in varchar2 default null,
    p_tab_text                  in varchar2 default null,
    p_tab_step                  in number   default null,
    p_tab_also_current_for_pages in varchar2 default null,
    p_tab_parent_tabset         in varchar2 default null,
    p_tab_plsql_condition       in varchar2 default null,
    p_display_condition_type    in varchar2 default null,
    p_tab_disp_cond_text        in varchar2 default null,
    p_required_patch            in number   default null,
    p_security_scheme           in varchar2 default null,
    p_tab_comment               in varchar2 default null,
    --
    p_auto_parent_tab_set       in varchar2 default null,
    p_auto_parent_tab_text      in varchar2 default null,
    --
    p_id_offset                 in number   default 0,
    p_target                    in varchar2 default 'PRIME')
    ;
procedure update_tab_condition (
    p_id                        in number   default null,
    p_tab_plsql_condition       in varchar2 default null)
    ;
procedure update_tab_text (
    p_id                        in number   default null,
    p_tab_text                  in varchar2 default null)
    ;
procedure rename_tabset (
    p_flow_id                   in number   default null,
    p_old_name                  in varchar2 default null,
    p_new_name                  in varchar2 default null)
    ;

procedure create_toplevel_tab (
    --
    -- Parent Tabs
    --
    p_id                        in number   default null,
    p_flow_id                   in number   default null,
    p_tab_set                   in varchar2 default null,
    p_tab_sequence              in number   default null,
    p_tab_name                  in varchar2 default null,
    p_tab_image                 in varchar2 default null,
    p_tab_non_current_image     in varchar2 default null,
    p_tab_image_attributes      in varchar2 default null,
    p_tab_text                  in varchar2 default null,
    p_tab_target                in varchar2 default null,
    p_current_on_tabset         in varchar2 default null,
    p_display_condition         in varchar2 default null,
    p_display_condition2        in varchar2 default null,
    p_display_condition_type    in varchar2 default null,
    p_required_patch            in number   default null,
    p_security_scheme           in varchar2 default null,
    p_tab_comment               in varchar2 default null,
    --
    p_id_offset                 in number   default 0,
    p_target                    in varchar2 default 'PRIME')
    ;
procedure update_toplevel_tab (
    p_id                        in number   default null,
    p_display_condition         in varchar2 default null)
    ;


procedure set_toplevel_tab_target (
    p_id                        in number   default null,
    p_tab_target                in varchar2 default null)
    ;

procedure set_toplevel_tab_text (
    p_id                        in number   default null,
    p_tab_text                  in varchar2 default null)
    ;


--
-- L I S T S  O F  V A L U E S
--

procedure create_list_of_values (
    p_id                        in number   default null,
    p_flow_id                   in number   default null,
    p_lov_name                  in varchar2 default null,
    p_lov_query                 in varchar2 default null,
    p_reference_id              in number   default null,
    --
    p_id_offset                 in number   default 0,
    p_target                    in varchar2 default 'PRIME')
    ;

procedure create_static_lov_data (
    p_id                        in number   default null,
    p_lov_id                    in number   default null,
    p_lov_disp_sequence         in number   default null,
    p_lov_disp_value            in varchar2 default null,
    p_lov_return_value          in varchar2 default null,
    p_lov_template              in varchar2 default null,
    p_lov_disp_cond_type        in varchar2 default null,
    p_lov_disp_cond             in varchar2 default null,
    p_lov_disp_cond2            in varchar2 default null,
    p_required_patch            in varchar2 default null,
    p_lov_data_comment          in varchar2 default null,
    --
    p_id_offset                 in number   default 0,
    p_target                    in varchar2 default 'PRIME')
    ;

--
-- I N S T A L L E R
--

procedure create_install (
    p_id                          in number   default null,
    p_flow_id                     in number   default null,
    p_include_in_export_yn        in varchar2 default 'Y',
    p_welcome_message             in varchar2 default null,
    p_license_message             in varchar2 default null,
    p_configuration_message       in varchar2 default null,
    p_build_options_message       in varchar2 default null,
    p_validation_message          in varchar2 default null,
    p_install_message             in varchar2 default null,
    p_install_success_message     in varchar2 default null,
    p_install_failure_message     in varchar2 default null,
    p_upgrade_message             in varchar2 default null,
    p_upgrade_confirm_message     in varchar2 default null,
    p_upgrade_success_message     in varchar2 default null,
    p_upgrade_failure_message     in varchar2 default null,
    p_get_version_sql_query       in varchar2 default null,
    p_deinstall_message           in varchar2 default null,
    p_deinstall_success_message   in varchar2 default null,
    p_deinstall_failure_message   in varchar2 default null,
    p_deinstall_script_clob       in varchar2 default null,

    p_prompt_sub_string_01        in varchar2 default null,
    p_prompt_sub_string_02        in varchar2 default null,
    p_prompt_sub_string_03        in varchar2 default null,
    p_prompt_sub_string_04        in varchar2 default null,
    p_prompt_sub_string_05        in varchar2 default null,
    p_prompt_sub_string_06        in varchar2 default null,
    p_prompt_sub_string_07        in varchar2 default null,
    p_prompt_sub_string_08        in varchar2 default null,
    p_prompt_sub_string_09        in varchar2 default null,
    p_prompt_sub_string_10        in varchar2 default null,
    p_prompt_sub_string_11        in varchar2 default null,
    p_prompt_sub_string_12        in varchar2 default null,
    p_prompt_sub_string_13        in varchar2 default null,
    p_prompt_sub_string_14        in varchar2 default null,
    p_prompt_sub_string_15        in varchar2 default null,
    p_prompt_sub_string_16        in varchar2 default null,
    p_prompt_sub_string_17        in varchar2 default null,
    p_prompt_sub_string_18        in varchar2 default null,
    p_prompt_sub_string_19        in varchar2 default null,
    p_prompt_sub_string_20        in varchar2 default null,

    p_install_prompt_01           in varchar2 default null,
    p_install_prompt_02           in varchar2 default null,
    p_install_prompt_03           in varchar2 default null,
    p_install_prompt_04           in varchar2 default null,
    p_install_prompt_05           in varchar2 default null,
    p_install_prompt_06           in varchar2 default null,
    p_install_prompt_07           in varchar2 default null,
    p_install_prompt_08           in varchar2 default null,
    p_install_prompt_09           in varchar2 default null,
    p_install_prompt_10           in varchar2 default null,
    p_install_prompt_11           in varchar2 default null,
    p_install_prompt_12           in varchar2 default null,
    p_install_prompt_13           in varchar2 default null,
    p_install_prompt_14           in varchar2 default null,
    p_install_prompt_15           in varchar2 default null,
    p_install_prompt_16           in varchar2 default null,
    p_install_prompt_17           in varchar2 default null,
    p_install_prompt_18           in varchar2 default null,
    p_install_prompt_19           in varchar2 default null,
    p_install_prompt_20           in varchar2 default null,

    p_prompt_if_mult_auth_yn      in varchar2 default null,

    p_trigger_install_when_cond   in varchar2 default null,
    p_trigger_install_when_exp1   in varchar2 default null,
    p_trigger_install_when_exp2   in varchar2 default null,
    p_trigger_failure_message     in varchar2 default null,

    p_required_free_kb            in number   default null,
    p_required_sys_privs          in varchar2 default null,
    p_required_names_available    in varchar2 default null,

    p_last_updated_by             in varchar2 default null,
    p_last_updated_on             in date     default null,
    --
    p_id_offset                   in number   default 0,
    p_target                      in varchar2 default 'PRIME')
    ;

procedure create_install_script (
    p_id                          in number   default null,
    p_flow_id                     in number   default null,
    p_security_group_id           in number   default null,
    p_install_id                  in number   default null,
    p_name                        in varchar2 default null,
    p_sequence                    in number   default null,
    p_script_type                 in varchar2 default null,
    p_script_clob                 in varchar2 default null,
    p_condition_type              in varchar2 default null,
    p_condition                   in varchar2 default null,
    p_condition2                  in varchar2 default null,
    --
    p_id_offset                   in number   default 0,
    p_target                      in varchar2 default 'PRIME')
    ;

procedure append_to_install_script (
    p_id                          in number   default null,
    p_flow_id                     in number   default null,
    p_script_clob                 in varchar2 default null,
    p_deinstall                   in boolean  default false)
    ;

procedure create_install_check (
    p_id                          in number   default null,
    p_flow_id                     in number   default null,
    p_security_group_id           in number   default null,
    p_install_id                  in number   default null,
    p_name                        in varchar2 default null,
    p_sequence                    in number   default null,
    p_check_type                  in varchar2 default null,
    p_check_condition             in varchar2 default null,
    p_check_condition2            in varchar2 default null,
    p_failure_message             in varchar2 default null,

    p_condition_type              in varchar2 default null,
    p_condition                   in varchar2 default null,
    p_condition2                  in varchar2 default null,
    --
    p_id_offset                   in number   default 0,
    p_target                      in varchar2 default 'PRIME')
    ;

procedure create_install_build_option (
    p_id                          in number   default null,
    p_flow_id                     in number   default null,
    p_security_group_id           in number   default null,
    p_install_id                  in number   default null,
    p_build_opt_id                in number   default null,
    --
    p_id_offset                   in number   default 0,
    p_target                      in varchar2 default 'PRIME')
    ;



--
-- P A G E
--
procedure create_page (
    --
    -- Creates a page identification.  The p_auto_ auto
    -- arguments are used to optionally create new
    -- tab sets and tab text.
    --
    p_id                          in number   default null,
    p_flow_id                     in number   default null,
    p_tab_set                     in varchar2 default null,
    p_name                        in varchar2 default null,
    p_alias                       in varchar2 default null,
    p_step_title                  in varchar2 default null,
    p_step_sub_title              in varchar2 default null,
    p_step_sub_title_type         in varchar2 default null,
    p_media_type                  in varchar2 default null,
    p_first_item                  in varchar2 default null,
    p_include_apex_css_js_yn      in varchar2 default null,
    p_welcome_text                in varchar2 default null,
    p_box_welcome_text            in varchar2 default null,
    p_box_footer_text             in varchar2 default null,
    p_footer_text                 in varchar2 default null,
    p_help_text                   in varchar2 default null,
    p_step_template               in number   default null,
    p_box_image                   in varchar2 default null,
    p_required_role               in varchar2 default null,
    p_required_patch              in number   default null,
    p_allow_duplicate_submissions in varchar2 default null,
    p_on_dup_submission_goto_url  in varchar2 default null,
    p_html_page_header            in varchar2 default null,
    p_html_page_onload            in varchar2 default null,
    p_page_is_protected_y_n       in varchar2 default null,
    p_page_is_public_y_n          in varchar2 default null,
    p_protection_level            in varchar2 default null,
    p_error_notification_text     in varchar2 default null,
    p_page_comment                in varchar2 default null,
    --
    p_tab_name                    in varchar2 default null,  -- current tab name
    --
    p_auto_tab_set                in varchar2 default null,
    p_auto_tab_text               in varchar2 default null,
    p_auto_parent_tab_set         in varchar2 default null,
    p_auto_parent_tab_text        in varchar2 default null,
    --
    p_autocomplete_on_off         in varchar2 default null,
    --
    p_cache_page_yn               in varchar2 default null,
    p_cache_timeout_seconds       in number   default null,
    p_cache_by_user_yn            in varchar2 default null,
    p_cache_when_condition_type   in varchar2 default null,
    p_cache_when_condition_e1     in varchar2 default null,
    p_cache_when_condition_e2     in varchar2 default null,
    --
    p_group_id                    in number   default null,
    --
    p_last_updated_by             in varchar2 default null,
    p_last_upd_yyyymmddhh24miss   in varchar2 default null,
    --
    p_created_by                  in varchar2 default null,
    p_created_on_yyyymmddhh24miss in varchar2 default null,
    --
    p_id_offset                   in number   default 0,
    p_target                      in varchar2 default 'PRIME') ;

procedure create_page_group (
    p_id                          in number   default null,
    p_flow_id                     in number   default null,
    p_group_name                  in varchar2 default null,
    p_group_desc                  in varchar2 default null,
    p_id_offset                   in number   default 0,
    p_target                      in varchar2 default 'PRIME') ;

procedure create_page_help (
    --
    -- Used to add up to 32767 bytes of page level help text to an existing page.
    -- P_ID identifies the page ID.
    --
    p_id                          in number   default null,
    p_flow_id                     in number   default null,
    p_help_text                   in varchar2 default null,
    --
    p_id_offset                 in number   default 0,
    p_target                    in varchar2 default 'PRIME') ;

procedure update_page (
    p_id                          in number   default null,
    p_flow_id                     in number   default null,
    p_tab_set                     in varchar2 default null,
    p_name                        in varchar2 default null,
    p_step_title                  in varchar2 default null,
    p_step_sub_title              in varchar2 default null,
    p_step_sub_title_type         in varchar2 default null,
    p_welcome_text                in varchar2 default null,
    p_box_welcome_text            in varchar2 default null,
    p_box_footer_text             in varchar2 default null,
    p_footer_text                 in varchar2 default null,
    p_help_text                   in varchar2 default null,
    p_step_template               in varchar2 default null,
    p_box_image                   in varchar2 default null,
    p_required_role               in varchar2 default null,
    p_required_patch              in number   default null,
    p_page_comment                in varchar2 default null)
    ;


--
-- B U T T O N S
--
procedure create_page_button (
    p_id                        in number   default null,
    p_flow_id                   in number   default null,
    p_flow_step_id              in number   default null,
    p_button_sequence           in number   default null,
    p_button_plug_id            in number   default null,
    p_button_name               in varchar2 default null,
    p_button_image              in varchar2 default null,
    p_button_image_alt          in varchar2 default null,
    p_button_position           in varchar2 default null,
    p_button_alignment          in varchar2 default null,
    p_button_redirect_url       in varchar2 default null,
    p_button_condition          in varchar2 default null,
    p_button_condition2         in varchar2 default null,
    p_button_condition_type     in varchar2 default null,
    p_button_image_attributes   in varchar2 default null,
    p_button_cattributes        in varchar2 default null,
    p_security_scheme           in varchar2 default null,
    p_required_patch            in number   default null,
    p_button_comment            in varchar2 default null,
    --
    p_id_offset                 in number   default 0,
    p_target                    in varchar2 default 'PRIME',
    p_database_action           in varchar2 default null )
    ;

--
-- B R A N C H
--
procedure create_page_branch (
    p_id                          in number   default null,
    p_flow_id                     in number   default null,
    p_flow_step_id                in number   default null,
    p_branch_action               in varchar2 default null,
    p_branch_point                in varchar2 default null,
    p_branch_type                 in varchar2 default null,
    p_branch_when_button_id       in number   default null,
    p_branch_sequence             in number   default null,
    p_branch_condition_type       in varchar2 default null,
    p_branch_condition            in varchar2 default null,
    p_branch_condition_text       in varchar2 default null,
    p_save_state_before_branch_yn in varchar2 default 'N',
    p_security_scheme             in varchar2 default null,
    p_required_patch              in number   default null,
    p_branch_comment              in varchar2 default null,
    --
    p_id_offset                   in number   default 0,
    p_target                      in varchar2 default 'PRIME')
    ;

--
-- B R A N C H   A R G S
--
procedure create_page_branch_args (
    p_id                        in number   default null,
    p_flow_step_branch_id       in number   default null,
    p_branch_arg_sequence       in number   default null,
    p_branch_arg_source_type    in varchar2 default null,
    p_branch_arg_source         in varchar2 default null,
    p_branch_arg_comment        in varchar2 default null,
    --
    p_id_offset                 in number   default 0,
    p_target                    in varchar2 default 'PRIME')
    ;
--
-- P A G E   I T E M S
--
procedure create_page_item (
    p_id                        in number   default null,
    p_flow_id                   in number   default null,
    p_flow_step_id              in number   default null,
    p_name                      in varchar2 default null,
    p_data_type                 in varchar2 default null,
    p_accept_processing         in varchar2 default null,
    p_item_sequence             in number   default null,
    p_item_plug_id              in number   default null,
    p_use_cache_before_default  in varchar2 default null,
    p_item_default              in varchar2 default null,
    p_item_default_type         in varchar2 default null,
    p_prompt                    in varchar2 default null,
    p_pre_element_text          in varchar2 default null,
    p_post_element_text         in varchar2 default null,
    p_format_mask               in varchar2 default null,
    p_source                    in varchar2 default null,
    p_source_type               in varchar2 default null,
    p_source_post_computation   in varchar2 default null,
    p_display_as                in varchar2 default null,
    p_named_lov                 in varchar2 default null,
    p_lov                       in varchar2 default null,
    p_lov_columns               in number   default null,
    p_lov_display_extra         in varchar2 default null,
    p_lov_display_null          in varchar2 default null,
    p_lov_null_text             in varchar2 default null,
    p_lov_null_value            in varchar2 default null,
    p_lov_translated            in varchar2 default null,
    p_cSize                     in number   default null,
    p_cMaxlength                in number   default null,
    p_cHeight                   in number   default null,
    p_cAttributes               in varchar2 default null,
    p_cAttributes_element       in varchar2 default null,
    p_tag_attributes            in varchar2 default null,
    p_tag_attributes2           in varchar2 default null,
    p_begin_on_new_line         in varchar2 default null,
    p_begin_on_new_field        in varchar2 default null,
    p_colspan                   in number   default null,
    p_rowspan                   in number   default null,
    p_button_image              in varchar2 default null,
    p_button_image_attr         in varchar2 default null,
    p_label_alignment           in varchar2 default null,
    p_field_alignment           in varchar2 default null,
    p_field_template            in varchar2 default null,
    p_display_when              in varchar2 default null,
    p_display_when2             in varchar2 default null,
    p_display_when_type         in varchar2 default null,
    p_is_Persistent             in varchar2 default null,
    p_javascript                in varchar2 default null,
    p_security_scheme           in varchar2 default null,
    p_required_patch            in number   default null,
    p_item_comment              in varchar2 default null,
    p_help_text                 in varchar2 default null,
    --
    p_read_only_when            in varchar2 default null,
    p_read_only_when2           in varchar2 default null,
    p_read_only_when_type       in varchar2 default null,
    p_read_only_disp_attr       in varchar2 default null,
    --
    p_protection_level          in varchar  default null,
    p_escape_on_http_input      in varchar2 default null,
    --
    p_encrypt_session_state_yn  in varchar2 default 'N',
    --
    p_reference_id              in number   default null,
    --
    p_id_offset                 in number   default 0,
    p_target                    in varchar2 default 'PRIME')
    ;

--
-- P A G E   C O M P U T A T I O N S
--
procedure create_page_computation (
    p_id                        in number   default null,
    p_flow_id                   in number   default null,
    p_flow_step_id              in number   default null,
    p_computation_sequence      in number   default null,
    p_computation_item          in varchar2 default null,
    p_computation_point         in varchar2 default null,
    p_computation_item_type     in varchar2 default null,
    p_computation_type          in varchar2 default null,
    p_computation_processed     in varchar2 default null,
    p_computation               in varchar2 default null,
    p_computation_comment       in varchar2 default null,
    p_compute_when              in varchar2 default null,
    p_compute_when_type         in varchar2 default null,
    p_computation_error_message in varchar2 default null,
    p_compute_when_text         in varchar2 default null,
    p_security_scheme           in varchar2 default null,
    p_required_patch            in number   default null,
    --
    p_id_offset                 in number   default 0,
    p_target                    in varchar2 default 'PRIME')
    ;

--
-- P A G E   V A L I D A T I O N S
--
procedure create_page_validation (
    p_id                        in number   default null,
    p_flow_id                   in number   default null,
    p_flow_step_id              in number   default null,
    p_validation_name           in varchar2 default null,
    p_validation_sequence       in number   default null,
    p_validation                in varchar2 default null,
    p_validation2               in varchar2 default null,
    p_validation_type           in varchar2 default null,
    p_error_message             in varchar2 default null,
    p_validation_condition      in varchar2 default null,
    p_validation_condition2     in varchar2 default null,
    p_validation_condition_type in varchar2 default null,
    p_when_button_pressed       in varchar2 default null,
    p_associated_item           in number   default null,
    p_error_display_location    in varchar2 default null,
    p_security_scheme           in varchar2 default null,
    p_required_patch            in number   default null,
    p_validation_comment        in varchar2 default null,
    --
    p_id_offset                 in number   default 0,
    p_target                    in varchar2 default 'PRIME')
    ;

--
-- P A G E   P R O C E S S E S
--
procedure create_page_process (
    p_id                        in number   default null,
    p_flow_id                   in number   default null,
    p_flow_step_id              in number   default null,
    p_process_sequence          in number   default null,
    p_process_point             in varchar2 default null,
    p_process_type              in varchar2 default null,
    p_process_name              in varchar2 default null,
    p_process_sql               in varchar2 default null,
    p_process_sql_clob          in varchar2 default null,
    p_process_error_message     in varchar2 default null,
    p_process_when_button_id    in number   default null,
    p_process_when              in varchar2 default null,
    p_process_when_type         in varchar2 default null,
    p_process_when2             in varchar2 default null,
    p_process_when_type2        in varchar2 default null,
    p_process_success_message   in varchar2 default null,
    p_security_scheme           in varchar2 default null,
    p_required_patch            in number   default null,
    p_process_is_stateful_y_n   in varchar2 default 'N',
    p_return_key_into_item1     in varchar2 default null,
    p_return_key_into_item2     in varchar2 default null,
    p_process_item_name         in varchar2 default null,
    p_process_comment           in varchar2 default null,
    p_runtime_where_clause      in varchar2 default null,
    --
    p_id_offset                 in number   default 0,
    p_target                    in varchar2 default 'PRIME')
    ;

------------------------------------------------------------
-- T H E M E S
--

procedure create_theme(
    p_id                          in number default null,
    p_flow_id                     in number default null,
    p_theme_id                    in number default null,
    p_theme_name                  in varchar2,
    p_default_page_template       in number default null,
    p_error_template              in number default null,
    p_printer_friendly_template   in number default null,
    p_breadcrumb_display_point    in varchar2 default null,
    p_sidebar_display_point       in varchar2 default null,
    p_login_template              in number default null,
    p_default_button_template     in number default null,
    p_default_region_template     in number default null,
    p_default_chart_template      in number default null,
    p_default_form_template       in number default null,
    p_default_reportr_template    in number default null,
    p_default_tabform_template    in number default null,
    p_default_wizard_template     in number default null,
    p_default_menur_template      in number default null,
    p_default_listr_template      in number default null,
    p_default_report_template     in number default null,
    p_default_label_template      in number default null,
    p_default_menu_template       in number default null,
    p_default_calendar_template   in number default null,
    p_default_list_template       in number default null,
    p_default_option_label        in number default null,
    p_default_required_label      in number default null,
    p_calendar_icon               in varchar2 default null,
    p_calendar_icon_attr          in varchar2 default null,
    p_theme_description           in varchar2 default null);

procedure create_theme_image (
    p_id                          in number default null,
    p_flow_id                     in number default null,
    p_theme_id                    in number default null,
    p_varchar2_table              in dbms_sql.varchar2_table default empty_varchar2_table,
    p_mimetype                    in varchar2 default null);

procedure delete_theme(
    p_flow_id       in number default null,
    p_theme_id      in number default null,
    p_import        in varchar2 default null);

procedure set_theme_calendar_icon (
    p_id            in number default null,
    p_flow_id       in number default null,
    p_calendar_icon in varchar2 default null,
    p_calendar_icon_attr in varchar2 default null);


------------------------------------------------------------
-- T E M P L A T E S
--
-- page template
--

procedure create_template (
    p_id                        in number default null,
    p_flow_id                   in number default null,
    p_name                      in varchar2 default null,
    p_look                      in number default null,
    p_header_template           in varchar2 default null,
    p_footer_template           in varchar2 default null,
    p_success_message           in varchar2 default null,
    --
    p_current_tab               in varchar2 default null,
    p_current_tab_font_attr     in varchar2 default null,
    p_non_current_tab           in varchar2 default null,
    p_non_current_tab_font_attr in varchar2 default null,
    --
    p_current_image_tab         in varchar2 default null,
    p_non_current_image_tab     in varchar2 default null,
    --
    p_top_current_tab            in varchar2 default null,
    p_top_current_tab_font_attr  in varchar2 default null,
    p_top_non_curr_tab           in varchar2 default null,
    p_top_non_curr_tab_font_attr in varchar2 default null,
    --
    p_box                       in varchar2 default null,
    p_navigation_bar            in varchar2 default null,
    p_navbar_entry              in varchar2 default null,
    p_body_title                in varchar2 default null,
    p_notification_message      in varchar2 default null,
    p_attribute1                in varchar2 default null,
    p_attribute2                in varchar2 default null,
    p_attribute3                in varchar2 default null,
    p_attribute4                in varchar2 default null,
    p_attribute5                in varchar2 default null,
    p_attribute6                in varchar2 default null,
    --
    p_table_bgcolor             in varchar2 default null,
    p_heading_bgcolor           in varchar2 default null,
    p_table_cattributes         in varchar2 default null,
    p_font_size                 in varchar2 default null,
    p_font_face                 in varchar2 default null,
    --
    p_region_table_cattributes  in varchar2 default null,
    --
    p_app_tab_before_tabs       in varchar2 default null,
    p_app_tab_current_tab       in varchar2 default null,
    p_app_tab_non_current_tab   in varchar2 default null,
    p_app_tab_after_tabs        in varchar2 default null,
    --
    p_error_page_template       in varchar2 default null,
    --
    p_default_button_position   in varchar2 default null,
    p_required_patch            in number   default null,
    p_reference_id              in number   default null,
    p_translate_this_template   in varchar2 default 'N',
    p_template_comment          in varchar2 default null,
    p_breadcrumb_def_reg_pos    in varchar2 default null,
    p_sidebar_def_reg_pos       in varchar2 default null,
    --
    p_id_offset                 in number   default 0,
    p_target                    in varchar2 default 'PRIME',
    --
    p_theme_id                  in number   default null,
    p_theme_class_id            in number   default null)
    ;

procedure create_button_templates (
    p_id                            in number   default null,
    p_flow_id                       in number   default null,
    p_template_name                 in varchar2 default null,
    p_template                      in varchar2 default null,
    p_translate_this_template       in varchar2 default 'N',
    p_template_comment              in varchar2 default null,
    p_reference_id                  in number   default null,
    p_id_offset                     in number   default 0,
    p_target                        in varchar2 default 'PRIME',
    --
    p_theme_id                  in number   default null,
    p_theme_class_id            in number   default null)
    ;

procedure create_plug_template (
    p_id                            in number   default null,
    p_flow_id                       in number   default null,
    p_page_plug_template_name       in varchar2 default null,
    p_template                      in varchar2 default null,
    p_template2                     in varchar2 default null,
    p_template3                     in varchar2 default null,
    p_plug_table_bgcolor            in varchar2 default null,
    p_plug_heading_bgcolor          in varchar2 default null,
    p_plug_font_size                in varchar2 default null,
    p_reference_id                  in number   default null,
    p_form_table_attr               in varchar2 default null,
    p_translate_this_template       in varchar2 default 'N',
    p_template_comment              in varchar2 default null,
    p_id_offset                     in number   default 0,
    p_target                        in varchar2 default 'PRIME',
    --
    p_theme_id                  in number   default null,
    p_theme_class_id            in number   default null)
    ;

procedure set_plug_template_tab_attr (
    -- provides compatability with version 1.0.0
    p_id                            in number   default null,
    p_form_table_attr               in varchar2 default null,
    p_target                        in varchar2 default 'PRIME')
    ;

procedure create_list_template (
    p_id                            in number   default null,
    p_flow_id                       in number   default null,
    p_list_template_name            in varchar2 default null,
    p_list_template_current         in varchar2 default null,
    p_list_template_noncurrent      in varchar2 default null,
    p_list_template_before_rows     in varchar2 default null,
    p_list_template_after_rows      in varchar2 default null,
    p_between_items                 in varchar2 default null,
    p_before_sub_list               in varchar2 default null,
    p_after_sub_list                in varchar2 default null,
    p_between_sub_list_items        in varchar2 default null,
    p_sub_list_item_current         in clob     default null,
    p_sub_list_item_noncurrent      in clob     default null,
    p_item_templ_curr_w_child       in clob     default null,
    p_item_templ_noncurr_w_child    in clob     default null,
    p_sub_templ_curr_w_child        in clob     default null,
    p_sub_templ_noncurr_w_child     in clob     default null,
    p_reference_id                  in number   default null,
    p_translate_this_template       in varchar2 default 'N',
    p_list_template_comment         in varchar2 default null,
    p_id_offset                     in number   default 0,
    p_target                        in varchar2 default 'PRIME',
    --
    p_theme_id                  in number   default null,
    p_theme_class_id            in number   default null)
    ;

procedure create_row_template (
    --
    -- Create a report template which defines HTML
    -- template control over report rows
    --
    p_id                            in number default null,
    p_flow_id                       in number default null,
    p_row_template_name             in varchar2 default null,
    p_row_template_type             in varchar2 default null,
    p_before_column_heading         in varchar2 default null, -- new 3.1
    p_column_heading_template       in varchar2 default null,
    p_after_column_heading          in varchar2 default null, -- new 3.1
    p_row_template1                 in varchar2 default null,
    p_row_template_condition1       in varchar2 default null,
    p_row_template_display_cond1    in varchar2 default null,
    p_row_template2                 in varchar2 default null,
    p_row_template_condition2       in varchar2 default null,
    p_row_template_display_cond2    in varchar2 default null,
    p_row_template3                 in varchar2 default null,
    p_row_template_condition3       in varchar2 default null,
    p_row_template_display_cond3    in varchar2 default null,
    p_row_template4                 in varchar2 default null,
    p_row_template_condition4       in varchar2 default null,
    p_row_template_display_cond4    in varchar2 default null,
    p_row_template_before_rows      in varchar2 default null,
    p_row_template_after_rows       in varchar2 default null,
    p_row_template_before_first     in varchar2 default null,
    p_row_template_after_last       in varchar2 default null,
    p_row_template_table_attr       in varchar2 default null,
    p_reference_id                  in number   default null,
    --
    p_pagination_template           in varchar2 default null,
    p_next_page_template            in varchar2 default null,
    p_previous_page_template        in varchar2 default null,
    p_next_set_template             in varchar2 default null,
    p_previous_set_template         in varchar2 default null,
    --
    p_row_style_mouse_over          in varchar2 default null,
    p_row_style_mouse_out           in varchar2 default null,
    p_row_style_checked             in varchar2 default null,
    p_row_style_unchecked           in varchar2 default null,
    --
    p_translate_this_template       in varchar2 default 'N',
    p_row_template_comment          in varchar2 default null,
    p_id_offset                     in number   default 0,
    p_target                        in varchar2 default 'PRIME',
    --
    p_theme_id                  in number   default null,
    p_theme_class_id            in number   default null)
    ;

procedure create_row_template_patch (
    --
    -- This procedure extendes the create_row_template
    -- procedure.  It allows for compatability with version
    -- 1.0.0.
    --
    p_id                            in number,
    p_row_template_before_first     in varchar2 default null,
    p_row_template_after_last       in varchar2 default null,
    p_target                        in varchar2 default 'PRIME')
    ;

procedure create_field_template (
    --
    -- Create a field template which defines the display
    -- of a form field, for example a form page item label.
    -- Page lables do not require the use of a field template,
    -- the use of field templates is optional.
    -- Field templates are defined at the flow level and shared
    -- to all pages within a flow.
    --
    p_id                            in number default null,
    p_flow_id                       in number default null,
    p_template_name                 in varchar2 default null,
    p_template_body1                in varchar2 default null,
    p_template_body2                in varchar2 default null,
    p_on_error_before_label         in varchar2 default null,
    p_on_error_after_label          in varchar2 default null,
    p_reference_id                  in number   default null,
    p_translate_this_template       in varchar2 default 'N',
    p_template_comment              in varchar2 default null,
    p_id_offset                     in number   default 0,
    p_target                        in varchar2 default 'PRIME',
    --
    p_theme_id                  in number   default null,
    p_theme_class_id            in number   default null)
    ;

procedure create_calendar_template (
    -- creates a calendar template
    p_id                          in number   default null,
    p_flow_id                     in number   default null,
    p_cal_template_name           in varchar2 default null,
    p_translate_this_template     in varchar2 default 'N',
    p_month_title_format          in varchar2 default null,
    p_day_of_week_format          in varchar2 default null,
    p_month_open_format           in varchar2 default null,
    p_month_close_format          in varchar2 default null,
    p_day_title_format            in varchar2 default null,
    p_day_open_format             in varchar2 default null,
    p_day_close_format            in varchar2 default null,
    p_today_open_format           in varchar2 default null,
    p_weekend_title_format        in varchar2 default null,
    p_weekend_open_format         in varchar2 default null,
    p_weekend_close_format        in varchar2 default null,
    p_nonday_title_format         in varchar2 default null,
    p_nonday_open_format          in varchar2 default null,
    p_nonday_close_format         in varchar2 default null,
    p_week_title_format           in varchar2 default null,
    p_week_open_format            in varchar2 default null,
    p_week_close_format           in varchar2 default null,
    p_daily_title_format          in varchar2 default null,
    p_daily_open_format           in varchar2 default null,
    p_daily_close_format          in varchar2 default null,
    p_weekly_title_format         in varchar2 default null,
    p_weekly_day_of_week_format   in varchar2 default null,
    p_weekly_month_open_format    in varchar2 default null,
    p_weekly_month_close_format   in varchar2 default null,
    p_weekly_day_title_format     in varchar2 default null,
    p_weekly_day_open_format      in varchar2 default null,
    p_weekly_day_close_format     in varchar2 default null,
    p_weekly_today_open_format    in varchar2 default null,
    p_weekly_weekend_title_format in varchar2 default null,
    p_weekly_weekend_open_format  in varchar2 default null,
    p_weekly_weekend_close_format in varchar2 default null,
    p_weekly_time_open_format     in varchar2 default null,
    p_weekly_time_close_format    in varchar2 default null,
    p_weekly_time_title_format    in varchar2 default null,
    p_weekly_hour_open_format     in varchar2 default null,
    p_weekly_hour_close_format    in varchar2 default null,
    p_daily_day_of_week_format    in varchar2 default null,
    p_daily_month_title_format    in varchar2 default null,
    p_daily_month_open_format     in varchar2 default null,
    p_daily_month_close_format    in varchar2 default null,
    p_daily_day_title_format      in varchar2 default null,
    p_daily_day_open_format       in varchar2 default null,
    p_daily_day_close_format      in varchar2 default null,
    p_daily_today_open_format     in varchar2 default null,
    p_daily_time_open_format      in varchar2 default null,
    p_daily_time_close_format     in varchar2 default null,
    p_daily_time_title_format     in varchar2 default null,
    p_daily_hour_open_format      in varchar2 default null,
    p_daily_hour_close_format     in varchar2 default null,
    p_reference_id                in number   default null,
    p_id_offset                   in number   default 0,
    p_target                      in varchar2 default 'PRIME',
    --
    p_theme_id                    in number   default null,
    p_theme_class_id              in number   default null)
    ;

procedure create_report_layout (
    p_id                            in number   default null,
    p_flow_id                       in number   default null,
    p_report_layout_name            in varchar2 default null,
    p_report_layout_type            in varchar2 default null,
    p_page_template                 in varchar2 default null,
    p_varchar2_table                in dbms_sql.varchar2_table default empty_varchar2_table,
    p_xslfo_column_heading          in varchar2 default null,
    p_xslfo_column_template         in varchar2 default null,
    p_xslfo_column_template_width   in varchar2 default null,
    p_reference_id                  in number   default null,
    p_report_layout_comment         in varchar2 default null)
    ;

procedure create_shared_query (
    --
    -- For high fidelity printing with custom/uploaded templates
    --
    p_id                        in number   default null,
    p_flow_id                   in number   default null,
    p_name                      in varchar2 default null,
    p_query_text                in varchar2 default null,
    p_xml_structure             in varchar2 default null,
    p_report_layout_id          in number   default null,
    p_format                    in varchar2 default null,
    p_format_item               in varchar2 default null,
    p_output_file_name          in varchar2 default null,
    p_content_disposition       in varchar2 default null,
    p_document_header           in varchar2 default null,
    p_xml_items                 in varchar2 default null)
    ;

procedure create_shared_query_stmnt (
    --
    -- For high fidelity printing with custom/uploaded templates
    --
    p_id                        in number   default null,
    p_flow_id                   in number   default null,
    p_shared_query_id           in varchar2 default null,
    p_sql_statement             in varchar2 default null)
    ;

--
-- R E G I O N S  (PLUGS)
--

procedure create_page_plug (
    p_id                            in number   default null,
    p_flow_id                       in number   default null,
    p_page_id                       in number   default null,
    p_plug_name                     in varchar2 default null,
    p_region_name                   in varchar2 default null,
    p_plug_template                 in number   default null,
    p_plug_display_sequence         in varchar2 default null,
    p_REGION_ATTRIBUTES             in varchar2 default null,
    p_report_attributes             in varchar2 default null,
    p_plug_display_column           in varchar2 default null,
    p_plug_display_point            in varchar2 default null,
    p_plug_source                   in varchar2 default null,
    p_plug_source_type              in varchar2 default null,
    p_plug_display_error_message    in varchar2 default null,
    p_plug_create_link_text         in varchar2 default null,
    p_plug_create_link_target       in varchar2 default null,
    p_plug_create_image             in varchar2 default null,
    p_plug_create_image_attributes  in varchar2 default null,
    p_plug_edit_link_text           in varchar2 default null,
    p_plug_edit_link_target         in varchar2 default null,
    p_plug_edit_image               in varchar2 default null,
    p_plug_edit_image_attributes    in varchar2 default null,
    p_plug_expand_link_text         in varchar2 default null,
    p_plug_expand_link_target       in varchar2 default null,
    p_plug_expand_image             in varchar2 default null,
    p_plug_expand_image_attributes  in varchar2 default null,
    p_plug_close_link_text          in varchar2 default null,
    p_plug_close_link_target        in varchar2 default null,
    p_plug_close_image              in varchar2 default null,
    p_plug_close_image_attributes   in varchar2 default null,
    p_plug_required_role            in varchar2 default null,
    p_plug_display_when_condition   in varchar2 default null,
    p_plug_display_when_cond2       in varchar2 default null,
    p_plug_display_condition_type   in varchar2 default null,
    --
    p_plug_header                   in varchar2 default null,
    p_plug_footer                   in varchar2 default null,
    p_plug_override_reg_pos         in varchar2 default null,
    p_plug_customized               in varchar2 default null,
    p_plug_customized_name          in varchar2 default null,
    p_translate_title               in varchar2 default null,
    p_ajax_enabled                  in varchar2 default null,
    --
    p_plug_query_row_template       in number   default null,
    p_plug_query_max_columns        in number   default null,
    p_plug_query_headings           in varchar2 default null,
    p_plug_query_headings_type      in varchar2 default 'COLON_DELMITED_LIST',
    p_plug_query_num_rows           in number   default null,
    p_plug_query_hit_highlighting   in varchar2 default null,
    p_plug_query_options            in varchar2 default null,
    p_plug_query_format_out         in varchar2 default null,
    p_plug_query_show_nulls_as      in varchar2 default null,
    p_plug_query_col_allignments    in varchar2 default null,
    p_plug_query_break_cols         in varchar2 default null,
    p_plug_query_sum_cols           in varchar2 default null,
    p_plug_query_number_formats     in varchar2 default null,
    p_plug_query_table_border       in varchar2 default null,
    p_plug_column_width             in varchar2 default null,
    p_plug_query_no_data_found      in varchar2 default null,
    p_plug_query_more_data          in varchar2 default null,
    p_plug_ignore_pagination        in number   default null,
    p_plug_query_num_rows_item      in varchar2 default null,
    p_plug_query_num_rows_type      in varchar2 default null,
    p_plug_query_row_count_max      in number   default 500,
    p_plug_query_asc_image          in varchar2 default null,
    p_plug_query_asc_image_attr     in varchar2 default null,
    p_plug_query_desc_image         in varchar2 default null,
    p_plug_query_desc_image_attr    in varchar2 default null,
    --
    p_plug_query_exp_filename       in varchar2 default null,
    p_plug_query_exp_separator      in varchar2 default null,
    p_plug_query_exp_enclosed_by    in varchar2 default null,
    p_plug_query_strip_html         in varchar2 default null,
    --
    p_pagination_display_position   in varchar2 default null,
    p_report_total_text_format      in varchar2 default null,
    p_break_column_text_format      in varchar2 default null,
    p_break_before_row              in varchar2 default null,
    p_break_generic_column          in varchar2 default null,
    p_break_after_row               in varchar2 default null,
    p_break_type_flag               in varchar2 default null,
    p_break_repeat_heading_format   in varchar2 default null,
    p_csv_output                    in varchar2 default null,
    p_csv_output_link_text          in varchar2 default null,
    p_print_url                     in varchar2 default null,
    p_print_url_label               in varchar2 default null,
    --
    p_prn_output                    in varchar2 default null,
    p_prn_print_server_overwrite    in varchar2 default null,
    p_prn_template_id               in number   default null,
    p_prn_format                    in varchar2 default null,
    p_prn_format_item               in varchar2 default null,
    p_prn_output_show_link          in varchar2 default null,
    p_prn_output_link_text          in varchar2 default null,
    p_prn_output_file_name          in varchar2 default null,
    p_prn_content_disposition       in varchar2 default null,
    p_prn_document_header           in varchar2 default null,
    p_prn_units                     in varchar2 default null,
    p_prn_paper_size                in varchar2 default null,
    p_prn_width_units               in varchar2 default null,
    p_prn_width                     in number   default null,
    p_prn_height                    in number   default null,
    p_prn_orientation               in varchar2 default null,
    p_prn_page_header               in varchar2 default null,
    p_prn_page_header_font_color    in varchar2 default null,
    p_prn_page_header_font_family   in varchar2 default null,
    p_prn_page_header_font_weight   in varchar2 default null,
    p_prn_page_header_font_size     in varchar2 default null,
    p_prn_page_footer               in varchar2 default null,
    p_prn_page_footer_font_color    in varchar2 default null,
    p_prn_page_footer_font_family   in varchar2 default null,
    p_prn_page_footer_font_weight   in varchar2 default null,
    p_prn_page_footer_font_size     in varchar2 default null,
    p_prn_header_bg_color           in varchar2 default null,
    p_prn_header_font_color         in varchar2 default null,
    p_prn_header_font_family        in varchar2 default null,
    p_prn_header_font_weight        in varchar2 default null,
    p_prn_header_font_size          in varchar2 default null,
    p_prn_body_bg_color             in varchar2 default null,
    p_prn_body_font_color           in varchar2 default null,
    p_prn_body_font_family          in varchar2 default null,
    p_prn_body_font_weight          in varchar2 default null,
    p_prn_body_font_size            in varchar2 default null,
    p_prn_border_width              in number   default null,
    --
    p_shared_query_id               in number   default null,
    --
    p_plug_url_text_begin           in varchar2 default null,
    p_plug_url_text_end             in varchar2 default null,
    p_java_entry_point              in varchar2 default null,
    --
    p_plug_caching                  in varchar2 default null,
    p_plug_caching_session_state    in varchar2 default null,
    p_plug_caching_max_age_in_sec   in varchar2 default null,
    p_plug_cache_when_cond_type     in varchar2 default null,
    p_plug_cache_when_condition_e1  in varchar2 default null,
    p_plug_cache_when_condition_e2  in varchar2 default null,
    --
    p_plug_chart_font_size          in varchar2 default null,
    p_plug_chart_max_rows           in varchar2 default null,
    p_plug_chart_num_mask           in varchar2 default null,
    p_plug_chart_scale              in varchar2 default null,
    p_plug_chart_axis               in varchar2 default null,
    p_plug_chart_show_summary       in varchar2 default null,
    --
    p_menu_template_id              in number   default null,
    p_list_template_id              in number   default null,
    --
    p_required_patch                in varchar2 default null,
    p_plug_comment                  in varchar2 default null,
    --
    p_use_custom_item_layout        in varchar2 default null,
    p_custom_item_layout            in varchar2 default null,
    --
    p_prn_page_header_alignment     in varchar2 default null,
    p_prn_page_footer_alignment     in varchar2 default null,
    p_prn_border_color              in varchar2 default null,
    p_sort_null                     in varchar2 default null,
    --
    p_id_offset                     in number   default 0,
    p_target                        in varchar2 default 'PRIME')
    ;

procedure set_region_column_width (
    p_id                            in number   default null,
    p_flow_id                       in number   default null,
    p_page_id                       in number   default null,
    p_plug_column_width             in varchar2 default null)
    ;

procedure create_report_region (
    p_id                            in number   default null,
    p_flow_id                       in number   default null,
    p_page_id                       in number   default null,
    p_name                          in varchar2 default null,
    p_region_name                   in varchar2 default null,
    p_template                      in number   default null,
    p_display_sequence              in varchar2 default null,
    p_REGION_ATTRIBUTES             in varchar2 default null,
    p_report_attributes             in varchar2 default null,
    p_display_column                in varchar2 default null,
    p_display_point                 in varchar2 default null,
    p_source                        in varchar2 default null,
    p_source_type                   in varchar2 default null,
    p_display_error_message         in varchar2 default null,
    p_required_role                 in varchar2 default null,
    p_display_when_condition        in varchar2 default null,
    p_display_when_cond2            in varchar2 default null,
    p_display_condition_type        in varchar2 default null,
    --
    p_header                        in varchar2 default null,
    p_footer                        in varchar2 default null,
    p_override_reg_pos              in varchar2 default null,
    p_customized                    in varchar2 default null,
    p_customized_name               in varchar2 default null,
    p_translate_title               in varchar2 default null,
    p_ajax_enabled                  in varchar2 default null,
    --
    p_query_row_template            in number   default null,
    p_plug_query_max_columns        in number   default null,
    p_query_headings                in varchar2 default null,
    p_query_headings_type           in varchar2 default 'COLON_DELMITED_LIST',
    p_query_num_rows                in number   default null,
    p_query_options                 in varchar2 default null,
    p_query_show_nulls_as           in varchar2 default null,
    p_query_break_cols              in varchar2 default null,
    p_query_no_data_found           in varchar2 default null,
    p_query_more_data               in varchar2 default null,
    p_ignore_pagination             in number   default null,
    p_query_num_rows_item           in varchar2 default null,
    p_query_num_rows_type           in varchar2 default null,
    p_query_row_count_max           in number   default 500,
    --
    p_pagination_display_position   in varchar2 default null,
    p_report_total_text_format      in varchar2 default null,
    p_break_column_text_format      in varchar2 default null,
    p_break_before_row              in varchar2 default null,
    p_break_generic_column          in varchar2 default null,
    p_break_after_row               in varchar2 default null,
    p_break_type_flag               in varchar2 default null,
    p_break_repeat_heading_format   in varchar2 default null,
    p_csv_output                    in varchar2 default null,
    p_csv_output_link_text          in varchar2 default null,
    p_print_url                     in varchar2 default null,
    p_print_url_label               in varchar2 default null,
    --
    p_prn_output                    in varchar2 default null,
    p_prn_print_server_overwrite    in varchar2 default null,
    p_prn_template_id               in number   default null,
    p_prn_format                    in varchar2 default null,
    p_prn_format_item               in varchar2 default null,
    p_prn_output_show_link          in varchar2 default null,
    p_prn_output_link_text          in varchar2 default null,
    p_prn_output_file_name          in varchar2 default null,
    p_prn_content_disposition       in varchar2 default null,
    p_prn_document_header           in varchar2 default null,
    p_prn_units                     in varchar2 default null,
    p_prn_paper_size                in varchar2 default null,
    p_prn_width_units               in varchar2 default null,
    p_prn_width                     in number   default null,
    p_prn_height                    in number   default null,
    p_prn_orientation               in varchar2 default null,
    p_prn_page_header               in varchar2 default null,
    p_prn_page_header_font_color    in varchar2 default null,
    p_prn_page_header_font_family   in varchar2 default null,
    p_prn_page_header_font_weight   in varchar2 default null,
    p_prn_page_header_font_size     in varchar2 default null,
    p_prn_page_footer               in varchar2 default null,
    p_prn_page_footer_font_color    in varchar2 default null,
    p_prn_page_footer_font_family   in varchar2 default null,
    p_prn_page_footer_font_weight   in varchar2 default null,
    p_prn_page_footer_font_size     in varchar2 default null,
    p_prn_header_bg_color           in varchar2 default null,
    p_prn_header_font_color         in varchar2 default null,
    p_prn_header_font_family        in varchar2 default null,
    p_prn_header_font_weight        in varchar2 default null,
    p_prn_header_font_size          in varchar2 default null,
    p_prn_body_bg_color             in varchar2 default null,
    p_prn_body_font_color           in varchar2 default null,
    p_prn_body_font_family          in varchar2 default null,
    p_prn_body_font_weight          in varchar2 default null,
    p_prn_body_font_size            in varchar2 default null,
    p_prn_border_width              in number   default null,
    --
    p_shared_query_id               in number   default null,
    --
    p_query_asc_image               in varchar2 default 'arrow_down_gray_dark.gif',
    p_query_asc_image_attr          in varchar2 default 'width="13" height="12"',
    p_query_desc_image              in varchar2 default 'arrow_up_gray_dark.gif',
    p_query_desc_image_attr         in varchar2 default 'width="13" height="12"',
    --
    p_plug_query_exp_filename       in varchar2 default null,
    p_plug_query_exp_separator      in varchar2 default null,
    p_plug_query_exp_enclosed_by    in varchar2 default null,
    p_plug_query_strip_html         in varchar2 default null,
    --
    p_required_patch                in varchar2 default null,
    p_comment                       in varchar2 default null,
    --
    p_plug_column_width             in varchar2 default null,
    --
    p_prn_page_header_alignment     in varchar2 default null,
    p_prn_page_footer_alignment     in varchar2 default null,
    p_prn_border_color              in varchar2 default null,
    p_sort_null                     in varchar2 default null,
    --
    p_plug_caching                  in varchar2 default null,
    p_plug_caching_session_state    in varchar2 default null,
    p_plug_caching_max_age_in_sec   in varchar2 default null,
    p_plug_cache_when_cond_type     in varchar2 default null,
    p_plug_cache_when_condition_e1  in varchar2 default null,
    p_plug_cache_when_condition_e2  in varchar2 default null,
    --
    p_id_offset                     in number   default 0,
    p_target                        in varchar2 default 'PRIME')
    ;

procedure create_report_columns(
    p_id                             in number default null,
    p_region_id                      in number default null,
    p_flow_id                        in number default null,
    p_query_column_id                in number default null,
    p_form_element_id                in number default null,
    p_column_alias                   in varchar2 default null,
    p_column_display_sequence        in varchar2 default null,
    p_column_heading                 in varchar2 default null,
    p_column_format                  in varchar2 default null,
    p_column_html_expression         in varchar2 default null,
    p_column_css_class               in varchar2 default null,
    p_column_css_style               in varchar2 default null,
    p_column_hit_highlight           in varchar2 default null,
    p_column_link                    in varchar2 default null,
    p_column_linktext                in varchar2 default null,
    p_column_link_attr               in varchar2 default null,
    p_column_alignment               in varchar2 default 'LEFT',
    p_heading_alignment              in varchar2 default 'CENTER',
    p_default_sort_column_sequence   in varchar2 default null,
    p_default_sort_dir               in varchar2 default null,
    p_disable_sort_column            in varchar2 default 'Y',
    p_sum_column                     in varchar2 default 'N',
    p_hidden_column                  in varchar2 default 'N',
    p_display_when_cond_type         in varchar2 default null,
    p_display_when_condition         in varchar2 default null,
    p_display_when_condition2        in varchar2 default null,
    p_report_column_required_role    in varchar2 default null,
    p_security_group_id              in varchar2 default null,
    p_last_updated_by                in varchar2 default null,
    p_last_updated_on                in varchar2 default null,
    p_display_as                     in varchar2 default 'WITHOUT_MODIFICATION',
    p_named_lov                      in varchar2 default null,
    p_inline_lov                     in varchar2 default null,
    p_lov_show_nulls                 in varchar2 default null,
    p_lov_null_text                  in varchar2 default null,
    p_lov_null_value                 in varchar2 default null,
    p_column_width                   in varchar2 default null,
    p_column_height                  in varchar2 default null,
    p_cattributes                    in varchar2 default null,
    p_cattributes_element            in varchar2 default null,
    --
    p_pk_col_source_type             in varchar2 default null,
    p_pk_col_source                  in varchar2 default null,
    p_derived_column                 in varchar2 default null,
    --
    p_column_default                 in varchar2 default null,
    p_column_default_type            in varchar2 default null,
    p_lov_display_extra              in varchar2 default null,
    --
    p_include_in_export             in varchar2 default null,
    p_print_col_width               in varchar2 default null,
    p_print_col_align               in varchar2 default null,
    --
    p_ref_schema                     in varchar2 default null,
    p_ref_table_name                 in varchar2 default null,
    p_ref_column_name                in varchar2 default null,
    --
    p_column_link_checksum_type      in varchar2 default null,
    --
    p_column_comment                 in varchar2 default null,
    p_target                        in varchar2 default 'PRIME')
    ;

procedure create_query_definition(
    p_id                               in number default null,
    p_region_id                        in number default null,
    p_flow_id                          in number default null,
    p_reference_id                     in number default null)
    ;

procedure create_query_object(
    p_id                               in number default null,
    p_query_id                         in number default null,
    p_object_owner                     in varchar2 default null,
    p_object_name                      in varchar2 default null,
    p_object_alias                     in varchar2 default null)
    ;

procedure create_query_column(
    p_id                               in number default null,
    p_query_id                         in number default null,
    p_query_object_id                  in number default null,
    p_column_number                    in number default null,
    p_column_alias                     in varchar2 default null,
    p_column_sql_expression            in varchar2 default null,
    p_column_group_by_sequence         in varchar2 default null)
    ;

procedure create_query_condition(
    p_id                               in number default null,
    p_query_id                         in number default null,
    p_condition                        in varchar2 default null,
    p_cond_column                      in varchar2 default null,
    p_cond_id1                         in number default null,
    p_cond_id2                         in number default null,
    p_cond_root                        in varchar2 default null,
    p_operator                         in varchar2 default null)
    ;

procedure set_plug_source (
    p_id                            in number   default null,
    p_plug_source                   in varchar2 default null)
    ;

procedure set_plug_query_heading (
    p_id                            in number   default null,
    p_plug_query_heading            in varchar2 default null)
    ;

procedure create_chart_series_attr (
    p_id                            in number default null,
    p_region_id                     in number default null,
    p_series_id                     in number default null,
    p_a001                          in varchar2 default null,
    p_a002                          in varchar2 default null,
    p_a003                          in varchar2 default null,
    p_a004                          in varchar2 default null,
    p_a005                          in varchar2 default null,
    p_a006                          in varchar2 default null,
    p_a007                          in varchar2 default null,
    p_a008                          in varchar2 default null,
    p_a009                          in varchar2 default null,
    p_a010                          in varchar2 default null,
    p_a011                          in varchar2 default null,
    p_a012                          in varchar2 default null,
    p_a013                          in varchar2 default null,
    p_a014                          in varchar2 default null,
    p_a015                          in varchar2 default null,
    p_a016                          in varchar2 default null,
    p_a017                          in varchar2 default null,
    p_a018                          in varchar2 default null,
    p_a019                          in varchar2 default null,
    p_a020                          in varchar2 default null,
    p_a021                          in varchar2 default null,
    p_a022                          in varchar2 default null,
    p_a023                          in varchar2 default null,
    p_a024                          in varchar2 default null,
    p_a025                          in varchar2 default null,
    p_a026                          in varchar2 default null,
    p_a027                          in varchar2 default null,
    p_a028                          in varchar2 default null,
    p_a029                          in varchar2 default null,
    p_a030                          in varchar2 default null,
    p_a031                          in varchar2 default null,
    p_a032                          in varchar2 default null,
    p_a033                          in varchar2 default null,
    p_a034                          in varchar2 default null,
    p_a035                          in varchar2 default null,
    p_a036                          in varchar2 default null,
    p_a037                          in varchar2 default null,
    p_a038                          in varchar2 default null,
    p_a039                          in varchar2 default null,
    p_a040                          in varchar2 default null,
    p_a041                          in varchar2 default null,
    p_a042                          in varchar2 default null,
    p_a043                          in varchar2 default null,
    p_a044                          in varchar2 default null,
    p_a045                          in varchar2 default null,
    p_a046                          in varchar2 default null,
    p_a047                          in varchar2 default null,
    p_a048                          in varchar2 default null,
    p_a049                          in varchar2 default null,
    p_a050                          in varchar2 default null,
    --
    p_id_offset                     in number   default 0,
    p_target                        in varchar2 default 'PRIME')
    ;

procedure create_generic_attr (
    p_id                            in number   default null,
    p_region_id                     in number   default null,
    p_attribute_id                  in number   default null,
    p_attribute_value               in varchar2 default null,
    --
    p_id_offset                     in number   default 0,
    p_target                        in varchar2 default 'PRIME')
    ;

procedure create_region_rpt_cols (
    --
    -- Updatable report columns define attributes of regions
    -- of type UPDATABLE_SQL_QUERY.
    --
    p_id                            in number,
    p_FLOW_ID                       in number,
    p_PLUG_ID                       in number,
    p_COLUMN_SEQUENCE               in number,
    p_QUERY_COLUMN_NAME             in varchar2,
    p_DISPLAY_AS                    in varchar2 default null,
    p_NAMED_LOV                     in number   default null,
    p_INLINE_LOV                    in varchar2 default null,
    p_LOV_SHOW_NULLS                in varchar2 default null,
    p_LOV_NULL_TEXT                 in varchar2 default null,
    p_LOV_NULL_VALUE                in varchar2 default null,
    p_COLUMN_WIDTH                  in number   default null,
    p_COLUMN_HEIGHT                 in number   default null,
    p_CATTRIBUTES                   in varchar2 default null,
    p_COLUMN_COMMENT                in varchar2 default null,
    --
    p_id_offset                 in number   default 0,
    p_target                    in varchar2 default 'PRIME')
    ;


procedure create_calendar (
    --
    -- create calendar and easy_calendar
    --
    p_id                            in number   default null,
    p_flow_id                       in number   default null,
    p_page_id                       in number   default null,
    p_plug_name                     in varchar2 default null,
    p_region_name                   in varchar2 default null,
    p_plug_template                 in number   default null,
    p_plug_display_sequence         in varchar2 default null,
    p_REGION_ATTRIBUTES             in varchar2 default null,
    p_report_attributes             in varchar2 default null,
    p_plug_display_column           in varchar2 default null,
    p_plug_display_point            in varchar2 default null,
    p_plug_source                   in varchar2 default null,
    p_plug_source_type              in varchar2 default null,
    p_plug_display_error_message    in varchar2 default null,
    p_plug_required_role            in varchar2 default null,
    p_plug_display_when_condition   in varchar2 default null,

    p_plug_display_when_cond2       in varchar2 default null,
    p_plug_display_condition_type   in varchar2 default null,
    p_plug_header                   in varchar2 default null,
    p_plug_footer                   in varchar2 default null,
    p_plug_override_reg_pos         in varchar2 default null,
    p_plug_customized               in varchar2 default null,
    p_plug_customized_name          in varchar2 default null,
    p_translate_title               in varchar2 default null,
    --
    p_plug_caching                  in varchar2 default null,
    p_plug_caching_session_state    in varchar2 default null,
    p_plug_caching_max_age_in_sec   in varchar2 default null,
    p_plug_cache_when_cond_type     in varchar2 default null,
    p_plug_cache_when_condition_e1  in varchar2 default null,
    p_plug_cache_when_condition_e2  in varchar2 default null,
    --
    p_required_patch                in varchar2 default null,
    p_plug_comment                  in varchar2 default null,
    --
    p_cal_id                        in number          default null,
    p_start_date                    in varchar2        default null,
    p_end_date                      in varchar2        default null,
    p_begin_at_start_of_interval    in varchar2        default 'Y',
    p_date_item                     in varchar2        default null,
    p_display_as                    in varchar2        default null,
    p_display_item                  in varchar2        default null,
    p_display_type                  in varchar2        default null,
    p_item_format                   in varchar2        default null,
    p_easy_sql_owner                in varchar2        default null,
    p_easy_sql_table                in varchar2        default null,
    p_date_column                   in varchar2        default null,
    p_display_column                in varchar2        default null,
    p_template_id                   in number          default null,
    p_start_of_week                 in number          default null,
    p_day_link                      in varchar2        default null,
    p_item_link                     in varchar2        default null,
    p_start_time                    in varchar2        default null,
    p_end_time                      in varchar2        default null,
    p_time_format                   in varchar2        default null,
    p_week_start_day                in varchar2        default null,
    p_week_end_day                  in varchar2        default null,
    p_date_type_column              in varchar2        default null,
    p_calendar_type                 in varchar2        default null,
    p_calendar_comments             in varchar2        default null,
    --
    p_plug_column_width             in varchar2 default null,
    p_id_offset                     in number   default 0,
    p_target                        in varchar2 default 'PRIME');
--
-- B U G
--

procedure create_bug (
    p_id                        in number   default null,
    p_flow_id                   in number   default null,
    p_page_id                   in number   default null,
    p_bug_description           in varchar2 default null,
    p_bug_priority              in varchar2 default null,
    p_bug_status_code           in varchar2 default null,
    p_bug_reported_by           in varchar2 default null,
    p_bug_reported_on           in date     default null,
    p_bug_assigned_to           in varchar2 default null,
    p_bug_assigned_on           in date     default null,
    p_bug_fix_in_version        in varchar2 default null,
    p_bug_projected_close_date  in date     default null,
    p_bug_close_date            in date     default null,
    p_bug_affected_files_or_mod in varchar2 default null,
    p_bug_text                  in varchar2 default null,
    p_bug_how_to_reproduce      in varchar2 default null,
    p_bug_workaround            in varchar2 default null,
    p_bug_additional_text       in varchar2 default null,
    p_bug_work_log              in varchar2 default null,
    p_bug_last_updated_by       in varchar2 default null,
    p_bug_last_updated_on       in date     default null,
    --
    p_id_offset                 in number   default 0,
    p_target                    in varchar2 default 'PRIME')
    ;



--
-- L I S T S
--



procedure create_list (
    p_id                        in number   default null,
    p_flow_id                   in number   default null,
    p_name                      in varchar2 default null,
    p_list_status               in varchar2 default null,
    p_list_displayed            in varchar2 default null,
    p_display_row_template_id   in number   default null,
    p_required_patch            in number   default null,
    --
    p_id_offset                 in number   default 0,
    p_target                    in varchar2 default 'PRIME')
    ;


procedure create_list_item (
    p_id                         in number   default null,
    p_list_id                    in number   default null,
    p_list_item_type             in varchar2 default null,
    p_list_item_status           in varchar2 default null,
    p_item_displayed             in varchar2 default null,
    p_list_item_display_sequence in number   default null,
    p_list_item_link_text        in varchar2 default null,
    p_list_item_link_target      in varchar2 default null,
    p_list_item_icon             in varchar2 default null,
    p_list_item_icon_attributes  in varchar2 default null,
    p_list_item_disp_cond_type   in varchar2 default null,
    p_list_item_disp_condition   in varchar2 default null,
    p_list_item_disp_cond_type2  in varchar2 default null,
    p_list_item_disp_condition2  in varchar2 default null,
    --
    p_list_item_icon_exp         in varchar2 default null,
    p_list_item_icon_exp_attr    in varchar2 default null,
    p_list_item_parent_id        in number default null,
    p_parent_list_item_id        in number default null,
    p_sub_item_count             in number default null,
    --
    p_list_countclicks_y_n       in varchar2 default null,
    p_list_countclicks_cat       in varchar2 default null,
    p_list_text_01               in varchar2 default null,
    p_list_text_02               in varchar2 default null,
    p_list_text_03               in varchar2 default null,
    p_list_text_04               in varchar2 default null,
    p_list_text_05               in varchar2 default null,
    p_list_text_06               in varchar2 default null,
    p_list_text_07               in varchar2 default null,
    p_list_text_08               in varchar2 default null,
    p_list_text_09               in varchar2 default null,
    p_list_text_10               in varchar2 default null,
    p_list_item_owner            in varchar2 default null,
    p_list_item_current_for_pages in varchar2 default null,
    p_list_item_current_type     in varchar2 default null,
    p_security_scheme            in varchar2 default null,
    p_required_patch             in number   default null,
    --
    p_id_offset                 in number   default 0,
    p_target                    in varchar2 default 'PRIME')
    ;


procedure set_list_item_sequence (
    p_id                         in number   default null,
    p_item_sequence              in number   default null)
    ;

procedure set_list_item_link_text (
    p_id                         in number   default null,
    p_link_text                  in varchar2 default null)
    ;
procedure set_list_item_link_target (
    p_id                         in number   default null,
    p_link_target                in varchar2 default null)
    ;

--------------------------
-- C O M M E N T S
--
procedure create_app_comments (
    p_id                         in number   default null,
    p_flow_id                    in number   default null,
    p_pages                      in varchar2 default null,
    p_app_comment                in varchar2 default null,
    p_comment_owner              in varchar2 default null,
    p_comment_flag               in varchar2 default null,
    p_app_version                in varchar2 default null,
    --
    p_created_by                 in varchar2 default null,
    p_created_on                 in varchar2 default null,
    p_updated_by                 in varchar2 default null,
    p_updated_on                 in varchar2 default null,
    --
    p_id_offset                 in number   default 0,
    p_target                    in varchar2 default 'PRIME')
    ;


--------------------------
-- T R A N S L A T I O N S
--

procedure create_dynamic_translation (
    p_id                         in number   default null,
    p_flow_id                    in number   default null,
    p_language                   in varchar2 default null,
    p_from                       in varchar2 default null,
    p_to                         in varchar2 default null,
    --
    p_id_offset                 in number   default 0,
    p_target                    in varchar2 default 'PRIME')
    ;

procedure create_message (
    p_id                         in number   default null,
    p_flow_id                    in number   default null,
    p_name                       in varchar2 default null,
    p_message_language           in varchar2 default null,
    p_message_text               in varchar2 default null,
    --
    p_id_offset                 in number   default 0,
    p_target                    in varchar2 default 'PRIME')
    ;


procedure create_language_map (
    p_id                            in number   default null,
    p_primary_language_flow_id      in number   default null,
    p_translation_flow_id           in number   default null,
    p_translation_flow_language_cd  in varchar2 default null,
    p_translation_image_directory   in varchar2 default null,
    p_translation_comments          in varchar2 default null,
    --
    p_id_offset                 in number   default 0,
    p_target                    in varchar2 default 'PRIME')
    ;

procedure create_translation (
    p_id                            in number default null,
    p_translated_flow_id            in number default null,
    p_flow_id                       in number default null,
    p_page_id                       in number default null,
    p_TRANSLATE_TO_ID               in number default null,
    p_translate_from_id             in number default null,
    p_translate_from_flow_table     in varchar2 default null,
    p_translate_from_flow_column    in varchar2 default null,
    p_translate_to_lang_code        in varchar2 default null,
    p_translation_specific_to_item  in varchar2 default 'NO',
    p_translate_to_text             in varchar2 default null,
    p_translate_from_text           in varchar2 default null,
    --
    p_id_offset                 in number   default 0,
    p_target                    in varchar2 default 'PRIME')
    ;

procedure remove_translation (
    p_translated_flow_id            in number default null)
    ;

procedure remove_dyanamic_translation (
    p_flow_id            in number default null,
    p_language           in varchar2 default null)
    ;


procedure create_image (
    p_id                in number default null,
    p_flow_id           in number default null,
    p_image_name        in varchar2 default null,
    p_national_language in varchar2 default null,
    p_height            in number   default null,
    p_width             in number   default null,
    p_notes             in varchar2 default null,
    --
    p_id_offset                 in number   default 0,
    p_target                    in varchar2 default 'PRIME')
    ;

procedure create_or_remove_file (
    p_name                      in varchar2,
    p_varchar2_table            in dbms_sql.varchar2_table default empty_varchar2_table,
    p_mimetype                  in varchar2 default null,
    p_location                  in varchar2 default 'WORKSPACE',
    p_flow_id                   in number   default null,
    p_nlang                     in varchar2 default null,
    p_height                    in number   default null,
    p_width                     in number   default null,
    p_notes                     in varchar2 default '',
    p_mode                      in varchar2 default 'CREATE_OR_REPLACE',
    p_type                      in varchar2 default 'STATIC')
    ;

procedure create_shortcut (
    p_id                         in number   default null,
    p_flow_id                    in number   default null,
    p_shortcut_name              in varchar2 default null,
    p_shortcut_consideration_seq in number   default null,
    p_shortcut_type              in varchar2 default null,
    p_shortcut_condition_type1   in varchar2 default null,
    p_shortcut_condition1        in varchar2 default null,
    p_shortcut_condition_type2   in varchar2 default null,
    p_shortcut_condition2        in varchar2 default null,
    p_build_option               in number   default null,
    p_error_text                 in varchar2 default null,
    p_reference_id               in number default null,
    p_comments                   in varchar2 default null,
    p_shortcut                   in varchar2 default null,
    --
    p_id_offset                 in number   default 0,
    p_target                    in varchar2 default 'PRIME')
    ;


procedure create_tree  (
    p_id                        in number   default null,
    p_flow_id                   in number   default null,
    p_name                      in varchar2 default null,
    p_type                      in varchar2 default 'DYNAMIC',
    p_item                      in varchar2 default null,
    p_query                     in varchar2 default null,
    p_levels                    in number   default null,
    p_unexpanded_parent         in varchar2 default null,
    p_unexpanded_parent_last    in varchar2 default null,
    p_expanded_parent           in varchar2 default null,
    p_expanded_parent_last      in varchar2 default null,
    p_leaf_node                 in varchar2 default null,
    p_leaf_node_last            in varchar2 default null,
    p_name_link_anchor_tag      in varchar2 default null,
    p_name_link_not_anchor_tag  in varchar2 default null,
    p_indent_vertical_line      in varchar2 default null,
    p_indent_vertical_line_last in varchar2 default null,
    p_drill_up                  in varchar2 default null,
    p_before_tree               in varchar2 default null,
    p_after_tree                in varchar2 default null,
    p_level_1_template          in varchar2 default null,
    p_level_2_template          in varchar2 default null,
    --
    p_id_offset                 in number   default 0,
    p_target                    in varchar2 default 'PRIME')
    ;




----------------------------------------------------
--   F L O W   P A G E   G E N E R A T I O N      --
--                                                --
--  API for Wizard based generation of components --
----------------------------------------------------

procedure create_page_on_table (
    p_flow_id                 in number   default null,
    p_flow_step_id            in number   default null,
    p_form_page_name          in varchar2 default 'form',
    p_report_page_name        in varchar2 default 'report',
    p_table_owner             in varchar2 default null,
    p_table_name              in varchar2 default null,
    p_table_pk_column_name    in varchar2 default null,
    p_omit_column_list        in varchar2 default null,
    p_button_position         in varchar2 default 'TOP',
    p_report_page_id          in varchar2 default null,
    p_report_select_list      in varchar2 default null,
    --
    p_rpt_plug_template       in varchar2 default null,
    p_form_plug_template      in varchar2 default null,
    --
    p_where_clause            in varchar2 default null,
    p_pagination_size         in varchar2 default '10',
    p_table_bgcolor           in varchar2 default '#CCCCCC',
    p_heading_bgcolor         in varchar2 default '#CCCCCC',
    p_table_bgcolors          in varchar2 default '#DDDDFF:#CCCCFF'
    )
    ;

procedure create_report_page (
    p_flow_id             in number   default null,
    p_flow_step_id        in number   default null,
    p_page_name           in varchar2 default null,
    p_report_sql          in varchar2 default null,
    p_report_headings     in varchar2 default null,
    p_tab_set             in varchar2 default null,
    p_plug_template       in varchar2 default null,
    p_plug_display_column in varchar2 default '1',
    p_max_rows            in varchar2 default '15',
    p_report_type         in varchar2 default null) ;

procedure create_chart_page (
    p_flow_id             in number   default null,
    p_flow_step_id        in number   default null,
    p_page_name           in varchar2 default null,
    p_chart_sql           in varchar2 default null,
    p_tab_set             in varchar2 default null,
    p_scale               in varchar2 default '400',
    p_axis                in varchar2 default 'ZERO',
    p_num_mask            in varchar2 default '999,999,999,990',
    p_plug_id             in varchar2 default null,
    p_plug_display_column in varchar2 default '1')
    ;

procedure create_popup_lov_template (
    p_id                 in number   default null,
    p_security_group_id  in number   default null,
    p_flow_id            in number   default null,
    p_popup_icon         in varchar2 default null,
    p_popup_icon_attr    in varchar2 default null,
    p_popup_icon2        in varchar2 default null,
    p_popup_icon_attr2   in varchar2 default null,
    p_page_name          in varchar2 default null,
    p_page_title         in varchar2 default null,
    p_page_html_head     in varchar2 default null,
    p_page_body_attr     in varchar2 default null,
    p_before_field_text  in varchar2 default null,
    p_page_heading_text  in varchar2 default null,
    p_page_footer_text   in varchar2 default null,
    p_filter_width       in varchar2 default null,
    p_filter_max_width   in varchar2 default null,
    p_filter_text_attr   in varchar2 default null,
    p_find_button_text   in varchar2 default null,
    p_find_button_image  in varchar2 default null,
    p_find_button_attr   in varchar2 default null,
    p_close_button_text  in varchar2 default null,
    p_close_button_image in varchar2 default null,
    p_close_button_attr  in varchar2 default null,
    p_next_button_text   in varchar2 default null,
    p_next_button_image  in varchar2 default null,
    p_next_button_attr   in varchar2 default null,
    p_prev_button_text   in varchar2 default null,
    p_prev_button_image  in varchar2 default null,
    p_prev_button_attr   in varchar2 default null,
    p_after_field_text   in varchar2 default null,
    p_scrollbars         in varchar2 default null,
    p_resizable          in varchar2 default null,
    p_width              in varchar2 default null,
    p_height             in varchar2 default null,
    p_result_row_x_of_y  in varchar2 default null,
    p_result_rows_per_pg in varchar2 default null,
    p_before_result_set  in varchar2 default null,
    p_after_result_set   in varchar2 default null,
    p_when_no_data_found_message     in varchar2 default null,
    p_before_first_fetch_message     in varchar2 default null,
    p_minimum_characters_required    in number   default null,
    p_reference_id       in number   default null,
    p_translate_this_template        in varchar2 default 'N',
    --
    p_id_offset          in number   default 0,
    p_target             in varchar2 default 'PRIME',
    p_theme_id                  in number   default null,
    p_theme_class_id            in number   default null)
    ;

procedure create_menu (
    p_id                       in number   default null,
    p_flow_id                  in number   default null,
    p_name                     in varchar2 default null,
    p_security_group_id        in number   default null,
    --
    p_id_offset                in number   default 0,
    p_target                   in varchar2 default 'PRIME')
    ;

procedure create_menu_option (
    p_id                       in number   default null,
    p_parent_id                in number   default null,
    p_menu_id                  in number   default null,
    p_option_sequence          in number   default null,
    p_short_name               in varchar2 default null,
    p_long_name                in varchar2 default null,
    p_link                     in varchar2 default null,
    p_page_id                  in number   default null,
    p_also_current_for_pages   in varchar2 default null,
    p_display_when_cond_type   in varchar2 default null,
    p_display_when_condition   in varchar2 default null,
    p_display_when_condition2  in varchar2 default null,
    p_security_scheme          in varchar2 default null,
    p_required_patch           in number   default null,
    p_security_group_id        in number   default null,
    --
    p_id_offset                in number   default 0,
    p_target                   in varchar2 default 'PRIME')
    ;

procedure create_menu_template (
    p_id                       in number   default null,
    p_flow_id                  in number   default null,
    p_name                     in varchar2 default null,
    p_before_first             in varchar2 default null,
    p_current_page_option      in varchar2 default null,
    p_non_current_page_option  in varchar2 default null,
    p_menu_link_attributes     in varchar2 default null,
    p_between_levels           in varchar2 default null,
    p_after_last               in varchar2 default null,
    p_max_levels               in number   default null,
    p_start_with_node          in varchar2 default null,
    p_translate_this_template  in varchar2 default 'N',
    p_template_comments        in varchar2 default null,
    p_security_group_id        in number   default null,
    p_reference_id             in number   default null,
    --
    p_id_offset                in number   default 0,
    p_target                   in varchar2 default 'PRIME',
    --
    p_theme_id                  in number   default null,
    p_theme_class_id            in number   default null)
    ;



procedure create_web_service (
    p_id                       in number   default null,
    p_security_group_id        in number   default null,
    p_flow_id                  in number   default null,
    p_name                     in varchar2 default null,
    p_url                      in varchar2 default null,
    p_action                   in varchar2 default null,
    p_proxy_override           in varchar2 default null,
    p_soap_envelope            in varchar2 default null,
    p_flow_items_comma_delimited in varchar2 default null,
    p_static_parm_01           in varchar2 default null,
    p_static_parm_02           in varchar2 default null,
    p_static_parm_03           in varchar2 default null,
    p_static_parm_04           in varchar2 default null,
    p_static_parm_05           in varchar2 default null,
    p_static_parm_06           in varchar2 default null,
    p_static_parm_07           in varchar2 default null,
    p_static_parm_08           in varchar2 default null,
    p_static_parm_09           in varchar2 default null,
    p_static_parm_10           in varchar2 default null,
    p_stylesheet               in varchar2 default null,
    p_reference_id             in number   default null,
    --
    p_id_offset                in number   default 0,
    p_target                   in varchar2 default 'PRIME')
    ;

procedure create_ws_operations (
    p_id                       in number   default null,
    p_ws_id                    in number   default null,
    p_name                     in varchar2 default null,
    p_input_message_name       in varchar2 default null,
    p_input_message_ns         in varchar2 default null,
    p_input_message_style      in varchar2 default null,
    p_output_message_name      in varchar2 default null,
    p_output_message_ns        in varchar2 default null,
    p_output_message_style     in varchar2 default null,
    p_header_message_name      in varchar2 default null,
    p_header_message_style     in varchar2 default null,
    p_soap_action              in varchar2 default null)
    ;

procedure create_ws_parameters (
    p_id                       in number   default null,
    p_ws_opers_id              in number   default null,
    p_name                     in varchar2 default null,
    p_input_or_output          in varchar2 default null,
    p_parm_type                in varchar2 default null,
    p_type_is_xsd              in varchar2 default null,
    p_parent_id                in varchar2 default null)
    ;

procedure create_ws_process_parms_map (
    p_id                       in number   default null,
    p_parameter_id             in number   default null,
    p_process_id               in number   default null,
    p_map_type                 in varchar2 default null,
    p_parm_value               in varchar2 default null)
    ;

procedure create_auth_setup(
    p_id                        in number   default null,
    p_flow_id                   in number   default null,
    p_name                      in varchar2 default null,
    p_description               in varchar2 default null,
    p_reference_id              in number   default null,
    p_page_sentry_function      in varchar2 default null,
    p_sess_verify_function      in varchar2 default null,
    p_invalid_session_page      in varchar2 default null,
    p_invalid_session_url       in varchar2 default null,
    p_pre_auth_process          in varchar2 default null,
    p_auth_function             in varchar2 default null,
    p_post_auth_process         in varchar2 default null,
    p_cookie_name               in varchar2 default null,
    p_cookie_path               in varchar2 default null,
    p_cookie_domain             in varchar2 default null,
    p_use_secure_cookie_yn      in varchar2 default null,
    p_ldap_host                 in varchar2 default null,
    p_ldap_port                 in varchar2 default null,
    p_ldap_string               in varchar2 default null,
    p_attribute_01              in varchar2 default null,
    p_attribute_02              in varchar2 default null,
    p_attribute_03              in varchar2 default null,
    p_attribute_04              in varchar2 default null,
    p_attribute_05              in varchar2 default null,
    p_attribute_06              in varchar2 default null,
    p_attribute_07              in varchar2 default null,
    p_attribute_08              in varchar2 default null,
    p_required_patch            in varchar2 default null,
    p_security_group_id         in number   default null,
    p_target                    in varchar2 default 'PRIME')
    ;

procedure create_flash_chart (
    p_id                         in number   default null,
    p_flow_id                    in number   default null,
    p_page_id                    in number   default null,
    p_region_id                  in number   default null,
    p_default_chart_type         in varchar2 default null,
    p_chart_title                in varchar2 default null,
    p_chart_width                in number   default null,
    p_chart_height               in number   default null,
    p_chart_animation            in varchar2 default null,
    p_display_attr               in varchar2 default null,
    p_dial_tick_attr             in varchar2 default null,
    p_margins                    in varchar2 default null,
    p_omit_label_interval        in number   default null,
    --
    p_bgtype                     in varchar2 default null,
    p_bgcolor1                   in varchar2 default null,
    p_bgcolor2                   in varchar2 default null,
    p_gradient_rotation          in number   default null,
    p_color_scheme               in varchar2 default null,
    p_custom_colors              in varchar2 default null,
    --
    p_x_axis_title               in varchar2 default null,
    p_x_axis_min                 in number   default null,
    p_x_axis_max                 in number   default null,
    p_x_axis_grid_spacing        in number   default null,
    p_x_axis_prefix              in varchar2 default null,
    p_x_axis_postfix             in varchar2 default null,
    p_x_axis_group_sep           in varchar2 default null,
    p_x_axis_decimal_place       in number   default null,
    --
    p_y_axis_title               in varchar2 default null,
    p_y_axis_min                 in number   default null,
    p_y_axis_max                 in number   default null,
    p_y_axis_grid_spacing        in number   default null,
    p_y_axis_prefix              in varchar2 default null,
    p_y_axis_postfix             in varchar2 default null,
    p_y_axis_group_sep           in varchar2 default null,
    p_y_axis_decimal_place       in number   default null,
    --
    p_async_update               in varchar2 default null,
    p_async_time                 in number   default null,
    --
    p_names_font                 in varchar2 default null,
    p_names_rotation             in number   default null,
    p_values_font                in varchar2 default null,
    p_values_rotation            in number   default null,
    p_hints_font                 in varchar2 default null,
    p_legend_font                in varchar2 default null,
    p_grid_labels_font           in varchar2 default null,
    p_chart_title_font           in varchar2 default null,
    p_x_axis_title_font          in varchar2 default null,
    p_y_axis_title_font          in varchar2 default null,
    --
    p_use_chart_xml              in varchar2 default null,
    p_chart_xml                  in varchar2 default null,
    p_attribute_01               in varchar2 default null,
    p_attribute_02               in varchar2 default null,
    p_attribute_03               in varchar2 default null,
    p_attribute_04               in varchar2 default null,
    p_attribute_05               in varchar2 default null,
    --
    p_id_offset                  in number   default 0,
    p_target                     in varchar2 default 'PRIME')
    ;

procedure create_flash_chart_series (
    p_id                           in number default null,
    p_chart_id                     in number default null,
    p_flow_id                      in number default null,
    p_series_seq                   in number default null,
    p_series_name                  in varchar2 default null,
    p_series_query                 in varchar2 default null,
    p_series_query_type            in varchar2 default null,
    p_series_query_parse_opt       in varchar2 default null,
    p_series_query_no_data_found   in varchar2 default null,
    p_series_query_row_count_max   in number default null,
    --
    p_id_offset                    in number   default 0,
    p_target                       in varchar2 default 'PRIME')
    ;

procedure create_worksheet (
    p_id                         in number   default null,
    p_flow_id                    in number   default null,
    p_page_id                    in number   default null,
    p_region_id                  in number   default null,
    p_name                       in varchar2 default null,
    p_folder_id                  in number   default null,
    p_alias                      in varchar2 default null,
    p_report_id_item             in varchar2 default null,
    p_max_row_count              in varchar2 default null,
    p_max_row_count_message      in varchar2 default null,
    p_no_data_found_message      in varchar2 default null,
    p_max_rows_per_page          in varchar2 default null,
    p_search_button_label        in varchar2 default null,
    p_page_items_to_submit       in varchar2 default null,
    p_sort_asc_image             in varchar2 default null,
    p_sort_asc_image_attr        in varchar2 default null,
    p_sort_desc_image            in varchar2 default null,
    p_sort_desc_image_attr       in varchar2 default null,
    --
    p_sql_query                  in varchar2 default null,
    p_base_table_or_view         in varchar2 default null,
    p_base_pk1                   in varchar2 default null,
    p_base_pk2                   in varchar2 default null,
    p_base_pk3                   in varchar2 default null,
    p_sql_hint                   in varchar2 default null,
    --
    p_status                     in varchar2 default null,
    --
    p_allow_report_saving        in varchar2 default null,
    p_allow_report_categories    in varchar2 default null,
    p_show_nulls_as              in varchar2 default null,
    p_pagination_type            in varchar2 default null,
    p_pagination_display_pos     in varchar2 default null,
    p_button_template            in number   default null,
    p_show_finder_drop_down      in varchar2 default null,
    p_show_display_row_count     in varchar2 default null,
    p_show_search_bar            in varchar2 default null,
    p_show_search_textbox        in varchar2 default null,
    p_show_actions_menu          in varchar2 default null,
    p_actions_menu_icon          in varchar2 default null,
    p_finder_icon                in varchar2 default null,
    p_report_list_mode           in varchar2 default null,
    --
    p_show_detail_link           in varchar2 default null,
    p_show_select_columns        in varchar2 default null,
    p_show_filter                in varchar2 default null,
    p_show_sort                  in varchar2 default null,
    p_show_control_break         in varchar2 default null,
    p_show_highlight             in varchar2 default null,
    p_show_computation           in varchar2 default null,
    p_show_aggregate             in varchar2 default null,
    p_show_chart                 in varchar2 default null,
    p_show_calendar              in varchar2 default null,
    p_show_flashback             in varchar2 default null,
    p_show_reset                 in varchar2 default null,
    p_show_download              in varchar2 default null,
    p_show_help                  in varchar2 default null,
    p_download_formats           in varchar2 default null,
    p_download_filename          in varchar2 default null,
    p_csv_output_separator       in varchar2 default null,
    p_csv_output_enclosed_by     in varchar2 default null,
    --
    p_detail_link                in varchar2 default null,
    p_detail_link_text           in varchar2 default null,
    p_detail_link_attr           in varchar2 default null,
    p_detail_link_checksum_type  in varchar2 default null,
    p_detail_link_condition_type in varchar2 default null,
    p_detail_link_cond           in varchar2 default null,
    p_detail_link_cond2          in varchar2 default null,
    p_detail_link_auth_scheme    in varchar2 default null,
    --
    p_allow_exclude_null_values  in varchar2 default null,
    p_allow_hide_extra_columns   in varchar2 default null,
    --
    p_max_query_cost             in varchar2 default null,
    p_max_flashback              in varchar2 default null,
    p_worksheet_flags            in varchar2 default null,
    --
    p_description                in varchar2 default null,
    p_owner                      in varchar2 default null,
    --
    p_id_offset                  in number   default 0,
    p_target                     in varchar2 default 'PRIME');

procedure create_worksheet_column (
    p_id                      in number   default null,
    p_flow_id                 in number   default null,
    p_page_id                 in number   default null,
    p_worksheet_id            in number   default null,
    --
    p_db_column_name          in varchar2 default null,
    p_display_order           in number   default null,
    p_group_id                in number   default null,
    p_column_identifier       in varchar2 default null,
    p_column_expr             in varchar2 default null,
    p_column_label            in varchar2 default null,
    p_report_label            in varchar2 default null,
    p_sync_form_label         in varchar2 default null,
    --
    p_display_in_default_rpt  in varchar2 default null,
    p_column_html_expression  in varchar2 default null,
    p_column_link             in varchar2 default null,
    p_column_linktext         in varchar2 default null,
    p_column_link_attr        in varchar2 default null,
    p_column_link_checksum_type in varchar2 default null,
    --
    p_is_sortable             in varchar2 default null,
    p_allow_sorting           in varchar2 default null,
    p_allow_filtering         in varchar2 default null,
    p_allow_ctrl_breaks       in varchar2 default null,
    p_allow_aggregations      in varchar2 default null,
    p_allow_computations      in varchar2 default null,
    p_allow_charting          in varchar2 default null,
    --
    p_use_custom              in varchar2 default null,
    p_custom_filter           in varchar2 default null,
    p_base_column             in varchar2 default null,
    p_allow_filters           in varchar2 default null,
    --
    p_others_may_edit         in varchar2 default null,
    p_others_may_view         in varchar2 default null,
    --
    p_column_type             in varchar2 default null,
    p_display_as              in varchar2 default null,
    p_display_text_as         in varchar2 default null,
    p_heading_alignment       in varchar2 default null,
    p_column_alignment        in varchar2 default null,
    p_max_length              in number   default null,
    p_display_width           in number   default null,
    p_display_height          in number   default null,
    --
    p_allow_null              in varchar2 default null,
    p_format_mask             in varchar2 default null,
    p_fact_table_key          in varchar2 default null,
    p_dimension_table         in varchar2 default null,
    p_dimension_table_id      in varchar2 default null,
    p_dimension_table_value   in varchar2 default null,
    --
    p_rpt_distinct_lov        in varchar2 default null,
    p_rpt_lov                 in varchar2 default null,
    p_rpt_named_lov           in number   default null,
    p_rpt_show_filter_lov     in varchar2 default null,
    p_rpt_filter_date_ranges  in varchar2 default null,
    --
    p_static_lov              in varchar2 default null,
    p_lov_null_text           in varchar2 default null,
    p_lov_allow_new_values    in varchar2 default null,
    p_lov_is_distinct_values  in varchar2 default null,
    p_lov_num_columns         in number   default null,
    p_lov_id                  in number   default null,
    --
    p_computation_type        in varchar2 default null,
    p_computation_expr_1      in varchar2 default null,
    p_computation_expr_2      in varchar2 default null,
    --
    p_validation_type         in varchar2 default null,
    p_validation_expr_1       in varchar2 default null,
    p_validation_expr_2       in varchar2 default null,
    --
    p_display_condition_type  in varchar2 default null,
    p_display_condition       in varchar2 default null,
    p_display_condition2      in varchar2 default null,
    --
    p_default_value           in varchar2 default null,
    p_default_when            in varchar2 default null,
    p_help_text               in varchar2 default null,
    p_security_scheme         in varchar2 default null,
    p_column_flags            in varchar2 default null,
    p_column_comment          in varchar2 default null,
    --
    p_id_offset               in number   default 0,
    p_target                  in varchar2 default 'PRIME');

procedure create_worksheet_col_group (
    p_id                      in number   default null,
    p_flow_id                 in number   default null,
    p_worksheet_id            in number   default null,
    p_name                    in varchar2 default null,
    p_description             in varchar2 default null,
    p_display_sequence        in number   default null,
    --
    p_id_offset               in number   default 0,
    p_target                  in varchar2 default 'PRIME');

procedure create_worksheet_rpt (
    p_id                      in number   default null,
    p_flow_id                 in number   default null,
    p_page_id                 in number   default null,
    p_worksheet_id            in number   default null,
    p_session_id              in number   default null,
    p_base_report_id          in number   default null,
    p_application_user        in varchar2 default null,
    p_name                    in varchar2 default null,
    p_description             in varchar2 default null,
    p_report_seq              in number   default null,
    p_report_type             in varchar2 default null,
    p_status                  in varchar2 default null,
    p_category_id             in number   default null,
    p_autosave                in varchar2 default null,
    p_is_default              in varchar2 default null,
    --
    p_display_rows            in number   default null,
    p_report_columns          in varchar2 default null,
    --
    p_sort_column_1           in varchar2 default null,
    p_sort_direction_1        in varchar2 default null,
    p_sort_column_2           in varchar2 default null,
    p_sort_direction_2        in varchar2 default null,
    p_sort_column_3           in varchar2 default null,
    p_sort_direction_3        in varchar2 default null,
    p_sort_column_4           in varchar2 default null,
    p_sort_direction_4        in varchar2 default null,
    p_sort_column_5           in varchar2 default null,
    p_sort_direction_5        in varchar2 default null,
    p_sort_column_6           in varchar2 default null,
    p_sort_direction_6        in varchar2 default null,
    --
    p_break_on                in varchar2 default null,
    p_break_enabled_on        in varchar2 default null,
    p_control_break_options   in varchar2 default null,
    --
    p_sum_columns_on_break    in varchar2 default null,
    p_avg_columns_on_break    in varchar2 default null,
    p_max_columns_on_break    in varchar2 default null,
    p_min_columns_on_break    in varchar2 default null,
    p_median_columns_on_break in varchar2 default null,
    p_mode_columns_on_break   in varchar2 default null,
    p_count_columns_on_break  in varchar2 default null,
    --
    p_flashback_mins_ago      in varchar2 default null,
    p_flashback_enabled       in varchar2 default null,
    --
    p_chart_type              in varchar2 default null,
    p_chart_3d                in varchar2 default null,
    p_chart_label_column      in varchar2 default null,
    p_chart_label_title       in varchar2 default null,
    p_chart_value_column      in varchar2 default null,
    p_chart_aggregate         in varchar2 default null,
    p_chart_value_title       in varchar2 default null,
    p_chart_sorting           in varchar2 default null,
    --
    p_calendar_date_column    in varchar2 default null,
    p_calendar_display_column in varchar2 default null,
    --
    p_id_offset               in number   default 0,
    p_target                  in varchar2 default 'PRIME');

procedure create_worksheet_condition (
    p_id                    in number   default null,
    p_flow_id               in number   default null,
    p_page_id               in number   default null,
    p_worksheet_id          in number   default null,
    p_report_id             in number   default null,
    p_name                  in varchar2 default null,
    p_condition_type        in varchar2 default null,
    p_allow_delete          in varchar2 default null,
    --
    p_column_name           in varchar2 default null,
    p_operator              in varchar2 default null,
    p_expr_type             in varchar2 default null,
    p_expr                  in varchar2 default null,
    p_expr2                 in varchar2 default null,
    p_condition_sql         in varchar2 default null,
    p_condition_display     in varchar2 default null,
    --
    p_enabled               in varchar2 default null,
    --
    p_highlight_sequence    in number   default null,
    p_row_bg_color          in varchar2 default null,
    p_row_font_color        in varchar2 default null,
    p_row_format            in varchar2 default null,
    p_column_bg_color       in varchar2 default null,
    p_column_font_color     in varchar2 default null,
    p_column_format         in varchar2 default null,
    --
    p_id_offset             in number   default 0,
    p_target                in varchar2 default 'PRIME');

procedure create_worksheet_computation (
    p_id                    in number   default null,
    p_flow_id               in number   default null,
    p_page_id               in number   default null,
    p_worksheet_id          in number   default null,
    p_report_id             in number   default null,
    --
    p_db_column_name        in varchar2 default null,
    p_column_identifier     in varchar2 default null,
    p_computation_expr      in varchar2 default null,
    p_format_mask           in varchar2 default null,
    p_column_type           in varchar2 default null,
    --
    p_column_label          in varchar2 default null,
    p_report_label          in varchar2 default null,
    --
    p_id_offset             in number   default 0,
    p_target                in varchar2 default 'PRIME');

procedure create_entry_point(
    p_id                        in number   default null,
    p_flow_id                   in number   default null,
    p_name                      in varchar2 default null,
    p_page_reset                in varchar2 default null,
    p_entry_point_comment       in number   default null,
    p_security_group_id         in number   default null,
    p_target                    in varchar2 default 'PRIME')
    ;

procedure create_entry_point_args(
    p_id                        in number   default null,
    p_flow_entry_point_id       in number   default null,
    p_entry_point_arg_sequence  in varchar2 default null,
    p_entry_point_arg_item_id   in varchar2 default null,
    p_entry_point_arg_comment   in number   default null,
    p_security_group_id         in number   default null,
    p_target                    in varchar2 default 'PRIME')
    ;

procedure set_security_group_id(
    p_security_group_id in number default null)
    --
    -- This procedure allows the caller to set wwv_flow_security.g_security_group_id
    -- to the security group id of the schema they are currently running in.
    --
    ;

function get_security_group_id
    --
    -- This function returns wwv_flow_security.g_security_group_id
    --
    return number
    ;

procedure update_owner(
    -----------------------------
    -- Change flow schema (owner)
    --
    p_flow_id in number   default null,
    p_owner   in varchar2 default null)
    ;

procedure set_build_status_run_only(
    ---------------------------------------
    -- Change flow build status to RUN_ONLY
    --
    p_flow_id in number default null)
    ;

procedure delete_template(
    ------------------------------------
    -- Delete template of specified type
    --
    p_type    in varchar2 default null,
    p_flow_id in number   default null,
    p_id      in number   default null)
    ;

procedure set_page_help_text(
    ----------------------------------
    -- select page help text into clob
    --
    p_flow_id       in number   default null,
    p_flow_step_id  in number   default null,
    p_text          in varchar2 default null)
    ;

procedure set_html_page_header(
    ------------------------------------
    -- select html page header into clob
    --
    p_flow_id       in number   default null,
    p_flow_step_id  in number   default null,
    p_text          in varchar2 default null)
    ;

procedure import_script (
    p_filename        in varchar2,
    p_varchar2_table  in dbms_sql.varchar2_table,
    p_flow_id         in number default null,
    p_pathid          in number default null,
    p_name            in varchar2 default null,
    p_title           in varchar2 default null,
    p_mime_type       in varchar2 default null,
    p_dad_charset     in varchar2 default null,
    p_deleted_as_of   in date default null,
    p_content_type    in varchar2 default null,
    p_language        in varchar2 default null,
    p_description     in varchar2 default null,
    p_file_type       in varchar2 default null,
    p_file_charset    in varchar2 default null)
    ;

procedure update_page_item (
    p_flow_id              in number,
    p_page_id              in number,
    p_item_id              in number,
    p_new_sequence         in number,
    p_display_as           in varchar2,
    p_new_name             in varchar2,
    p_new_label            in varchar2,
    p_new_begin_new_line   in varchar2,
    p_new_begin_new_field  in varchar2)
    ;

procedure create_app_from_query (
    p_schema                     in varchar2,
    p_workspace_id               in number,
    p_application_name           in varchar2,
    p_authentication             in varchar2 default 'DATABASE ACCOUNT',
    p_application_id             out number,
    p_theme                      in number,
    p_theme_type                 in varchar2,
    p_sql                        in varchar2,
    p_page_name                  in varchar2 default 'Page 1',
    p_max_displayed_columns      in number default 30,
    p_group_name                 in varchar2 default null)
    ;
end wwv_flow_api;
/