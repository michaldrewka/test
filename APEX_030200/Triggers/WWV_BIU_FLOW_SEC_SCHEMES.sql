CREATE OR REPLACE trigger wwv_biu_flow_sec_schemes
    before insert or update on wwv_flow_security_schemes
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
    -- remove trailing spaces
    --
    for i in 1..10 loop
        :new.SCHEME_TEXT  := rtrim(:new.SCHEME_TEXT );
        :new.SCHEME_TEXT  := rtrim(:new.SCHEME_TEXT ,chr(10));
        :new.SCHEME_TEXT  := rtrim(:new.SCHEME_TEXT ,chr(13));
    end loop;
    --
    -- last updated
    --
    if not wwv_flow.g_import_in_progress then
        :new.last_updated_on := sysdate;
        :new.last_updated_by := wwv_flow.g_user;
        update wwv_flows set
           last_updated_on = sysdate,
           last_updated_by = wwv_flow.g_user
        where
           id = :new.flow_id and
           security_group_id = :new.security_group_id;
    end if;
end;
/