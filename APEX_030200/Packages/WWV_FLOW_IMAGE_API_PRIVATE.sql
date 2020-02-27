CREATE OR REPLACE package wwv_flow_image_api_private
as

procedure get_image_details(
    p_id                        in number,
    p_file_object_id           out number,
    p_file_path                out varchar2,
    p_file_name                out varchar2)
    ;

/*
 * create record in wwv_flow_image_repository, and find the associated
 *  record in wwv_flow_file_object$ (key off of p_new_image_name) and
 *  write that blob to the file system
 */
procedure process_new_image(
    p_flow_id                   in number,
    p_image_id                  in number,
    p_image_name                in varchar2,
    p_new_image_name            in varchar2,
    p_nlang                     in varchar2,
    p_height                    in number,
    p_width                     in number,
    p_notes                     in varchar2)
    ;

--
-- F I L E S Y S T E M   I N T E G R A T I O N
--
/*
 * pass in the image id of the wwv_flow_image_repository record representing
 *  the image you want to drop. If this image does not exist according to the
 *  wwv_flow_image_repository table, this will not work.
 */
procedure remove_image(
    p_id                        in number)
    ;

end wwv_flow_image_api_private;
/