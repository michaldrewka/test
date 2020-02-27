CREATE OR REPLACE trigger wwv_biu_flow_db_auth
    before insert or update on wwv_flow_db_auth
    for each row
begin
    :new.db_auth_schema := upper(:new.db_auth_schema);
end;
/