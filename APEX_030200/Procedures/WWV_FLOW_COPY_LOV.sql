CREATE OR REPLACE procedure wwv_flow_copy_lov (
    p_lov_id_from         in number,
    p_lov_name_to         in varchar2,
    p_copy_from_flow_id   in number default null,
    p_flow_id             in number default null,
    p_lov_id_to           in number default null)

--
--  Copyright (c) Oracle Corporation 1999-2004. All Rights Reserved.
--
--    DESCRIPTION
--      Copy shared lists of values
--
--    SECURITY
--
--
--    NOTES
--

is
    l_rowCnt      int := 0;
    l_id          number := null;
    l_lov_id_to   number := null;

    l_copy_from_flow_id  number := null;
    l_flow_id            number := null;

    l_lov         varchar2(4000);
    l_lov_type    number := 0;
begin
    begin
        l_id := p_lov_id_from;
    exception when others then
        raise_application_error (-20001,wwv_flow_lang.system_message('wwv_flow_copy_lov.numeric_err',p_lov_id_from));
    end;

    l_lov_id_to := p_lov_id_to;
    if l_lov_id_to is null then
       l_lov_id_to := wwv_flow_id.next_val;
    end if;

    l_copy_from_flow_id := nvl(p_copy_from_flow_id,wwv_flow.g_flow_id);
    l_flow_id := nvl(p_flow_id,wwv_flow.g_flow_id);

    for c1 in (select *
               from wwv_flow_lists_of_values$
               where id = l_id
               and flow_id = l_copy_from_flow_id) loop

        select count(*) into l_lov_type
        from wwv_flow_list_of_values_data
        where lov_id = c1.id;

        if l_lov_type = 0 then
            l_lov := c1.lov_query;
        else
            l_lov := '.'||l_lov_id_to||'.';
        end if;
        insert into WWV_FLOW_LISTS_OF_VALUES$ (
            id,
            flow_id,
            lov_name,
            lov_query)
        values (
            l_lov_id_to,
            l_flow_id,
            p_lov_name_to,
            l_lov);
        l_rowCnt := l_rowCnt + 1;
    end loop;

    for c1 in (select * from  wwv_flow_list_of_values_data where lov_id = l_id) loop
        insert into  wwv_flow_list_of_values_data (
             id,
             lov_id,
             lov_disp_sequence,
             lov_disp_value,
             lov_return_value,
             lov_disp_cond_type,
             lov_disp_cond,
             lov_disp_cond2,
             required_patch,
             lov_template)
        values (
             null,
             l_lov_id_to,
             c1.lov_disp_sequence,
             c1.lov_disp_value,
             c1.lov_return_value,
             c1.lov_disp_cond_type,
             c1.lov_disp_cond,
             c1.lov_disp_cond2,
             c1.required_patch,
             c1.lov_template);
    end loop;

    if l_rowCnt = 0 then
        raise_application_error (-20001,wwv_flow_lang.system_message('wwv_flow_copy_lov.not_found_err',p_lov_id_from));
    end if;
exception when others then
    rollback;
    raise_application_error (-20001,wwv_flow_lang.system_message('wwv_flow_copy_lov.execution_err',sqlerrm));
end wwv_flow_copy_lov;
/