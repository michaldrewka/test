CREATE OR REPLACE package wwv_flow_log as

--  Copyright (c) Oracle Corporation 1999 - 2002. All Rights Reserved.
--
--    DESCRIPTION
--      Flow activity logging
--
--    SECURITY
--
--    NOTES:
--      This program logs flow activity
--      p_elap:     Elapsed time in seconds
--      p_num_rows: Number of rows processed by page
--      p_verbose:  Log all information not just most critical
--
--    RUNTIME DEPLOYMENT: YES
--

g_log_interval_in_days  constant number := 14;
g_total_rows_fetched pls_integer := 0;


function current_log_number
    return number
    ;

procedure log (
    p_elap                in number   default null,
    p_num_rows            in number   default null,
    p_verbose             in boolean  default true)
    ;


end wwv_flow_log;
/