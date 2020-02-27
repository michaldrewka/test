CREATE OR REPLACE trigger wwv_biu_step_buttons
    before insert or update on wwv_flow_step_buttons
    for each row
begin
    if inserting and :new.id is null then
        :new.id := wwv_flow_id.next_val;
    elsif updating
        and :old.button_condition_type = 'COMPOUND'
        and nvl(:new.button_condition_type,'-123' ) <> 'COMPOUND' then
        begin
            delete wwv_flow_compound_conditions
                where id = to_number(:old.button_condition)
                and flow_id = :old.flow_id
                and security_group_id = :old.security_group_id;
        exception when others then null;
        end;
    end if;

    for c1 in (select tab_name from wwv_flow_tabs where flow_id = :new.flow_id and tab_name = :new.button_name) loop
        raise_application_error (-20001,wwv_flow_lang.system_message('TRIGGER.BUTTON_TAB_NAMES_NOT_EQUAL'));
        exit;
    end loop;
    --
    -- remove trailing spaces
    --
    for i in 1..10 loop
        :new.button_condition  := rtrim(:new.button_condition );
        :new.button_condition  := rtrim(:new.button_condition ,chr(10));
        :new.button_condition  := rtrim(:new.button_condition ,chr(13));
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