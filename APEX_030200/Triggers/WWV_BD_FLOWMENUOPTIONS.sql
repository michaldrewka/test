CREATE OR REPLACE trigger wwv_bd_flowmenuoptions
    before delete on wwv_flow_menu_options
    for each row
begin
    --
    -- delete compound condition that may exist for this menu option
    --
    if :old.display_when_cond_type = 'COMPOUND' then
        begin
            delete wwv_flow_compound_conditions
                where id = to_number(:old.display_when_condition)
                and security_group_id = :old.security_group_id;
        exception when others then null;
        end;
    end if;
end wwv_bd_flowmenuoptions;
/