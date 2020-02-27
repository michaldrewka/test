CREATE OR REPLACE trigger wwv_bd_flowpageplugs
    before delete on wwv_flow_page_plugs
    for each row
begin
    --
    -- cascade update to null items with this plug
    -- ignore errors on mutating tables
    --
    begin
    update wwv_flow_step_items
       set item_plug_id = null
     where flow_id = :old.flow_id and flow_step_id = :old.page_id and item_plug_id = :old.id;
    exception when others then null;
    end;
    --
    -- delete compound condition that may exist for this region
    --
    if :old.plug_display_condition_type = 'COMPOUND' then
        begin
            delete wwv_flow_compound_conditions
                where id = to_number(:old.plug_display_when_condition)
                and flow_id = :old.flow_id
                and security_group_id = :old.security_group_id;
        exception when others then null;
        end;
    end if;
end wwv_bd_flowpageplugs;
/