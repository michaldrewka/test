CREATE OR REPLACE trigger wwv_flow_app_comments_t1
    before insert or update on wwv_flow_app_comments
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
    -- clean up whitespace in pages
    --
    for i in 1..10 loop
    	  :new.pages := replace(:new.pages,'  ',' ');
    end loop;
    :new.pages := trim(:new.pages);
    :new.pages := replace(:new.pages,':',',');
    :new.pages := replace(:new.pages,' ',',');
    :new.pages := replace(:new.pages,',,',', ');
    :new.pages := rtrim(:new.pages,',');
    --
    -- last updated
    --
    if not wwv_flow.g_import_in_progress then
        :new.updated_on := sysdate;
        :new.updated_by := wwv_flow.g_user;
    if inserting then
        :new.created_on := sysdate;
        :new.created_by := wwv_flow.g_user;
    end if;
    update wwv_flows
    set last_updated_on = sysdate,
        last_updated_by = wwv_flow.g_user
    where id = :new.flow_id and
        security_group_id = :new.security_group_id;
    end if;
end;
/