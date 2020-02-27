CREATE OR REPLACE package wwv_flow_epg_include_modules
as

function authorize(
    procedure_name in varchar2)
    return boolean
    ;
end wwv_flow_epg_include_modules;
/