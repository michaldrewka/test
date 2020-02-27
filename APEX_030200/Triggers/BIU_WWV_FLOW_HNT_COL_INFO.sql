CREATE OR REPLACE trigger biu_wwv_flow_hnt_col_info
        before insert or update on wwv_flow_hnt_column_info
            for each row
    begin
        if inserting and :new.column_id is null then
            :new.column_id := wwv_flow_id.next_val;
        end if;
        if inserting then
            :new.created_by := nvl(wwv_flow.g_user,user);
            :new.created_on := sysdate;
        end if;
        :new.last_updated_by := nvl(wwv_flow.g_user,user);
        :new.last_updated_on := sysdate;
    end;
/