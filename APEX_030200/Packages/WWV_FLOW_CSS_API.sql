CREATE OR REPLACE package wwv_flow_css_api
as

/*
 * Create a new css_repository entry, returns unique id for
 *  wwv_flow_css_repository table.
 */
function new_css_repository_record(
    p_name                  in out varchar2,
    p_varchar2_table            in dbms_sql.varchar2_table,
    p_mimetype                  in varchar2,
    p_flow_id                   in number,
    p_notes                     in varchar2)
    return number
    ;


--
-- F I L E S Y S T E M   I N T E G R A T I O N
--

/*
 * pass in the css id of the wwv_flow_css_repository record representing
 *  the css file you want to drop. If this css does not exist according to the
 *  wwv_flow_css_repository table, this will fail.
 */
--
-- remove by name
--
procedure remove_css(
    p_css_name                  in varchar2)
    ;

end wwv_flow_css_api;
/