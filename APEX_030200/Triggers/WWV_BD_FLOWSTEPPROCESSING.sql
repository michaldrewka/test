CREATE OR REPLACE trigger wwv_bd_flowstepprocessing
    before delete on wwv_flow_step_processing
    for each row
begin
    --
    -- delete compound condition that may exist for this process
    --
    if :old.process_when_type = 'COMPOUND' then
        begin
            delete wwv_flow_compound_conditions
                where id = to_number(:old.process_when)
                and flow_id = :old.flow_id
                and security_group_id = :old.security_group_id;
        exception when others then null;
        end;
    end if;
end wwv_bd_flowstepprocessing;
/