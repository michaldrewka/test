CREATE OR REPLACE trigger wwv_biu_mig_frm_blk_item_trg
    before insert or update on wwv_mig_frm_blk_item_triggers
    for each row
begin
    --insert unique primary key for id
     if inserting then
        if :new.id is null then
            :new.id := wwv_flow_id.next_val;
        end if;
        -- created
        :new.created_by := wwv_flow.g_user;
        :new.created_on := sysdate;
     end if;

     -- default tracking info
     --mike
     if inserting or updating then
        if :new.applicable is null then
            :new.applicable := 'Y';
        end if;
        if dbms_lob.getlength(:new.triggertext) = 0 then
           :new.applicable := 'N';
        end if;
        if :new.triggertext is null or :new.triggertext = 'exit_form;' then
           :new.applicable := 'N';
        end if;
     end if;

    -- vpd
     if :new.security_group_id is null then
       :new.security_group_id := nvl(wwv_flow_security.g_security_group_id, 0);
     end if;

    -- last updated
    if not wwv_flow.g_import_in_progress then
        :new.last_updated_on := sysdate;
        :new.last_updated_by := wwv_flow.g_user;
    end if;
end;
/