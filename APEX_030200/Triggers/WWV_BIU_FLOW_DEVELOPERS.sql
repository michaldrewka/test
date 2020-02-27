CREATE OR REPLACE trigger wwv_biu_flow_developers
    before insert or update on wwv_flow_developers
    for each row
begin
    if inserting then
        if :new.id is null then
            :new.id := wwv_flow_id.next_val;
        end if;
        if :new.user_id is null then
            :new.user_id := :new.id;
        end if;
    end if;
    :new.userid := upper(:new.userid);
    --
    -- set admin privs
    --
    if instr(:new.DEVELOPER_ROLE,'ADMIN') > 0 then
       :new.DEVELOPER_ROLE := 'ADMIN:CREATE:DATA_LOADER:EDIT:HELP:MONITOR:SQL';
    end if;
    --
    -- vpd
    --
    if :new.security_group_id is null then
       :new.security_group_id := nvl(wwv_flow_security.g_security_group_id,0);
    end if;
end;
/