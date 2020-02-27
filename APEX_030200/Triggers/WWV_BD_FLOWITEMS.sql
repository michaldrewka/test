CREATE OR REPLACE trigger wwv_bd_flowitems
    before delete on wwv_flow_items
    for each row
begin
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
end wwv_bd_flowitems;
/