CREATE OR REPLACE trigger wwv_biu_flow_steps
    before insert or update on wwv_flow_steps
    for each row
begin
    if inserting and :new.id is null then
        :new.id := wwv_flow_id.next_val;
    end if;
    if inserting then
        :new.created_on := sysdate;
        :new.created_by := wwv_flow.g_user;
    end if;
    if (inserting or updating) and :new.id2 is null then
        :new.id2 := wwv_flow_id.next_val;
    end if;
    if :new.step_sub_title_type is null then
        :new.step_sub_title_type := 'TEXT_WITH_SUBSTITUTIONS';
    end if;

    :new.alias := upper(:new.alias);

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
    else
        if :new.last_updated_on is null and wwv_flow.g_user is not null then
            :new.last_updated_on := sysdate;
            :new.last_updated_by := wwv_flow.g_user;
        end if;
    end if;
    --
    -- cascade update to application
    --
    update wwv_flows set
        last_updated_on = sysdate,
        last_updated_by = wwv_flow.g_user
    where
        id = :new.flow_id and
        security_group_id = :new.security_group_id;
end;
/