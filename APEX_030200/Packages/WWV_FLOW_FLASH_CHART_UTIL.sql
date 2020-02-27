CREATE OR REPLACE package wwv_flow_flash_chart_util as
--  Copyright (c) Oracle Corporation 2007. All Rights Reserved.
--
--    DESCRIPTION
--      Flash Chart utility package.
--
--    SECURITY
--
--    NOTES
--
--

function is_valid_flash_chart_query (
    p_flow_id           in number,
    p_security_group_id in number,
    p_chart_type        in varchar2,
    p_query             in varchar2,
    p_query_type        in varchar2 default 'SQL_QUERY'
    ) return varchar2;

procedure show_preview (
    p_page_id    in number,
    p_region_id  in number,
    p_chart_type in varchar2,
    p_bg_color   in varchar2
);

function get_asynch_update_js (
  p_region_id in varchar2,
  p_browser_lang in varchar2
) return varchar2;

function get_flash_filename (
  p_flash_chart_type in varchar2
) return varchar2;

procedure fetch_chart_attr (
    p_flow_id                 in number,
    p_region_id               in number,
    p_chart_id                out number,
    p_chart_type              out varchar2,
    p_chart_width             out number,
    p_chart_height            out number,
    --
    p_chart_margin_top        out number,
    p_chart_margin_bottom     out number,
    p_chart_margin_left       out number,
    p_chart_margin_right      out number,
    --
    p_chart_title             out varchar2,
    p_animation               out varchar2,
    p_color_scheme            out varchar2,
    p_custom_colors           out varchar2,
    p_bgtype                  out varchar2,
    p_bgcolor1                out varchar2,
    p_bgcolor2                out varchar2,
    p_gradient_rotation       out number,
    p_show_hints              out varchar2,
    p_show_names              out varchar2,
    p_show_values             out varchar2,
    p_show_legend             out varchar2,
    p_show_grid               out varchar2,
    p_x_axis_title            out varchar2,
    p_y_axis_title            out varchar2,
    p_y_axis_title_rotate     out varchar2,
    p_x_axis_prefix           out varchar2,
    p_x_axis_postfix          out varchar2,
    p_x_axis_group_sep        out varchar2,
    p_x_axis_decimal_place    out number,
    p_y_axis_prefix           out varchar2,
    p_y_axis_postfix          out varchar2,
    p_y_axis_group_sep        out varchar2,
    p_y_axis_decimal_place    out number,
    --
    p_x_axis_min              out number,
    p_x_axis_max              out number,
    p_x_axis_grid_spacing     out number,
    p_y_axis_min              out number,
    p_y_axis_max              out number,
    p_y_axis_grid_spacing     out number,
    p_names_font_face         out varchar2,
    p_names_font_size         out number,
    p_names_font_color        out varchar2,
    p_names_rotation          out number,
    p_values_font_face        out varchar2,
    p_values_font_size        out number,
    p_values_font_color       out varchar2,
    p_values_rotation         out number,
    p_hints_font_face         out varchar2,
    p_hints_font_size         out number,
    p_hints_font_color        out varchar2,
    p_legend_font_face        out varchar2,
    p_legend_font_size        out number,
    p_legend_font_color       out varchar2,
    p_grid_font_face          out varchar2,
    p_grid_font_size          out varchar2,
    p_grid_font_color         out varchar2,
    p_chart_title_font_face   out varchar2,
    p_chart_title_font_size   out varchar2,
    p_chart_title_font_color  out varchar2,
    p_xaxis_font_face         out varchar2,
    p_xaxis_font_size         out number,
    p_xaxis_font_color        out varchar2,
    p_yaxis_font_face         out varchar2,
    p_yaxis_font_size         out number,
    p_yaxis_font_color        out varchar2,
    p_xml                     out varchar2,
    p_use_xml                 out varchar2,
    p_async                   out varchar2,
    p_async_time              out number,
    p_omit_label_interval     out number,
    p_show_dial_tick          out varchar2,
    p_show_dial_tick_label    out varchar2,
    p_dial_tick_spacing       out number
    );

