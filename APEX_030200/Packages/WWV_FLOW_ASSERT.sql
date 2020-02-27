CREATE OR REPLACE package wwv_flow_assert
is
INVALID_SCHEMA_NAME EXCEPTION;
    PRAGMA EXCEPTION_INIT(INVALID_SCHEMA_NAME, -44001);
INVALID_OBJECT_NAME EXCEPTION;
    PRAGMA EXCEPTION_INIT(INVALID_OBJECT_NAME, -44002);
INVALID_SQL_NAME EXCEPTION;
    PRAGMA EXCEPTION_INIT(INVALID_SQL_NAME, -44003);
--
--
function noop(
--
-- Purpose: dummy check to prevent reporting by SQL injection tool
-- Example: if wwv_flow_assert.noop(p_value => <some parameter>) then null; end if;
-- Notes:   Use sparingly, as a last resort when you are absolutely sure of the safety of not checking the input value
--
    p_value in varchar2)
    return varchar2
    ;

procedure noop(
--
-- Purpose: dummy check to prevent reporting by SQL injection tool
-- Example: wwv_flow_assert.noop(p_value => <some parameter>);
-- Notes:   Use sparingly, as a last resort when you are absolutely sure of the safety of not checking the input value
--
    p_value in varchar2);

function noop(
--
-- Purpose: dummy check to prevent reporting by SQL injection tool
-- Example: if wwv_flow_assert.noop(p_value => <some parameter>) then null; end if;
-- Notes:   Use sparingly, as a last resort when you are absolutely sure of the safety of not checking the input value
--      :   Overloaded
--
    p_value in wwv_flow_global.vc_arr2)
    return wwv_flow_global.vc_arr2
    ;

procedure noop(
--
-- Purpose: dummy check to prevent reporting by SQL injection tool
-- Example: wwv_flow_assert.noop(p_value => <some parameter>);
-- Notes:   Use sparingly, as a last resort when you are absolutely sure of the safety of not checking the input value
--      :   Overloaded
--
    p_value in wwv_flow_global.vc_arr2);

function schema_name(
--
-- Purpose: check for existing schema in database
-- Example: if wwv_flow_assert.schema_name(p_schema => <some parameter>) then null; end if;
-- Notes  : input schema name may be enclosed in double quotes; Checks for existence of schema in database
--
    p_schema in varchar2)
    return varchar2
    ;

procedure schema_name(
--
-- Purpose: check for existing schema in database
-- Example: wwv_flow_assert.schema_name(p_schema => <some parameter>);
-- Notes  : input schema name may be enclosed in double quotes; Checks for existence of schema in database
--
    p_schema in varchar2)
    ;

function simple_sql_name(
--
-- Purpose: check for valid identifier
-- Example: if wwv_flow_assert.simple_sql_name(p_name => <some parameter>) then null; end if;
-- Notes  : input name may be enclosed in double quotes; length is checked
--
    p_name in varchar2)
    return varchar2
    ;

function normal_sql_name(
--
-- Purpose: check for valid identifier
-- Example: if wwv_flow_assert.simple_sql_name(p_name => <some parameter>) then null; end if;
-- Notes  : input name assumed to be in "normal" format and must not be enclosed in double quotes; length is checked
--
    p_name in varchar2)
return varchar2
    ;

function null_or_normal_sql_name(
--
-- Purpose: check for null or valid identifier
-- Example: if wwv_flow_assert.null_or_normal_sql_name(p_name => <some parameter>) then null; end if;
-- Notes  : input name assumed to be in "normal" format and must not be enclosed in double quotes; length is checked
--
    p_name in varchar2)
    return varchar2
    ;

procedure simple_sql_name(
--
-- Purpose: check for valid identifier
-- Example: wwv_flow_assert.simple_sql_name(p_name => <some parameter>);
-- Notes  : input name may be enclosed in double quotes; length is checked
--
    p_name in varchar2)
    ;

