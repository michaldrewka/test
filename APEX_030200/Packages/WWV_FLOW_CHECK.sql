CREATE OR REPLACE package wwv_flow_check
as

--  Copyright (c) Oracle Corporation 1999. All Rights Reserved.
--
--    DESCRIPTION
--      Flow utility to check conditions
--
--    SECURITY
--
--    NOTES
--      To improve performance checks are cached to avoid evaluating duplicate checks.
--


--
-- internal caching mechinisms
--
procedure cache_sql (
    p_sql    in varchar2,
    p_result in boolean)
    ;

function check_cache (
    p_sql in varchar2)
    return varchar2
    ;

-----------------
-- generic check
--
-- p_codition1      = a condition of type p_condition_type
-- p_codition2      = a second condition used by some condition types
-- p_condition_type = SQL_EXPRESSION
--                    PLSQL_EXPRESSION
--                    EXISTS
--                    NOT_EXISTS
--                    CONDITION1_EQUALS_CONDITION2
--                    CONDITION1_NOT_EQUALS_CONDITION2
--                    CONDITION1_IN_CONDITION2
--                    VAL_OF_ITEM_IN_CONDITION1_EQUALS_CONDITION2
--                    VAL_OF_ITEM_IN_CONDITION1_NOT_EQUALS_CONDITION2
--                    VAL_OF_ITEM_IN_CONDITION1_IS_NULL
--                    VAL_OF_ITEM_IN_CONDITION1_IS_NOT_NULL
--                    REQUEST_EQUALS_CONDITION1
--                    REQUEST_NOT_EQUALS_CONDITION1
--                    REQUEST_IN_CONDITION1
--                    REQUEST_NOT_IN_CONDITION1
--

function check_condition (
    p_condition_type in varchar2,
    p_condition1     in varchar2,
    p_condition2     in varchar2 default null)
    return boolean
    ;


--
--
--

function check_cond_plsql_expresion (
    p_condition in varchar2 default null)
    return boolean
    ;

function check_condition_sql_expresion (
    p_condition in varchar2 default null)
    return boolean
    ;
end wwv_flow_check;
/