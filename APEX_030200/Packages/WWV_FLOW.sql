CREATE OR REPLACE package wwv_flow as

--  Copyright (c) Oracle Corporation 1999 - 2009. All Rights Reserved.
--
--    DESCRIPTION
--      Application Express rendering engine package specification.
--
--    SECURITY
--      Publicly executable.
--
--    NOTES
--      This program shows and accepts application express pages.
--      The application express engine is also known as the flows engine.
--      Freqently called from the procedure f.
--
--    RUNTIME DEPLOYMENT: YES
--



----------------------------------------------------------------------------
-- F L O W   G L O B A L    V A R I A B L E S
--

    -------------------------
    -- flow public data types
    --
    type flow_vc_arr is table of varchar2(32767) index by binary_integer;
    empty_flow_vc_arr flow_vc_arr;
    --
    empty_vc_arr wwv_flow_global.vc_arr2;
    type vc_long_arr is table of varchar2(32767) index by binary_integer;

    empty_vc_long_arr vc_long_arr;

    type clob_arr is table of clob index by binary_integer;

    type vc_assoc_arr is table of varchar2(32767) index by varchar2(255);

    -------------------------------------
    -- Globals for generic and public use
    --
    g_image_prefix                 varchar2(255) := wwv_flow_global.g_image_prefix;
    g_company_images               varchar2(255);
    g_flow_images                  varchar2(255);
    g_id                           number;
    g_notification                 varchar2(32767) := null;
    g_global_notification          varchar2(4000) := null;
    g_value                        varchar2(32767) := null;
    g_sysdate                      date;
    g_boolean                      boolean := false;
    g_excel_format                 boolean := false;
    g_error_message_override       varchar2(4000) := null; -- if set programmatically overrides process error messages
    g_unique_page_id               number;
    g_form_painted                 boolean := false;
    g_print_success_message        varchar2(4000) := null;
    g_return_key_1                 varchar2(4000) := null;  -- used to return keys from dml operations
    g_return_key_2                 varchar2(4000) := null;  -- used to return keys from dml operations
    g_base_href                    varchar2(4000) := null;  -- BASE HREF for APEX references
    g_remote_addr                  varchar2(100)  := null;  -- remote address
    g_exec_count                   pls_integer := 0;

    ---------------------
    -- translated strings
    g_nls_edit                     varchar2(255) := 'Edit';

    ----------------------------------------------------
    -- Optimization and performance feedback information
    --
    g_use_cached_substitution_val  boolean := false;
    g_form_count                   pls_integer := 0;
    g_package_instantiated         number;
    g_ok_to_cache_sql              boolean := false;
    g_page_text_generated          boolean := false;
    g_import_in_progress           boolean := false;
    g_cached_region_count          pls_integer := 0;

    -----------------------------------
    -- Debug and error page information
    --
    g_debug                        boolean := false;        -- identifies if flow is running in debug mode
    g_unrecoverable_error          boolean := false;        -- indicates error has occured which requires error page
    g_last_query_text              varchar2(32767) := null; -- if set is the last user sql query executed

    -----------------------------------------------------
    -- security groups for virtual private database (vpd)
    --
    g_vpd                          varchar2(4000) := null;

    ----------------------------------------
    -- Authentication and login, logout info
    --
    g_authentication               varchar2(255) := null;
    g_current_user                 varchar2(255) := null;
    g_user                         varchar2(255) := null; -- corresponds to username used to login
    g_user_id                      number        := null; -- alternate primary key that identifies a user by number
    g_user_known_as                varchar2(255) := null;
    g_flow_schema_owner            constant varchar2(30)  := 'APEX_030200'; -- the owner of Oracle Application Express
    g_login_url                    varchar2(255) := null;
    g_logout_url                   varchar2(4000) := null;
    g_logo_image                   varchar2(500) := null;
    g_logo_image_attributes        varchar2(4000) := null;
    g_cookie_session_id            number := null;
    g_security_scheme              varchar2(255) := null;
    g_ex_context_authentication    boolean := false;
    g_use_zero_sid                 boolean := false;
    g_public_page_ids              wwv_flow_global.vc_arr2;
    g_public_page_aliases          wwv_flow_global.vc_arr2;
    g_public_auth_scheme           boolean := false;

    -----------------------------
    -- Optimistic Locking Globals
    --
    g_md5_checksum                 varchar2(255) := '0';

    ------------------
    -- spatial globals
    --
    g_map1                         wwv_flow_global.vc_arr2;
    g_map2                         wwv_flow_global.vc_arr2;
    g_map3                         wwv_flow_global.vc_arr2;

    ---------------------
    -- Pagination Globals
    --
    g_rownum                       pls_integer := 0;
    g_flow_current_min_row         pls_integer := 1;
    g_flow_current_max_rows        pls_integer := 10;
    g_flow_current_rows_fetched    pls_integer := 0;
    g_flow_total_row_count         pls_integer := 0;
    g_pagination_buttons_painted   boolean := false;

    ---------------------
    -- Tabular Form Globals
    --
    g_item_idx_offset              number := 0;
    g_rownum_offset                number := 0;

    ---------------------
    -- Sorting Globals
    --
    g_fsp_region_id                number := 0;

    ----------------------------
    -- Translation (NLS) Globals
    --
    g_flow_language                varchar2(255) := null;  -- language flow written in (primary langauge)
    g_flow_language_derived_from   varchar2(30);           -- how the language preference of the user is determined
    g_browser_language             varchar2(255) := null;  -- users language preference (set using lang_derived_from method)
    g_browser_version              varchar2(255) := null;  -- browser version
    g_translated_flow_id           number  := null;        -- flow ID for translated flow
    g_translated_page_id           number  := null;        -- page ID for translated flow, e.g. page_id.trans_flow_id
    g_nls_date_format              varchar2(255) := null;  -- current database format from nls_session_parameters table.
    g_nls_decimal_separator        varchar2(10)  := null;  -- current database session decimal separator (derived from NLS_NUMERIC_CHARACTERS)
    g_nls_group_separator          varchar2(10)  := null;  -- current database session numeric group separator (derived from NLS_NUMERIC_CHARACTERS)


    -----------------
    -- Fetch Counters
    --
    g_sessionCnt                   pls_integer := 0;      --
    g_roleCnt                      pls_integer := 0;      --
    g_flowCnt                      pls_integer := 0;      -- flow info found, 1 = yes, 0 = no
    g_stepCnt                      pls_integer := 0;      -- pages found
    g_itemCnt                      pls_integer := 0;      -- page items count
    g_processCnt                   pls_integer := 0;      -- page and flow processes count
    g_plugCnt                      pls_integer := 0;      -- region count
    g_buttonCnt                    pls_integer := 0;      -- page button count
    g_iconbarCnt                   pls_integer := 0;      -- nav bar icon count
    g_tabCnt                       pls_integer := 0;      -- standard tab count
    g_branchCnt                    pls_integer := 0;      -- branch count
    g_computationCnt               pls_integer := 0;      -- computations count
    g_validationCnt                pls_integer := 0;      -- validations count
    g_list_mgr_cnt                 pls_integer := 0;      --
    g_inline_validation_error_cnt  pls_integer := 0;      -- identifies number of inline errors found


    ------------------------------
    -- Substitution Variable Cache
    --
    g_substitution_item_id         wwv_flow_global.vc_arr2; --
    g_substitution_item_name       wwv_flow_global.vc_arr2; -- substitution name
    g_substitution_item_value      vc_long_arr;             -- substitution value
    g_substitution_item_filter     wwv_flow_global.vc_arr2; -- filter on input attribute 'N', 'Y'
    g_substitution_item_encrypted  wwv_flow_global.vc_arr2; -- 'Y' or 'N'
    ------------
    -- Role Info
    --
    g_required_roles               wwv_flow_global.vc_arr2;

    ----------------------
    -- Session Information
    --
    g_new_instance                 boolean := false;
    g_session_cookie               varchar2(255) := null;

    -------------------
    -- Flow Information
    --
    g_flow_id                      number;                  -- flow pk
    g_flow_theme_id                number;                  -- current theme for flow
    g_flow_alias                   varchar2(255) := null;   -- flow alphanumeric alias
    g_flow_step_id                 number;                  -- page pk
    g_instance                     number;                  -- flow session
    g_edit_cookie_session_id       number := null;          -- flow builder session
    g_page_submitted               number := null;          -- set when page posted
    g_exact_substitutions_only     varchar2(1);             -- Y or N
    g_arg_names                    wwv_flow_global.vc_arr2; -- array of item names
    g_arg_values                   wwv_flow_global.vc_arr2; -- array of item values
    g_flow_name                    varchar2(255);           -- name of flow
    g_flow_charset                 varchar2(255);           -- used in html header
    g_date_format                  varchar2(255);           -- Application default date format
    g_flow_owner                   varchar2(30);            -- for secure use wwv_flow_security.g_parse_as_schema
    g_home_link                    varchar2(4000);          -- home page for this flow
    --g_box_width                    varchar2(30);            -- obsolete ?
    g_default_page_template        varchar2(255);           --
    g_printer_friendly_template    varchar2(255);           --
    g_error_template               varchar2(255);           --
    g_webdb_logging                varchar2(30);            -- YES (insert entries into a log table), NO (do not do inserts)

    g_application_info             varchar2(4000);          -- apex 3.2 log this text in the apex log

    g_public_url_prefix            varchar2(255);           --
    g_public_user                  varchar2(255);           -- identifies public user name
    g_dbauth_url_prefix            varchar2(255);           --
    g_proxy_server                 varchar2(255);           -- used for some regions of type url and web services
    g_media_type                   varchar2(255);           -- Media Type used in Content-Type HTTP header
    g_flow_version                 varchar2(255);           --
    g_flow_status                  varchar2(30);            -- controls availability of flow
    g_build_status                 varchar2(30);            --
    g_rejoin_existing_sessions     boolean := true;         --
    g_request                      varchar2(4000);          -- method of submitting page
    g_sqlerrm                      varchar2(4000) := null;  -- unexpected sql error message to be logged into log tables
    g_err_comp_type                varchar2(255) := null;   -- sqlerrm_component_type identifies what type of component caused the error
    g_err_comp_name                varchar2(255) := null;   -- sqlerrm_component_name identifies the name of the component that raised the error
    g_cache_mode                   varchar2(1) := 'D';      -- R = rendered from cache, C = Cache Created, D = Dynamic

    ------------
    -- shortcuts
    --
    g_shortcut_name                wwv_flow_global.vc_arr2;
    g_shortcut_id                  wwv_flow_global.vc_arr2;

    -------------------
    -- Page Information
    --
    g_popup_filter                 varchar2(4000) := null;  --
    g_printer_friendly             boolean := false;        -- if true use printer friendly page template
    g_first_field_displayable      boolean := false;        --
    g_spell_check_required         boolean := false;        --
    g_step_name                    varchar2(255);           -- page name
    g_step_tab_set                 varchar2(255);           -- page current tab set
    g_step_title                   varchar2(255);           -- page title typically becomes html page title
    g_step_sub_title               varchar2(255);           -- referencable via a template
    g_step_sub_title_type          varchar2(30);            -- describes above
    g_step_media_type              varchar2(255);           -- Media Type used in Content-Type HTTP header
    g_step_first_item              varchar2(255);           -- name of item to put cursor in
    g_step_welcome_text            varchar2(4000);          -- wwv_flow_steps.welcome_text displayed after page template header
    g_step_box_welcome_text        varchar2(4000);          -- wwv_flow_steps.box_welcome_text displayed before #BOX_BODY# in page template body
    --g_step_box_footer_text         varchar2(4000);          -- obsolete ?
    g_step_footer_text             varchar2(4000);          -- wwv_flow_steps.footer_text displayed before showing page template footer
    g_step_template                varchar2(255);           -- page template
    g_step_required_role           varchar2(255);           -- priv required to view page
    g_allow_duplicate_submissions  varchar2(3);             -- Y or N
    g_head                         varchar2(32767);         -- page header for javascript etc. #HEAD#
    g_page_onload                  varchar2(32767);         -- allows control over #ONLOAD# in page template
    g_autocomplete_on_off          varchar2(3);             -- should autocomplete="off" be included in form tag
    g_cache                        varchar2(1);             -- Y or N, Y = page can be cached
    g_include_apex_css_js_yn       varchar2(1);             -- Y is default, N does not include standard apex css and js files for mobile devices

    -------------------
    -- Page Button info
    --
    g_button_id                  wwv_flow_global.n_arr;     -- pk of page button
    g_button_name                wwv_flow_global.vc_arr2;   -- becomes request when button pressed
    g_button_plug_id             wwv_flow_global.vc_arr2;   -- region in which button is displayed
    g_button_image               wwv_flow_global.vc_arr2;   -- optional image name
    g_button_image_alt           wwv_flow_global.vc_arr2;   -- button text
    g_button_position            wwv_flow_global.vc_arr2;   -- display position within region
    g_button_alignment           wwv_flow_global.vc_arr2;   -- used for some positions
    g_button_redirect_url        wwv_flow_global.vc_arr2;   -- redirect to this url, do not submit
    g_button_condition           wwv_flow_global.vc_arr2;   -- conditional attributes
    g_button_condition2          wwv_flow_global.vc_arr2;   -- conditional attributes
    g_button_condition_type      wwv_flow_global.vc_arr2;   -- conditional attributes
    g_button_image_attributes    wwv_flow_global.vc_arr2;   -- optional html image attributes
    g_button_cattributes         wwv_flow_global.vc_arr2;   -- optional html button attributes
    g_button_security_scheme     wwv_flow_global.vc_arr2;   -- security
    g_default_button_position    varchar2(30) default null; --

    -----------------
    -- Navigation Bar
    --
    g_icon_id                    wwv_flow_global.n_arr;       -- pk of nav bar icon
    g_icon_image                 wwv_flow_global.vc_arr2;     -- name of image
    g_icon_subtext               wwv_flow_global.vc_arr2;     --
    g_icon_target                wwv_flow_global.vc_arr2;     --
    g_icon_image_alt             wwv_flow_global.vc_arr2;     --
    g_icon_height                wwv_flow_global.vc_arr2;     --
    g_icon_width                 wwv_flow_global.vc_arr2;     --
    g_icon_free_text             wwv_flow_global.vc_arr2;     --
    g_icon_bar_disp_cond         wwv_flow_global.vc_arr2;     --
    g_icon_bar_disp_cond_type    wwv_flow_global.vc_arr2;     --
    g_icon_bar_flow_cond_instr   wwv_flow_global.vc_arr2;     --
    g_icon_begins_on_new_line    wwv_flow_global.vc_arr2;     --
    g_icon_colspan               wwv_flow_global.vc_arr2;     --
    g_icon_onclick               wwv_flow_global.vc_arr2;     --
    g_icon_security_scheme       wwv_flow_global.vc_arr2;     --

    --------------------------
    -- tab and parent tab info
    --
    g_tab_id                     wwv_flow_global.n_arr;       -- std tab: pk
    g_tab_set                    wwv_flow_global.vc_arr2;     -- std tab: name of tab "collection"
    g_tab_step                   wwv_flow_global.vc_arr2;     -- std tab: page
    g_tab_name                   wwv_flow_global.vc_arr2;     -- std tab: name of tab, not the display text
    g_tab_image                  wwv_flow_global.vc_arr2;     -- std tab: optional image name
    g_tab_non_current_image      wwv_flow_global.vc_arr2;     -- std tab: optional image name
    g_tab_image_attributes       wwv_flow_global.vc_arr2;     -- std tab: attributes for images
    g_tab_text                   wwv_flow_global.vc_arr2;     -- std tab: display text of tab
    g_tab_target                 wwv_flow_global.vc_arr2;     --
    g_tab_parent_id              wwv_flow_global.n_arr;       -- parent tab pk
    g_tab_parent_tabset          wwv_flow_global.vc_arr2;     -- parent tab tabset
    g_tab_parent_display_cond    wwv_flow_global.vc_arr2;     -- parent tab display condition
    g_tab_parent_display_cond2   wwv_flow_global.vc_arr2;     -- parent tab display condition2
    g_tab_parent_display_cond_ty wwv_flow_global.vc_arr2;     -- parent tab display condition type
    g_tab_parent_security_scheme wwv_flow_global.vc_arr2;     -- parent tab security scheme
    g_tab_current_on_tabset      wwv_flow_global.vc_arr2;     -- parent tab current for this standard tab set
    g_tab_also_current_for_pages wwv_flow_global.vc_arr2;     -- std tab: also current for comma delimited page list
    g_tab_plsql_condition        wwv_flow_global.vc_arr2;     --
    g_tab_plsql_condition_type   wwv_flow_global.vc_arr2;     --
    g_tab_disp_cond_text         wwv_flow_global.vc_arr2;     --
    g_tab_security_scheme        wwv_flow_global.vc_arr2;     -- sec scheme
    g_last_tab_pressed           varchar2(255);               -- when branching to a tab, this global is set
    g_current_parent_tab_text    varchar2(255) := null;       -- text of the current parent tab set

    ----------------------------
    -- page template information
    --
    g_current_tab                varchar2(4000)  default null;  --
    g_current_tab_font_attr      varchar2(255)   default null;  --
    g_non_current_tab            varchar2(4000)  default null;  --
    g_non_current_tab_font_attr  varchar2(255)   default null;  --
    g_current_image_tab          varchar2(4000)  default null;  --
    g_non_current_image_tab      varchar2(4000)  default null;  --
    g_top_current_tab            varchar2(4000)  default null;  --
    g_top_current_tab_font_attr  varchar2(255)   default null;  --
    g_top_non_curr_tab           varchar2(4000)  default null;  --
    g_top_non_curr_tab_font_attr varchar2(255)   default null;  --
    g_header_template            varchar2(32767) default null;  -- page template header
    g_box                        varchar2(32767) default null;  -- page template body
    g_footer_template            varchar2(32767) default null;  -- page template footer
    g_footer_len                 pls_integer     default null;  --
    g_footer_end                 varchar2(32767) default null;  --
    g_end_tag_printed            boolean         default true;  -- used to position edit links
    g_template_navigation_bar    varchar2(4000)  default null;  --
    g_template_navbar_entry      varchar2(4000)  default null;  -- defines a navigation bar occurance
    g_template_success_message   varchar2(4000)  default null;  -- success message page sub template
    g_body_title                 varchar2(4000)  default null;  --
    g_notification_message       varchar2(32767) default null;  -- notification message page sub template

    g_heading_bgcolor            varchar2(255)   default null;  -- obsolete ?
    g_table_bgcolor              varchar2(255)   default null;  -- obsolete ?
    g_table_cattributes          varchar2(255)   default null;  -- obsolete ?
    g_region_table_cattributes   varchar2(255)   default null;  -- obsolete ?
    g_font_size                  varchar2(255)   default null;  -- obsolete ?
    g_font_face                  varchar2(255)   default null;  -- obsolete ?

    ------------
    -- item info
    --
    g_item_id                   wwv_flow_global.vc_arr2;    -- page item pk
    g_item_name                 wwv_flow_global.vc_arr2;
    g_item_is_persistent        wwv_flow_global.vc_arr2;
    g_item_sequence             wwv_flow_global.vc_arr2;
    g_item_plug_id              wwv_flow_global.vc_arr2;
    g_item_default              wwv_flow_global.vc_arr2;
    g_item_default_type         wwv_flow_global.vc_arr2;
    g_item_prompt               wwv_flow_global.vc_arr2;
    g_item_pre_element_text     wwv_flow_global.vc_arr2;
    g_item_post_element_text    wwv_flow_global.vc_arr2;
    g_item_format_mask          wwv_flow_global.vc_arr2;
    g_item_source               wwv_flow_global.vc_arr2;
    g_item_source_type          wwv_flow_global.vc_arr2;
    g_item_source_post_computation wwv_flow_global.vc_arr2;
    g_item_display_as           wwv_flow_global.vc_arr2;
    g_item_lov                  wwv_flow_global.vc_arr2;
    g_item_lov_display_extra    wwv_flow_global.vc_arr2;
    g_item_lov_columns          wwv_flow_global.vc_arr2;
    g_item_lov_display_null     wwv_flow_global.vc_arr2;
    g_item_lov_null_text        wwv_flow_global.vc_arr2;
    g_item_lov_null_value       wwv_flow_global.vc_arr2;
    g_item_lov_translated       wwv_flow_global.vc_arr2;
    g_item_csize                wwv_flow_global.vc_arr2;
    g_item_cmaxlength           wwv_flow_global.vc_arr2;
    g_item_cHeight              wwv_flow_global.vc_arr2;
    g_item_cattributes          wwv_flow_global.vc_arr2;
    g_item_cattributes_element  wwv_flow_global.vc_arr2;
    g_item_tag_attributes       wwv_flow_global.vc_arr2;
    g_item_tag_attributes2      wwv_flow_global.vc_arr2;
    g_item_display_when         wwv_flow_global.vc_arr2;
    g_item_display_when2        wwv_flow_global.vc_arr2;
    g_item_display_when_type    wwv_flow_global.vc_arr2;
    g_item_use_cache_before_def wwv_flow_global.vc_arr2;
    g_item_begin_on_new_line    wwv_flow_global.vc_arr2;
    g_item_begin_on_new_field   wwv_flow_global.vc_arr2;
    g_item_colspan              wwv_flow_global.vc_arr2;
    g_item_rowspan              wwv_flow_global.vc_arr2;
    g_item_label_alignment      wwv_flow_global.vc_arr2;
    g_item_field_alignment      wwv_flow_global.vc_arr2;
    g_item_security_scheme      wwv_flow_global.vc_arr2;
    g_item_button_image         wwv_flow_global.vc_arr2;
    g_item_button_image_attr    wwv_flow_global.vc_arr2;
    g_item_read_only_when       wwv_flow_global.vc_arr2;
    g_item_read_only_when2      wwv_flow_global.vc_arr2;
    g_item_read_only_when_type  wwv_flow_global.vc_arr2;
    g_item_read_only_disp_attr  wwv_flow_global.vc_arr2;
    g_item_escape_on_http_input wwv_flow_global.vc_arr2;
    g_item_encrypted            wwv_flow_global.vc_arr2;

    --------------
    -- branch info
    --
    g_branch_has_occured           boolean := false;
    g_before_header_branch_occured boolean := false;
    g_db_session_branch_targets    varchar2(4000) := null;
    g_branch_to_page_accept_count  pls_integer := 0;
    g_branch_point1                varchar2(30);
    g_branch_action1               varchar2(4000);
    g_branch_point                 wwv_flow_global.vc_arr2;
    g_branch_action                wwv_flow_global.vc_arr2;
    g_branch_type1                 varchar2(4000);
    g_branch_type                  wwv_flow_global.vc_arr2;
    g_branch_when_button_id        wwv_flow_global.vc_arr2;
    g_branch_condition1            varchar2(32767);
    g_branch_condition             wwv_flow_global.vc_arr2;
    g_branch_condition_type        wwv_flow_global.vc_arr2;
    g_branch_condition_text        wwv_flow_global.vc_arr2;
    g_save_state_before_branch_yn  wwv_flow_global.vc_arr2;
    g_save_state_before_branch     varchar2(1);
    g_branch_condition_text1       varchar2(4000);
    g_branch_condition_type1       varchar2(4000);
    g_branch_security_scheme       wwv_flow_global.vc_arr2;
    g_in_process                   boolean := false;

    ---------------
    -- process info
    --
    g_process_id                   wwv_flow_global.vc_arr2;
    g_process_name                 wwv_flow_global.vc_arr2;
    g_process_sql                  wwv_flow_global.vc_arr2;
    g_process_sql_clob             clob_arr;
    g_process_point                wwv_flow_global.vc_arr2;
    g_process_type                 wwv_flow_global.vc_arr2;
    g_process_error_message        wwv_flow_global.vc_arr2;
    g_process_success_message      wwv_flow_global.vc_arr2;
    g_process_when_button_id       wwv_flow_global.vc_arr2;
    g_process_when                 wwv_flow_global.vc_arr2;
    g_process_when2                wwv_flow_global.vc_arr2;
    g_process_when_type            wwv_flow_global.vc_arr2;
    g_process_security_scheme      wwv_flow_global.vc_arr2;
    g_job                          pls_integer;
    g_process_is_stateful_y_n      wwv_flow_global.vc_arr2;
    g_process_item_name            wwv_flow_global.vc_arr2;
    g_proc_return_key_into_item1   wwv_flow_global.vc_arr2;
    g_proc_return_key_into_item2   wwv_flow_global.vc_arr2;
    g_proc_runtime_where_clause    wwv_flow_global.vc_arr2;

    ---------------------
    -- region (plug) info
    --
    g_plug_id                      wwv_flow_global.vc_arr2;
    g_plug_name                    wwv_flow_global.vc_arr2;
    g_plug_template                wwv_flow_global.vc_arr2;
    g_plug_display_column          wwv_flow_global.vc_arr2;
    g_plug_display_point           wwv_flow_global.vc_arr2;
    g_plug_source                  wwv_flow_global.vc_arr2;
    g_plug_source_type             wwv_flow_global.vc_arr2;
    g_plug_list_template_id        wwv_flow_global.vc_arr2;
    g_plug_display_error_message   wwv_flow_global.vc_arr2;
    g_plug_table_bgcolor           varchar2(255) := null;
    g_plug_heading_bgcolor         varchar2(255) := null;
    g_plug_font_size               varchar2(255) := null;
    g_plug_form_tab_attr           varchar2(4000):= null;
    g_plug_header                  wwv_flow_global.vc_arr2;
    g_plug_footer                  wwv_flow_global.vc_arr2;
    g_plug_required_role           wwv_flow_global.vc_arr2;
    g_plug_display_when_condition  wwv_flow_global.vc_arr2;
    g_plug_display_when_cond2      wwv_flow_global.vc_arr2;
    g_plug_display_condition_type  wwv_flow_global.vc_arr2;
    g_plug_column_width            wwv_flow_global.vc_arr2;
    g_plug_customized              wwv_flow_global.vc_arr2;
    g_plug_no_data_found           wwv_flow_global.vc_arr2;
    g_plug_query_more_data         wwv_flow_global.vc_arr2;
    g_plug_caching                 wwv_flow_global.vc_arr2;
    g_plug_position                varchar2(255)  := null;
    g_cached_regions               varchar2(4000) := null;
    g_plug_static_id               wwv_flow_global.vc_arr2;
    g_plug_att_sub                 wwv_flow_global.vc_arr2;

    -------------------
    -- computation info
    --
    g_computation_id              wwv_flow_global.vc_arr2;
    g_computation_type            wwv_flow_global.vc_arr2;
    g_computation_item            wwv_flow_global.vc_arr2;
    g_computation_point           wwv_flow_global.vc_arr2;
    g_computation_processed       wwv_flow_global.vc_arr2;
    g_computation                 wwv_flow_global.vc_arr2;
    g_computation_result_vc       varchar2(32767);
    g_computation_result_vc_arr   wwv_flow_global.vc_arr2;
    g_computation_result_num      number;
    g_compute_when                wwv_flow_global.vc_arr2;
    g_compute_when_text           wwv_flow_global.vc_arr2;
    g_compute_when_type           wwv_flow_global.vc_arr2;
    g_compute_security_scheme     wwv_flow_global.vc_arr2;

    --------------------
    -- list manager info
    --
    g_list_managers               wwv_flow_global.vc_arr2;

    --------------
    -- Validations
    --
    g_validation_ids_in_error     wwv_flow_global.vc_arr2;
    g_item_ids_in_error           wwv_flow_global.vc_arr2;
    g_validation_message          wwv_flow_global.vc_arr2;

    --------------------------------------------
    -- Global input values for updatable reports
    --
    g_f01             wwv_flow_global.vc_arr2;
    g_f02             wwv_flow_global.vc_arr2;
    g_f03             wwv_flow_global.vc_arr2;
    g_f04             wwv_flow_global.vc_arr2;
    g_f05             wwv_flow_global.vc_arr2;
    g_f06             wwv_flow_global.vc_arr2;
    g_f07             wwv_flow_global.vc_arr2;
    g_f08             wwv_flow_global.vc_arr2;
    g_f09             wwv_flow_global.vc_arr2;
    g_f10             wwv_flow_global.vc_arr2;
    g_f11             wwv_flow_global.vc_arr2;
    g_f12             wwv_flow_global.vc_arr2;
    g_f13             wwv_flow_global.vc_arr2;
    g_f14             wwv_flow_global.vc_arr2;
    g_f15             wwv_flow_global.vc_arr2;
    g_f16             wwv_flow_global.vc_arr2;
    g_f17             wwv_flow_global.vc_arr2;
    g_f18             wwv_flow_global.vc_arr2;
    g_f19             wwv_flow_global.vc_arr2;
    g_f20             wwv_flow_global.vc_arr2;
    g_f21             wwv_flow_global.vc_arr2;
    g_f22             wwv_flow_global.vc_arr2;
    g_f23             wwv_flow_global.vc_arr2;
    g_f24             wwv_flow_global.vc_arr2;
    g_f25             wwv_flow_global.vc_arr2;
    g_f26             wwv_flow_global.vc_arr2;
    g_f27             wwv_flow_global.vc_arr2;
    g_f28             wwv_flow_global.vc_arr2;
    g_f29             wwv_flow_global.vc_arr2;
    g_f30             wwv_flow_global.vc_arr2;
    g_f31             wwv_flow_global.vc_arr2;
    g_f32             wwv_flow_global.vc_arr2;
    g_f33             wwv_flow_global.vc_arr2;
    g_f34             wwv_flow_global.vc_arr2;
    g_f35             wwv_flow_global.vc_arr2;
    g_f36             wwv_flow_global.vc_arr2;
    g_f37             wwv_flow_global.vc_arr2;
    g_f38             wwv_flow_global.vc_arr2;
    g_f39             wwv_flow_global.vc_arr2;
    g_f40             wwv_flow_global.vc_arr2;
    g_f41             wwv_flow_global.vc_arr2;
    g_f42             wwv_flow_global.vc_arr2;
    g_f43             wwv_flow_global.vc_arr2;
    g_f44             wwv_flow_global.vc_arr2;
    g_f45             wwv_flow_global.vc_arr2;
    g_f46             wwv_flow_global.vc_arr2;
    g_f47             wwv_flow_global.vc_arr2;
    g_f48             wwv_flow_global.vc_arr2;
    g_f49             wwv_flow_global.vc_arr2;
    g_f50             wwv_flow_global.vc_arr2;
    g_fcs             wwv_flow_global.vc_arr2;
    g_survey_map      varchar2(32767);

    ---------------------------
    -- URL Tampering Prevention
    --

    g_arg_values_delimited          wwv_flow_global.vc_arr2;
    g_protected_page_ids            wwv_flow_global.n_arr;
    g_protected_page_aliases        wwv_flow_global.vc_arr2;

    --------------------------------------------
    -- Global input variables for AJAX utilities
    --
    g_widget_name		varchar2(255);
    g_widget_mod		varchar2(255);
    g_widget_action     varchar2(255);
    g_widget_action_mod	varchar2(255);
    g_widget_num_return	varchar2(255);

    g_x01             varchar2(32767);
    g_x02             varchar2(32767);
    g_x03             varchar2(32767);
    g_x04             varchar2(32767);
    g_x05             varchar2(32767);
    g_x06             varchar2(32767);
    g_x07             varchar2(32767);
    g_x08             varchar2(32767);
    g_x09             varchar2(32767);
    g_x10             varchar2(32767);
    g_clob_01         clob;

    ------------------------------------
    -- Session Timeout
    --

    g_max_session_length_sec        number;
    g_max_session_idle_sec          number;

    -------------------------------------------------------------
    -- Global array of session values updated at end of page show.
    -- Session value name is the index of the associated array.
    --
    g_deferred_session_val_ids  vc_assoc_arr;
    g_deferred_session_values   vc_assoc_arr;

    ----------------------------------------------------------------------------
    -- Global array of form item values fetched by automated row fetch processes
    -- and other globals previously in wwv_flow_dml
    --
    g_column_values             wwv_flow.flow_vc_arr;
    g_dml_blob                  blob;
    g_dml_validation_count      pls_integer := 0;
    g_dml_mimetype              varchar2(255) := null;
    g_dml_filename              varchar2(400);
    g_dml_charset               varchar2(255);
    g_dml_last_updated_date     date;
    g_dml_clob_text             clob;
    g_dml_varchar32767_text     varchar2(32767) := null;
    g_dml_rowid                 varchar2(255);
    g_dml_blob_length           number := 0;

