CREATE OR REPLACE package wwv_flow_plsql_editor as


    -----------------------------------------------------------------------------------------------
    -- get_lines
    -- p_code: CLOB containing PL/SQL code

    function get_lines (
        p_code CLOB
    ) return dbms_sql.varchar2s;


    -----------------------------------------------------------------------------------------------
    -- compile
    -- p_owner:       parse as schema name
    -- p_object_name: PL/SQL object name
    -- p_code:        PL/SQL code

    function compile (
        p_owner       varchar2,
        p_object_name varchar2,
        p_object_type varchar2,
        p_code        clob
    ) return varchar2;


end;
/