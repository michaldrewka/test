CREATE OR REPLACE trigger wwv_biu_flow_page_cache
    before insert or update on wwv_flow_page_cache
    for each row
begin
    if inserting and :new.id is null then
        :new.id := wwv_flow_id.next_val;
        :new.cached_on := sysdate;
        :new.cached_by := wwv_flow.g_user;
        :new.request   := wwv_flow.g_request;
        if :new.language is null then
           :new.language  := upper(substr(wwv_flow.g_flow_language,1,2));
        end if;
    end if;

    --
    -- vpd
    --
    --:new.security_group_id := nvl(wwv_flow_security.g_security_group_id,0);
    :new.security_group_id := nvl(wwv_flow_security.g_curr_flow_security_group_id,0);
    --
    -- last updated
    --
    if not wwv_flow.g_import_in_progress then
        :new.updated_on := sysdate;
        :new.updated_by := wwv_flow.g_user;
    end if;
end;
/