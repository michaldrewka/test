CREATE OR REPLACE trigger wwv_biu_flow_list_items
    before insert or update on wwv_flow_list_items
    for each row
begin
    if inserting then
        if :new.id is null then
            :new.id := wwv_flow_id.next_val;
        end if;
    elsif updating
        and :old.list_item_disp_cond_type = 'COMPOUND'
        and nvl(:new.list_item_disp_cond_type,'-123' ) <> 'COMPOUND' then
        begin
            delete wwv_flow_compound_conditions
                where id = to_number(:old.list_item_disp_condition)
                and security_group_id = :old.security_group_id;
        exception when others then null;
        end;
    end if;
    if :new.list_item_owner is not null then
        :new.list_item_owner := user;
    end if;
    for c1 in (select flow_id from wwv_flow_lists where id = :new.list_id) loop
        :new.flow_id := c1.flow_id;
        exit;
    end loop;
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