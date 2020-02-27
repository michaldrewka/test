CREATE OR REPLACE trigger wwv_biu_wwv_flow_hnt_argument
    before insert or update on  wwv_flow_hnt_argument_info
    for each row
begin
    if :new.argument_id is null then
        :new.argument_id := wwv_flow_id.next_val;
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