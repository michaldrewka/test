CREATE OR REPLACE package wwv_flow_regexp
as
--  Copyright (c) Oracle Corporation 1999 - 2006. All Rights Reserved.
--
--
--    DESCRIPTION
--      This package is used to support regular expression features.  The body that is compiled is
--      dependant on the version of the db.  If less that 10g, the body is stubbed.
--

g_result boolean;

function is_supported return boolean;

function is_instr(
    p_source    in varchar2,
    p_pattern   in varchar2
    ) return boolean;


end wwv_flow_regexp;
/