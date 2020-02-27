CREATE TABLE wwv_flow_worksheet_columns (
  "ID" NUMBER NOT NULL,
  flow_id NUMBER NOT NULL,
  page_id NUMBER,
  worksheet_id NUMBER NOT NULL,
  db_column_name VARCHAR2(30 BYTE) NOT NULL,
  display_order NUMBER NOT NULL,
  "GROUP_ID" NUMBER,
  column_identifier VARCHAR2(10 BYTE) NOT NULL,
  column_expr VARCHAR2(4000 BYTE),
  column_label VARCHAR2(4000 BYTE) NOT NULL,
  report_label VARCHAR2(4000 BYTE) NOT NULL,
  sync_form_label VARCHAR2(1 BYTE) CONSTRAINT wwv_flow_val_wscol_sync_lab CHECK (sync_form_label in ('Y','N')),
  display_in_default_rpt VARCHAR2(1 BYTE) CONSTRAINT wwv_flow_ws_display_col CHECK (display_in_default_rpt in ('Y','N')),
  column_html_expression VARCHAR2(4000 BYTE),
  column_link VARCHAR2(4000 BYTE),
  column_linktext VARCHAR2(4000 BYTE),
  column_link_attr VARCHAR2(4000 BYTE),
  column_link_checksum_type VARCHAR2(255 BYTE) CONSTRAINT wwv_flow_ws_checksum_type CHECK (column_link_checksum_type in (
                              '1', -- workspace
                              '2', -- user
                              '3'  -- session
                              )),
  is_sortable VARCHAR2(1 BYTE) CONSTRAINT wwv_flow_ws_col_sort_ck CHECK (is_sortable in ('Y','N')),
  allow_sorting VARCHAR2(1 BYTE) NOT NULL CONSTRAINT wwv_flow_ws_col_sorting_ck CHECK (allow_sorting in ('Y','N')),
  allow_filtering VARCHAR2(1 BYTE) NOT NULL CONSTRAINT wwv_flow_ws_col_filter_ck CHECK (allow_filtering in ('Y','N')),
  allow_ctrl_breaks VARCHAR2(1 BYTE) NOT NULL CONSTRAINT wwv_flow_ws_col_ctrl_ck CHECK (allow_ctrl_breaks in ('Y','N')),
  allow_aggregations VARCHAR2(1 BYTE) NOT NULL CONSTRAINT wwv_flow_ws_col_agg_ck CHECK (allow_aggregations in ('Y','N')),
  allow_computations VARCHAR2(1 BYTE) NOT NULL CONSTRAINT wwv_flow_ws_col_comp_ck CHECK (allow_computations in ('Y','N')),
  allow_charting VARCHAR2(1 BYTE) NOT NULL CONSTRAINT wwv_flow_ws_col_chart_ck CHECK (allow_charting in ('Y','N')),
  use_custom VARCHAR2(1 BYTE),
  custom_filter VARCHAR2(4000 BYTE),
  base_column VARCHAR2(30 BYTE),
  allow_filters VARCHAR2(1 BYTE),
  others_may_edit VARCHAR2(1 BYTE),
  others_may_view VARCHAR2(1 BYTE),
  column_type VARCHAR2(255 BYTE) NOT NULL CONSTRAINT wwv_flow_valid_ws_col_type CHECK (column_type in (
                      	'STRING',
                      	'DATE',
                      	'NUMBER',
                      	'CLOB',
                      	'FILE',
                      	'COMPUTED',
                      	'DETAIL_LINK',
                      	'OTHER')),
  display_as VARCHAR2(255 BYTE) NOT NULL CONSTRAINT wwv_flow_ws_col_disp_as_ck CHECK (display_as in (
                        'READONLY',
                        'TEXT',
                        'TEXTAREA',
                        'SELECTLIST',
                        'CHECKBOX',
                        'RADIOGROUP',
                        'POPUP_LOV',
                        'DATE_PICKER')),
  display_text_as VARCHAR2(255 BYTE) NOT NULL CONSTRAINT wwv_flow_ws_col_disp_txt_as_ck CHECK (display_text_as in (
                        'WITHOUT_MODIFICATION',
                        'ESCAPE_SC',
                        'HIDDEN')),
  heading_alignment VARCHAR2(255 BYTE) NOT NULL CONSTRAINT wwv_flow_ws_col_head_al_ck CHECK (heading_alignment in (
                        'LEFT',
                        'RIGHT',
                        'CENTER')),
  column_alignment VARCHAR2(255 BYTE) NOT NULL CONSTRAINT wwv_flow_ws_col_col_al_ck CHECK (column_alignment in (
                        'LEFT',
                        'RIGHT',
                        'CENTER')),
  max_length NUMBER,
  display_width NUMBER(*,0),
  display_height NUMBER(*,0),
  allow_null VARCHAR2(1 BYTE) CONSTRAINT wwv_flow_wscol_allow_null CHECK (allow_null in ('Y','N')),
  format_mask VARCHAR2(255 BYTE),
  fact_table_key VARCHAR2(255 BYTE),
  dimension_table VARCHAR2(255 BYTE),
  dimension_table_id VARCHAR2(255 BYTE),
  dimension_table_value VARCHAR2(255 BYTE),
  rpt_distinct_lov VARCHAR2(1 BYTE) CONSTRAINT wwv_flow_wscol_lov CHECK (rpt_distinct_lov in ('Y','N')),
  rpt_lov VARCHAR2(4000 BYTE),
  rpt_named_lov NUMBER,
  rpt_show_filter_lov VARCHAR2(1 BYTE) CONSTRAINT wwv_flow_wscol_showfil_lov_ck CHECK (rpt_show_filter_lov in ('D','S','N')),
  rpt_filter_date_ranges VARCHAR2(255 BYTE) CONSTRAINT wwv_flow_wscol_fil_dtrng_ck CHECK (rpt_filter_date_ranges in ('ALL','PAST','FUTURE')),
  static_lov VARCHAR2(4000 BYTE),
  lov_null_text VARCHAR2(255 BYTE),
  lov_allow_new_values VARCHAR2(1 BYTE) CONSTRAINT wwv_flow_ws_lov_allow_new CHECK (lov_allow_new_values in ('Y','N')),
  lov_is_distinct_values VARCHAR2(1 BYTE) CONSTRAINT wwv_flow_ws_lov_distinct_vals CHECK (lov_is_distinct_values in ('Y','N')),
  lov_num_columns NUMBER,
  lov_id NUMBER,
  computation_type VARCHAR2(255 BYTE),
  computation_expr_1 VARCHAR2(4000 BYTE),
  computation_expr_2 VARCHAR2(4000 BYTE),
  validation_type VARCHAR2(255 BYTE),
  validation_expr_1 VARCHAR2(4000 BYTE),
  validation_expr_2 VARCHAR2(4000 BYTE),
  display_condition_type VARCHAR2(255 BYTE),
  display_condition VARCHAR2(4000 BYTE),
  display_condition2 VARCHAR2(4000 BYTE),
  default_value VARCHAR2(4000 BYTE),
  default_when VARCHAR2(30 BYTE),
  help_text VARCHAR2(4000 BYTE),
  security_scheme VARCHAR2(255 BYTE),
  column_flags VARCHAR2(4000 BYTE),
  column_comment VARCHAR2(4000 BYTE),
  created_on DATE NOT NULL,
  created_by VARCHAR2(255 BYTE) NOT NULL,
  updated_on DATE,
  updated_by VARCHAR2(255 BYTE),
  security_group_id NUMBER NOT NULL,
  CONSTRAINT wwv_flow_worksheet_columns_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_flow_worksheet_columns_uk2 UNIQUE (worksheet_id,db_column_name) USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_flow_worksheet_columns_fk FOREIGN KEY (worksheet_id) REFERENCES wwv_flow_worksheets ("ID") ON DELETE CASCADE,
  CONSTRAINT wwv_flow_worksheet_col_fk FOREIGN KEY (flow_id) REFERENCES wwv_flows ("ID") ON DELETE CASCADE,
  CONSTRAINT wwv_flow_worksheet_col_grps_fk FOREIGN KEY ("GROUP_ID") REFERENCES wwv_flow_worksheet_col_groups ("ID") ON DELETE SET NULL
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";