CREATE OR REPLACE package wwv_flow_worksheet
as

g_delete_in_progress        boolean := false;

empty_worksheet_attributes  wwv_flow_worksheets%rowtype;
empty_report_attributes     wwv_flow_worksheet_rpts%rowtype;
empty_col_arr               wwv_flow_worksheet_standard.col_arr;
empty_col_arr2              wwv_flow_worksheet_standard.col_arr2;
empty_binds                 wwv_flow_worksheet_standard.bind_arr;

g_worksheet_attributes      wwv_flow_worksheets%rowtype;
g_report_attributes         wwv_flow_worksheet_rpts%rowtype;
g_column_attributes         wwv_flow_worksheet_standard.col_arr;
g_column_attributes_by_name wwv_flow_worksheet_standard.col_arr2;
g_binds                     wwv_flow_worksheet_standard.bind_arr;

g_num_highlight_cols        number := 0;
g_num_link_cols             number := 0;
g_num_break_cols            number := 0;
g_num_visible_cols          number := 0;
g_num_hidden_cols           number := 0;
g_num_aggregate_cols        number := 0;

g_break_col_list            varchar2(32767) := null;

g_base_worksheet_table      varchar2(255) := null;
g_base_worksheet_table_pk1  varchar2(255) := null;
g_base_worksheet_table_pk2  varchar2(255) := null;
g_base_worksheet_table_pk3  varchar2(255) := null;

g_id_postfix                varchar2(255);

type num_arr is table of number index by binary_integer;


-- ------------------------------
-- procedures to populate globals
--
procedure get_worksheet_attributes (
    p_worksheet_id in number
);

procedure get_report_attributes (
    p_worksheet_id   in number,
    p_app_user       in varchar2,
    p_base_report_id in number
);

-- ----------------------------------------
-- procedure to fetch all column attributes
-- including computed columns for the
-- specified report
--
procedure get_all_column_attributes (
    p_worksheet_id        in number,
    p_app_user            in varchar2,
    p_report_id           in number default null,
    --
    p_include_hidden_cols in varchar2 default 'N',
    --
    p_column_attributes         out wwv_flow_worksheet_standard.full_col_arr,
    p_column_attributes_by_name out wwv_flow_worksheet_standard.full_col_arr2);

-- ---------------------------
-- functions returning queries
--
function get_filter_query (
    p_worksheet_id      in number,
    p_app_user          in varchar2,
    p_report_id         in number default null,
    p_derived_report_id in number default null,
    p_column            in varchar2,
    p_search_string     in varchar2 default null
) return varchar2;

function get_single_row_query (
    p_worksheet_id      in number,
    p_app_user          in varchar2,
    p_derived_report_id in number,
    --
    p_columns           in varchar2 default null,
    p_pk1               in varchar2,
    p_pk2               in varchar2 default null,
    p_pk3               in varchar2 default null
) return varchar2;

function get_worksheet_report_query (
    p_worksheet_id in number,
    p_app_user     in varchar2,
    p_report_id    in number,
    --
    p_sql_hint             in varchar2 default 'DEFAULT',
    p_highlight_list       in varchar2 default 'DEFAULT',
    p_pk_columns           in varchar2 default 'DEFAULT',
    p_select_list          in varchar2 default 'DEFAULT',
    p_aggregate_list       in varchar2 default 'DEFAULT',
    p_from                 in varchar2 default 'DEFAULT',
    p_flashback            in varchar2 default 'DEFAULT',
    p_where                in varchar2 default 'DEFAULT',
    p_group_by             in varchar2 default 'DEFAULT',
    p_order_by             in varchar2 default 'DEFAULT',
    --
    p_include_max_row_cnt  in varchar2 default 'N',
    p_include_max_row_filter in varchar2 default 'Y',
    p_exclude_column       in varchar2 default null,
    p_apply_sql_formats    in varchar2 default 'N',
    p_select_hidden_cols   in varchar2 default 'Y',
    p_exclude_special_formats in varchar2 default 'N'
    )
return varchar2;

-- -----------------------------------------
-- procedures to display interactive reports
--
procedure show_report (
    p_worksheet_id     in number,
    p_app_user         in varchar2,
    p_report_id        in number default null,
    --
    p_request          in varchar2,
    p_flow_id          in number default null,
    p_max_rows         in number default null,
    p_search_string    in varchar2 default null,
    p_show_checkbox    in varchar2 default 'N',
    p_show_report_tabs in varchar2 default null
);

procedure show_full_worksheet_region (
    p_worksheet_id     in number,
    p_app_user         in varchar2,
    p_report_id        in number default null,
    --
    p_request          in varchar2,
    --
    p_show_checkbox    in varchar2 default 'N',
    p_show_report_tabs in varchar2 default null
);

procedure show_region (
    p_region_id in number);


end wwv_flow_worksheet;
/