function null_or_simple_sql_name(
--
-- Purpose: check for null or valid identifier
-- Example: if wwv_flow_assert.simple_sql_name(p_name => <some parameter>) then null; end if;
-- Notes  : input name may be enclosed in double quotes; length is checked
--
    p_name in varchar2)
    return varchar2
    ;

procedure null_or_simple_sql_name(
--
-- Purpose: check for null or valid identifier
-- Example: wwv_flow_assert.simple_sql_name(p_name => <some parameter>);
-- Notes  : input name may be enclosed in double quotes; length is checked
--
    p_name in varchar2)
    ;

function get_first_token(
    p_str in varchar2)
    return varchar2
    ;

function sql_query_start(
    p_query in varchar2)
    return varchar2
    ;
--
-- Purpose: check that first token is 'SELECT' or 'WITH'
-- Example: if wwv_flow_assert.sql_query_start(p_query => <some parameter>) then null; end if;
-- Notes:   Function ignores case of input and trims leading whitespace and left parentheses
--

procedure sql_query_start(
--
-- Purpose: check that first token is 'SELECT' or 'WITH'
-- Example: wwv_flow_assert.sql_query_start(p_query => <some parameter>);
-- Notes:   Function ignores case of input and trims leading whitespace and left parentheses
--
    p_query in varchar2)
    ;

function where_clause_start(
--
-- Purpose: check that first token is 'WHERE'
-- Example: if wwv_flow_assert.where_clause_start(p_query => <some parameter>) then null; end if;
-- Notes:   Function ignores case of input and trims leading whitespace and left parentheses
--
    p_query in varchar2)
    return varchar2
    ;

procedure where_clause_start(
--
-- Purpose: check that first token is 'WHERE'
-- Example: wwv_flow_assert.where_clause_start(p_query => <some parameter>);
-- Notes:   Function ignores case of input and trims leading whitespace and left parentheses
--
    p_query in varchar2)
    ;

function function_body_start(
    p_query in varchar2)
--
-- Purpose: check that first token is 'DECLARE' or 'BEGIN'
-- Example: if wwv_flow_assert.function_body_start(p_query => <some parameter>) then null; end if;
-- Notes:   Function ignores case of input and trims leading whitespace and left parentheses
--
    return varchar2
    ;

procedure function_body_start(
--
-- Purpose: check that first token is 'DECLARE' or 'BEGIN'
-- Example: wwv_flow_assert.function_body_start(p_query => <some parameter>);
-- Notes:   Function ignores case of input and trims leading whitespace and left parentheses
--
    p_query in varchar2)
    ;

function sql_or_function_start(
--
-- Purpose: check that first token is 'SELECT' or 'WITH' or DECLARE' or 'BEGIN'
-- Example: if wwv_flow_assert.sql_or_function_start(p_query => <some parameter>) then null; end if;
-- Notes:   Function ignores case of input and trims leading whitespace and left parentheses
--
    p_query in varchar2)
    return varchar2
    ;

procedure sql_or_function_start(
--
-- Purpose: check that first token is 'SELECT' or 'WITH' or DECLARE' or 'BEGIN'
-- Example: wwv_flow_assert.sql_or_function_start(p_query => <some parameter>);
-- Notes:   Function ignores case of input and trims leading whitespace and left parentheses
--
    p_query in varchar2)
    ;

procedure verify_parsing_schema(
--
-- Purpose: check that parsing schema is allowed to parse in current security group ID (wwv_flow_security.g_security_group_id)
-- Example: if wwv_flow_assert.verify_parsing_schema(p_schema => <some parameter>) then null; end if;
-- Notes:   Schema name, if provided, may not be double-quoted
--
    p_schema in varchar2 default wwv_flow_security.g_parse_as_schema)
    ;

function verify_parsing_schema(
--
-- Purpose: check that parsing schema is allowed to parse in current security group ID (wwv_flow_security.g_security_group_id)
-- Example: wwv_flow_assert.verify_parsing_schema(p_schema => <some parameter>);
-- Notes:   Schema name, if provided, may not be double-quoted
--
    p_schema in varchar2 default wwv_flow_security.g_parse_as_schema)
    return varchar2
    ;

end wwv_flow_assert;
/