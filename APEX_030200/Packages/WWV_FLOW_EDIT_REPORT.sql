CREATE OR REPLACE package wwv_flow_edit_report as

  type assoc_vc2_arr is table of varchar2(4000) index by varchar2(4000);
  empty_assoc_vc2_arr assoc_vc2_arr;

  type assoc_bln_arr is table of boolean index by varchar2(4000);
  empty_assoc_bln_arr assoc_bln_arr;

  g_is_query_column  assoc_bln_arr := empty_assoc_bln_arr;

  g_col_alias        wwv_flow_global.vc_arr2;
  g_status           varchar(5000);    -- execution status

  g_col_display_seq  assoc_vc2_arr := empty_assoc_vc2_arr;
  g_col_hidden       assoc_vc2_arr := empty_assoc_vc2_arr;
  g_col_heading      assoc_vc2_arr := empty_assoc_vc2_arr;
  g_col_alignment    assoc_vc2_arr := empty_assoc_vc2_arr;
  g_hd_alignment     assoc_vc2_arr := empty_assoc_vc2_arr;
  g_col_sum          assoc_vc2_arr := empty_assoc_vc2_arr;
  g_disable_sort_col assoc_vc2_arr := empty_assoc_vc2_arr;
  g_default_sort_col assoc_vc2_arr := empty_assoc_vc2_arr;

  g_include_in_export assoc_vc2_arr := empty_assoc_vc2_arr;
  g_print_col_width   assoc_vc2_arr := empty_assoc_vc2_arr;
  g_print_col_align   assoc_vc2_arr := empty_assoc_vc2_arr;

------------------------------------------------------------------------------------------------------
--

  procedure move_cols (
    p_region_id           in number,
    p_column_id           in number,
    p_col_num             in number,
    p_dir                 in varchar2
  );

------------------------------------------------------------------------------------------------------
--

  function get_alias_display_name (
    p_alias in varchar2
  ) return varchar2;

------------------------------------------------------------------------------------------------------
--

  function add_derived_column (
    p_region_id in number,
    p_col_num   in number,
    p_type      in varchar2
  ) return number;

------------------------------------------------------------------------------------------------------
--

  procedure remove_derived_column (
      p_region_id in number,
      p_column_id in number
  );

------------------------------------------------------------------------------------------------------
--

  procedure update_report_columns (
    p_region_id           in number,
    p_column_heading_type in varchar2,
    p_column_id           in wwv_flow_global.vc_arr2,
    p_column_alias        in wwv_flow_global.vc_arr2,
    p_display_seq         in wwv_flow_global.vc_arr2,
    p_column_heading      in wwv_flow_global.vc_arr2,
    p_column_alignment    in wwv_flow_global.vc_arr2,
    p_heading_alignment   in wwv_flow_global.vc_arr2,
    p_hidden_column       in wwv_flow_global.vc_arr2,
    p_sum_column          in wwv_flow_global.vc_arr2,
    p_disable_sort_column in wwv_flow_global.vc_arr2,
    p_default_sort_column in wwv_flow_global.vc_arr2
  );

------------------------------------------------------------------------------------------------------
--

  procedure update_print_column_attributes (
    p_region_id           in number,
    p_column_heading_type in varchar2,
    p_column_id           in wwv_flow_global.vc_arr2,
    p_column_alias        in wwv_flow_global.vc_arr2,
    p_include_in_export   in wwv_flow_global.vc_arr2,
    p_print_col_width     in wwv_flow_global.vc_arr2
  );

------------------------------------------------------------------------------------------------------
--

  procedure update_column_display_sequence (
    p_region_id           in number
  );

------------------------------------------------------------------------------------------------------
--

  procedure update_report_column_sequence (
    p_region_id           in number
  );

------------------------------------------------------------------------------------------------------
--

  procedure column_headings_javascript (
    p_region_id                number,
    p_plug_query_headings_type varchar2
  );

end wwv_flow_edit_report;
/