CREATE OR REPLACE package wwv_flow_table_drill
as
--  Copyright (c) Oracle Corporation 1999 - 2002. All Rights Reserved.
--
--
--    DESCRIPTION
--      Given owner and table name this package generates report to drill up and drill down
--      based on the referential integrity.
--
--    NOTES
--
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

empty_vc_arr wwv_flow_global.vc_arr2;

function build_sql (
    p_owner       varchar2,
    p_to_table    varchar2,
    p_type        varchar2 default 'TABLE',
    p_from_table  varchar2 default null,
    p_drill       varchar2 default null,
    p_rowid       varchar2 default null,
    p_include     varchar2 default null,
    p_show_drill  varchar2 default 'Y'
    ) return varchar2
    ;

function build_view_sql (
    p_owner       varchar2,
    p_to_table    varchar2,
    p_type        varchar2 default 'TABLE',
    p_from_table  varchar2 default null,
    p_drill       varchar2 default null,
    p_rowid       varchar2 default null,
    p_include     varchar2 default null
    ) return varchar2
    ;

procedure draw_data_model (
    p_owner       in varchar2,
    p_table_name  in varchar2,
    p_session     in number,
    p_page        in varchar2 default null,
    p_request     in varchar2 default null,
    p_clear_cache in varchar2 default null,
    p_item_oid    in varchar2 default null
    )
    ;

end wwv_flow_table_drill;
/