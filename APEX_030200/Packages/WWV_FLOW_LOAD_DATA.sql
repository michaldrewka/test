CREATE OR REPLACE package wwv_flow_load_data as

  type vcArray is table of varchar2(2000) index by binary_integer;
  g_words	  vcArray;
  g_empty	  vcArray;
  g_last_string	  varchar2(4096);
  g_number_format varchar2(4000) := null;

  function valid_file_extension (
      p_filename in varchar2) return boolean
      ;

  function de_quote( p_str in varchar2, p_enc_by in varchar2 ) return varchar2
  ;

  function cleanout_column_name (
    p_column_name in varchar2
    ) return varchar2
    ;

  function is_number (
     p_string            in varchar2,
     p_currency          in varchar2 default '$',
     p_numeric_chars     in varchar2 default '.,'
     ) return boolean
     ;

  function is_date (
     p_string in varchar2
     ) return boolean
     ;

  function date_format (
   p_string in varchar2
   ) return varchar2
   ;

  procedure build_sql (
  p_line                   in varchar2,
  p_upload                 in wwv_flow_global.vc_arr2,
  p_schema                 in varchar2,
  p_table                  in varchar2,
  p_cnames                 in wwv_flow_global.vc_arr2,
  p_line_ctr               in number,
  --
  p_data_type              in wwv_flow_global.vc_arr2 default wwv_flow.empty_vc_arr,
  p_data_format            in wwv_flow_global.vc_arr2 default wwv_flow.empty_vc_arr,
  p_parsed_data_format     in wwv_flow_global.vc_arr2 default wwv_flow.empty_vc_arr,
  --
  p_separator              in varchar2 default chr(9),
  p_enclosed_by            in varchar2 default null,
  p_first_row_is_col_name  in boolean default false,
  --
  p_currency               in varchar2 default '$',
  p_numeric_chars          in varchar2 default '.,',
  p_load_type              in varchar2 default 'CSV',
  p_de_quote              in varchar2 default 'NO',
  --
  p_sql                    out varchar2,
  p_n                      out sys.wwv_dbms_sql.vc_arr2,
  p_r                      out sys.wwv_dbms_sql.vc_arr2
  )
  ;


  function  load_data( p_id        in number) return number
  ;
  function  dump_ascii( p_query         in varchar2,
                        p_schema        in varchar2,
                        p_separator     in varchar2 default ',',
                        p_enclosed_by   in varchar2 default null,
                        p_inc_col_names in varchar2 default 'N',
                        p_mime_header   in varchar2 default 'application/text',
                        p_mime_charset  in varchar2 default null,
                        p_file_format   in varchar2 default 'UNIX',
                        p_file_name     in varchar2 default 'export')
  return number
  ;

  procedure create_tab_info_collection(
    p_clob                   in clob,
    p_collection_name        in varchar2 default null,
    p_load_type              in varchar2 default null,
    p_separator              in varchar2 default null,
    p_enclosed_by            in varchar2 default null,
    p_first_row_is_col_name  in boolean default false,
    p_currency               in varchar2 default '$',
    p_numeric_chars          in varchar2 default '.,'
    )
    ;

  procedure create_csv_collection (
   p_file_id               in number,
   p_separator             in varchar2 default ',',
   p_enclosed_by           in varchar2 default null,
   p_first_row_is_col_name in boolean default false,
   p_currency              in varchar2 default '$',
   p_numeric_chars         in varchar2 default '.,',
   p_charset               in varchar2 default null
   )
   ;

  procedure load_data (
    p_clob                  in clob,
    p_cnames                in wwv_flow_global.vc_arr2,
    p_upload                in wwv_flow_global.vc_arr2,
    p_schema                in varchar2,
    p_table                 in varchar2,
    --
    p_data_type             in wwv_flow_global.vc_arr2,
    p_data_format           in wwv_flow_global.vc_arr2 default wwv_flow.empty_vc_arr,
    p_parsed_data_format    in wwv_flow_global.vc_arr2 default wwv_flow.empty_vc_arr,
    --
    p_separator             in varchar2 default ',',
    p_enclosed_by           in varchar2 default null,
    p_first_row_is_col_name in boolean default false,
    p_load_to               in varchar2 default 'EXIST' ,
    p_currency              in varchar2 default '$',
    p_numeric_chars         in varchar2 default '.,',
    p_load_id               in number default null,
    --
    p_file_id               in number default null,
    p_load_data_type        in varchar2 default null,
    p_load_type             in varchar2 default null
    )
    ;

  procedure load_csv_data (
   p_file_id               in number,
   p_cnames                in wwv_flow_global.vc_arr2,
   p_upload                in wwv_flow_global.vc_arr2,
   p_schema                in varchar2,
   p_table                 in varchar2,
   --
   p_data_type             in wwv_flow_global.vc_arr2,
   p_data_format           in wwv_flow_global.vc_arr2 default wwv_flow.empty_vc_arr,
   p_parsed_data_format    in wwv_flow_global.vc_arr2 default wwv_flow.empty_vc_arr,
   --
   p_separator             in varchar2 default ',',
   p_enclosed_by           in varchar2 default null,
   p_first_row_is_col_name in boolean default false,
   p_load_to               in varchar2 default 'EXIST',
   p_currency              in varchar2 default '$',
   p_numeric_chars         in varchar2 default '.,',
   p_charset               in varchar2 default null,
   p_load_id               in number default null
   )
   ;

   procedure display_ntable_property (
    p_collection_name in varchar2
    );

   procedure display_etable_property (
    p_table_owner     in varchar2,
    p_table_name      in varchar2,
    p_collection_name in varchar2
    );
end wwv_flow_load_data;
/