CREATE OR REPLACE trigger wwv_biu_wwv_mig_rev_apex
    before insert or update on  wwv_mig_rev_apexapp
    for each row
begin
    if inserting and :new.id is null then
        :new.id := wwv_flow_id.next_val;
    end if;
    --
    -- vpd
    --
    if :new.security_group_id is null then
       :new.security_group_id := nvl(wwv_flow_security.g_security_group_id,0);
    end if;

    --
    --
    -- last updated
    --
        :new.last_updated_on := sysdate;
        :new.last_updated_by := wwv_flow.g_user;
    --
    -- created
    --
    if inserting then
        :new.created_by := wwv_flow.g_user;
        :new.created_on := sysdate;
    end if;

end;
/