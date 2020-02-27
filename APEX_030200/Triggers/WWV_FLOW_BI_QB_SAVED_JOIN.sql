CREATE OR REPLACE trigger wwv_flow_bi_qb_saved_join
    before insert on wwv_flow_qb_saved_join
    for each row
begin
    :new.security_group_id  := nvl(wwv_flow_security.g_security_group_id,0);
    if not wwv_flow.g_import_in_progress then
        update wwv_flow_qb_saved_query set
           last_updated_on = sysdate,
           last_updated_by = wwv_flow.g_user
        where
           id = :new.id and
           security_group_id = :new.security_group_id;
    end if;
end;
/