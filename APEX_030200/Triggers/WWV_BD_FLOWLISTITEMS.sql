CREATE OR REPLACE trigger wwv_bd_flowlistitems
    before delete on wwv_flow_list_items
    for each row
begin
    --
    -- delete compound condition that may exist for this list item
    --
    if :old.list_item_disp_cond_type = 'COMPOUND' then
        begin
            delete wwv_flow_compound_conditions
                where id = to_number(:old.list_item_disp_condition)
                and flow_id = :old.flow_id
                and security_group_id = :old.security_group_id;
        exception when others then null;
        end;
    end if;
end wwv_bd_flowlistitems;
/