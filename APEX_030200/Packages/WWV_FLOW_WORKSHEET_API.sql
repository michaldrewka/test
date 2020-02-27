CREATE OR REPLACE package wwv_flow_worksheet_api
is
--
--
--
--  Copyright (c) Oracle Corporation 2007. All Rights Reserved.
--
--    NAME
--      wwv_flow_worksheet_api.sql
--
--    DESCRIPTION
--      Public worksheet APIs.
--
--    RUNTIME DEPLOYMENT: YES
--
--

g_flow_id      number;
g_worksheet_id number;


--
--
--
function get_worksheet_id (
    p_worksheet_alias     in varchar2,
    p_flow_id             in number default null)
return number;

function highlight_expr(
    p_val1 in varchar2,
    p_val2 in varchar2,
    p_expression_type in varchar2,
    p_highlight_rule in number)
return number;

function get_report_name (
    p_worksheet_id        in number,
    p_app_user            in varchar2,
    p_report_id           in number)
return varchar2;

function get_column_info (
    p_worksheet_id        in number,
    p_app_user            in varchar2,
    p_report_id           in number,
    --
    p_column              in varchar2)
return varchar2;

--------------------
-- USER PREFERENCES
--
procedure clear_worksheet_prefs (
    p_worksheet_id   in number,
    p_app_user       in varchar2);

procedure reset_pagination (
    p_child_report_id   in number);

procedure reset_pagination (
    p_worksheet_id in number,
    p_app_user     in varchar2,
    p_report_id    in number);


---------------------------
-- P U B L I C   A P I s
--(exposed in htmldb_util)
--
procedure ir_reset (
    p_page_id      in number);

procedure ir_clear (
    p_page_id      in number);

procedure ir_filter (
    p_page_id       in number,
    p_report_column in varchar2,
    p_operator_abbr in varchar2 default null,
    p_filter_value  in varchar2);

procedure ir_reset_pagination (
    p_page_id      in number);

------------------
-- SELECT COLUMNS
--
procedure hide_column (
    p_worksheet_id        in number,
    p_app_user            in varchar2,
    p_report_id           in number,
    --
    p_column              in varchar2);

procedure show_column (
    p_worksheet_id        in number,
    p_app_user            in varchar2,
    p_report_id           in number,
    --
    p_column              in varchar2);

procedure show_column_in_default_report (
    p_worksheet_id        in number,
    p_column              in varchar2);

function get_column_list (
    p_worksheet_id        in number,
    p_app_user            in varchar2,
    p_report_id           in number)
return varchar2;

procedure save_column_list (
    p_worksheet_id in number,
    p_app_user     in varchar2,
    p_report_id    in number,
    --
    p_column_list  in wwv_flow_global.vc_arr2);

/*procedure set_column_list (
    p_worksheet_id        in number,
    p_app_user            in varchar2,
    p_report_id           in number,
    --
    p_column_list         in varchar2);*/


-----------------------
-- USER DEFINED REPORTS
--
procedure reset_report_settings (
    p_worksheet_id      in number,
    p_app_user          in varchar2,
    p_report_id         in number);

procedure clear_report_settings (
    p_worksheet_id    in number,
    p_app_user        in varchar2,
    p_report_id       in number);

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

procedure rename_report (
    p_worksheet_id      in number,
    p_app_user          in varchar2,
    p_report_id         in number,
    p_report_name       in varchar2 default null,
    p_report_descr      in varchar2 default null,
    p_category_id       in varchar2 default null,
    p_public            in varchar2 default null);

procedure delete_report (
    p_worksheet_id      in number,
    p_app_user          in varchar2,
    p_report_id         in number);

procedure delete_reports_for_user (
    p_flow_id           in number,
    p_page_id           in number default null,
    p_app_user          in varchar2,
    p_delete_child_rpts in varchar2 default 'Y');

procedure delete_reports_for_app (
    p_flow_id             in number,
    p_page_id             in number default null,
    p_delete_child_rpts   in varchar2 default 'Y',
    p_delete_default_rpts in varchar2 default 'N');

