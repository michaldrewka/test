CREATE OR REPLACE trigger wwv_biu_region_report_column
    before insert or update on wwv_flow_region_report_column
    for each row
begin
    if inserting and :new.id is null then
        :new.id := wwv_flow_id.next_val;
    end if;
    --
    -- sync flow id for translations
    --
    if :new.flow_id is null then
         for c1 in (select flow_id
                     from wwv_flow_page_plugs
                     where id = :new.region_id) loop
             :new.flow_id := c1.flow_id;
             exit;
         end loop;
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
end;
/