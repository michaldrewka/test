CREATE OR REPLACE package body WWV_FLOW_FND_FUNCTION
as
function TEST (
    function_name IN varchar2) return boolean
is
begin
    return true;
end test;
end wwv_flow_fnd_function;
/