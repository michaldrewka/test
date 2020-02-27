CREATE OR REPLACE FORCE VIEW apex_application_page_flash_ch (workspace,application_id,application_name,page_id,page_name,region_id,region_name,chart_id,chart_type,chart_title,chart_width,chart_height,chart_animation,display_attr,dial_tick_attr,margins,omit_label_interval,color_scheme,custom_colors,bgtype,bgcolor1,bgcolor2,gradient_rotation,x_axis_title,x_axis_min,x_axis_max,x_axis_grid_spacing,x_axis_prefix,x_axis_postfix,x_axis_group_sep,x_axis_decimal_place,y_axis_title,y_axis_min,y_axis_max,y_axis_grid_spacing,y_axis_prefix,y_axis_postfix,y_axis_group_sep,y_axis_decimal_place,async_update,async_time,names_font,names_rotation,values_font,values_rotation,hints_font,legend_font,grid_labels_font,chart_title_font,x_axis_title_font,y_axis_title_font,use_chart_xml,chart_xml,last_updated_by,last_updated_on,component_signature) AS
select
    w.short_name                     workspace,
    f.id                             application_id,
    f.name                           application_name,
    p.id                             page_id,
    p.name                           page_name,
    c.region_id                      region_id,
    (select plug_name
     from wwv_flow_page_plugs
     where id = c.region_id)         region_name,
    c.id                             chart_id,
    decode(c.default_chart_type,
    '2DColumn', '2D Column',
    '2DColumn_Line', '2D Column Line',
    '2DDoughnut', '2D Doughnut',
    '2DLine', '2D Line',
    '2DPie', '2D Pie',
    '3DColumn', '3D Column',
    '3DPie', '3D Pie',
    'Candlestick', 'Candlestick',
    'GaugeChart', 'Dial',
    'DIALSWEEP', 'Dial (Sweep)',
    'Horizontal2DColumn', 'Horizontal 2D Column',
    'Horizontal3DColumn', 'Horizontal 3D Column',
    'HorizontalRange3DColumn', 'Horizontal Range 3D Column',
    'HorizontalRange2DColumn', 'HorizontalRange 2D Column',
    'Inverse2DLine', 'Inverse 2D Line',
    'Range2DColumn', 'Range 2D Column',
    'Range3DColumn', 'Range 3D Column',
    'dot', 'Scatter',
    'Stacked2DColumn', 'Stacked 2D Column',
    '2DSTACKED_PCT', 'Stacked 2D Column (Percent)',
    'Stacked3DColumn', 'Stacked 3D Column',
    '3DSTACKED_PCT', 'Stacked 3D Column (Percent)',
    'StackedHorizontal2DColumn', 'Stacked Horizontal 2D Column',
    '2DHSTACKED_PCT', 'Stacked Horizontal 2D Column (Percent)',
    'StackedHorizontal3DColumn', 'Stacked Horizontal 3D Column',
    '3DHSTACKED_PCT', 'Stacked Horizontal 3D Column (Percent)',
    c.default_chart_type)            chart_type,
    c.chart_title                    chart_title,
    c.chart_width                    chart_width,
    c.chart_height                   chart_height,
    c.chart_animation                chart_animation,
    c.display_attr                   display_attr,
    c.dial_tick_attr                 dial_tick_attr,
    c.margins                        margins,
    c.omit_label_interval            omit_label_interval,
    c.color_scheme                   color_scheme,
    c.custom_colors                  custom_colors,
    c.bgtype                         bgtype,
    c.bgcolor1                       bgcolor1,
    c.bgcolor2                       bgcolor2,
    c.gradient_rotation              gradient_rotation,
    c.x_axis_title                   x_axis_title,
    c.x_axis_min                     x_axis_min,
    c.x_axis_max                     x_axis_max,
    c.x_axis_grid_spacing            x_axis_grid_spacing,
    c.x_axis_prefix                  x_axis_prefix,
    c.x_axis_postfix                 x_axis_postfix,
    c.x_axis_group_sep               x_axis_group_sep,
    c.x_axis_decimal_place           x_axis_decimal_place,
    c.y_axis_title                   y_axis_title,
    c.y_axis_min                     y_axis_min,
    c.y_axis_max                     y_axis_max,
    c.y_axis_grid_spacing            y_axis_grid_spacing,
    c.y_axis_prefix                  y_axis_prefix,
    c.y_axis_postfix                 y_axis_postfix,
    c.y_axis_group_sep               y_axis_group_sep,
    c.y_axis_decimal_place           y_axis_decimal_place,
    c.async_update                   async_update,
    c.async_time                     async_time,
    c.names_font                     names_font,
    c.names_rotation                 names_rotation,
    c.values_font                    values_font,
    c.values_rotation                values_rotation,
    c.hints_font                     hints_font,
    c.legend_font                    legend_font,
    c.grid_labels_font               grid_labels_font,
    c.chart_title_font               chart_title_font,
    c.x_axis_title_font              x_axis_title_font,
    c.y_axis_title_font              y_axis_title_font,
    c.use_chart_xml                  use_chart_xml,
    c.chart_xml                      chart_xml,
    --
    c.updated_by                     last_updated_by,
    c.updated_on                     last_updated_on,
    --
    decode(c.default_chart_type,
    '2DColumn', '2D Column',
    '2DColumn_Line', '2D Column Line',
    '2DDoughnut', '2D Doughnut',
    '2DLine', '2D Line',
    '2DPie', '2D Pie',
    '3DColumn', '3D Column',
    '3DPie', '3D Pie',
    'Candlestick', 'Candlestick',
    'GaugeChart', 'Dial',
    'DIALSWEEP', 'Dial (Sweep)',
    'Horizontal2DColumn', 'Horizontal 2D Column',
    'Horizontal3DColumn', 'Horizontal 3D Column',
    'HorizontalRange3DColumn', 'Horizontal Range 3D Column',
    'HorizontalRange2DColumn', 'HorizontalRange 2D Column',
    'Inverse2DLine', 'Inverse 2D Line',
    'Range2DColumn', 'Range 2D Column',
    'Range3DColumn', 'Range 3D Column',
    'dot', 'Scatter',
    'Stacked2DColumn', 'Stacked 2D Column',
    '2DSTACKED_PCT', 'Stacked 2D Column (Percent)',
    'Stacked3DColumn', 'Stacked 3D Column',
    '3DSTACKED_PCT', 'Stacked 3D Column (Percent)',
    'StackedHorizontal2DColumn', 'Stacked Horizontal 2D Column',
    '2DHSTACKED_PCT', 'Stacked Horizontal 2D Column (Percent)',
    'StackedHorizontal3DColumn', 'Stacked Horizontal 3D Column',
    '3DHSTACKED_PCT', 'Stacked Horizontal 3D Column (Percent)',
    c.default_chart_type)
    ||' attr='||c.chart_width||c.chart_height||c.chart_animation||c.display_attr||c.dial_tick_attr||c.margins||c.omit_label_interval
    ||' color='||c.color_scheme||substr(c.custom_colors,1,20)||'.'||length(c.custom_colors)
               ||c.bgtype||substr(c.bgcolor1,1,20)||'.'||length(c.bgcolor1)||substr(c.bgcolor2,1,20)||'.'||length(c.bgcolor2)
    ||' rotation='||c.gradient_rotation||':'||c.names_rotation||':'||c.values_rotation
    ||' title='||substr(c.chart_title,1,20)||'.'||length(c.chart_title)
    ||substr(c.x_axis_title,1,20)||'.'||length(c.x_axis_title)
    ||substr(c.y_axis_title,1,20)||'.'||length(c.y_axis_title)
    ||' axis='||c.x_axis_min||':'||c.x_axis_max||':'||c.x_axis_grid_spacing||substr(c.x_axis_prefix,1,20)||':'||substr(c.x_axis_postfix,1,20)||':'||c.x_axis_group_sep||':'||c.x_axis_decimal_place
              ||c.y_axis_min||':'||c.y_axis_max||':'||c.y_axis_grid_spacing||substr(c.y_axis_prefix,1,20)||':'||substr(c.y_axis_postfix,1,20)||':'||c.y_axis_group_sep||':'||c.y_axis_decimal_place
    ||' font='||c.names_font||c.values_font||c.hints_font||c.legend_font||c.grid_labels_font||c.chart_title_font||c.x_axis_title_font||c.y_axis_title_font
    ||' xml='||decode(c.use_chart_xml,'Y',
                      dbms_lob.substr(c.chart_xml,30,1)||'.'||dbms_lob.getlength(c.chart_xml),
                      null)
    ||' refresh='||c.async_update||c.async_time
    component_signature
