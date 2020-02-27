CREATE OR REPLACE trigger wwv_flow_worksheets_trig
    before insert or update on wwv_flow_worksheets
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
    elsif updating and not wwv_flow.g_import_in_progress then
        :new.updated_on := sysdate;
        :new.updated_by := nvl(wwv_flow.g_user,user);
    end if;
    --
    -- set owner
    --
    if :new.owner is null then
        :new.owner := :new.created_by;
    end if;
    --
    -- set status
    --
    if :new.status is null then
        :new.status := 'AVAILABLE_FOR_OWNER';
    end if;
    --
    -- by default, reports show up as TABS
    --
    if inserting and :new.report_list_mode is null then
        :new.report_list_mode := 'TABS';
    end if;

    :new.SHOW_SELECT_COLUMNS       := nvl(:new.SHOW_SELECT_COLUMNS,'Y');
    :new.SHOW_FILTER               := nvl(:new.SHOW_FILTER,'Y');
    :new.SHOW_CONTROL_BREAK        := nvl(:new.SHOW_CONTROL_BREAK,'Y');
    :new.SHOW_SORT                 := nvl(:new.SHOW_SORT,'Y');
    :new.SHOW_HIGHLIGHT            := nvl(:new.SHOW_HIGHLIGHT,'Y');
    :new.SHOW_AGGREGATE            := nvl(:new.SHOW_AGGREGATE,'Y');
    :new.SHOW_CHART                := nvl(:new.SHOW_CHART,'Y');
    :new.SHOW_CALENDAR             := nvl(:new.SHOW_CALENDAR,'Y');
    :new.SHOW_FLASHBACK            := nvl(:new.SHOW_FLASHBACK,'Y');
    :new.SHOW_RESET                := nvl(:new.SHOW_RESET,'Y');
    :new.SHOW_DOWNLOAD             := nvl(:new.SHOW_DOWNLOAD,'Y');
    :new.SHOW_COMPUTATION          := nvl(:new.SHOW_COMPUTATION,'Y');
    :new.SHOW_HELP                 := nvl(:new.SHOW_HELP,'Y');
    :new.SHOW_DETAIL_LINK          := nvl(:new.SHOW_DETAIL_LINK,'Y');
    :new.ALLOW_REPORT_SAVING       := nvl(:new.ALLOW_REPORT_SAVING,'Y');
    :new.ALLOW_REPORT_CATEGORIES   := nvl(:new.ALLOW_REPORT_CATEGORIES,'Y');
    :new.ALLOW_EXCLUDE_NULL_VALUES := nvl(:new.ALLOW_EXCLUDE_NULL_VALUES,'Y');
    :new.ALLOW_HIDE_EXTRA_COLUMNS  := nvl(:new.ALLOW_HIDE_EXTRA_COLUMNS,'Y');

    :new.SHOW_FINDER_DROP_DOWN     := nvl(:new.SHOW_FINDER_DROP_DOWN,'Y');
    :new.SHOW_DISPLAY_ROW_COUNT    := nvl(:new.SHOW_DISPLAY_ROW_COUNT,'Y');
    :new.SHOW_SEARCH_BAR           := nvl(:new.SHOW_SEARCH_BAR,'Y');
    :new.SHOW_SEARCH_TEXTBOX       := nvl(:new.SHOW_SEARCH_TEXTBOX,'Y');
    :new.SHOW_ACTIONS_MENU         := nvl(:new.SHOW_ACTIONS_MENU,'Y');

    --
    -- maintain column values
    --
    if :new.flow_id is null then
       :new.flow_id := wwv_flow.g_flow_id;
    end if;
    --
    -- vpd
    --
    if :new.security_group_id is null then
       :new.security_group_id := wwv_flow.get_sgid;
    end if;

    --
    -- last updated page, cascades to update application
    --
    if not wwv_flow.g_import_in_progress and :new.flow_id != 4900 then
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