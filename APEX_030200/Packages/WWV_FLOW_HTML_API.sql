CREATE OR REPLACE package wwv_flow_html_api
as

/*
 * Create a new html_repository entry, returns unique id for
 *  wwv_flow_html_repository table.
 */
function new_html_repository_record(
    p_name                  in out varchar2,
    p_varchar2_table            in dbms_sql.varchar2_table,
    p_mimetype                  in varchar2,
    p_flow_id                   in number,
    p_notes                     in varchar2)
    return number
    ;

--
-- remove by name
--
procedure remove_html(
    p_html_name in varchar2)
    ;
end wwv_flow_html_api;
/