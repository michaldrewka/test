CREATE OR REPLACE package wwv_flow_form_control
as
--  Copyright (c) Oracle Corporation 2004. All Rights Reserved.
--
--
--    DESCRIPTION
--
--
--    NOTES
--      This package is used to compute form control values.
--      For example, it is used to compute next or previous primary key value(s) based on given table information and current primary key value(s).
--
--    SECURITY
--      No grants, must be run as FLOW schema owner.
--
--    NOTES
--
--    INTERNATIONALIZATION
--      unknown
--
--    MULTI-CUSTOMER
--      unknown
--
--    CUSTOMER MAY CUSTOMIZE
--      NO
--
--    RUNTIME DEPLOYMENT: YES
--


procedure get_next_or_prev_info (
    p_process_sql    in varchar2 default null);
end wwv_flow_form_control;
/