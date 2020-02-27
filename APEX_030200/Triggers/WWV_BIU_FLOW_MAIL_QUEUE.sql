CREATE OR REPLACE trigger wwv_biu_flow_mail_queue
    before insert or update on wwv_flow_mail_queue
    for each row
begin
    if inserting then
        if :new.id is null then
            :new.id := wwv_flow_id.next_val;
        end if;
        if :new.mail_send_count is null then
            :new.mail_send_count := 0;
        end if;
    end if;
    :new.last_updated_on := sysdate;
    :new.last_updated_by := nvl(wwv_flow.g_user,user);

    --
    -- vpd
    --
    if :new.security_group_id is null then
       :new.security_group_id := nvl(wwv_flow_security.g_security_group_id,0);
    end if;
end;
/