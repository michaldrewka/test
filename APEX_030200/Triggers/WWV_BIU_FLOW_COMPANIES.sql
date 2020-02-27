CREATE OR REPLACE trigger wwv_biu_flow_companies
    before insert or update on wwv_flow_companies
    for each row
begin
    if :new.provisioning_company_id = 20 and :new.short_name not in ('ORACLE','COM.ORACLE.APEX.APPLICATIONS') then
        raise_application_error(-20001,wwv_flow_lang.system_message('TRIGGER.SGID_RESERVED'));
    end if;
    if inserting and :new.id is null then
        :new.id := wwv_flow_id.next_val;
    end if;
    :new.short_name := upper(:new.short_name);
end;
/