CREATE OR REPLACE procedure p (
    n       in varchar2 default null,
    p_mime_type in varchar2 default null,
    p_inline    in varchar2 default 'NO')

-- Copyright (c) Oracle Corporation 2001. All Rights Reserved.
--
--    DESCRIPTION
--      View a page given a page ID
--
--    SECURITY
--      Public shortcut
--
--    NOTES
--
--    EXAMPLES:
--

is
begin
     if n is null then
         htp.p(wwv_flow_lang.system_message('p.valid_page_err'));
         return;
     end if;
     --
     wwv_flow_file_mgr.get_file (
        p_id => n,
        p_mime_type => p_mime_type,
        p_inline => p_inline);
end p;
/