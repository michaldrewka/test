CREATE OR REPLACE trigger wwv_biu_online_help
    before insert on wwv_flow_online_help
    for each row
begin
    if inserting and :new.id is null then
        :new.id := wwv_flow_id.next_val;
    end if;
end;
/