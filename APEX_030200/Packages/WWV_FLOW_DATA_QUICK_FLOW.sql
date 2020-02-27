CREATE OR REPLACE package wwv_flow_data_quick_flow
as
--  Copyright (c) Oracle Corporation 2004. All Rights Reserved.
--
--
--    DESCRIPTION
--      This package creates application on a table from spreadsheet to finished application.
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


g_flow_id   number := null;
g_page_id   number := null; -- report page
g_run_link  varchar2(32767) := null;


procedure create_modules (
    p_owner                  in varchar2,
    p_table_name             in varchar2,
    -- used only for quick app on table in read write mode
    p_table_pk_column_name   in varchar2 default null,
    p_table_pk_src_type      in varchar2 default null,
    p_table_pk_src           in varchar2 default null,
    p_table_pk2_column_name  in varchar2 default null,
    p_table_pk2_src_type     in varchar2 default null,
    p_table_pk2_src          in varchar2 default null,
    -- used only for quick app on table in read write mode
    p_create_type            in varchar2 default 'NEW',
    p_create_mode            in varchar2 default 'RW',
    p_save_ui_default        in varchar2 default 'Y',
    p_flow_name              in varchar2 default 'Quick Flow',
    p_singular_name          in varchar2 default null,
    p_plural_name            in varchar2 default null,
    p_collection             in varchar2 default 'EXCEL_IMPORT',
    p_group_by               in varchar2 default null,
    p_chart_type             in varchar2 default 'PIE',
    p_report_type            in varchar2 default 'CLASSIC',
    p_aggregate_by           in varchar2 default null,
    p_aggregate_function     in varchar2 default null,
    p_string                 in clob default empty_clob(),
    p_file_name              in varchar2 default null,
    p_file_charset           in varchar2 default null,
    p_theme                  in varchar2 default null,
    p_separator              in varchar2 default '\t',
    p_enclosed_by            in varchar2 default null,
    p_currency               in varchar2 default '$',
    p_numeric_chars          in varchar2 default '.,',
    p_first_row_is_col_name  in boolean default false,
    p_load_id                in number default null,
    p_authentication         in varchar2 default 'HTMLDB'
    );

end wwv_flow_data_quick_flow;
/