procedure save_chart_attr (
    p_flow_id                 in number,
    p_region_id               in number,
    p_chart_id                in number,
    p_chart_type              in varchar2 default null,
    p_chart_width             in number default null,
    p_chart_height            in number default null,
    --
    p_chart_margin_top        in number default null,
    p_chart_margin_bottom     in number default null,
    p_chart_margin_left       in number default null,
    p_chart_margin_right      in number default null,
    --
    p_chart_title             in varchar2 default null,
    p_animation               in varchar2 default null,
    p_color_scheme            in varchar2 default null,
    p_custom_colors           in varchar2 default null,
    p_bgtype                  in varchar2 default null,
    p_bgcolor1                in varchar2 default null,
    p_bgcolor2                in varchar2 default null,
    p_gradient_rotation       in number default null,
    p_show_hints              in varchar2 default null,
    p_show_names              in varchar2 default null,
    p_show_values             in varchar2 default null,
    p_show_legend             in varchar2 default null,
    p_show_grid               in varchar2 default null,
    p_x_axis_title            in varchar2 default null,
    p_y_axis_title            in varchar2 default null,
    p_y_axis_title_rotate     in varchar2 default null,
    p_x_axis_prefix           in varchar2 default null,
    p_x_axis_postfix          in varchar2 default null,
    p_x_axis_group_sep        in varchar2 default null,
    p_x_axis_decimal_place    in number default null,
    p_y_axis_prefix           in varchar2 default null,
    p_y_axis_postfix          in varchar2 default null,
    p_y_axis_group_sep        in varchar2 default null,
    p_y_axis_decimal_place    in number default null,
    --
    p_x_axis_min              in number default null,
    p_x_axis_max              in number default null,
    p_x_axis_grid_spacing     in number default null,
    p_y_axis_min              in number default null,
    p_y_axis_max              in number default null,
    p_y_axis_grid_spacing     in number default null,
    p_names_font_face         in varchar2 default null,
    p_names_font_size         in number default null,
    p_names_font_color        in varchar2 default null,
    p_names_rotation          in number default null,
    p_values_font_face        in varchar2 default null,
    p_values_font_size        in number default null,
    p_values_font_color       in varchar2 default null,
    p_values_rotation         in number default null,
    p_hints_font_face         in varchar2 default null,
    p_hints_font_size         in number default null,
    p_hints_font_color        in varchar2 default null,
    p_legend_font_face        in varchar2 default null,
    p_legend_font_size        in number default null,
    p_legend_font_color       in varchar2 default null,
    p_grid_font_face          in varchar2 default null,
    p_grid_font_size          in varchar2 default null,
    p_grid_font_color         in varchar2 default null,
    p_chart_title_font_face   in varchar2 default null,
    p_chart_title_font_size   in varchar2 default null,
    p_chart_title_font_color  in varchar2 default null,
    p_xaxis_font_face         in varchar2 default null,
    p_xaxis_font_size         in number default null,
    p_xaxis_font_color        in varchar2 default null,
    p_yaxis_font_face         in varchar2 default null,
    p_yaxis_font_size         in number default null,
    p_yaxis_font_color        in varchar2 default null,
    p_xml                     in varchar2 default null,
    p_use_xml                 in varchar2 default null,
    p_async                   in varchar2 default null,
    p_async_time              in number default null,
    p_omit_label_interval     in number default null,
    p_show_dial_tick          in varchar2 default null,
    p_show_dial_tick_label    in varchar2 default null,
    p_dial_tick_spacing       in number default null
    );

procedure fetch_chart_series_attr (
    p_series_id           in number,
    p_chart_id            out number,
    p_series_name         out varchar2,
    p_series_seq          out number,
    p_query               out varchar2,
    p_query_type          out varchar2,
    p_query_parse_opt     out varchar2,
    p_query_max_rows      out number,
    p_query_no_data_found out varchar2
    );

procedure save_chart_series_attr (
    p_chart_id            in number,
    p_series_id           in number default null,
    p_series_name         in varchar2 default null,
    p_series_seq          in number default null,
    p_query               in varchar2 default null,
    p_query_type          in varchar2 default null,
    p_query_parse_opt     in varchar2 default null,
    p_query_max_rows      in number default null,
    p_query_no_data_found in varchar2 default null
    );
end wwv_flow_flash_chart_util;
/