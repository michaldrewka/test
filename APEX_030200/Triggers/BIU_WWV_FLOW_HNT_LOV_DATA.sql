CREATE OR REPLACE trigger biu_wwv_flow_hnt_lov_data
        before insert or update on wwv_flow_hnt_lov_data
            for each row
    begin
        if inserting and :new.id is null then
            :new.id := wwv_flow_id.next_val;
        end if;
        :new.last_updated_by := nvl(wwv_flow.g_user,user);
        :new.last_updated_on := sysdate;
    end;
/