CREATE OR REPLACE package wwv_flow_temp as
    g_colCnt      int := 0;
procedure init( p_query in varchar2);
function  init( p_query in varchar2) return varchar2;
end wwv_flow_temp;
/