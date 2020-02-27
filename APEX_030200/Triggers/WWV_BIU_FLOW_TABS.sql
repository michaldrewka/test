CREATE OR REPLACE trigger wwv_biu_flow_tabs
    before insert or update on wwv_flow_tabs
    for each row
begin
    if inserting and :new.id is null then
        :new.id := wwv_flow_id.next_val;
    elsif updating
        and :old.display_condition_type = 'COMPOUND'
        and nvl(:new.display_condition_type,'-123' ) <> 'COMPOUND' then
        begin
            delete wwv_flow_compound_conditions
                where id = to_number(:old.tab_plsql_condition)
                and flow_id = :old.flow_id
                and security_group_id = :old.security_group_id;
        exception when others then null;
        end;
    end if;
    :new.tab_also_current_for_pages :=
       replace(replace(replace(:new.tab_also_current_for_pages,':',','),' ',','),'|',',');
    --
    -- vpd
    --
    if :new.security_group_id is null then
       :new.security_group_id := nvl(wwv_flow_security.g_security_group_id,0);
    end if;

    if not wwv_flow.g_import_in_progress then
        :new.last_updated_on := sysdate;
        :new.last_updated_by := wwv_flow.g_user;
    end if;
end;
/