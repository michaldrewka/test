CREATE OR REPLACE trigger wwv_flow_worksheet_col_trig
    before insert or update on wwv_flow_worksheet_columns
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
    --
    -- default values
    --
    if :new.report_label is null then
        :new.report_label := :new.column_label;
    elsif :new.column_label is null then
        :new.column_label := :new.report_label;
    end if;

    if :new.is_sortable is null then
        :new.is_sortable := 'Y';
    end if;

    :new.allow_sorting      := nvl(:new.allow_sorting,'Y');
    :new.allow_filtering    := nvl(:new.allow_filtering,'Y');
    :new.allow_ctrl_breaks  := nvl(:new.allow_ctrl_breaks,'Y');
    :new.allow_aggregations := nvl(:new.allow_aggregations,'Y');
    :new.allow_computations := nvl(:new.allow_computations,'Y');
    :new.allow_charting     := nvl(:new.allow_charting,'Y');

    if :new.display_text_as is null then
        :new.display_text_as := 'ESCAPE_SC';
    end if;
    if :new.heading_alignment is null then
        :new.heading_alignment := 'CENTER';
    end if;
    if :new.column_alignment is null then
        :new.column_alignment := 'LEFT';
    end if;
    if :new.rpt_show_filter_lov is null then
        :new.rpt_show_filter_lov := 'D';
    end if;
    if :new.rpt_filter_date_ranges is null then
        :new.rpt_filter_date_ranges := 'ALL';
    end if;

    --
    -- security columns
    --
    if :new.others_may_edit is null then
       :new.others_may_edit := 'Y';
    end if;
    if :new.others_may_view is null then
       :new.others_may_view := 'Y';
    end if;

    -- maintain distinct_value_filter
    if :new.display_as = 'TEXTAREA' and :new.rpt_distinct_lov is null then
       :new.rpt_distinct_lov := 'N';
    elsif :new.rpt_distinct_lov is null then
       :new.rpt_distinct_lov := 'Y';
    end if;

    -- use for prototype to get next available col, alter logic later to fill gaps
    if inserting and :new.db_column_name is null then
        :new.db_column_name := wwv_flow_worksheet_standard.get_next_db_column_name(:new.worksheet_id, :new.column_type);
    end if;
    if inserting and :new.display_order is null then
        :new.display_order := wwv_flow_worksheet_standard.get_next_display_order_number(:new.worksheet_id);
    end if;
    if inserting and :new.column_identifier is null then
       :new.column_identifier := wwv_flow_worksheet_standard.get_next_identifier(:new.worksheet_id);
    end if;
    --
    -- sync column headings
    --
    if :new.sync_form_label is null then
       :new.sync_form_label := 'Y';
    end if;
    if :new.sync_form_label = 'Y' then
       :new.column_label := :new.report_label;
    end if;
    --
    -- vpd
    --
    if :new.security_group_id is null then
       :new.security_group_id := wwv_flow.get_sgid;
    end if;
    --
    -- update parent timestamp
    --
    if not wwv_flow.g_import_in_progress and not wwv_flow_worksheet.g_delete_in_progress then
        wwv_flow_audit.g_cascade := true;
        update wwv_flow_worksheets set
           updated_on = :new.updated_on,
           updated_by = :new.updated_by
        where
           id = :new.worksheet_id and
           security_group_id = :new.security_group_id;
        wwv_flow_audit.g_cascade := false;
    end if;
end;
/