CREATE OR REPLACE trigger wwv_flow_purged_sess_biu
    before insert or update on wwv_flow_purged_sessions$
    for each row
begin
    --
    -- vpd
    --
    if :new.security_group_id is null then
       :new.security_group_id := nvl(wwv_flow_security.g_security_group_id,0);
    end if;
end;
/