-------------
-- SORTING
--
procedure sort_on_column (
    p_worksheet_id        in number,
    p_app_user            in varchar2,
    p_report_id           in number,
    --
    p_sort_column         in varchar2,
    p_sort_direction      in varchar2);

procedure save_ordering (
    p_worksheet_id        in number,
    p_app_user            in varchar2,
    p_report_id           in number,
    p_sort_column         in wwv_flow_global.vc_arr2,
    p_sort_direction      in wwv_flow_global.vc_arr2,
    p_null_sorting        in wwv_flow_global.vc_arr2);

-----------------
-- CONTROL BREAKS
--
procedure break_on_column (
    p_worksheet_id        in number,
    p_app_user            in varchar2,
    p_report_id           in number,
    --
    p_column              in varchar2);

procedure remove_break_on_column (
    p_worksheet_id        in number,
    p_app_user            in varchar2,
    p_report_id           in number,
    --
    p_column              in varchar2);

procedure toggle_break_on_column (
    p_worksheet_id        in number,
    p_app_user            in varchar2,
    p_report_id           in number,
    --
    p_column              in varchar2);

procedure set_control_breaks (
    p_worksheet_id        in number,
    p_app_user            in varchar2,
    p_report_id           in number,
    --
    p_break_on            in wwv_flow_global.vc_arr2,
    p_break_enabled_list  in wwv_flow_global.vc_arr2);

-----------
-- FILTERS
--
/*procedure add_or_update_search_filter (
    p_worksheet_id        in number,
    p_app_user            in varchar2,
    p_report_id           in number,
    --
    p_condition_id        in number default null,
    p_column              in number default null,
    p_search_string       in varchar2 default null);
*/

procedure add_or_update_filter (
    p_worksheet_id        in number,
    p_app_user            in varchar2,
    p_report_id           in number,
    -- filtering
    p_condition_id        in number   default null,
    p_filter_column       in varchar2 default null,
    p_filter_operator     in varchar2 default '=',
    p_filter_expr_type    in varchar2 default null,
    p_filter_expr         in varchar2 default null,
    p_filter_expr2        in varchar2 default null,
    --
    p_clear_existing_col_filters in varchar2 default 'Y',
    --
    p_validation_error    out varchar2);

procedure clear_filters_on_column (
    p_worksheet_id        in number,
    p_app_user            in varchar2,
    p_report_id           in number,
    --
    p_filter_column       in varchar2);

procedure clear_filter (
    p_worksheet_id in number,
    p_app_user     in varchar2,
    p_report_id    in number,
    --
    p_condition_id in number);

procedure toggle_filter (
    p_worksheet_id      in number,
    p_app_user          in varchar2,
    p_report_id         in number,
    --
    p_condition_id      in number,
    p_filter_enabled    in varchar2);

-------------
-- HIGHLIGHTS
--
procedure toggle_highlighting (
    p_worksheet_id      in number,
    p_app_user          in varchar2,
    p_report_id         in number,
    --
    p_condition_id      in number,
    p_highlight_enabled in varchar2);

procedure fetch_highlight (
    p_worksheet_id        in number,
    p_app_user            in varchar2,
    p_report_id           in number,
    --
    p_condition_id        in number default null,
    p_name                out varchar2,
    -- highlight condition
    p_column              out varchar2,
    p_operator            out varchar2,
    p_expr_type           out varchar2,
    p_expr                out varchar2,
    -- highlight formatting
    p_highlight_sequence  out varchar2,
    p_highlight_enabled   out varchar2,
    p_row_bg_color        out varchar2,
    p_row_font_color      out varchar2,
    p_row_format          out varchar2,
    p_column_bg_color     out varchar2,
    p_column_font_color   out varchar2,
    p_column_format       out varchar2
    );

