CREATE OR REPLACE trigger wwv_flow_ws_computation_trig
    before insert or update on wwv_flow_worksheet_computation
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

    if :new.db_column_name is null then
        :new.db_column_name := wwv_flow_worksheet_standard.get_next_computed_column_name(:new.worksheet_id, :new.report_id);
    end if;

    if :new.column_identifier is null then
        :new.column_identifier := wwv_flow_worksheet_standard.get_next_computed_identifier(:new.worksheet_id, :new.report_id);
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