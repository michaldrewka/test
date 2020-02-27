CREATE OR REPLACE function wwv_flow_lov_used_on_pages (
    p_flow_id  in number,
    p_lov_name in varchar2,
    p_lov_id   in number)
    return varchar2

--  Copyright (c) Oracle Corporation 1999. All Rights Reserved.
--
--    DESCRIPTION
--      List multiple columns as a single column
--
--    SECURITY
--
--    NOTES
--
--    RUNTIME DEPLOYMENT: YES
--
--      jstraub 11/05/2003  - Added union with LOV's referenced in wwv_flow_region_report_column
--      jstraub 11/05/2003  - Added constraining by flow_id to union query, so tranlated flow_step_id's do not appear

is
    s varchar2(32767) := null;
    r varchar2(4000) := null;
begin
    for c1 in (select flow_step_id from wwv_flow_step_items where flow_id = p_flow_id and named_lov = p_lov_name
               union
               select a.page_id flow_step_id
                 from wwv_flow_page_plugs a, wwv_flow_region_report_column b, wwv_flow_lists_of_values$ c
                where a.id = b.region_id
                  and c.id = b.named_lov
                  and a.flow_id = p_flow_id
                  and c.id = p_lov_id
               order by 1 ) loop
        s := s||' '||c1.flow_step_id;
    end loop;
    if length(r) > 3997 then
       r := ltrim(substr(s,1,3997))||'...';
    else
       r := ltrim(substr(s,1,4000));
    end if;
    return r;
end wwv_flow_lov_used_on_pages;
/