----------------------------------------------------------------------------
-- S H O W
--
-- This procedure is the entry point for the display of application express pages.
--
--
-- p_request              -- Request which can be the tab pressed, the button pressed, an
--                           arbitrary value etc.
-- p_instance             -- Flow Session ID, must be numeric.
-- p_flow_id              -- Flow ID, must be numeric.
-- p_flow_step_id         -- Page ID, must be numeric (for example: 1)
-- p_debug                -- If "YES" then flows will display debug messages.
-- p_arg_names            -- Comma seperated list of flow item names.  Item names should
--                           have corresponding (p_arg_values) values.  For example:
--                           p_arg_names => 'A,B,C'
--                           p_arg_values=> '1,2,3'
--                           This assumes that a flow or page item called A, B, and C
--                           exists.  When called a value of 1 will be assigned to A,
--                           2 to B, etc.
-- p_arg_values           -- Comma seperated list of values that corresponds to a
--                           comma seperated list of names (p_arg_names).  The session
--                           state for the flow items identified will be set to these
--                           values.
-- p_arg_name             -- use when passing one item name, itentifies a single item name
-- p_arg_value            -- use when passing one item value, identifies a single item value
-- p_clear_cache          -- Comma seperated list of pages (e.g. 2,3,4).
--                           Sets to null the values of any flow item declared for a
--                           list of pages.
-- p_box_border           -- obsolete
-- p_printer_friendly     -- If "YES" then show page using printer friendly template.
--                           Do not generate tabs or nav bar icons.
-- p_trace                -- If "YES", generate trace file for debugging and performance tuning
-- p_company              -- ID of company (security group id) must be numeric
-- p_md5_checksum         -- checksum to prevent lost updates
-- p_last_button_pressed  -- facilitates reference to :flow_last_button_pressed


