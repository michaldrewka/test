CREATE OR REPLACE package wwv_flow_hint
as
--  Copyright (c) Oracle Corporation 1999 - 2004. All Rights Reserved.
--
--
--    DESCRIPTION
--      This package is used to get friendly name attributes from following tables:
--          wwv_flow_hnt_table_info
--          wwv_flow_hnt_column_info
--      This package can be used to better create meaningful forms and reports and other flows contructs.
--
--    NOTES
--
--
--    SECURITY
--      No grants, must be run as FLOW schema owner.
--
--    NOTES
--
--    INTERNATIONALIZATION
--      unknown
--
--    MULTI-CUSTOMER
--      unknown
--
--    CUSTOMER MAY CUSTOMIZE
--      NO
--
--    RUNTIME DEPLOYMENT: YES
--

-- Used in get_table_ui_defaults and get_col_ui_defaults

    g_form_region_title    varchar2(255)  := null;
    g_report_region_title  varchar2(255)  := null;

    g_column_id            number         := null;
    g_label                varchar2(255)  := null;
    g_help_text            varchar2(4000) := null;
    g_mask_form            varchar2(255)  := null;
    g_display_seq_form     number         := null;
    g_display_in_form      varchar2(1)    := null;
    g_display_as_form      varchar2(50)   := null;
    g_display_as_tab_form  varchar2(255)  := null;
    g_display_seq_report   number         := null;
    g_display_in_report    varchar2(1)    := null;
    g_display_as_report    varchar2(255)  := null;
    g_mask_report          varchar2(255)  := null;
    g_aggregate_by         varchar2(1)    := null;
    g_lov_query            varchar2(4000) := null;
    g_default_value        varchar2(255)  := null;
    g_required             varchar2(1)    := null;
    g_alignment            varchar2(1)    := null;
    g_display_width        number         := null;
    g_max_width            number         := null;
    g_height               number         := null;
    g_group_by             varchar2(1)    := null;
    g_searchable           varchar2(1)    := null;
    g_lov_type             varchar2(1)    := null;

-- Setting the following global to true makes all the functions and procedures pull
--   the UI Default values.  If the global is set to false (the user running the wizard
--   decided to override and not use UI Defaults), null is returned for the values.

    g_use_ui_defaults      boolean        := true;

-- The following global is used in check_schema_privs to ensure that, on import,
--    the user has privilege on the schema they are importing.

    g_schema               varchar2(30)   := null;


function table_hint_exists (
    p_schema      in varchar2,
    p_table_name  in varchar2
    ) return boolean;

function column_hint_exists (
    p_schema       in varchar2,
    p_table_name   in varchar2,
    p_column_name  in varchar2
    ) return boolean;

-- sbk, 06/11/04: This column is no longer used but function left in for now
function get_region_title (
    p_schema      in varchar2,
    p_table_name  in varchar2
    ) return varchar2;

function get_report_region_title (
    p_schema      in varchar2,
    p_table_name  in varchar2
    ) return varchar2;

function get_form_region_title (
    p_schema      in varchar2,
    p_table_name  in varchar2
    ) return varchar2;

function get_item_help (
    p_schema      in varchar2,
    p_table_name  in varchar2,
    p_column_name in varchar2
    ) return varchar2;

function get_report_mask (
    p_schema      in varchar2,
    p_table_name  in varchar2,
    p_column_name in varchar2
    ) return varchar2;

function get_form_mask (
    p_schema      in varchar2,
    p_table_name  in varchar2,
    p_column_name in varchar2
    ) return varchar2;

function get_alignment (
    p_schema      in varchar2,
    p_table_name  in varchar2,
    p_column_name in varchar2
    ) return varchar2;

function get_searchable (
    p_schema      in varchar2,
    p_table_name  in varchar2,
    p_column_name in varchar2
    ) return varchar2;

function get_required (
    p_schema      in varchar2,
    p_table_name  in varchar2,
    p_column_name in varchar2
    ) return varchar2;

function get_label (
    p_schema      in varchar2,
    p_table_name  in varchar2,
    p_column_name in varchar2
    ) return varchar2;

function get_display_in_report (
    p_schema      in varchar2,
    p_table_name  in varchar2,
    p_column_name in varchar2
    ) return varchar2;

function get_display_seq_report (
    p_schema      in varchar2,
    p_table_name  in varchar2,
    p_column_name in varchar2
    ) return number;

function get_group_by (
    p_schema       in varchar2,
    p_table_name   in varchar2,
    p_column_name  in varchar2
    ) return varchar2;

