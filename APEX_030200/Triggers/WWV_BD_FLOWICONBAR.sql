CREATE OR REPLACE trigger wwv_bd_flowiconbar
    before delete on wwv_flow_icon_bar
    for each row
begin
    --
    -- delete compound condition that may exist for this icon
    --
    if :old.icon_bar_disp_cond_type = 'COMPOUND' then
        begin
            delete wwv_flow_compound_conditions
                where id = to_number(:old.icon_bar_disp_cond)
                and flow_id = :old.flow_id
                and security_group_id = :old.security_group_id;
        exception when others then null;
        end;
    end if;
end wwv_bd_flowiconbar;
/