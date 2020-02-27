CREATE OR REPLACE trigger wwv_biu_flowflashchartseries
    before insert or update on wwv_flow_flash_chart_series
    for each row
begin
    if inserting and :new.id is null then
        :new.id := wwv_flow_id.next_val;
    end if;
    if inserting then
        :new.created_by := nvl(wwv_flow.g_user,user);
        :new.created_on := sysdate;
    end if;
    --
    -- last updated
    --
    if not wwv_flow.g_import_in_progress then
        :new.updated_on := sysdate;
        :new.updated_by := wwv_flow.g_user;
    end if;

    if :new.flow_id is null then
        for c1 in (select flow_id
                     from wwv_flow_flash_charts
                    where id = :new.chart_id) loop
            :new.flow_id := c1.flow_id;
            exit;
        end loop;
    end if;

    if :new.series_query is not null then
      wwv_flow_page_cache_api.lob_replace(
        p_lob  => :new.series_query,
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
    -- last updated flash chart, page, cascades to update application
    --
    if not wwv_flow.g_import_in_progress then
        wwv_flow_audit.g_cascade := true;
        update wwv_flow_flash_charts set
           updated_on = sysdate,
           updated_by = wwv_flow.g_user
        where
           flow_id = :new.flow_id and
           id = :new.chart_id and
           security_group_id = :new.security_group_id;
        wwv_flow_audit.g_cascade := false;
    end if;
end;
/