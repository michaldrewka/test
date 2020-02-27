CREATE OR REPLACE trigger wwv_biu_flow_company_schemas
    before insert or update on wwv_flow_company_schemas
    for each row
begin
    if inserting and :new.id is null then
        :new.id := wwv_flow_id.next_val;
    end if;
    :new.schema := upper(:new.schema);
end;
/