-- sbk, 06/11/04 - column not used for 1.5 or 1.6
function get_order_by_seq (
    p_schema       in varchar2,
    p_table_name   in varchar2,
    p_column_name  in varchar2
    ) return number;

-- sbk, 06/11/04 - column not used for 1.5 or 1.6
function get_order_by_asc_desc (
    p_schema       in varchar2,
    p_table_name   in varchar2,
    p_column_name  in varchar2
    ) return number;

function get_display_in_form (
    p_schema       in varchar2,
    p_table_name   in varchar2,
    p_column_name  in varchar2
    ) return varchar2;

function get_display_seq_form (
    p_schema       in varchar2,
    p_table_name   in varchar2,
    p_column_name  in varchar2
    ) return number;

function get_display_as_form (
    p_schema       in varchar2,
    p_table_name   in varchar2,
    p_column_name  in varchar2
    ) return varchar2;

function get_lov_query (
    p_schema       in varchar2,
    p_table_name   in varchar2,
    p_column_name  in varchar2
    ) return varchar2;

procedure get_lov (
    p_schema       in varchar2,
    p_table_name   in varchar2,
    p_column_name  in varchar2,
    p_lov_type     out varchar2,
    p_lov_query    out varchar2,
    p_column_id    out number
    );

function get_static_lov_string (
    p_column_id   in number
    ) return varchar2;

function get_default_value (
    p_schema       in varchar2,
    p_table_name   in varchar2,
    p_column_name  in varchar2
    ) return varchar2;

function get_display_width (
    p_schema       in varchar2,
    p_table_name   in varchar2,
    p_column_name  in varchar2
    ) return number;

function get_max_width (
    p_schema       in varchar2,
    p_table_name   in varchar2,
    p_column_name  in varchar2
    ) return number;

function get_height (
    p_schema       in varchar2,
    p_table_name   in varchar2,
    p_column_name  in varchar2
    ) return number;

function get_display_as_tab_form (
    p_schema       in varchar2,
    p_table_name   in varchar2,
    p_column_name  in varchar2
    ) return varchar2;

function get_display_as_report (
    p_schema       in varchar2,
    p_table_name   in varchar2,
    p_column_name  in varchar2
    ) return varchar2;

function get_aggregate_by (
    p_schema       in varchar2,
    p_table_name   in varchar2,
    p_column_name  in varchar2
    ) return varchar2;


procedure create_table_hint (
    p_table_id             in number   default null,
    p_schema               in varchar2 default null,
    p_table_name           in varchar2 default null,
    p_form_region_title    in varchar2 default null,
    p_report_region_title  in varchar2 default null
    );

procedure create_column_hint (
    p_column_id           in number   default null,
    p_table_id            in number   default null,
    p_column_name         in varchar2 default null,
    p_label               in varchar2 default null,
    p_help_text           in varchar2 default null,
    p_mask_form           in varchar2 default null,
    p_display_seq_form    in number   default null,
    p_display_in_form     in varchar2 default null,
    p_display_as_form     in varchar2 default null,
    p_display_as_tab_form in varchar2 default null,
    p_display_seq_report  in number   default null,
    p_display_in_report   in varchar2 default null,
    p_display_as_report   in varchar2 default null,
    p_mask_report         in varchar2 default null,
    p_aggregate_by        in varchar2 default null,
    p_lov_query           in varchar2 default null,
    p_default_value       in varchar2 default null,
    p_required            in varchar2 default null,
    p_alignment           in varchar2 default null,
    p_display_width       in number   default null,
    p_max_width           in number   default null,
    p_height              in number   default null,
    p_group_by            in varchar2 default null,
    p_order_by_seq        in number   default null,
    p_order_by_asc_desc   in varchar2 default null,
    p_searchable          in varchar2 default null
    );

procedure create_lov_data (
    p_id                 in number      default null,
    p_column_id          in number      default null,
    p_lov_disp_sequence  in number      default null,
    p_lov_disp_value     in varchar2    default null,
    p_lov_return_value   in varchar2    default null
    );

procedure remove_table_hint (
    p_table_id    in number   default null
    );

procedure remove_hint (
    p_schema          in varchar2 default null,
    p_table_name      in varchar2 default null
    );

procedure synch_hints (
    p_schema          in varchar2 default null,
    p_table_name      in varchar2 default null
    );

function display_cons_columns (
    p_owner           in varchar2,
    p_table_name      in varchar2,
    p_constraint_name in varchar2
    ) return varchar2;

