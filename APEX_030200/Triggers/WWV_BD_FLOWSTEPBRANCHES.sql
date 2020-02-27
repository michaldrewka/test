CREATE OR REPLACE trigger wwv_bd_flowstepbranches
    before delete on wwv_flow_step_branches
    for each row
begin
    --
    -- delete compound condition that may exist for this branch
    --
    if :old.branch_condition_type = 'COMPOUND' then
        begin
            delete wwv_flow_compound_conditions
                where id = to_number(:old.branch_condition)
                and flow_id = :old.flow_id
                and security_group_id = :old.security_group_id;
        exception when others then null;
        end;
    end if;
end wwv_bd_flowstepbranches;
/