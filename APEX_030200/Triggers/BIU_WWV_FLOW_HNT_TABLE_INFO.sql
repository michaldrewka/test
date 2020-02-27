CREATE OR REPLACE trigger biu_wwv_flow_hnt_table_info
        before insert or update on wwv_flow_hnt_table_info
            for each row
    begin
        if inserting and :new.table_id is null then
            :new.table_id := wwv_flow_id.next_val;
        end if;
        if inserting then
            :new.created_by := nvl(wwv_flow.g_user,user);
            :new.created_on := sysdate;
        end if;
        :new.last_updated_by := nvl(wwv_flow.g_user,user);
        :new.last_updated_on := sysdate;
    end;
/