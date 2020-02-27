CREATE OR REPLACE trigger wwv_biu_flow_chart_ser_attr
    before insert or update on wwv_flow_region_chart_ser_attr
    for each row
begin
    if inserting and :new.id is null then
        :new.id := wwv_flow_id.next_val;
    end if;
    --
    -- vpd
    --
    if :new.security_group_id is null then
       :new.security_group_id := nvl(wwv_flow_security.g_security_group_id,0);
    end if;
    --
    -- last updated page, cascades to update application
    --
    if not wwv_flow.g_import_in_progress then
        wwv_flow_audit.g_cascade := true;
        for c1 in (select flow_id, page_id from wwv_flow_page_plugs
                   where id = :new.region_id
                   and security_group_id = :new.security_group_id) loop
            update wwv_flow_steps set
               last_updated_on = sysdate,
               last_updated_by = wwv_flow.g_user
            where
               flow_id = c1.flow_id and
               id = c1.page_id and
               security_group_id = :new.security_group_id;
        end loop;
        wwv_flow_audit.g_cascade := false;
    end if;
end;
/