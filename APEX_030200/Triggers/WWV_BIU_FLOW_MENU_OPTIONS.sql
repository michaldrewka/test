CREATE OR REPLACE trigger wwv_biu_flow_menu_options
    before insert or update on wwv_flow_menu_options
    for each row
begin
    if inserting and :new.id is null then
        :new.id := wwv_flow_id.next_val;
    elsif updating
        and :old.display_when_cond_type = 'COMPOUND'
        and nvl(:new.display_when_cond_type,'-123' ) <> 'COMPOUND' then
        begin
            delete wwv_flow_compound_conditions
                where id = to_number(:old.display_when_condition)
                and security_group_id = :old.security_group_id;
        exception when others then null;
        end;
    end if;
    --
    if :new.flow_id is null then
        for c1 in (select flow_id
                     from wwv_flow_menus
                    where id = :new.menu_id) loop
            :new.flow_id := c1.flow_id;
            exit;
        end loop;
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
    end if;
end;
/