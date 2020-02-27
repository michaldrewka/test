CREATE OR REPLACE trigger wwv_biu_flow_prov_company
    before insert or update on wwv_flow_provision_company
    for each row
begin
    if inserting and :new.id is null then
        :new.id := wwv_flow_id.next_val;
    end if;
    if inserting and :new.admin_id is null then
        :new.admin_id := wwv_flow_id.next_val;
    end if;
    if inserting and :new.security_group_id is null then
        :new.security_group_id := wwv_flow_id.next_val;
    end if;
    if inserting then
        :new.request_date := sysdate;
    end if;
    :new.company_name := upper(:new.company_name);
    :new.admin_userid := upper(:new.admin_userid);
    :new.schema_name  := upper(:new.schema_name);

    if inserting then
         wwv_flow_fnd_developer_api.admin_notify_new_request(
             p_workspace_name => :new.company_name,
             p_schema_name    => :new.schema_name,
             p_admin_userid   => :new.admin_userid,
             p_admin_email    => :new.admin_email );
    end if;
end;
/