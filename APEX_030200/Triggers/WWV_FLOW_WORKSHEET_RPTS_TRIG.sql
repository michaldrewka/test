CREATE OR REPLACE trigger wwv_flow_worksheet_rpts_trig
    before insert or update on wwv_flow_worksheet_rpts
    for each row
declare
    l_col_type varchar2(30);
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
    if :new.application_user is null then
        :new.application_user := v('APP_USER');
    end if;
    if :new.status is null then
       :new.status := 'PRIVATE';
    end if;
    if :new.display_rows is null then
       :new.display_rows := 15;
    end if;
    if :new.flashback_enabled is null then
       :new.flashback_enabled := 'N';
    end if;
    if :new.report_seq is null then
       :new.report_seq := 10;
    end if;
    if :new.is_default is null then
        :new.is_default := 'N';
    end if;
    --
    -- vpd
    --
    if :new.security_group_id is null then
       :new.security_group_id := wwv_flow.get_sgid;
    end if;
end;
/