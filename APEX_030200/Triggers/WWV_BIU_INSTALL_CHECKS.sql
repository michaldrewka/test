CREATE OR REPLACE trigger wwv_biu_install_checks
    before insert or update on wwv_flow_install_checks
    for each row
begin
    if inserting and :new.id is null then
        :new.id := wwv_flow_id.next_val;
    end if;

    if :new.flow_id is null then
       :new.flow_id := v('FB_FLOW_ID');
    end if;

    if :new.install_id is null then
       for c1 in (select id from wwv_flow_install where flow_id = :new.flow_id) loop
          :new.install_id := c1.id;
       end loop;
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
       if inserting then
          :new.created_by := nvl(wwv_flow.g_user,user);
          :new.created_on := sysdate;
       elsif updating then
          :new.last_updated_by := nvl(wwv_flow.g_user,user);
          :new.last_updated_on := sysdate;
       end if;
       update wwv_flow_install set
           last_updated_on = sysdate,
           last_updated_by = wwv_flow.g_user
        where
           id = :new.install_id and
           security_group_id = :new.security_group_id;
    end if;
end;
/