procedure show (
    p_request             in varchar2   default null,
    p_instance            in varchar2   default null,
    p_flow_id             in varchar2   default null,
    p_flow_step_id        in varchar2   default null,
    p_debug               in varchar2   default 'NO',
    p_arg_names           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_arg_values          in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_clear_cache         in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_box_border          in varchar2   default '0',
    p_printer_friendly    in varchar2   default 'NO',
    p_trace               in varchar2   default 'NO',
    p_company             in number     default null,
    p_md5_checksum        in varchar2   default '0',
    p_last_button_pressed in varchar2   default null,
    p_arg_name            in varchar2   default null,
    p_arg_value           in varchar2   default null,
    f01                   in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f02                   in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f03                   in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f04                   in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f05                   in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f06                   in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f07                   in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f08                   in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f09                   in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f10                   in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f11                   in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f12                   in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f13                   in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f14                   in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f15                   in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f16                   in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f17                   in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f18                   in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f19                   in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f20                   in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_widget_name         in varchar2   default null,
    p_widget_mod          in varchar2   default null,
    p_widget_action       in varchar2   default null,
    p_widget_action_mod   in varchar2   default null,
	p_widget_num_return   in varchar2   default null,
    x01                   in varchar2   default null,
    x02                   in varchar2   default null,
    x03                   in varchar2   default null,
    x04                   in varchar2   default null,
    x05                   in varchar2   default null,
    x06                   in varchar2   default null,
    x07                   in varchar2   default null,
    x08                   in varchar2   default null,
    x09                   in varchar2   default null,
    x10                   in varchar2   default null,
    p_clob_01             in clob       default null)
    ;


