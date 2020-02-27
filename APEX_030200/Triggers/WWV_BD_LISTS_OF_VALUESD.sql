CREATE OR REPLACE trigger wwv_bd_lists_of_valuesd
    before delete on wwv_flow_list_of_values_data
    for each row
begin
    --
    -- delete compound condition that may exist for this lov item
    --
    if :old.lov_disp_cond_type = 'COMPOUND' then
        begin
            delete wwv_flow_compound_conditions
                where id = to_number(:old.lov_disp_cond)
                and security_group_id = :old.security_group_id;
        exception when others then null;
        end;
    end if;
end wwv_bd_lists_of_valuesd;
/