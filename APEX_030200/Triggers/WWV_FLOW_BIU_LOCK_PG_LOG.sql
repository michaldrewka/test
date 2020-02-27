CREATE OR REPLACE trigger wwv_flow_biu_lock_pg_log
before insert or update on wwv_flow_lock_page_log
for each row
begin
    --
    -- ID
    --
    if inserting and :new.id is null then
        :new.id := wwv_flow_id.next_val;
    end if;
    --
    -- last updated
    --
    if not wwv_flow.g_import_in_progress then
        :new.action_date := sysdate;
    end if;
end;
/