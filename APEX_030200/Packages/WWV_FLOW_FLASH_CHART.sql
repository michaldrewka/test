CREATE OR REPLACE package wwv_flow_flash_chart
as

g_chart_engine  varchar2(255) := 'ANYCHART';
g_clob                       clob;

procedure chart (
    p_region_id in number
    );

function static_xml (
    p_region_id in number
    ) return varchar2;

end wwv_flow_flash_chart;
/