procedure add_or_update_highlight (
    p_worksheet_id        in number,
    p_app_user            in varchar2,
    p_report_id           in number,
    --
    p_condition_id        in number   default null,
    p_name                in varchar2 default null,
    -- highlight condition
    p_column              in varchar2,
    p_operator            in varchar2,
    p_expr_type           in varchar2 default null,
    p_expr                in varchar2 default null,
    p_expr2               in varchar2 default null,
    -- highlight settings
    p_highlight_sequence  in varchar2 default null,
    p_highlight_enabled   in varchar2 default 'Y',
    p_highlight_type      in varchar2 default 'ROW',
    -- highlight formatting
    p_bg_color            in varchar2 default null,
    p_font_color          in varchar2 default null,
    p_format              in varchar2 default null,
    p_validation_error    out varchar2
    );


procedure clear_highlight (
    p_worksheet_id in number,
    p_app_user     in varchar2,
    p_report_id    in number,
    --
    p_condition_id in number);

--------------
-- AGGREGATES
--
procedure create_aggregate (
    p_worksheet_id        in number,
    p_app_user            in varchar2,
    p_report_id           in number,
    p_old_aggregation     in varchar2 default null,
    p_aggregate           in varchar2 default null,
    p_column              in varchar2 default null);

procedure remove_aggregate (
    p_worksheet_id    in number,
    p_app_user        in varchar2,
    p_report_id       in number,
    p_aggregate       in varchar2,
    p_column          in varchar2);

----------------
-- COMPUTATIONS
--
procedure add_or_update_computation (
    p_worksheet_id        in number,
    p_app_user            in varchar2,
    p_report_id           in number,
    --
    p_computation_id      in number default null,
    p_computation_expr    in varchar2 default null,
    p_format_mask         in varchar2 default null,
    p_column_label        in varchar2 default null,
    p_report_label        in varchar2 default null,
    p_validation_error    out varchar2);

procedure fetch_computation (
    p_worksheet_id        in number,
    p_app_user            in varchar2,
    p_report_id           in number,
    --
    p_computation_id      in number,
    --
    p_computation_expr    out varchar2,
    p_format_mask         out varchar2,
    p_column_label        out varchar2,
    p_report_label        out varchar2);

procedure delete_computation (
    p_worksheet_id        in number,
    p_app_user            in varchar2,
    p_report_id           in number,
    --
    p_computation_id      in number);

---------------
-- FLASHBACK
--
procedure set_flashback (
    p_worksheet_id     in number,
    p_app_user         in varchar2,
    p_report_id        in number,
    p_mins_ago         in varchar2,
    p_validation_error out varchar2);

procedure toggle_flashback (
    p_worksheet_id in number,
    p_app_user     in varchar2,
    p_report_id    in number,
    --
    p_flashback_enabled in varchar2 default null);

procedure clear_flashback (
    p_worksheet_id in number,
    p_app_user     in varchar2,
    p_report_id    in number);


-------------------
-- CHART / CALENDAR
--
procedure set_report_type (
    p_worksheet_id in number,
    p_app_user     in varchar2,
    p_report_id    in number,
    --
    p_report_type  in varchar2);

procedure save_chart (
    p_worksheet_id in number,
    p_app_user     in varchar2,
    p_report_id    in number,
    --
    p_chart_type         in varchar2 default null,
    p_chart_label_column in varchar2 default null,
    p_chart_label_title  in varchar2 default null,
    p_chart_value_column in varchar2 default null,
    p_chart_aggregate    in varchar2 default null,
    p_chart_value_title  in varchar2 default null,
    p_chart_sorting      in varchar2 default null);

procedure delete_chart (
    p_worksheet_id in number,
    p_app_user     in varchar2,
    p_report_id    in number);

procedure save_calendar (
    p_worksheet_id in number,
    p_app_user     in varchar2,
    p_report_id    in number,
    --
    p_calendar_date_column in varchar2,
    p_calendar_display_column in varchar2);

-----------------------------
-- Report / Category Creation
--
procedure create_category (
    p_id                      in varchar2 default null,
    p_worksheet_id            in varchar2 default null,
    p_base_cat_id             in varchar2 default null,
    p_application_user        in varchar2 default null,
    p_name                    in varchar2 default null,
    p_display_sequence        in varchar2 default null);

procedure update_category (
    p_id                      in varchar2 default null,
    p_worksheet_id            in varchar2 default null,
    p_base_cat_id             in varchar2 default null,
    p_application_user        in varchar2 default null,
    p_name                    in varchar2 default null);

