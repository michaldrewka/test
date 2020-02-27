CREATE OR REPLACE package wwv_flow_file_mgr
as

-- Copyright (c) Oracle Corporation 2000-2008. All Rights Reserved.
--
--    DESCRIPTION
--      File Upload/Download services
--
--    SECURITY
--
--    NOTES
--      Package Body should be wrapped
--

procedure show_item_download_page (
    p_format       in varchar2 default null)
    ;

procedure show_download_format_page (
    p_format       in varchar2 default null)
    ;

function get_file_id(
    p_name in varchar2)
    return number
    ;

procedure process_download
    ;

procedure get_file(
    p_id        in varchar2,
    p_mime_type in varchar2 default null,
    p_inline    in varchar2 default 'NO' );

procedure get_file(
    p_fname             in varchar2,
    p_security_group_id in varchar2,
    p_flow_id           in varchar2 default null,
    p_inline            in varchar2 default 'YES' );


end wwv_flow_file_mgr;
/