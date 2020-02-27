CREATE OR REPLACE trigger wwv_biu_flow_prov_comp_smod
    before insert or update on wwv_flow_provision_serice_mod
    for each row
begin
    if inserting and :new.id is null then
        :new.id := wwv_flow_id.next_val;
    end if;
    if inserting then
        :new.requested_on := sysdate;
        :new.requested_by := wwv_flow.g_user;
    end if;
    if updating then
        :new.last_status_change_on := sysdate;
        :new.last_status_change_by := wwv_flow.g_user;
    end if;
    --
    -- vpd
    --
    if :new.security_group_id is null then
       :new.security_group_id := nvl(wwv_flow_security.g_security_group_id,0);
    end if;

    if inserting then
         wwv_flow_fnd_developer_api.admin_notify_change_request(
             p_workspace_id   => :new.security_group_id,
             p_admin_userid   => :new.requested_by );
    end if;

end;
/