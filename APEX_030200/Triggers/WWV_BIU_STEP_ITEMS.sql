CREATE OR REPLACE trigger wwv_biu_step_items
    before insert or update on wwv_flow_step_items
    for each row
begin
    if inserting and :new.id is null then
        :new.id := wwv_flow_id.next_val;
    elsif updating then
        if :old.display_when_type = 'COMPOUND'
            and nvl(:new.display_when_type,'-123' ) <> 'COMPOUND' then
            begin
                delete wwv_flow_compound_conditions
                    where id = to_number(:old.display_when)
                    and flow_id = :old.flow_id
                    and security_group_id = :old.security_group_id;
            exception when others then null;
            end;
        end if;
        --
        if :old.read_only_when_type = 'COMPOUND'
            and nvl(:new.read_only_when_type,'-123' ) <> 'COMPOUND' then
            begin
                delete wwv_flow_compound_conditions
                    where id = to_number(:old.read_only_when)
                    and flow_id = :old.flow_id
                    and security_group_id = :old.security_group_id;
            exception when others then null;
            end;
        end if;
    end if;
    -----------------
    -- default values
    --
    if :new.begin_on_new_line is null then
        :new.begin_on_new_line := 'YES';
    end if;
    if :new.begin_on_new_field is null then
        :new.begin_on_new_field := 'YES';
    end if;
    if :new.colspan is null then
        :new.colspan := 1;
    end if;
    if :new.rowspan is null then
        :new.rowspan := 1;
    end if;
    if :new.label_alignment is null then
        :new.label_alignment := 'LEFT';
    end if;
    if :new.field_alignment is null then
        :new.field_alignment := 'LEFT';
    end if;
    if :new.lov_display_null is null then
        :new.lov_display_null := 'NO';
    end if;
    if :new.accept_processing is null then
        :new.accept_processing := 'REPLACE_EXISTING';
    end if;
    if :new.is_Persistent is null then
        :new.is_Persistent := 'Y';
    end if;
    -- maintain the length of the item name
    :new.name_length := length(:new.name);
    -- force field into upper case
    :new.name := upper(:new.name);
    --
    -- remove trailing whitespace from source column
    :new.source := rtrim(rtrim(ltrim(:new.source)),chr(13)||chr(10));
    --
    if replace(:new.named_lov,'%null%') is not null then
        begin
        select replace(lov_query,chr(13),null) into :new.lov
        from   wwv_flow_lists_of_values$
        where  flow_id = :new.flow_id and lov_name = :new.named_lov;
        exception when others then null;
        end;
    end if;
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
    end if;
    --
    -- last updated page, cascades to update application
    --
    if not wwv_flow.g_import_in_progress then
        wwv_flow_audit.g_cascade := true;
        update wwv_flow_steps set
           last_updated_on = sysdate,
           last_updated_by = wwv_flow.g_user
        where
           flow_id = :new.flow_id and
           id = :new.flow_step_id and
           security_group_id = :new.security_group_id;
        wwv_flow_audit.g_cascade := false;
    end if;
end;
/