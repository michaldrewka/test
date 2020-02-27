CREATE OR REPLACE trigger wwv_flow_biu_lock_page
before insert or update on wwv_flow_lock_page
for each row
begin
    --
    -- ID
    --
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
    -- last updated
    --
    if not wwv_flow.g_import_in_progress then
        :new.LOCKED_ON := sysdate;
    end if;
    --
    -- maintain log
    --
    if inserting then
        insert into wwv_flow_lock_page_log
            (lock_id,lock_flow,lock_page,action,developer,lock_comment)
        values
            (:new.id,:new.flow_id,:new.object_id,'LOCK',:new.locked_by,:new.lock_comment);
    end if;
    if updating then
        insert into wwv_flow_lock_page_log
            (lock_id,lock_flow,lock_page,action,developer,lock_comment)
        values
            (:new.id,:new.flow_id,:new.object_id,'UPDATE',:new.locked_by,:new.lock_comment);
    end if;
end;
/