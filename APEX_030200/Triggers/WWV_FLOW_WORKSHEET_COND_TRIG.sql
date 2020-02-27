CREATE OR REPLACE trigger wwv_flow_worksheet_cond_trig
    before insert or update on wwv_flow_worksheet_conditions
    for each row
begin
    --
    -- maintain pk and timestamps
    --
    if inserting and :new.id is null then
        :new.id := wwv_flow_id.next_val;
    end if;
    if inserting then
        :new.created_on := sysdate;
        :new.created_by := nvl(wwv_flow.g_user,user);
        :new.updated_on := sysdate;
        :new.updated_by := nvl(wwv_flow.g_user,user);
    elsif updating then
        :new.updated_on := sysdate;
        :new.updated_by := nvl(wwv_flow.g_user,user);
    end if;
    if inserting and :new.enabled is null then
        :new.enabled := 'Y';
    end if;
    if inserting and :new.allow_delete is null then
        :new.allow_delete := 'Y';
    end if;
    --
    -- update parent timestamp
    --
    update wwv_flow_worksheet_rpts
       set updated_on = :new.updated_on,
           updated_by = :new.updated_by
     where id = :new.report_id;
    --
    -- vpd
    --
    if :new.security_group_id is null then
       :new.security_group_id := wwv_flow.get_sgid;
    end if;
end;
/