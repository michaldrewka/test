CREATE OR REPLACE trigger wwv_biu_flow_lists_of_valuesd
    before insert or update on wwv_flow_list_of_values_data
    for each row
begin
    if inserting and :new.id is null then
        :new.id := wwv_flow_id.next_val;
    elsif updating
        and :old.lov_disp_cond_type = 'COMPOUND'
        and nvl(:new.lov_disp_cond_type,'-123' ) <> 'COMPOUND' then
        begin
            delete wwv_flow_compound_conditions
                where id = to_number(:old.lov_disp_cond)
                and security_group_id = :old.security_group_id;
        exception when others then null;
        end;
    end if;
    if :new.lov_return_value is null then
       :new.lov_return_value := :new.lov_disp_value;
    end if;
    if :new.lov_disp_value is null then
       :new.lov_disp_value := :new.lov_return_value;
    end if;
    --
    if :new.flow_id is null then
        for c1 in (select flow_id
                     from wwv_flow_lists_of_values$
                    where id = :new.lov_id) loop
            :new.flow_id := c1.flow_id;
            exit;
        end loop;
    end if;
    --
    -- vpd
    --
    if :new.security_group_id is null then
       :new.security_group_id := nvl(wwv_flow_security.g_security_group_id,0);
    end if;
    --
    -- last updated
    --
    if not wwv_flow.g_import_in_progress then
        :new.last_updated_on := sysdate;
        :new.last_updated_by := wwv_flow.g_user;
    end if;
end;
/