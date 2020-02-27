CREATE OR REPLACE trigger wwv_biu_step_validations
    before insert or update on wwv_flow_step_validations
    for each row
begin
    if inserting and :new.id is null then
        :new.id := wwv_flow_id.next_val;
    elsif updating
        and :old.validation_condition_type = 'COMPOUND'
        and nvl(:new.validation_condition_type,'-123' ) <> 'COMPOUND' then
        begin
            delete wwv_flow_compound_conditions
                where id = to_number(:old.validation_condition)
                and flow_id = :old.flow_id
                and security_group_id = :old.security_group_id;
        exception when others then null;
        end;
    end if;
    :new.validation_condition := rtrim( :new.validation_condition, ' '||chr(10)||chr(13) );
    --
    -- remove trailing spaces
    --
    for i in 1..10 loop
        :new.validation  := rtrim(:new.validation );
        :new.validation  := rtrim(:new.validation ,chr(10));
        :new.validation  := rtrim(:new.validation ,chr(13));
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