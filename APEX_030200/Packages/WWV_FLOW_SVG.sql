CREATE OR REPLACE package wwv_flow_svg
as
--  Copyright (c) Oracle Corporation 2002. All Rights Reserved.
--
--
--    DESCRIPTION
--      Flow SVG charting engine
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

d1 varchar2(255);
d2 varchar2(255);
d3 varchar2(255);
d4 varchar2(255);
d5 varchar2(255);

type values_table is table of wwv_flow_global.vc_arr2 index by binary_integer;


empty_vc_arr       wwv_flow_global.vc_arr2;

--
-- global constants
--
g_height_id                  pls_integer := 30;
g_width_id                   pls_integer := 31;
--
-- global variables
--
g_region_id                  number := 0;
--
g_max_rows                   number := 0;
g_overall_max_rows           number := 0;
g_more_data_exist            boolean := false;
--
g_link_init                  wwv_flow_global.vc_arr2;
g_link                       wwv_flow_global.vc_arr2;
g_label_init                 wwv_flow_global.vc_arr2;
g_label                      wwv_flow_global.vc_arr2;
g_value_init                 wwv_flow_global.vc_arr2;
g_value                      wwv_flow_global.vc_arr2;
g_prev_value                 wwv_flow_global.vc_arr2;
g_colors                     wwv_flow_global.vc_arr2;
g_row_cnt                    number := 0;

g_sValues                    values_table;
g_sLabels                    values_table;
g_sLinks                     values_table;

--
g_total_value                number := 0;
g_max_label_length           number := 0;
g_max_value                  number := 0;
g_min_value                  number := 0;
g_max_element                number := 0;
g_min_element                number := 0;
--
g_theme                      varchar2(4000) := null;
g_chart_type                 varchar2(4000) := null;
g_chart_title                varchar2(32767) := null;
g_x_axis_title               varchar2(32767) := null;
g_y_axis_title               varchar2(32767) := null;
g_graph_size                 number := 0;
g_chart_height               number := 0;
g_chart_width                number := 0;
--
-- original passed chart width and height value
--
g_chart_org_height           number := 0;
g_chart_org_width            number := 0;

--
-- chart width and height for view box
--
g_chart_viewbox_height       number := 0;
g_chart_viewbox_width        number := 0;
--
g_bar_width                  number := 0;
g_num_mask                   varchar2(250);
g_gap                        number := 0;
g_data_labels                varchar2(4000) := null;
g_3d                         boolean;
g_show_legend                boolean;
g_legend_bg_color            varchar2(4000) := null;
--
g_grid_visible               boolean;
g_axis_interval              number(30,5) := 0;
g_axis_major_unit            number := 0;
g_axis_min                   number := 0;
g_axis_max                   number := 0;
--
g_title_font_face            varchar2(4000) := null;
g_title_font_size            number := 0;
g_title_font_color           varchar2(4000) := null;
g_label_font_face            varchar2(4000) := null;
g_label_font_size            number := 0;
g_label_font_color           varchar2(4000) := null;
g_value_font_face            varchar2(4000) := null;
g_value_font_size            number := 0;
g_value_font_color           varchar2(4000) := null;
g_legend_font_face           varchar2(4000) := null;
g_legend_font_size           number := 0;
g_legend_font_color          varchar2(4000) := null;
g_x_axis_title_font_face     varchar2(4000) := null;
g_x_axis_title_font_size     number := 0;
g_x_axis_title_font_color    varchar2(4000) := null;
g_y_axis_title_font_face     varchar2(4000) := null;
g_y_axis_title_font_size     number := 0;
g_y_axis_title_font_color    varchar2(4000) := null;
--
g_series_queries             wwv_flow_global.vc_arr2;
g_series_max_rows            wwv_flow_global.vc_arr2;
g_series_no_data_found       wwv_flow_global.vc_arr2;
g_series_colors              wwv_flow_global.vc_arr2;
g_series_names               wwv_flow_global.vc_arr2;
g_series_labels              wwv_flow_global.vc_arr2;
g_series_formats             wwv_flow_global.vc_arr2;
g_series_orientations        wwv_flow_global.vc_arr2;
g_series_marker_styles       wwv_flow_global.vc_arr2;
g_series_marker_sizes        wwv_flow_global.vc_arr2;
g_series_line_styles         wwv_flow_global.vc_arr2;
g_series_line_weights        wwv_flow_global.vc_arr2;
--
g_series_name                varchar2(32767) := null;
g_series_color               varchar2(32767) := null;
g_data_format                varchar2(32767) := null;
g_data_orientation           varchar2(32767) := null;
g_series_marker_style        varchar2(32767) := null;
g_series_marker_size         varchar2(32767) := null;
g_series_line_style          varchar2(32767) := null;
--
g_x_axis_min_value           number := 0;
g_y_axis_min_value           number := 0;
g_x_axis_max_value           number := 0;
g_y_axis_max_value           number := 0;
g_x_axis_major_unit          number := 0;
g_y_axis_major_unit          number := 0;
g_x_axis_interval            number := 0;
g_y_axis_interval            number := 0;
g_x_axis_max                 number := 0;
g_y_axis_max                 number := 0;
g_x_axis_min                 number := 0;
g_y_axis_min                 number := 0;
g_x_axis_format              varchar2(4000) := null;
g_y_axis_format              varchar2(4000) := null;

g_series_prev_y              wwv_flow_global.vc_arr2;

g_negative_offset            number := 0;

procedure init_colors;

procedure set_attributes (
    p_region_id           in number,
    p_query               in varchar2,
    p_chart_type          in varchar2,
    p_no_data_found       in varchar2 default null
    );

procedure chart (
    p_region_id in number
    );

function get_shared_styles (
   p_type in varchar2,
   p_x_axis_title_font_face in varchar2 default null,
   p_x_axis_title_font_size in varchar2 default null,
   p_x_axis_title_font_color in varchar2 default null,

   p_y_axis_title_font_face in varchar2 default null,
   p_y_axis_title_font_size in varchar2 default null,
   p_y_axis_title_font_color in varchar2 default null,

   p_label_font_face in varchar2 default null,
   p_label_font_size in varchar2 default null,
   p_label_font_color in varchar2 default null,

   p_value_font_face in varchar2 default null,
   p_value_font_size in varchar2 default null,
   p_value_font_color in varchar2 default null
    ) return varchar2;

procedure migrate_svg_to_flash (
    p_region_id in number,
    p_flow_id   in number,
    p_page_id   in number);

end wwv_flow_svg;
/