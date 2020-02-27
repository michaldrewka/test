CREATE OR REPLACE function wwv_flow_hot_http_links (
    p_text   in varchar2 default null)
    return varchar2
is
    s varchar2(32767) := null;
    begin_http_cc number := 1;
    http_idx      number := 1;
    http_length   number := 0;
begin
    loop
       begin_http_cc := instr(upper(p_text)||' ','HTTP://', http_idx );
       exit when begin_http_cc = 0;

       s := s||substr(p_text||' ',http_idx,begin_http_cc-http_idx);

       http_length := instr(replace(p_text,chr(10),' ')||' ',' ',begin_http_cc) - begin_http_cc;

       s := s||'<a href="'||
            rtrim(substr(p_text||' ',begin_http_cc,http_length),'.')||
            '">'||substr(p_text||' ',begin_http_cc,http_length)||'</a>';

       http_idx := begin_http_cc + http_length;

    end loop;
    return s||substr(p_text||' ',http_idx);
end wwv_flow_hot_http_links;
/