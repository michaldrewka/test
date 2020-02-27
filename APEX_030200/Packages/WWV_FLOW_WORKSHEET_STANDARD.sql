CREATE OR REPLACE package wwv_flow_worksheet_standard
is
--
--
--
--  Copyright (c) Oracle Corporation 2007. All Rights Reserved.
--
--    NAME
--      wwv_flow_worksheet_standard.sql
--
--    DESCRIPTION
--      Generic worksheet APIs.
--
--    RUNTIME DEPLOYMENT: YES
--
--

    empty_vc_arr wwv_flow_global.vc_arr2;

    type col_attr_t is record (
        id                     number,
        column_expression      varchar2(4000),
        db_column_name         varchar2(255),
        column_alias           varchar2(255),
        column_identifier      varchar2(10),
        report_label           varchar2(4000),
        column_type            varchar2(255),
        format_mask            varchar2(255),
        display_as             varchar2(255),
        display_text_as        varchar2(255),
        display_order          number,
        heading_alignment      varchar2(255),
        column_alignment       varchar2(255),
        --
        filter_date_ranges     varchar2(255),
        col_index_in_query     number,
        html_expression        varchar2(4000),
        link                   varchar2(4000),
        linktext               varchar2(4000),
        link_attr              varchar2(4000),
        link_checksum_type     varchar2(255),
        --
        rpt_distinct_lov       varchar2(1),
        rpt_show_filter_lov    varchar2(1),
        rpt_lov                varchar2(4000),
        --
        fact_table_key         varchar2(4000),
        dimension_table        varchar2(4000),
        dimension_table_id     varchar2(4000),
        dimension_table_value  varchar2(4000),
        --
        display_condition_type varchar2(255),
        display_condition      varchar2(4000),
        display_condition2     varchar2(4000),
        security_scheme        varchar2(255),
        user_may_view          varchar2(1),
        user_may_edit          varchar2(1),
        show_column            varchar2(1));

    type col_arr   is table of col_attr_t index by binary_integer;
    type col_arr2  is table of col_attr_t index by varchar2(255);

    type full_col_arr  is table of wwv_flow_worksheet_columns%rowtype index by binary_integer;
    type full_col_arr2 is  table of wwv_flow_worksheet_columns%rowtype index by varchar2(255);

    type bind_arr  is table of varchar2(4000) index by varchar2(30);
    empty_bind_arr        bind_arr;

    g_pref_parent_report_id  number;
    g_pref_show_nulls        varchar2(30);
    g_pref_show_rpt_cols     varchar2(30);
    g_pref_show_rpt_settings varchar2(30);

    type col_privs is table of boolean index by varchar2(30);
    g_empty_col_privs     col_privs;
    g_user_may_view_col   col_privs;
    g_user_may_edit_col   col_privs;

    g_attachment_subquery       varchar2(255) := '(select r.id from dual where exists (select null from wwv_flow_worksheet_docs where row_id = r.id))';
    g_sticky_subquery           varchar2(255) := '(select r.id from dual where exists (select null from wwv_flow_worksheet_stick where row_id = r.id))';
    g_link_subquery             varchar2(255) := '(select r.id from dual where exists (select null from wwv_flow_worksheet_links where row_id = r.id))';

    g_attachment_alias          varchar2(30)  := 'acnt';
    g_sticky_alias              varchar2(30)  := 'scnt';
    g_link_alias                varchar2(30)  := 'lcnt';
    g_value                     varchar2(32767);

    g_running_worksheets_app    boolean := (case when wwv_flow.g_flow_id = 4900 then true else false end);

    g_canonical_date_format     varchar2(255) := 'YYYYMMDDHH24MISS';
    g_canonical_number_format   varchar2(255) := '99999999999999999999999999999999999999.99999999';
    g_nls_num_characters        varchar2(255) := 'NLS_NUMERIC_CHARACTERS=''.,''';


    function esc_ir_col_header (
        p_string in varchar2)
        return varchar2;

    ----------------------
    -- get_dbms_sql_cursor
    --
    function get_dbms_sql_cursor(
        p_query              in varchar2,
        p_owner              in varchar2 default wwv_flow_security.g_parse_as_schema,
        p_do_worksheet_binds in varchar2 default 'N',
        p_bind_array         in bind_arr default empty_bind_arr,
        p_final_query        out varchar2)
        return integer;

    function get_dbms_sql_cursor(
        p_query              in varchar2,
        p_owner              in varchar2 default wwv_flow_security.g_parse_as_schema,
        p_do_worksheet_binds in varchar2 default 'N',
        p_bind_array         in bind_arr default empty_bind_arr)
        return integer;

    -------
    -- tabs
    --
    procedure show_tabs (
       p_app_id  in number,
       p_session in number);

    ----------
    -- buttons
    --
    procedure show_worksheet_button (
       p_button_template_id in varchar2 default null,
       p_button_label       in varchar2 default null,
       p_button_link        in varchar2 default null,
       p_button_attributes  in varchar2 default null);


    --------------
    -- preferences
    --
    procedure init_worksheet_prefs (
       p_worksheet_id      in number,
       p_app_user          in varchar2);

    procedure set_worksheet_prefs (
       p_worksheet_id      in number,
       p_app_user          in varchar2,
       p_parent_report_id  in number   default g_pref_parent_report_id,
       p_show_rpt_settings in varchar2 default g_pref_show_rpt_settings,
       p_show_nulls        in varchar2 default g_pref_show_nulls,
       p_show_rpt_cols     in varchar2 default g_pref_show_rpt_cols);

    -------------------------------
    -- column computation functions
    --

    function col_heading_num_to_char (
        p_number       in number)
        return varchar2;

    function col_heading_char_to_num (
        p_char         in varchar2)
        return number;

    function get_next_identifier (
        p_worksheet_id in number)
        return varchar2;

    function get_next_computed_identifier (
        p_worksheet_id in number,
        p_report_id in number)
        return varchar2;

    function get_next_db_column_name (
        p_worksheet_id in number,
        p_column_type  in varchar2)
        return varchar2;

    function get_next_computed_column_name (
        p_worksheet_id in number,
        p_report_id in number)
        return varchar2;

    function get_next_display_order_number (
        p_worksheet_id in number)
        return number;

    function get_pseudocolumn_attributes (
        p_column_alias in varchar2)
        return col_attr_t;

    function get_db_column_name (
        p_worksheet_id in number,
        p_column_identifier in varchar2)
        return varchar2;

    function get_column_label (
       p_worksheet_id           in number,
       p_db_column_name         in varchar2,
       p_computed_column_prefix in varchar2 default null
       ) return varchar2;

    function get_column_type (
        p_worksheet_id   in number,
        p_db_column_name in varchar2)
        return varchar2;

    function get_condition_name (
        p_condition_name in varchar2,
        p_column_label   in varchar2,
        p_operator       in varchar2,
        p_expr           in varchar2,
        p_expr2          in varchar2)
        return varchar2;

    procedure get_column_attributes (
        p_worksheet_id          in number,
        p_app_user              in varchar2,
        p_report_id             in number default null,
        --
        p_column_name           in varchar2 default null,
        p_include_hidden_cols   in varchar2 default 'N',
        p_include_computed_cols in varchar2 default 'Y',
        --
        p_column_attributes         out full_col_arr,
        p_column_attributes_by_name out full_col_arr2);

    function get_single_column_attributes (
        p_worksheet_id in number,
        p_app_user     in varchar2,
        p_report_id    in number default null,
        --
        p_column_name  in varchar2)
        return wwv_flow_worksheet_columns%rowtype;

    function get_group_name (
        p_worksheet_id   in number,
        p_group_id       in number)
        return varchar2;

    function get_compute_sql (
        p_worksheet_id  in number,
        p_app_user      in varchar2,
        p_report_id     in number,
        --
        p_expr          in varchar2)
        return varchar2;


    -----------------------------
    -- dialog validations
    --

    function check_computation_expr (
        p_worksheet_id     in number,
        p_app_user         in varchar2,
        p_report_id        in number,
        --
        p_format_mask      in varchar2,
        p_computation_expr in varchar2)
    return varchar2;

    function check_flashback_time (
        p_flashback_time in varchar2)
    return varchar2;

    function check_highlight (
        p_worksheet_id   in number,
        p_app_user       in varchar2,
        p_report_id      in number,
        --
        p_condition_id   in number,
        p_name           in varchar2,
        p_sequence       in varchar2,
        p_color1         in varchar2,
        p_color2         in varchar2,
        --
        p_column         in varchar2,
        p_operator       in varchar2,
        p_expr           in varchar2,
        p_expr2          in varchar2)
    return varchar2;

    ---------------------
    -- report settings
    --

    function get_report_id (
        p_worksheet_id in number,
        p_app_user in varchar2,
        p_report_id in number,
        --
        p_create_report_if_necessary in varchar2 default 'Y')
        return number;

    function save_derived_report (
        p_worksheet_id      in number,
        p_app_user          in varchar2,
        p_base_report_id    in number,
        p_report_name       in varchar2 default null,
        p_report_descr      in varchar2 default null,
        p_category_id       in varchar2 default null,
        p_public            in varchar2 default null,
        p_is_default        in varchar2 default null)
        return number;

    procedure delete_report (
        p_worksheet_id      in number,
        p_app_user          in varchar2,
        p_report_id         in number);

    function is_column_filtered (
        p_worksheet_id        in number,
        p_app_user            in varchar2,
        p_derived_report_id   in varchar2,
        --
        p_filter_column       in varchar2)
        return varchar2;

    --
    -- security checks
    --

    function user_may_edit_worksheet (
        p_worksheet_id in number)
        return boolean;

    function user_may_edit_webpage (
        p_id in number)
        return boolean;

    function user_may_edit_folder (
        p_id in number)
        return boolean;

    function user_may_view_col (
        p_worksheet_id   in number,
        p_app_user       in varchar2,
        p_db_column_name in varchar2)
        return boolean;

    function user_may_edit_col (
        p_worksheet_id   in number,
        p_app_user       in varchar2,
        p_db_column_name in varchar2)
        return boolean;

    procedure get_col_privs (
        p_worksheet_id   in number,
        p_others_may_view  out varchar2,
        p_others_may_edit  out varchar2);

    procedure save_col_privs (
        p_worksheet_id   in number,
        p_others_may_view  in varchar2,
        p_others_may_edit  in varchar2);

    --
    -- sync report columns
    --

    procedure get_column_diff (
        p_flow_id         in  number,
        p_region_id       in  number,
        p_query           in  varchar2,
        p_removed_columns out wwv_flow_global.vc_arr2,
        p_new_columns     out wwv_flow_global.vc_arr2)
        ;

    procedure synch_report_columns (
        p_flow_id   in number,
        p_region_id in number,
        p_query     in varchar2,
        p_add_new_cols_to_default_rpt in varchar2 default 'Y')
        ;

    function is_valid_ir_query (
        p_flow_id   in number,
        p_region_id in number default null,
        p_query     in varchar2,
        p_show_detail_link in varchar2 default null,
        p_pk1       in varchar2 default null,
        p_pk2       in varchar2 default null,
        p_pk3       in varchar2 default null)
    return varchar2;

    procedure default_rpt_settings (
        p_worksheet_id  in number,
        p_rpt_cols      out varchar2,
        p_sort          out varchar2,
        p_ctrl_break    out varchar2,
        p_aggregate     out varchar2,
        p_computation   out varchar2,
        p_highlight     out varchar2,
        p_filter        out varchar2,
        p_chart         out varchar2,
        p_calendar      out varchar2
        );
end wwv_flow_worksheet_standard;
/