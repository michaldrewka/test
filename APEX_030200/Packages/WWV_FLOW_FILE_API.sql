CREATE OR REPLACE package wwv_flow_file_api
as

g_file_inserted boolean := false;
g_file_inserted_count pls_integer := 0;

/*
 * Clean a directory varchar2 value
 */
function clean_dirname(
    p_dir                       in varchar2)
    return varchar2
    ;

/*
 * Clean a filename varchar2 value
 */
function clean_filename(
    p_file                      in varchar2)
    return varchar2
    ;

/*
 * Take a BLOB, and write it to a table of VARCHAR2's. You can then use
 *  varchar2_to_blob to reconstruct your binary objects from your varchars'2.
 */
function blob_to_varchar2(
    p_blob                      in blob)
    return dbms_sql.varchar2_table
    ;

/*
 * Take a table of varchar2s, and write them to a blob.
 */
function varchar2_to_blob(
    p_varchar2_tab              in dbms_sql.varchar2_table)
    return blob
    ;

/*
 * Create a new record in the wwv_flow_file_objects$ table.
 */
function new_file_object$(
    p_name                    in out varchar2,
    p_blob                        in blob,
    p_mimetype                    in varchar2)
    return number
    ;

procedure remove_file(
    p_id                        in number,
    p_file_path                 in varchar2,
    p_file_name                 in varchar2)
    ;

function get_file_id (
   p_file_name                  in varchar2)
   return number;

procedure set_file_security_group_id (
   p_file_name                  in varchar2)
   ;

procedure set_file_security_group_id (
   p_file_id                    in number)
   ;

procedure create_file (
       p_id              in number default null,
       p_flow_id         in number default null,
       p_name            in varchar2 default null,
       p_pathid          in number default null,
       p_filename        in varchar2 default null,
       p_title           in varchar2 default null,
       p_mime_type       in varchar2 default null,
       p_doc_size        in number default null,
       p_dad_charset     in varchar2 default null,
       p_created_by      in varchar2 default null,
       p_created_on      in date default null,
       p_updated_by      in varchar2 default null,
       p_updated_on      in date default null,
       p_deleted_as_of   in date default null,
       p_last_updated    in date default null,
       p_content_type    in varchar2 default null,
       p_blob_content    in blob default null,
       p_language        in varchar2 default null,
       p_description     in varchar2 default null,
       p_file_type       in varchar2 default null)
       ;

end wwv_flow_file_api;
/