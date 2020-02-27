CREATE OR REPLACE package wwv_flow_element
as
    g_element          varchar2(255) := null;

    function add
        return number
    ;

end wwv_flow_element;
/