----------------------------------------------------------------------------
-- A C C E P T
--
-- This procedure accepts virtually every flow page.
-- Reference show procedure for input argument descriptions.
--
--
--
--

procedure accept (
    p_request       in varchar2   default null,
    p_instance      in varchar2   default null,
    p_flow_id       in varchar2   default null,
    p_company       in number     default null,
    p_flow_step_id  in varchar2   default null,
    p_arg_names     in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_arg_values    in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_accept_processing in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v01           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v02           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v03           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v04           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v05           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v06           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v07           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v08           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v09           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v10           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v11           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v12           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v13           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v14           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v15           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v16           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v17           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v18           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v19           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v20           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v21           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v22           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v23           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v24           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v25           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v26           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v27           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v28           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v29           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v30           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v31           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v32           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v33           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v34           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v35           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v36           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v37           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v38           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v39           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v40           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v41           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v42           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v43           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v44           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v45           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v46           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v47           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v48           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v49           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v50           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v51           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v52           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v53           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v54           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v55           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v56           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v57           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v58           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v59           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v60           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v61           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v62           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v63           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v64           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v65           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v66           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v67           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v68           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v69           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v70           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v71           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v72           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v73           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v74           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v75           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v76           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v77           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v78           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v79           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v80           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v81           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v82           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v83           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v84           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v85           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v86           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v87           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v88           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v89           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v90           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v91           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v92           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v93           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v94           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v95           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v96           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v97           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v98           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v99           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_v100          in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_t01           in varchar2   default null,
    p_t02           in varchar2   default null,
    p_t03           in varchar2   default null,
    p_t04           in varchar2   default null,
    p_t05           in varchar2   default null,
    p_t06           in varchar2   default null,
    p_t07           in varchar2   default null,
    p_t08           in varchar2   default null,
    p_t09           in varchar2   default null,
    p_t10           in varchar2   default null,
    p_t11           in varchar2   default null,
    p_t12           in varchar2   default null,
    p_t13           in varchar2   default null,
    p_t14           in varchar2   default null,
    p_t15           in varchar2   default null,
    p_t16           in varchar2   default null,
    p_t17           in varchar2   default null,
    p_t18           in varchar2   default null,
    p_t19           in varchar2   default null,
    p_t20           in varchar2   default null,
    p_t21           in varchar2   default null,
    p_t22           in varchar2   default null,
    p_t23           in varchar2   default null,
    p_t24           in varchar2   default null,
    p_t25           in varchar2   default null,
    p_t26           in varchar2   default null,
    p_t27           in varchar2   default null,
    p_t28           in varchar2   default null,
    p_t29           in varchar2   default null,
    p_t30           in varchar2   default null,
    p_t31           in varchar2   default null,
    p_t32           in varchar2   default null,
    p_t33           in varchar2   default null,
    p_t34           in varchar2   default null,
    p_t35           in varchar2   default null,
    p_t36           in varchar2   default null,
    p_t37           in varchar2   default null,
    p_t38           in varchar2   default null,
    p_t39           in varchar2   default null,
    p_t40           in varchar2   default null,
    p_t41           in varchar2   default null,
    p_t42           in varchar2   default null,
    p_t43           in varchar2   default null,
    p_t44           in varchar2   default null,
    p_t45           in varchar2   default null,
    p_t46           in varchar2   default null,
    p_t47           in varchar2   default null,
    p_t48           in varchar2   default null,
    p_t49           in varchar2   default null,
    p_t50           in varchar2   default null,
    p_t51           in varchar2   default null,
    p_t52           in varchar2   default null,
    p_t53           in varchar2   default null,
    p_t54           in varchar2   default null,
    p_t55           in varchar2   default null,
    p_t56           in varchar2   default null,
    p_t57           in varchar2   default null,
    p_t58           in varchar2   default null,
    p_t59           in varchar2   default null,
    p_t60           in varchar2   default null,
    p_t61           in varchar2   default null,
    p_t62           in varchar2   default null,
    p_t63           in varchar2   default null,
    p_t64           in varchar2   default null,
    p_t65           in varchar2   default null,
    p_t66           in varchar2   default null,
    p_t67           in varchar2   default null,
    p_t68           in varchar2   default null,
    p_t69           in varchar2   default null,
    p_t70           in varchar2   default null,
    p_t71           in varchar2   default null,
    p_t72           in varchar2   default null,
    p_t73           in varchar2   default null,
    p_t74           in varchar2   default null,
    p_t75           in varchar2   default null,
    p_t76           in varchar2   default null,
    p_t77           in varchar2   default null,
    p_t78           in varchar2   default null,
    p_t79           in varchar2   default null,
    p_t80           in varchar2   default null,
    p_t81           in varchar2   default null,
    p_t82           in varchar2   default null,
    p_t83           in varchar2   default null,
    p_t84           in varchar2   default null,
    p_t85           in varchar2   default null,
    p_t86           in varchar2   default null,
    p_t87           in varchar2   default null,
    p_t88           in varchar2   default null,
    p_t89           in varchar2   default null,
    p_t90           in varchar2   default null,
    p_t91           in varchar2   default null,
    p_t92           in varchar2   default null,
    p_t93           in varchar2   default null,
    p_t94           in varchar2   default null,
    p_t95           in varchar2   default null,
    p_t96           in varchar2   default null,
    p_t97           in varchar2   default null,
    p_t98           in varchar2   default null,
    p_t99           in varchar2   default null,
    p_t100          in varchar2   default null,
    f01             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f02             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f03             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f04             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f05             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f06             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f07             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f08             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f09             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f10             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f11             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f12             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f13             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f14             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f15             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f16             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f17             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f18             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f19             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f20             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f21             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f22             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f23             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f24             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f25             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f26             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f27             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f28             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f29             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f30             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f31             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f32             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f33             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f34             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f35             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f36             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f37             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f38             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f39             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f40             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f41             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f42             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f43             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f44             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f45             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f46             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f47             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f48             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f49             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    f50             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    fcs             in wwv_flow_global.vc_arr2 default empty_vc_arr,
    x01             in varchar2   default null,
    x02             in varchar2   default null,
    x03             in varchar2   default null,
    x04             in varchar2   default null,
    x05             in varchar2   default null,
    x06             in varchar2   default null,
    x07             in varchar2   default null,
    x08             in varchar2   default null,
    x09             in varchar2   default null,
    x10             in varchar2   default null,
    x11             in varchar2   default null,
    x12             in varchar2   default null,
    x13             in varchar2   default null,
    x14             in varchar2   default null,
    x15             in varchar2   default null,
    x16             in varchar2   default null,
    x17             in varchar2   default null,
    x18             in varchar2   default null,
    x19             in varchar2   default null,
    x20             in varchar2   default null,
    p_map1          in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_map2          in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_map3          in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_survey_map    in varchar2   default null,
    p_flow_current_min_row      in varchar2 default '1',
    p_flow_current_max_rows     in varchar2 default '10',
    p_flow_current_rows_fetched in varchar2 default '0',
    p_debug                     in varchar2 default 'NO',
    p_trace                     in varchar2 default 'NO',
    p_md5_checksum              in varchar2 default '0',
    p_page_submission_id        in varchar2 default null,
    p_ignore_01     in varchar2 default null,
    p_ignore_02     in varchar2 default null,
    p_ignore_03     in varchar2 default null,
    p_ignore_04     in varchar2 default null,
    p_ignore_05     in varchar2 default null,
    p_ignore_06     in varchar2 default null,
    p_ignore_07     in varchar2 default null,
    p_ignore_08     in varchar2 default null,
    p_ignore_09     in varchar2 default null,
    p_ignore_10     in varchar2 default null)
    ;





