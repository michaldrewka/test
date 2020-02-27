CREATE OR REPLACE trigger wwv_biu_flow_mail_log
    before insert on wwv_flow_mail_log
    for each row
begin
    :new.last_updated_on := sysdate;
end;
/