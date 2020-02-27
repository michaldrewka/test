CREATE OR REPLACE function wwv_flow_item_comps (
    p_flow_id  in number,
    p_item_name in varchar2)
    return varchar2
is
    s varchar2(32767) := null;
    p varchar2(255) := wwv_flow_lang.system_message('PAGE');
begin
    for c1 in (
        select computation_point
        from  wwv_flow_computations
        where flow_id = p_flow_id and computation_item = p_item_name
        order by 1) loop
        s := s||' '||c1.computation_point;
    end loop;
    --
    s := s||' '||p||': ';
    for c1 in (
        select flow_step_id
        from  wwv_flow_step_computations
        where flow_id = p_flow_id and computation_item = p_item_name
        order by 1) loop
        s := s||' '||c1.flow_step_id;
    end loop;
    --
    if length(s) > 3997 then
       return(ltrim(substr(s,1,3997))||'...');
    else
       return(ltrim(substr(s,1,4000)));
    end if;
end wwv_flow_item_comps;
/