from wwv_flow_flash_charts c,
     wwv_flow_steps p,
     wwv_flows f,
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(nv('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = s.security_group_id) and
      f.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.schema = f.owner and
      f.security_group_id = p.security_group_id and
      f.id = p.flow_id and
      f.id = c.flow_id and
      p.id = c.page_id and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      w.PROVISIONING_COMPANY_ID != 0 and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10);
COMMENT ON TABLE apex_application_page_flash_ch IS 'Identifies a Flash chart associated with a Page and Region';
COMMENT ON COLUMN apex_application_page_flash_ch.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_page_flash_ch.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_page_flash_ch.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_page_flash_ch.page_id IS 'ID of the application page';
COMMENT ON COLUMN apex_application_page_flash_ch.page_name IS 'Name of the application page';
COMMENT ON COLUMN apex_application_page_flash_ch.region_id IS 'Identifies the Page Region foreign key to the apex_application_page_regions view';
COMMENT ON COLUMN apex_application_page_flash_ch.region_name IS 'Identifies the region name in which this Flash chart is displayed';
COMMENT ON COLUMN apex_application_page_flash_ch.chart_id IS 'Primary Key of the Flash chart';
COMMENT ON COLUMN apex_application_page_flash_ch.chart_type IS 'Chart type to indicate the style in which the Flash chart will render';
COMMENT ON COLUMN apex_application_page_flash_ch.chart_title IS 'A title to display at the top of the chart';
COMMENT ON COLUMN apex_application_page_flash_ch.chart_width IS 'Width of the chart';
COMMENT ON COLUMN apex_application_page_flash_ch.chart_height IS 'Height of the chart';
COMMENT ON COLUMN apex_application_page_flash_ch.chart_animation IS 'An animation to control the initial appearance of the chart';
COMMENT ON COLUMN apex_application_page_flash_ch.display_attr IS 'Display attribute to show legend, grid, hints, labels and values';
COMMENT ON COLUMN apex_application_page_flash_ch.dial_tick_attr IS 'Dial chart attribute to show ticks, show tick labels, and tick spacing';
COMMENT ON COLUMN apex_application_page_flash_ch.margins IS 'Chart attribute for top, bottom, left, right margins';
COMMENT ON COLUMN apex_application_page_flash_ch.omit_label_interval IS 'A value to specify the interval to skip label text display.';
COMMENT ON COLUMN apex_application_page_flash_ch.color_scheme IS 'Pre-built color scheme for the chart';
COMMENT ON COLUMN apex_application_page_flash_ch.custom_colors IS 'Set of custom colors defined by a user';
COMMENT ON COLUMN apex_application_page_flash_ch.bgtype IS 'Background type for the chart';
COMMENT ON COLUMN apex_application_page_flash_ch.bgcolor1 IS 'Background Color 1 for the chart.  If the background type is set to Gradient, the chart background fades from Background Color 1 to Background Color 2.';
COMMENT ON COLUMN apex_application_page_flash_ch.bgcolor2 IS 'Background Color 2 for the chart.  If the background type is set to Gradient, the chart background fades from Background Color 1 to Background Color 2.';
COMMENT ON COLUMN apex_application_page_flash_ch.gradient_rotation IS 'The angle for the chart background gradient';
COMMENT ON COLUMN apex_application_page_flash_ch.x_axis_title IS 'Title for the X Axis';
COMMENT ON COLUMN apex_application_page_flash_ch.x_axis_min IS 'The smallest data value to appear on the X Axis';
COMMENT ON COLUMN apex_application_page_flash_ch.x_axis_max IS 'The highest data value to appear on the X Axis';
COMMENT ON COLUMN apex_application_page_flash_ch.x_axis_grid_spacing IS 'A value to specify the interval of gridlines on the X Axis';
COMMENT ON COLUMN apex_application_page_flash_ch.x_axis_prefix IS 'Text to display before X Axis values';
COMMENT ON COLUMN apex_application_page_flash_ch.x_axis_postfix IS 'Text to display after X Axis values';
COMMENT ON COLUMN apex_application_page_flash_ch.x_axis_group_sep IS 'A flag to display thousand separator in X Axis values';
COMMENT ON COLUMN apex_application_page_flash_ch.x_axis_decimal_place IS 'Number of decimal places to use in X Axis values';
COMMENT ON COLUMN apex_application_page_flash_ch.y_axis_title IS 'Title for the Y Axis';
COMMENT ON COLUMN apex_application_page_flash_ch.y_axis_min IS 'The smallest data value to appear on the Y Axis';
COMMENT ON COLUMN apex_application_page_flash_ch.y_axis_max IS 'The highest data value to appear on the Y Axis';
COMMENT ON COLUMN apex_application_page_flash_ch.y_axis_grid_spacing IS 'A value to specify the interval of gridlines on the Y Axis';
COMMENT ON COLUMN apex_application_page_flash_ch.y_axis_prefix IS 'Text to display before Y Axis values';
COMMENT ON COLUMN apex_application_page_flash_ch.y_axis_postfix IS 'Text to display after Y Axis values';
COMMENT ON COLUMN apex_application_page_flash_ch.y_axis_group_sep IS 'A flag to display thousand separator in Y Axis values';
COMMENT ON COLUMN apex_application_page_flash_ch.y_axis_decimal_place IS 'Number of decimal places to use in Y Axis values';
COMMENT ON COLUMN apex_application_page_flash_ch.async_update IS 'A flag to enable an asynchronous graph update';
COMMENT ON COLUMN apex_application_page_flash_ch.async_time IS 'The interval in seconds between chart updates';
COMMENT ON COLUMN apex_application_page_flash_ch.names_font IS 'Chart label text font settings';
COMMENT ON COLUMN apex_application_page_flash_ch.names_rotation IS 'The amount of rotation for the labels';
COMMENT ON COLUMN apex_application_page_flash_ch.values_font IS 'Chart value text font settings';
COMMENT ON COLUMN apex_application_page_flash_ch.values_rotation IS 'The amount of rotation for the values';
COMMENT ON COLUMN apex_application_page_flash_ch.hints_font IS 'Chart hint text font settings';
COMMENT ON COLUMN apex_application_page_flash_ch.legend_font IS 'Chart legend text font settings';
COMMENT ON COLUMN apex_application_page_flash_ch.grid_labels_font IS 'Chart grid label font settings';
COMMENT ON COLUMN apex_application_page_flash_ch.chart_title_font IS 'Chart title font settings';
COMMENT ON COLUMN apex_application_page_flash_ch.x_axis_title_font IS 'X Axis title font settings';
COMMENT ON COLUMN apex_application_page_flash_ch.y_axis_title_font IS 'Y Axis title font settings';
COMMENT ON COLUMN apex_application_page_flash_ch.use_chart_xml IS 'A flag to override generated XML and use a custom chart XML';
COMMENT ON COLUMN apex_application_page_flash_ch.chart_xml IS 'User defined custom Chart XML for the Flash chart';
COMMENT ON COLUMN apex_application_page_flash_ch.last_updated_by IS 'Apex developer who made last update';
COMMENT ON COLUMN apex_application_page_flash_ch.last_updated_on IS 'Date of last update';
COMMENT ON COLUMN apex_application_page_flash_ch.component_signature IS 'Identifies attributes defined at a given component level to facilitate application comparisons';