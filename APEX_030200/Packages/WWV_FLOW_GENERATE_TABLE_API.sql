CREATE OR REPLACE PACKAGE wwv_flow_generate_table_api IS


  procedure create_api (
    p_owner         in  varchar2,
    p_app_name      in  varchar2,
    p_table_name_01 in  varchar2 default null,
    p_table_name_02 in  varchar2 default null,
    p_table_name_03 in  varchar2 default null,
    p_table_name_04 in  varchar2 default null,
    p_table_name_05 in  varchar2 default null,
    p_table_name_06 in  varchar2 default null,
    p_table_name_07 in  varchar2 default null,
    p_table_name_08 in  varchar2 default null,
    p_table_name_09 in  varchar2 default null,
    p_table_name_10 in  varchar2 default null,
    p_action        in  varchar2 default 'SHOW'
  );


END wwv_flow_generate_table_api;
/