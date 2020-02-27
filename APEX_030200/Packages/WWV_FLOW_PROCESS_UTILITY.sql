CREATE OR REPLACE package wwv_flow_process_utility as

--  Copyright (c) Oracle Corporation 1999 - 2002. All Rights Reserved.
--
--    DESCRIPTION
--      Flow page level process utility.
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

function dml_row_info (
    p_process_id    in varchar2,
    p_type          in varchar2)
    return varchar2;

function dml_row_sql (
    p_owner            in varchar2,
    p_table_name       in varchar2,
    p_pk_item          in varchar2,
    p_pk_column        in varchar2,
    p_pk_item2         in varchar2 default null,
    p_pk_column2       in varchar2 default null,
    p_allowed_actions  in varchar2 default null,
    p_dml_fetch_mode   in varchar2 default null)
    return varchar2;

function multi_row_update_info (
    p_process_id    in varchar2,
    p_type          in varchar2)
    return varchar2;

function multi_row_update_sql (
    p_owner            in varchar2,
    p_table_name       in varchar2,
    p_pk_column        in varchar2,
    p_pk_column2       in varchar2 default null
    )
    return varchar2;

function set_pref_to_item_info (
    p_process_id    in varchar2,
    p_type          in varchar2)
    return varchar2;

function set_pref_to_item_sql (
    p_preference       in varchar2,
    p_item             in varchar2
    )
    return varchar2;

function get_next_or_prev_pk_info (
    p_process_id    in varchar2,
    p_type          in varchar2)
    return varchar2;

function get_next_or_prev_pk_sql (
    p_owner              varchar2,
    p_table              varchar2,
    p_pk_column          varchar2,
    p_pk_column2         varchar2 default null,
    p_sort_column        varchar2 default null,
    p_sort_column2       varchar2 default null,
    p_item_pk            varchar2 default null,
    p_item_next          varchar2 default null,
    p_item_prev          varchar2 default null,
    p_item_pk2           varchar2 default null,
    p_item_next2         varchar2 default null,
    p_item_prev2         varchar2 default null,
    p_item_row_cnt       varchar2 default null,
    p_where              varchar2 default null)
    return varchar2;
end wwv_flow_process_utility;
/