----------------------------------------------------------------------------
-- H E L P   S Y S T E M
--

procedure help (
    --
    -- Returns Page and Column level help from flow builder meta data
    -- repository.
    --
    -- Arguments:
    --    p_flow_id        = flow ID
    --    p_flow_step_id   = page ID
    --    p_show_item_help = YES (include item level help), NO do not show item level help
    --
    p_request        in varchar2 default null,
    p_flow_id        in varchar2 default null,
    p_flow_step_id   in varchar2 default null,
    p_show_item_help in varchar2 default 'YES',
    p_show_regions   in varchar2 default 'YES',
    --
    p_before_page_html     in varchar2 default '<p>',
    p_after_page_html      in varchar2 default null,
    p_before_region_html   in varchar2 default null,
    p_after_region_html    in varchar2 default '</td></tr></table></p>',
    p_before_prompt_html   in varchar2 default '<p><b>',
    p_after_prompt_html    in varchar2 default '</b></p>:&nbsp;',
    p_before_item_html     in varchar2 default null,
    p_after_item_html      in varchar2 default null)
    ;







----------------------------------------------------------------------------
-- U T I L I T I E S
--

function do_substitutions (
    --
    -- Perform substitutions of ampersand prefixed flow items with
    -- current flow session state for current user and current session.
    --
    p_string                       in varchar2 default null,
    p_sub_type                     in varchar2 default 'SQL',
    p_perform_oracle_substitutions in boolean default false,
    p_print_results                in boolean default false)
    return varchar2
    ;

