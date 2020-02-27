CREATE OR REPLACE package wwv_flow_session_mon
as
--  Copyright (c) Oracle Corporation 1999 - 2005. All Rights Reserved.
--
--    DESCRIPTION
--      Session monitoring utility package
--
--    SECURITY
--      NOT Publicly executable.
--
--
--    RUNTIME DEPLOYMENT: YES
--

    procedure populate_stats_array(p_sid in number);

    procedure populate_sys_stats_array(p_mode in varchar2 default 'REPORT');

    function highlight_plan_ind_cols(
        p_object_owner  in  varchar2,
        p_object_name   in  varchar2,
        p_string        in  varchar2)
    return varchar2;

end wwv_flow_session_mon;
/