function gen_lov_name (
    p_owner        in varchar2,
    p_table_name   in varchar2,
    p_column_name  in varchar2,
    p_sgid         in number,
    p_app_number   in number,
    p_page_number  in number
    ) return varchar2;


procedure get_table_ui_defaults (
    p_schema               in  varchar2,
    p_table_name           in  varchar2
    );

procedure get_col_ui_defaults (
    p_schema              in  varchar2,
    p_table_name          in  varchar2,
    p_column_name         in  varchar2
    );

function check_table (
    p_schema      in varchar2,
    p_table_name  in varchar2
    ) return varchar2;

procedure check_schema_privs;

procedure create_table_hint_priv (
    p_table_id             in number   default null,
    p_schema               in varchar2 default null,
    p_table_name           in varchar2 default null,
    p_form_region_title    in varchar2 default null,
    p_report_region_title  in varchar2 default null
    );

procedure create_column_hint_priv (
    p_column_id           in number   default null,
    p_table_id            in number   default null,
    p_column_name         in varchar2 default null,
    p_label               in varchar2 default null,
    p_help_text           in varchar2 default null,
    p_mask_form           in varchar2 default null,
    p_display_seq_form    in number   default null,
    p_display_in_form     in varchar2 default null,
    p_display_as_form     in varchar2 default null,
    p_display_as_tab_form in varchar2 default null,
    p_display_seq_report  in number   default null,
    p_display_in_report   in varchar2 default null,
    p_display_as_report   in varchar2 default null,
    p_mask_report         in varchar2 default null,
    p_aggregate_by        in varchar2 default null,
    p_lov_query           in varchar2 default null,
    p_default_value       in varchar2 default null,
    p_required            in varchar2 default null,
    p_alignment           in varchar2 default null,
    p_display_width       in number   default null,
    p_max_width           in number   default null,
    p_height              in number   default null,
    p_group_by            in varchar2 default null,
    p_order_by_seq        in number   default null,
    p_order_by_asc_desc   in varchar2 default null,
    p_searchable          in varchar2 default null
    );

procedure create_lov_data_priv (
    p_id                 in number      default null,
    p_column_id          in number      default null,
    p_lov_disp_sequence  in number      default null,
    p_lov_disp_value     in varchar2    default null,
    p_lov_return_value   in varchar2    default null
    );


procedure remove_hint_priv (
    p_schema          in varchar2 default null,
    p_table_name      in varchar2 default null
    );

function check_lov_issues (
    p_table_id in number
    ) return varchar2;

procedure create_normalize_hint (
    p_schema      in varchar2,
    p_table_name  in varchar2,
    p_column_name in varchar2,
    p_lov_query   in varchar2
    );

procedure update_table_hint (
    p_table_id             in number   default null,
    p_schema               in varchar2 default null,
    p_table_name           in varchar2 default null,
    p_form_region_title    in varchar2 default null,
    p_report_region_title  in varchar2 default null
    );

procedure update_column_hint (
    p_column_id           in number   default null,
    p_table_id            in number   default null,
    p_column_name         in varchar2 default null,
    p_label               in varchar2 default null,
    p_help_text           in varchar2 default null,
    p_mask_form           in varchar2 default null,
    p_display_seq_form    in number   default null,
    p_display_in_form     in varchar2 default null,
    p_display_as_form     in varchar2 default null,
    p_display_as_tab_form in varchar2 default null,
    p_display_seq_report  in number   default null,
    p_display_in_report   in varchar2 default null,
    p_display_as_report   in varchar2 default null,
    p_mask_report         in varchar2 default null,
    p_aggregate_by        in varchar2 default null,
    p_lov_query           in varchar2 default null,
    p_default_value       in varchar2 default null,
    p_required            in varchar2 default null,
    p_alignment           in varchar2 default null,
    p_display_width       in number   default null,
    p_max_width           in number   default null,
    p_height              in number   default null,
    p_group_by            in varchar2 default null,
    p_order_by_seq        in number   default null,
    p_order_by_asc_desc   in varchar2 default null,
    p_searchable          in varchar2 default null
    );

procedure update_lov_data (
    p_id                 in number      default null,
    p_column_id          in number      default null,
    p_lov_disp_sequence  in number      default null,
    p_lov_disp_value     in varchar2    default null,
    p_lov_return_value   in varchar2    default null
    );

procedure remove_column_hint (
    p_column_id  in number   default null
    );

procedure remove_lov_data (
    p_id  in number   default null
    );

end wwv_flow_hint;
/