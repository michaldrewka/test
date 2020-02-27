CREATE OR REPLACE trigger wwv_bd_flowstepitems
    before delete on wwv_flow_step_items
    for each row
begin
    --
    -- delete compound conditions that may exist for this item
    --
    if :old.display_when_type = 'COMPOUND' then
        begin
            delete wwv_flow_compound_conditions
                where id = to_number(:old.display_when)
                and flow_id = :old.flow_id
                and security_group_id = :old.security_group_id;
        exception when others then null;
        end;
    end if;

    if :old.read_only_when_type = 'COMPOUND' then
        begin
            delete wwv_flow_compound_conditions
                where id = to_number(:old.read_only_when)
                and flow_id = :old.flow_id
                and security_group_id = :old.security_group_id;
        exception when others then null;
        end;
    end if;

    --
    -- cascade delete flow and step computations referencing item
    --
    begin
        delete wwv_flow_computations
            where upper(computation_item) = upper(:old.name)
            and flow_id = :old.flow_id
            and security_group_id = :old.security_group_id;
        delete wwv_flow_step_computations
            where upper(computation_item) = upper(:old.name)
            and flow_id = :old.flow_id
            and security_group_id = :old.security_group_id;
    exception when others then null;
    end;
    --
    -- cascade update to page
    --
    begin
        wwv_flow_audit.g_cascade := true;
        update wwv_flow_steps set
           last_updated_on = sysdate,
           last_updated_by = wwv_flow.g_user
        where
           flow_id = :old.flow_id and
           id = :old.flow_step_id and
           security_group_id = :new.security_group_id;
        wwv_flow_audit.g_cascade := false;
    exception when others then null;
    end;
end wwv_bd_flowstepitems;
/