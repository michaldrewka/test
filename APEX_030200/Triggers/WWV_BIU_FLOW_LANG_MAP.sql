CREATE OR REPLACE trigger wwv_biu_flow_lang_map
    before insert or update on wwv_flow_language_map
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
    -- last updated and trans_flow_lang_code_root
    --
    :new.trans_flow_lang_code_root := substr(:new.translation_flow_language_code,1,2);
    if not wwv_flow.g_import_in_progress then
        :new.last_updated_on := sysdate;
        :new.last_updated_by := wwv_flow.g_user;
    end if;
end;
/