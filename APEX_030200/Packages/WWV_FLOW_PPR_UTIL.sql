CREATE OR REPLACE package wwv_flow_ppr_util
as
procedure run_process(
    p_process_name_or_id in varchar2)
    ;
end wwv_flow_ppr_util;
/