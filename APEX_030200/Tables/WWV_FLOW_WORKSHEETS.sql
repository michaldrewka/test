CREATE TABLE wwv_flow_worksheets (
  "ID" NUMBER NOT NULL,
  flow_id NUMBER NOT NULL,
  page_id NUMBER,
  region_id NUMBER,
  "NAME" VARCHAR2(255 BYTE) NOT NULL,
  folder_id NUMBER,
  "ALIAS" VARCHAR2(255 BYTE),
  report_id_item VARCHAR2(255 BYTE),
  max_row_count VARCHAR2(255 BYTE),
  max_row_count_message VARCHAR2(4000 BYTE),
  no_data_found_message VARCHAR2(4000 BYTE),
  max_rows_per_page VARCHAR2(4000 BYTE),
  search_button_label VARCHAR2(4000 BYTE),
  page_items_to_submit VARCHAR2(4000 BYTE),
  sort_asc_image VARCHAR2(4000 BYTE),
  sort_asc_image_attr VARCHAR2(4000 BYTE),
  sort_desc_image VARCHAR2(4000 BYTE),
  sort_desc_image_attr VARCHAR2(4000 BYTE),
  sql_query CLOB,
  base_table_or_view VARCHAR2(4000 BYTE),
  base_pk1 VARCHAR2(30 BYTE),
  base_pk2 VARCHAR2(30 BYTE),
  base_pk3 VARCHAR2(30 BYTE),
  sql_hint VARCHAR2(4000 BYTE),
  status VARCHAR2(30 BYTE) CONSTRAINT wwv_flow_ws_status_ck CHECK (status in (
                              'AVAILABLE_FOR_OWNER',
                              'NOT_AVAILABLE',
                              'AVAILABLE',
                              'ACL')),
  allow_report_saving VARCHAR2(1 BYTE) CONSTRAINT wwv_flow_ws_allow_save_ck CHECK (allow_report_saving in (
                              'Y',
                              'N')),
  allow_report_categories VARCHAR2(1 BYTE) CONSTRAINT wwv_flow_ws_allow_cat_ck CHECK (allow_report_categories in (
                              'Y',
                              'N')),
  show_nulls_as VARCHAR2(255 BYTE),
  pagination_type VARCHAR2(255 BYTE) CONSTRAINT wwv_flow_ws_pag_type CHECK (pagination_type in (
                              'ROWS_X_TO_Y_OF_Z',
                              'ROWS_X_TO_Y'
                              )),
  pagination_display_position VARCHAR2(255 BYTE),
  button_template NUMBER,
  show_finder_drop_down VARCHAR2(1 BYTE) NOT NULL CONSTRAINT wwv_flow_show_fnd_drop_ck CHECK (show_finder_drop_down in (
                              'Y',
                              'N')),
  show_display_row_count VARCHAR2(1 BYTE) NOT NULL CONSTRAINT wwv_flow_show_row_cnt_ck CHECK (show_display_row_count in (
                              'Y',
                              'N')),
  show_search_bar VARCHAR2(1 BYTE) NOT NULL CONSTRAINT wwv_flow_show_search_bar_ck CHECK (show_search_bar in (
                              'Y',
                              'N')),
  show_search_textbox VARCHAR2(1 BYTE) NOT NULL CONSTRAINT wwv_flow_show_search_box_ck CHECK (show_search_textbox in (
                              'Y',
                              'N')),
  show_actions_menu VARCHAR2(1 BYTE) NOT NULL CONSTRAINT wwv_flow_show_actions_ck CHECK (show_actions_menu in (
                              'Y',
                              'N')),
  actions_menu_icon VARCHAR2(4000 BYTE),
  finder_icon VARCHAR2(4000 BYTE),
  report_list_mode VARCHAR2(255 BYTE) NOT NULL CONSTRAINT wwv_flow_list_reps_ck CHECK (report_list_mode in (
                              'TABS',
                              'NONE')),
  show_select_columns VARCHAR2(1 BYTE) NOT NULL CONSTRAINT wwv_flow_ws_show_col_ck CHECK (show_select_columns in (
                              'Y',
                              'N')),
  show_filter VARCHAR2(1 BYTE) NOT NULL CONSTRAINT wwv_flow_ws_show_filter_ck CHECK (show_filter in (
                              'Y',
                              'N')),
  show_sort VARCHAR2(1 BYTE) NOT NULL CONSTRAINT wwv_flow_ws_show_sort_ck CHECK (show_sort in (
                              'Y',
                              'N')),
  show_control_break VARCHAR2(1 BYTE) NOT NULL CONSTRAINT wwv_flow_ws_show_break_ck CHECK (show_control_break in (
                              'Y',
                              'N')),
  show_highlight VARCHAR2(1 BYTE) NOT NULL CONSTRAINT wwv_flow_ws_show_hl_ck CHECK (show_highlight in (
                              'Y',
                              'N')),
  show_computation VARCHAR2(1 BYTE) NOT NULL CONSTRAINT wwv_flow_ws_show_comp_ck CHECK (show_computation in (
                              'Y',
                              'N')),
  show_aggregate VARCHAR2(1 BYTE) NOT NULL CONSTRAINT wwv_flow_ws_show_agg_ck CHECK (show_aggregate in (
                              'Y',
                              'N')),
  show_chart VARCHAR2(1 BYTE) NOT NULL CONSTRAINT wwv_flow_ws_show_chart_ck CHECK (show_chart in (
                              'Y',
                              'N')),
  show_calendar VARCHAR2(1 BYTE) NOT NULL CONSTRAINT wwv_flow_ws_show_cal_ck CHECK (show_calendar in (
                              'Y',
                              'N')),
  show_flashback VARCHAR2(1 BYTE) NOT NULL CONSTRAINT wwv_flow_ws_show_fb_ck CHECK (show_flashback in (
                              'Y',
                              'N')),
  show_reset VARCHAR2(1 BYTE) NOT NULL CONSTRAINT wwv_flow_ws_show_reset_ck CHECK (show_reset in (
                              'Y',
                              'N')),
  show_download VARCHAR2(1 BYTE) NOT NULL CONSTRAINT wwv_flow_ws_show_dl_ck CHECK (show_download in (
                              'Y',
                              'N')),
  show_help VARCHAR2(1 BYTE) NOT NULL CONSTRAINT wwv_flow_ws_show_help_ck CHECK (show_help in (
                              'Y',
                              'N')),
  show_detail_link VARCHAR2(1 BYTE) NOT NULL CONSTRAINT wwv_flow_ws_detail_link_ck CHECK (show_detail_link in (
                              'Y',
                              'N',
                              'C')),
  download_formats VARCHAR2(30 BYTE),
  download_filename VARCHAR2(255 BYTE),
  csv_output_separator VARCHAR2(1 BYTE),
  csv_output_enclosed_by VARCHAR2(1 BYTE),
  detail_link VARCHAR2(4000 BYTE),
  detail_link_text VARCHAR2(4000 BYTE),
  detail_link_attr VARCHAR2(4000 BYTE),
  detail_link_checksum_type VARCHAR2(255 BYTE) CONSTRAINT wwv_ir_link_checksum_type CHECK (detail_link_checksum_type in (
                                '1', -- workspace
                                '2', -- user
                                '3'  -- session
                                )),
  detail_link_condition_type VARCHAR2(255 BYTE),
  detail_link_cond VARCHAR2(4000 BYTE),
  detail_link_cond2 VARCHAR2(4000 BYTE),
  detail_link_auth_scheme VARCHAR2(4000 BYTE),
  allow_exclude_null_values VARCHAR2(1 BYTE) NOT NULL CONSTRAINT wwv_flow_ws_exclude_null_ck CHECK (allow_exclude_null_values in (
                              'Y',
                              'N')),
  allow_hide_extra_columns VARCHAR2(1 BYTE) NOT NULL CONSTRAINT wwv_flow_ws_hide_extra_ck CHECK (allow_hide_extra_columns in (
                              'Y',
                              'N')),
  max_query_cost VARCHAR2(4000 BYTE),
  max_flashback VARCHAR2(4000 BYTE),
  worksheet_flags VARCHAR2(4000 BYTE),
  description VARCHAR2(4000 BYTE),
  "OWNER" VARCHAR2(255 BYTE),
  created_on DATE NOT NULL,
  created_by VARCHAR2(255 BYTE) NOT NULL,
  updated_on DATE,
  updated_by VARCHAR2(255 BYTE),
  security_group_id NUMBER NOT NULL,
  CONSTRAINT wwv_flow_worksheets_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_flow_worksheets_flow_fk FOREIGN KEY (flow_id) REFERENCES wwv_flows ("ID") ON DELETE CASCADE,
  CONSTRAINT wwv_flow_worksheets_reg_fk FOREIGN KEY (region_id) REFERENCES wwv_flow_page_plugs ("ID") ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX"
LOB (sql_query) STORE AS BASICFILE (
  ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  NOCACHE LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT));