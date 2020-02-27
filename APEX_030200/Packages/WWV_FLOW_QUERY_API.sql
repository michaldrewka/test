CREATE OR REPLACE package wwv_flow_query_api as

    g_conditions wwv_flow_global.vc_arr2;
    g_columns    wwv_flow_global.vc_arr2;
    g_rows       wwv_flow_global.vc_arr2;
    g_y          wwv_flow_global.vc_arr2;
    g_index      number;
    g_emptyvc    wwv_flow_global.vc_arr2;

    function add_columns(
      p_condition   in varchar2,
      p_column      in varchar2 ) return varchar2;

    function get_conditions(
      p_query_id    in varchar2,
      p_new_line    in varchar2 := chr(10),
      sp            in varchar2 := ' ' ) return clob;

    function get_structured_query(
      p_id          in number ) return clob;

    procedure get_alias(
      p_column      in varchar2,
      p_query_id    in number,
      p_num         in number := 1 );

    procedure parse_conditions(
      p_query_id    in number,
      p_id          in number,
      p_top_id      in number );

    procedure create_collection(
      p_query_id    in number );

    procedure create_conditions(
      p_query_id    in number );

    procedure create_structured_query(
      p_flow_id     in number,
      p_region_id   in number,
      p_collection  in varchar2 default 'COLUMNS');

    procedure update_query_sql(
      p_query_id    in number);

    procedure delete_structured_query(
      p_query_id    in number );

    procedure reorder_columns(
      p_query_id    in number,
      p_collection  in varchar2 default null );

    procedure update_structured_query(
      p_query_id    in number,
      p_flow_id     in number,
      p_region_id   in number,
      p_collection  in varchar2 default 'COLUMNS');

    procedure update_joins(
      p_query_id    in number);



end wwv_flow_query_api;
/