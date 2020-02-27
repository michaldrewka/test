CREATE OR REPLACE package wwv_render_chart2 as
--  Copyright (c) Oracle Corporation 1999 - 2003. All Rights Reserved.
--
--    DESCRIPTION
--      Creates html bar charts from sql queries or cursors
--
--    SECURITY
--
--
--    NOTES:
--      Package to display the results of a query in a bar chart.
--
--      This package will take in either a query or a cursor of a query
--      of the form:
--
--        select the_link, the_text, the_value
--          from my_table
--         where my_constraints
--
--      The_link is the the link that will be associated to the_text or lable of the
--      the chart.  The_value is the numeric value of the bar.  Example:
--
--        select 'http://theserver/chart/owa/update_emp?emp_no='||empno the_link,
--               ename || '  ' || hiredate the_text,
--               nvl( sal, 0 ) + nvl( comm, 0 ) the_value
--          from scott.emp
--         where job = ':job_type'
--           and hiredate > ':h_date'
--
--      Parameters:
--        p_query            The query. It can be a query string or a cursor.
--        p_parm_names       An array of parameters to the query.
--                             eg.  my_parm_name(1) := 'job_type';
--                                  my_parm_name(2) := 'h_date';
--        p_parm_values      An array of parameter values.  They correspond to the parm_name.
--                             eg.  may_parm_value(1) := 'MANAGER';
--                                  may_parm_value(2) := '01-JAN-90';
--        p_cursor           A cursor of a parsed query.
--        p_chart_type       Determines whether the cart will be a horizontal bar chart ( HBAR ) or
--                           a vertical bar_chart ( VBAR )
--        p_bar_image        What image will fill the bars of the chart.  eg.  my_pic.gif
--                           If the value 'MULTI' is supplied then the chart will be colored coded by value.
--                           Any value in the top 12 1/2% of the values will be red.  The next 12 1/2% will
--                           be orange, then yellow, green, blue, purple, brown, and finally black.
--        p_chart_title      An optional title of the chart.
--        p_axis             The axis of the chart.  Valid values are:
--                             ZERO  -  chart is relative to zero
--                             FIRST -  chart is relative to the first value
--                             LAST  -  chart is relative to the last value
--                             MAX   -  chart is relative to the max value
--                             MIN   -  chart is relative to the min value
--                             AVG   -  chart is relative to the avg value
--         p_scale           A preportion of how big to make the bars.  Any positive interger is valid.
--         p_bar_width       How many pixels wide the bar will be.  Vaild for vertical charts only.
--         p_bar_height      How many pixels tall the bar will be.  Vaild for horizontal charts only.
--         p_num_mask        The number mask for the displaying of the value of the bar.
--         p_font_size       The size of the font for the text and title of the chart.  eg. '-2', '+1', ..
--         p_font_color      The color of the font for the text and title of the chart. eg. 'RED', 'GREEN', '#CCFF22'
--         p_font_face       The face of the font for the text and title of the chart.  eg. 'COMIC SANS MS', 'ARIAL'
--         p_max_rows        The maximum number of bars to display.
--         p_min_row         The minimum number of bars to start displaying, used for pagenation.
--         p_show_summary    Deterimies whether or not to show chart summary and what summary info to show.
--                           The parameter is a string of letters that correspond the different summary info
--                           and the order of the letters correspond to the order of displaying of the information.
--                           Possible values are:
--                             C  - Display the count of records/bars returned
--                             A  - Axis
--                             M  - Minimum value
--                             X  - Maximum value
--                             V  - Average value
--                             S  - Sum of all values
--                             F  - First value
--                             L  - Last value
--                           If the value 'CAS' is supplied, the summary information will contain
--                           The count, the average value and then the sum of all values.
--         p_image_locat     The virtural directory where the images are located.
--
  g_status  varchar2(32767) := null;
  g_row_cnt number := 0;
  empty_vc_arr wwv_flow_global.vc_arr2;
  g_use_flow_pagination varchar2(30) := null;
  g_region_id number := null;  -- current region id


    g_colors    wwv_flow_global.vc_arr2;

    g_chart_title   varchar2(2000);
    g_axis          varchar2(10);
    g_scale         number;
    g_bar_width     number;
    g_bar_height    number;
    g_bar_image     varchar2(250);
    g_num_mask      varchar2(250);
    g_font_size     varchar2(250);
    g_font_color    varchar2(250);
    g_font_face     varchar2(250);
    g_max_rows      number;
    g_min_row       number;
    g_image_locat   varchar2(250);

    g_link          wwv_flow_global.vc_arr2;
    g_text          wwv_flow_global.vc_arr2;
    g_value         wwv_flow_global.vc_arr2;

    g_upper_span    wwv_flow_global.vc_arr2;
    g_lower_span    wwv_flow_global.vc_arr2;
    g_range         number;

    g_total_value   number := 0;
    g_max_value     number := -999999999999999999999999999999999999;
    g_min_value     number := 999999999999999999999999999999999999;
    g_max_element   number := 0;
    g_min_element   number := 0;

    g_pagination_row  varchar2(32767) := null;

--
  procedure show_colors;

--

  procedure show(
    p_query             in varchar2,
    p_parm_names        in wwv_flow_global.vc_arr2   default empty_vc_arr,
    p_parm_values       in wwv_flow_global.vc_arr2   default empty_vc_arr,
    p_chart_type        in varchar2     default 'HBAR',
    p_bar_image         in varchar2     default 'MULTI',
    p_chart_title       in varchar2     default null,
    p_axis                      in varchar2     default 'ZERO',
    p_scale             in number               default 300,
    p_bar_width         in number               default 40,
    p_bar_height        in number               default 20,
    p_num_mask          in varchar2     default '999,999,999,999,999,999,999,999,999,999,999,999,999',
    p_font_size         in varchar2     default '-2',
    p_font_color        in varchar2     default null,
    p_font_face         in varchar2     default null,
    p_max_rows          in number               default 2000,
    p_min_row           in number               default 1,
    p_show_summary      in varchar2     default null, -- 'CAMXVSFLR'
    p_image_prefix      in varchar2     default nvl(wwv_flow.g_image_prefix,'/'||'i/'),
    p_use_flow_pagination in varchar2   default 'YES' );
--
  procedure show(
    p_cursor            in integer              default null,
    p_chart_type        in varchar2     default 'HBAR',
    p_bar_image         in varchar2     default 'MULTI',
    p_chart_title       in varchar2     default null,
    p_axis                      in varchar2     default 'ZERO',
    p_scale             in number               default 300,
    p_bar_width         in number               default 40,
    p_bar_height        in number               default 20,
    p_num_mask          in varchar2     default '999,999,999,999,999,999,999,999,999,999,999,999,999',
    p_font_size         in varchar2     default '-2',
    p_font_color        in varchar2     default null,
    p_font_face         in varchar2     default null,
    p_max_rows          in number               default 2000,
        p_min_row               in number               default 1,
    p_show_summary      in varchar2     default null, -- 'CAMXVSFLR'
    p_image_prefix      in varchar2     default nvl(wwv_flow.g_image_prefix,'/'||'i/'),
    p_use_flow_pagination in varchar2   default 'YES' );
--
end wwv_render_chart2;
/