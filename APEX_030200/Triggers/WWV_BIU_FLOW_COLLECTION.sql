CREATE OR REPLACE trigger wwv_biu_flow_collection
    before insert or update on wwv_flow_collections$
    for each row
begin
    :new.user_id           := wwv_flow.g_user;
    :new.session_id        := v('SESSION');
    :new.collection_name   := upper(:new.collection_name);
    :new.flow_id           := v('FLOW_ID');


    if inserting then
        if :new.id is null then
            :new.id := wwv_flow_id.next_val;
            :new.created_on        := sysdate;
        end if;
        if :new.collection_changed is null then
            :new.collection_changed := 'N';
        else
            :new.collection_changed := upper(:new.collection_changed);
        end if;
    end if;

    --
    -- vpd
    --
    if :new.security_group_id is null then
       :new.security_group_id := nvl(wwv_flow_security.g_security_group_id,0);
    end if;
end;
/