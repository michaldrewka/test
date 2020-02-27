CREATE OR REPLACE package wwv_flow_sw_util as

    function get_pk_position (
      p_table_owner in varchar2,
      p_table_name  in varchar2,
      p_column_name in varchar2
      )
    return number;

    function is_wrapped (
      p_owner  in varchar2,
      p_object in varchar2,
      p_type   in varchar2
      )
    return boolean;

    function is_reserved(
      p_word in varchar2)
    return boolean;

    function is_valid_name (
      p_name in varchar2
    ) return boolean;

    function is_database_reserved_word(
      p_word in varchar2)
    return boolean;

    function table_exists (
      p_name in varchar2,
      p_owner in varchar2
    ) return boolean;

    function is_available_name (
      p_name in varchar2,
      p_owner in varchar2
    ) return boolean;

    function is_available_name2 (
      p_name in varchar2,
      p_owner in varchar2,
      p_type in varchar2
    ) return boolean;

    function pick_pk (
      p_collection_name in varchar2
    ) return varchar2;

    function generate_pk_name (
      p_name in varchar2,
      p_cnt  in number default 0
    ) return varchar2;

    function generate_seq_name (
      p_name in varchar2,
      p_cnt  in number default 0
    ) return varchar2;

    procedure run_block(
      p_sql  in varchar2,
      p_user in varchar2 );

    procedure run_ddl(
      p_sql  in dbms_sql.varchar2s,
      p_user in varchar2 );

    function get_altertable_ddl(
      p_table_name varchar2,
      p_action     varchar2,
      p_con_claus  varchar2,
      p_col_claus  varchar2
    ) return varchar2;

   function get_trigger2_ddl(
      p_table_name in varchar2,
      p_action     in varchar2,
      p_trigger_nm in varchar2,
      p_when       in varchar2,
      p_operations in varchar2,
      p_for_each   in varchar2,
      p_body       in varchar2,
      p_col        in varchar2,
      p_col_when   in varchar2
   ) return varchar2;

   function get_index_ddl(
      p_table_name in varchar2,
      p_index_name in varchar2,
      p_action     in varchar2,
      p_unique     in varchar2,
      p_col1       in varchar2,
      p_col2       in varchar2,
      p_col3       in varchar2,
      p_col4       in varchar2,
      p_indextype  in varchar2
   ) return varchar2;

   function get_copytbl_ddl(
      p_table_name in varchar2,
      p_cp_table   in varchar2,
      p_columns    in varchar2,
      p_where      in varchar2
   ) return varchar2;

   function get_row_cnt(
      p_schema     in varchar2,
      p_table_name in varchar2
   ) return varchar2;

   function get_analyze_ddl(
      p_table_name  in varchar2,
      p_action      in varchar2,
      p_est_claus   in varchar2
   ) return varchar2;

   function get_function_ddl(
      p_func_name   in varchar2,
      p_arguments   in varchar2,
      p_return      in varchar2,
      p_body        in varchar2
   ) return varchar2;

   function get_sequence_ddl(
      p_seq_name    in varchar2,
      p_start       in varchar2 default null,
      p_increment   in varchar2 default null,
      p_max         in varchar2 default null,
      p_min         in varchar2 default null,
      p_cache       in varchar2 default null,
      p_cycle       in varchar2 default null,
      p_order       in varchar2 default null
   ) return varchar2;

   function get_dblink_ddl(
      p_link_name   in varchar2,
      p_schema      in varchar2,
      p_password    in varchar2,
      p_host        in varchar2,
      p_host_port   in varchar2,
      p_sid_or_serv in varchar2,
      p_sid_name    in varchar2
   ) return varchar2;

   function get_synonym_ddl(
      p_syn_name    in varchar2,
      p_type        in varchar2,
      p_schema_to   in varchar2,
      p_object_to   in varchar2,
      p_link        in varchar2
   ) return varchar2;

   function get_drop_ddl(
      p_object_type in varchar2,
      p_object_name in varchar2,
      p_cascade     in varchar2 default null
   ) return varchar2;

   function get_view_ddl(
      p_view_name   in varchar2,
      p_body        in varchar2
   ) return varchar2;

   function get_package_ddl(
      p_pack_name   in varchar2,
      p_spec        in varchar2
   ) return varchar2;

   function get_packagebody_ddl(
      p_pack_name   in varchar2,
      p_body        in varchar2
   ) return varchar2;

   function run_other_sql (
      p_schema     in varchar2,
      p_sql        in varchar2
   ) return varchar2;

   function get_ddl(
     p_table_name varchar2,
     p_schema     varchar2,
     p_pk1        varchar2,
     p_pk1_name   varchar2,
     p_pk1_type   varchar2,
     p_seq_name   varchar2,
     p_run_ddl    varchar2 default 'NO',
     p_pk2        varchar2 default null,
     p_fk_name    varchar2 default null,
     p_fk_col     varchar2 default null,
     p_fk_ftable  varchar2 default null,
     p_fk_fcol    varchar2 default null,
     p_fk_type    varchar2 default null
   ) return varchar2;

    procedure run_sql (
      p_sql_cmd    in varchar2,
      p_schema     in varchar2,
      p_table_name in varchar2,
      p_seq_name   in varchar2
    );

    procedure create_package (
      p_source  in sys.dbms_sql.varchar2s,
      p_owner   in varchar2
    );

    procedure get_object_info (
      p_object_id in number,
      p_object_owner out varchar2,
      p_object_name  out varchar2,
      p_object_type  out varchar2
    );

  function get_foreign_key_ddl(
    p_table_name varchar2,
    p_schema     varchar2,
    p_seq_name   varchar2,
    p_run_ddl    boolean default false,
    p_fk_name    varchar2,
    p_fk_col     varchar2,
    p_fk_ftable  varchar2,
    p_fk_fcol    varchar2,
    p_fk_type    varchar2 default 'N'
  ) return varchar2;

  function get_const_ddl(
    p_table_name varchar2,
    p_schema     varchar2,
    p_con_name   varchar2,
    p_type       varchar2,
    p_check      varchar2,
    p_cols       varchar2,
    p_run_ddl    boolean default false
  ) return       varchar2;

    function show_plsql_edit(
        p_sgid  in  varchar2
    ) return boolean;

end;
/