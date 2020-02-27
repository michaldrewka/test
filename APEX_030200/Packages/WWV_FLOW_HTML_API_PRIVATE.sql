CREATE OR REPLACE package wwv_flow_html_api_private
as

/*
 * create record in wwv_flow_html_repository, and find the associated
 *  record in wwv_flow_file_object$ (key off of p_html_name) and
 *  write that blob to the file system
 *
 * if the file id is known (fm table wwv_flow_file_object$), pass it.
 *  otherwise, it will be found based on p_html_name
 */
procedure new_html(
    p_flow_id                   in number,
    p_html_id                   in number default null,
    p_html_name                 in varchar2,
    p_notes                     in varchar2,
    p_file_charset              in varchar2 default null)
    ;

/*
 * Update an existing record in wwv_flow_html_repository, and find
 *  the associated record in wwv_flow_file_object$ and re-write that
 *  blob to the file system.
 */
procedure update_html(
    p_flow_id                   in number,
    p_html_id                   in number,
    p_html_name                 in varchar2,
    p_html_contents             in varchar2,
    p_notes                     in varchar2)
    ;


--
-- F I L E S Y S T E M   I N T E G R A T I O N
--
/*
 * pass in the html id of the wwv_flow_html_repository record representing
 *  the html you want to drop. If this html does not exist according to the
 *  wwv_flow_html_repository table, this will not work.
 */
procedure remove_html(
    p_id                        in number)
    ;

end wwv_flow_html_api_private;
/