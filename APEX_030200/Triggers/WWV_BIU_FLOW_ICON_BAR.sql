CREATE OR REPLACE trigger wwv_biu_flow_icon_bar
    before insert or update on wwv_flow_icon_bar
    for each row
begin
    if inserting and :new.id is null then
        :new.id := wwv_flow_id.next_val;
    elsif updating
        and :old.icon_bar_disp_cond_type = 'COMPOUND'
        and nvl(:new.icon_bar_disp_cond_type,'-123' ) <> 'COMPOUND' then
        begin
            delete wwv_flow_compound_conditions
                where id = to_number(:old.icon_bar_disp_cond)
                and flow_id = :old.flow_id
                and security_group_id = :old.security_group_id;
        exception when others then null;
        end;
    end if;
    --
    -- vpd
    --
    if :new.security_group_id is null then
       :new.security_group_id := nvl(wwv_flow_security.g_security_group_id,0);
    end if;
    --
    -- last updated
    --
    if not wwv_flow.g_import_in_progress then
        :new.last_updated_on := sysdate;
        :new.last_updated_by := wwv_flow.g_user;
        update wwv_flows set
           last_updated_on = sysdate,
           last_updated_by = wwv_flow.g_user
        where
           id = :new.flow_id and
           security_group_id = :new.security_group_id;
    end if;
end;
/