function trim_sql (
    --
    -- Given a SQL statement , trim trailing and leading
    -- white spaces.  Optionally perform session state substitutions
    -- as well as ensuring the statement ends in a semicolon.
    --
    p_sql               in varchar2 default null,
    p_ends_in_semicolon in boolean default false,
    p_do_substitutions  in boolean default true)
    return varchar2
    ;

function trim_sql (
    --
    -- This function gets a SQL statement ready for execution
    -- Function is overloaded; p_owner may be provided in order to cause package global
    -- to be temporarily replaced with the value of p_owner in package state during
    -- the execution of this function and until its return to the caller.
    --
    p_sql               in varchar2 default null,
    p_ends_in_semicolon in boolean default false,
    p_do_substitutions  in boolean default true,
    p_owner             in varchar2)
    return varchar2
    ;

procedure set_g_nls_date_format
    ;

procedure reset_g_nls_date_format
    ;


procedure set_g_nls_decimal_separator
    ;

procedure reset_g_nls_decimal_separator
    ;

function get_nls_decimal_separator return varchar2
    ;

function get_nls_group_separator return varchar2
    ;

function get_translated_app_id return number
    ;

procedure set_g_base_href
    ;

procedure reset_g_base_href
    ;

function get_g_base_href return varchar2
    ;

