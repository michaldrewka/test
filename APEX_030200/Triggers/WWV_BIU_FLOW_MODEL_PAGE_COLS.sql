CREATE OR REPLACE trigger wwv_biu_flow_model_page_cols
    before insert or update on wwv_flow_model_page_cols
    for each row
begin
    if inserting and :new.id is null then
        :new.id := wwv_flow_id.next_val;
    end if;
    if :new.security_group_id is null then
       :new.security_group_id := nvl(wwv_flow_security.g_security_group_id,0);
    end if;
    if inserting then
       :new.created_by := nvl(wwv_flow.g_user,user);
       :new.created_on := sysdate;
    elsif updating then
       :new.last_updated_by := nvl(wwv_flow.g_user,user);
       :new.last_updated_on := sysdate;
    end if;
end;
/