CREATE OR REPLACE trigger wwv_flow_biu_standard_js
    before insert or update
    on wwv_flow_standard_js
    for each row
begin
    if inserting and :new.id is null then
         :new.id := wwv_flow_id.next_val;
    end if;
end;
/