CREATE OR REPLACE trigger wwv_biu_flow_items
    before insert or update on wwv_flow_items
    for each row
begin
    if inserting and :new.id is null then
        :new.id := wwv_flow_id.next_val;
    end if;
    -----------------
    -- default values
    --
    if :new.data_type is null then
        :new.data_type := 'VARCHAR';
    end if;
    :new.name_length := length(:new.name);
    :new.name := upper(:new.name);
    if :new.is_Persistent is null then
        :new.is_Persistent := 'Y';
    end if;

    --
    -- name
    --
    :new.name := upper(:new.name);

    --
    -- cascade to computations
    --
    if updating and :new.name != upper(:old.name) then
        begin
            update wwv_flow_computations
                set computation_item = :new.name
                where flow_id = :new.flow_id
                and upper(computation_item) = upper(:old.name);
            --
            update wwv_flow_step_computations
                set computation_item = :new.name
                where flow_id = :new.flow_id
                and upper(computation_item) = upper(:old.name);
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