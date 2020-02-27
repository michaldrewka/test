CREATE OR REPLACE package wwv_flow_css_api_private
as

/*
 * create record in wwv_flow_css_repository, and find the associated
 *  record in wwv_flow_file_object$ (key off of p_new_css_name) and
 *  write that blob to the file system
 */
procedure process_new_css(
    p_flow_id                   in number,
    p_css_name                  in varchar2,
    p_notes                     in varchar2,
    p_file_charset              in varchar2 default null)
    ;


/*
 * update existing record in wwv_flow_css_repository, and find the
 *  record in wwv_flow_file_object$ and update the blob with
 *  p_css_contents
 */
procedure update_css(
    p_css_id                    in number,
    p_css_name                  in varchar2,
    p_css_contents              in varchar2,
    p_css_notes                 in varchar2)
    ;


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
procedure remove_css(
    p_id                        in number)
    ;
--
-- remove by name
--
procedure remove_css(
    p_css_name                  in varchar2)
    ;

end wwv_flow_css_api_private;
/