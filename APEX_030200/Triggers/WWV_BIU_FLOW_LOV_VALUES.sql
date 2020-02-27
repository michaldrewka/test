CREATE OR REPLACE trigger wwv_biu_flow_lov_values
    before insert or update on wwv_flow_lov_values
    for each row
begin
    if inserting then
        if :new.id is null then
            :new.id := wwv_flow_id.next_val;
        end if;
    end if;
    if :new.list_owner is null then
        :new.list_owner := nvl(wwv_flow.g_user,user);
    end if;
    --
    -- vpd
    --
    if :new.security_group_id is null then
       :new.security_group_id := nvl(wwv_flow_security.g_security_group_id,0);
    end if;
end;
/