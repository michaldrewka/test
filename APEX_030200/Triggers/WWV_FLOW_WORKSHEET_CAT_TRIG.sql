CREATE OR REPLACE trigger wwv_flow_worksheet_cat_trig
    before insert or update on wwv_flow_worksheet_categories
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
        :new.flow_id := nvl(wwv_flow.g_flow_id,0);

    elsif updating then
        :new.updated_on := sysdate;
        :new.updated_by := nvl(wwv_flow.g_user,user);
    end if;
    --
    -- display sequence
    --
    if inserting and :new.display_sequence is null then
        select nvl(max(display_sequence),0) + 1 into :new.display_sequence
          from wwv_flow_worksheet_categories
         where worksheet_id = :new.worksheet_id;
    end if;
    --
    -- vpd
    --
    if :new.security_group_id is null then
       :new.security_group_id := wwv_flow.get_sgid;
    end if;
end;
/