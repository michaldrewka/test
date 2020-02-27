CREATE OR REPLACE package wwv_flow_load_excel_data
as


function table_exists (
  p_table_name  in varchar2,
  p_schema      in varchar2
  ) return boolean;


procedure get_table_info (
   p_string                 in varchar2,
   p_separator              in varchar2 default '\t',
   p_enclosed_by            in varchar2 default null,
   p_first_row_is_col_name  in boolean default false,
   p_currency               in varchar2 default '$',
   p_numeric_chars          in varchar2 default '.,',
   p_load_type              in varchar2 default 'EXCEL'
   );

procedure get_table_info (
   p_string                 in clob,
   p_separator              in varchar2 default '\t',
   p_enclosed_by            in varchar2 default null,
   p_first_row_is_col_name  in boolean default false,
   p_currency               in varchar2 default '$',
   p_numeric_chars          in varchar2 default '.,',
   p_load_type              in varchar2 default 'EXCEL'
   );

procedure create_table (
  p_schema        in varchar2,
  p_table_name    in varchar2,
  p_pk1           in varchar2,
  p_pk1_name      in varchar2,
  p_pk1_type      in varchar2,
  p_seq_name      in varchar2 default null,
  --
  p_cnames        in wwv_flow_global.vc_arr2,
  p_data_type     in wwv_flow_global.vc_arr2,
  p_upload        in wwv_flow_global.vc_arr2,
  p_max_length    in wwv_flow_global.vc_arr2 default wwv_flow.empty_vc_arr
  );

procedure load_excel_data (
   p_string                 in varchar2,
   p_cnames                 in wwv_flow_global.vc_arr2,
   p_upload                 in wwv_flow_global.vc_arr2,
   p_schema                 in varchar2,
   p_table                  in varchar2,
   --
   p_data_type              in wwv_flow_global.vc_arr2,
   p_data_format            in wwv_flow_global.vc_arr2 default wwv_flow.empty_vc_arr,
   p_parsed_data_format     in wwv_flow_global.vc_arr2 default wwv_flow.empty_vc_arr,
   --
   p_separator              in varchar2 default '\t',
   p_enclosed_by            in varchar2 default null,
   p_first_row_is_col_name  in boolean default false,
   p_load_to                in varchar2 default 'EXIST',
   p_currency               in varchar2 default '$',
   p_numeric_chars          in varchar2 default '.,',
   p_load_type              in varchar2 default 'EXCEL',
   p_load_id                in number default null
   );

procedure load_excel_data (
   p_string                 in clob,
   p_cnames                 in wwv_flow_global.vc_arr2,
   p_upload                 in wwv_flow_global.vc_arr2,
   p_schema                 in varchar2,
   p_table                  in varchar2,
   --
   p_data_type              in wwv_flow_global.vc_arr2,
   p_data_format            in wwv_flow_global.vc_arr2 default wwv_flow.empty_vc_arr,
   p_parsed_data_format     in wwv_flow_global.vc_arr2 default wwv_flow.empty_vc_arr,
   --
   p_separator              in varchar2 default '\t',
   p_enclosed_by            in varchar2 default null,
   p_first_row_is_col_name  in boolean default false,
   p_load_to                in varchar2 default 'EXIST',
   p_currency               in varchar2 default '$',
   p_numeric_chars          in varchar2 default '.,',
   p_load_type              in varchar2 default 'EXCEL',
   p_load_id                in number default null
   );

end wwv_flow_load_excel_data;
/