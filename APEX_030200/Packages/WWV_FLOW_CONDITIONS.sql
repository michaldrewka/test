CREATE OR REPLACE package wwv_flow_conditions as

--  Copyright (c) Oracle Corporation 2002-2007. All Rights Reserved.
--
--    DESCRIPTION
--      Flow conditions
--
--    SECURITY
--      Internal function available only to the flows user.
--
--    RUNTIME DEPLOYMENT: YES
--

g_error_message varchar2(4000) := null; -- in the event of an error evaluating the condition display this error
g_sqlerrm       varchar2(4000) := null; -- database error generated when evaluating the condition

function standard_condition (
     p_condition_type    in varchar2 default null,
     p_condition         in varchar2 default null,
     p_condition2        in varchar2 default null)
     return boolean
     ;

end wwv_flow_conditions;
/