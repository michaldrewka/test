CREATE OR REPLACE trigger wwv_biu_computations
    before insert or update on wwv_flow_computations
    for each row
begin
    if inserting and :new.id is null then
        :new.id := wwv_flow_id.next_val;
    elsif updating
        and :old.compute_when_type = 'COMPOUND'
        and nvl(:new.compute_when_type,'-123' ) <> 'COMPOUND' then
        begin
            delete wwv_flow_compound_conditions
                where id = to_number(:old.compute_when)
                and flow_id = :old.flow_id
                and security_group_id = :old.security_group_id;
        exception when others then null;
        end;
    end if;
    if :new.computation_point is null then
       :new.computation_point := 'AFTER_SUBMIT';
    end if;
    if :new.computation_processed is null then
       :new.computation_processed := 'REPLACE_EXISTING';
    end if;
    if :new.computation_type is null then
       :new.computation_type := 'SQL_EXPRESSION';
    end if;

    --
    -- set name
    --
    :new.computation_item := upper(:new.computation_item);

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