procedure delete_category (
    p_id                      in varchar2 default null);

procedure create_worksheet_report (
    p_id                      in number   default null,
    p_worksheet_id            in number   default null,
    p_flow_id                 in number   default null,
    p_page_id                 in number   default null,
    p_session_id              in number   default null,
    p_base_report_id          in number   default null,
    p_application_user        in varchar2 default null,
    p_name                    in varchar2 default null,
    p_description             in varchar2 default null,
    p_report_seq              in varchar2 default null,
    p_report_type             in varchar2 default null,
    p_status                  in varchar2 default null,
    p_category_id             in varchar2 default null,
    p_autosave                in varchar2 default null,
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
    -- calendar
    p_calendar_date_column    in varchar2 default null,
    p_calendar_display_column in varchar2 default null
    );

procedure create_ws_report_condition (
    p_id                        in number   default null,
    p_flow_id                   in number   default null,
    p_page_id                   in number   default null,
    p_worksheet_id              in number   default null,
    p_report_id                 in number   default null,
    p_name                      in varchar2 default null,
    p_condition_type            in varchar2 default null,
    p_allow_delete              in varchar2 default null,
    --
    p_column_name               in varchar2 default null,
    p_operator                  in varchar2 default null,
    p_expr_type                 in varchar2 default null,
    p_expr                      in varchar2 default null,
    p_expr2                     in varchar2 default null,
    p_condition_sql             in varchar2 default null,
    p_condition_display         in varchar2 default null,
    --
    p_enabled                   in varchar2 default null,
    --
    p_highlight_sequence        in number   default null,
    p_row_bg_color              in varchar2 default null,
    p_row_font_color            in varchar2 default null,
    p_row_format                in varchar2 default null,
    p_column_bg_color           in varchar2 default null,
    p_column_font_color         in varchar2 default null,
    p_column_format             in varchar2 default null);

procedure create_ws_col_group (
    p_id               in number default null,
    p_flow_id          in number   default null,
    p_worksheet_id     in number default null,
    p_name             in varchar2 default null,
    p_description      in varchar2 default null,
    p_display_sequence in varchar2 default null);

/*procedure create_chart (
    p_worksheet_id        in number,
    p_app_user            in varchar2,
    p_report_id           in number,
    p_chart_type          in varchar2,
    p_chart_3d            in varchar2 default null,
    p_chart_label_column  in varchar2 default null,
    p_chart_label_title   in varchar2 default null,
    p_chart_value_column  in varchar2 default null,
    p_chart_aggregate     in varchar2 default null,
    p_chart_value_title   in varchar2 default null,
    p_chart_sorting       in varchar2 default null);

procedure create_calendar (
    p_worksheet_id            in number,
    p_app_user                in varchar2,
    p_report_id               in number,
    p_calendar_date_column    in varchar2,
    p_calendar_display_column in varchar2 default null);

procedure create_computation (
    p_worksheet_id        in number,
    p_app_user            in varchar2,
    p_report_id           in number,
    p_computation_id      in number default null,
    p_computation_expr    in varchar2 default null,
    p_format_mask         in varchar2 default null,
    p_column_label        in varchar2 default null,
    p_report_label        in varchar2 default null);*/

--
--
--
procedure create_dataview (
    p_flow_id                       in varchar2,
    p_tab_owner                     in varchar2,
    p_tabview                       in varchar2,
    p_columns                       in varchar2,
    p_name                          in varchar2,
    p_owner                         in varchar2);

procedure show_single_row_view (
    p_flow_id          in number,
    p_worksheet_id     in number,
    p_app_user         in varchar2,
    p_row_id           in varchar2 default null,
    p_base_report_id   in number   default null
    );

procedure get_form_navigation (
    p_worksheet_id     in number,
    p_app_user         in varchar2,
    p_pk               in varchar2 default null,
    p_base_report_id   in number default null,
    p_next_pk          out varchar2,
    p_prev_pk          out varchar2,
    p_row_cnt          out number,
    p_total_row_cnt    out number
    );
end wwv_flow_worksheet_api;
/