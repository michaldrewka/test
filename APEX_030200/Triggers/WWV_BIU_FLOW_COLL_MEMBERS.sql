CREATE OR REPLACE trigger wwv_biu_flow_coll_members
    before insert or update on wwv_flow_collection_members$
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