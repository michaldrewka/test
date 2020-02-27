CREATE OR REPLACE trigger wwv_flow_bi_qb_saved_qry
    before insert on wwv_flow_qb_saved_query
    for each row
begin
        :new.id                 := nvl(:new.id,wwv_flow_id.next_val);
        :new.query_owner        := nvl(:new.query_owner,wwv_flow_user_api.get_default_schema);
        :new.created_by         := nvl(:new.created_by,wwv_flow.g_user);
        :new.created_on         := nvl(:new.created_on,sysdate);
        :new.last_updated_by    := wwv_flow.g_user;
        :new.last_updated_on    := sysdate;
        :new.security_group_id  := nvl(wwv_flow_security.g_security_group_id,0);
end;
/