function get_page_alias return varchar2
    ;

function is_custom_auth_page return boolean
    ;

----------------------------------------------------------------------------
-- E R R O R   H A N D L I N G
--
procedure show_error_message (
    p_message  in varchar2 default 'Error',
    p_footer   in varchar2 default null,
    p_query    in varchar2 default null)
    ;




----------------------------------------
-- I N T E R N A L     U T I L I T I E S
--
-- Internal utilities used by the flow engine runtime
-- that are not intened and are not useful to the
-- flows programmer.
--

function paint_formOpen
    -- Return the HTML form open tag given current flow state.
    return varchar2
    ;


function draw_icon_navigation_bar
    -- Given the current flows context return the HTML which
    -- represents the navigation icon bar.  Page templates provide
    -- navigation bar location.  Page templates need not specify a
    -- navigation bar.
    return varchar2
    ;

procedure draw_body_close
    ;

function paint_buttons (
    -- Given current flows context draw (omit the HTML) for
    -- buttons given a position and region ID.
    p_position in varchar2 default 'TOP',
    p_plug_id  in varchar2 default '0')
    return varchar2
    ;

function do_template_substitutions (
    p_string        in varchar2 default null,
    p_onLoad        in varchar2 default null)
    return varchar2
    ;

function tab_title (
    p_text     in varchar2 default null)
    return varchar2
    ;

