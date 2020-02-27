CREATE OR REPLACE trigger wwv_biu_flowpageplugs
    before insert or update on wwv_flow_page_plugs
    for each row
begin
    if inserting and :new.id is null then
        :new.id := wwv_flow_id.next_val;
    elsif updating
        and :old.plug_display_condition_type = 'COMPOUND'
        and nvl(:new.plug_display_condition_type,'-123' ) <> 'COMPOUND' then
        begin
            delete wwv_flow_compound_conditions
                where id = to_number(:old.plug_display_when_condition)
                and flow_id = :old.flow_id
                and security_group_id = :old.security_group_id;
        exception when others then null;
        end;
    end if;
    if :new.plug_source_type is null then
        :new.plug_source_type := 'STATIC_TEXT';
    end if;
    if :new.plug_query_row_template is not null then
        :new.plug_query_format_out := 'TEMPLATE';
    end if;
    --
    -- remove trailing spaces
    --
    for i in 1..10 loop
        :new.plug_display_when_condition  := rtrim(:new.plug_display_when_condition );
        :new.plug_display_when_condition  := rtrim(:new.plug_display_when_condition ,chr(10));
        :new.plug_display_when_condition  := rtrim(:new.plug_display_when_condition ,chr(13));
    end loop;

    if :new.plug_source is not null then
      wwv_flow_page_cache_api.lob_replace(
        p_lob  => :new.plug_source,
        p_what => chr(13),
        p_with => null);
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
    --
    -- last updated page, cascades to update application
    --
    if not wwv_flow.g_import_in_progress then
        wwv_flow_audit.g_cascade := true;
        update wwv_flow_steps set
           last_updated_on = sysdate,
           last_updated_by = wwv_flow.g_user
        where
           flow_id = :new.flow_id and
           id = :new.page_id and
           security_group_id = :new.security_group_id;
        wwv_flow_audit.g_cascade := false;
    end if;
end;
/