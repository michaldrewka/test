CREATE OR REPLACE trigger wwv_biu_mig_frm_rev_apex_app
    before insert or update on  wwv_mig_frm_rev_apex_app
    for each row
begin
     if inserting then
        if :new.id is null then
            :new.id := wwv_flow_id.next_val;
        end if;
        -- created
        :new.created_by := wwv_flow.g_user;
        :new.created_on := sysdate;
     end if;

    -- vpd
    if :new.security_group_id is null then
       :new.security_group_id := nvl(wwv_flow_security.g_security_group_id,0);
    end if;

    -- last updated
    :new.last_updated_on := sysdate;
    :new.last_updated_by := wwv_flow.g_user;
end;
/