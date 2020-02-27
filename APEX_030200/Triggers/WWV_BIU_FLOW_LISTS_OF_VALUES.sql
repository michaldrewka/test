CREATE OR REPLACE trigger wwv_biu_flow_lists_of_values
    before insert or update on wwv_flow_lists_of_values$
    for each row
begin
    if inserting and :new.id is null then
        :new.id := wwv_flow_id.next_val;
    end if;
    if :new.lov_query is null then
       :new.lov_query := '.'||:new.id||'.';
    elsif :new.lov_query = '.' then
       :new.lov_query := '.'||:new.id||'.';
    end if;
    --
    -- last updated
    --
    :new.LAST_UPDATED_BY := wwv_flow.g_user;
    :new.LAST_UPDATED_ON := sysdate;
    --
    -- vpd
    --
    if :new.security_group_id is null then
       :new.security_group_id := nvl(wwv_flow_security.g_security_group_id,0);
    end if;
end;
/