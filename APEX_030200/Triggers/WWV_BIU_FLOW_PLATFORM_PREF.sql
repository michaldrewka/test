CREATE OR REPLACE trigger wwv_biu_flow_platform_pref
    before insert or update on wwv_flow_platform_pref
    for each row
begin
    if inserting and :new.id is null then
        :new.id := wwv_flow_id.next_val;
    end if;
end;
/