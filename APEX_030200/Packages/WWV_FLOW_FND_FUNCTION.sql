CREATE OR REPLACE package WWV_FLOW_FND_FUNCTION
is
function TEST (
    function_name IN varchar2) return boolean;
end wwv_flow_fnd_function;
/