procedure s (
    p in varchar2 default null)
    ;

procedure draw_body_open(
    p_title       in varchar2 default null,
    p_width       in varchar2 default '100%',
    p_box_border  in varchar2 default '0')
    ;

/*
function convert_display_id_to_flow_id (
   p_display_id in number)
   return number
   ;
*/

function convert_flow_alias_to_id (
     --
     -- Given a flow ID that may be an alphanumeric
     -- alias, convert it into the numeric flow ID.
     --
     p_flow_alias_or_id  in varchar2 default null,
     p_security_group_id in number   default null)
     return number
     ;



----------------------------------------------------------------------------
-- D E B U G G I N G
--
procedure debug (
    -- Given a string this will result in the generation of a debug entry
    p_string         in varchar2 default null)
    ;





----------------------------------------------------------------------------
-- S E S S I O N   S T A T E   M A N A G E M E N T
--
-- The following routines can be called to read and write session state.
--
--
--
--

function get_next_session_id
    -- Get integer ID values, session ID is a sequence, unique ID is a sequence
    -- with a random number which produces a virtual global unique ID.
    return number
    ;

function get_unique_id
    -- Return a number which is virually globally unique.
    return number
    ;

procedure clear_page_cache (
    -- Reset all cached items for a given page to null
    p_flow_page_id in number default null)
    ;

procedure null_page_cache (
    -- deprecated
    -- Reset all cached items for a given page to null
    p_flow_page_id in number default null)
    ;

procedure null_step_cache (
    -- depricated
    p_flow_step_id in number default null)
    ;

procedure clear_page_caches (
    -- Reset all cached items for pages in array to null
    p_flow_page_id in wwv_flow_global.vc_arr2 default empty_vc_arr)
    ;

procedure null_page_caches (
    -- deprecated
    p_flow_page_id in wwv_flow_global.vc_arr2 default empty_vc_arr)
    ;

procedure null_step_caches (
    -- depricated
    p_flow_step_id in wwv_flow_global.vc_arr2 default empty_vc_arr)
    ;

procedure clear_flow_cache (
    -- For the current session remove session state for the given flow.
    -- Requires g_instance to be set to the current flows session.
    p_flow_id in varchar2 default null)
    ;

procedure clear_app_cache (
    -- For the current session remove session state for the given flow.
    -- Requires g_instance to be set to the current flows session.
    p_app_id in varchar2 default null)
    ;

procedure clear_user_cache
    -- For the current users session remove session state and flow system preferences.
    -- Run this procedure if you reuse session IDs and want to run flows without
    -- the benifit of existing session state.  Requires g_instance to be set to the
    -- current flows session.
    ;

function find_item_id (
    -- Given a flow page or flow level items name return its numeric identifier.
    p_name in varchar2 default null)
    return number
    ;

function find_item_name (
    -- Given a flow page or flow level items numeric identifier return the items name.
    p_id in number default null)
    return varchar2
    ;

procedure save_in_substitution_cache (
    --
    -- Saves item in substitution cache (memory array only)
    -- Named item may not yet exist in cache.
    --
    -- name  = name of flow or page item
    -- value = value of flow or page item
    --
    p_name    in varchar2 default null,
    p_value   in varchar2 default null)
    ;

procedure update_cache_with_write (
    -- For the current session update an items cached value.  This update is persistent
    -- for the life of the flow session, unless the session state is cleared or updated.
    p_name    in varchar2 default null,
    p_value   in varchar2 default null)
    ;

procedure reset_security_check
    -- Security checks are cached to increase performance, this procedure allows you to
    -- undo the caching and thus require all security checks to be revalidated for the
    -- current user.  Use this routine if you allow a user to change "responcibilities"
    -- within an application, thus changing their authentication scheme.
    ;

function public_role_check (
    p_role      in varchar2 default null,
    p_component in varchar2 default null)
    return boolean
    ;

function public_security_check (
    -- Given the name of a flow security scheme determine if the current user
    -- passes the security check.
    p_security_scheme in varchar2)
    return boolean
    ;

function fetch_flow_item(
    -- Given a flow-level item name, locate item in current or specified
    -- flow and current or specified session and return item value.
    p_item         in varchar2,
    p_flow         in number default null,
    p_instance     in number default null)
    return varchar2
    ;

function fetch_app_item(
    -- Given a flow-level item name, locate item in current or specified
    -- flow and current or specified session and return item value.
    p_item         in varchar2,
    p_app          in number default null,
    p_instance     in number default null)
    return varchar2
    ;

------------------------------------------------------------------
-- V I R T U A L   P R I V A T E   D A T A B A S E   S U P P O R T
--
-- flows are owned by companies which are identified by a security
-- group ID.  The flow meta data repository is "sliced up" by
-- the security group id (sgid).
--

function get_sgid return number
    -- Given the current users context return the security group ID.
    ;
function get_browser_version return varchar2;
     -- return browser versiob

function get_company_name return varchar2
    -- Given the current users context return the company name.
    ;
function get_current_flow_sgid (
    -- Given a flow ID attempt to determine the security group ID.
    -- If the flow ID is unique on your flows runtime install then
    -- you will get a security group ID.
    p_flow_id    in number,
    p_company_id in number default null)
    return number
    ;

------------------------------------------------------------------
-- Stateful processes
--

function process_state(
    p_process_id in number)
    return varchar2
    ;

procedure reset_page_process(
    p_process_id in number)
    ;

procedure reset_page_processess(
    p_page_id in number)
    ;


------------------------------------------------------------------
-- A U T H E N T I C A T I O N
--

function get_custom_auth_login_url return varchar2
    -- for use with custom authentication
    ;

function replace_cgi_env(
    p_in varchar2)
    return varchar2
    ;
end wwv_flow;
/