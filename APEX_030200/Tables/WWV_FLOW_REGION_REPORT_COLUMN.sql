CREATE TABLE wwv_flow_region_report_column (
  "ID" NUMBER NOT NULL,
  region_id NUMBER NOT NULL,
  flow_id NUMBER,
  query_column_id NUMBER,
  form_element_id NUMBER,
  column_alias VARCHAR2(4000 BYTE) NOT NULL,
  column_display_sequence NUMBER NOT NULL,
  column_heading VARCHAR2(4000 BYTE),
  column_format VARCHAR2(4000 BYTE),
  column_html_expression VARCHAR2(4000 BYTE),
  column_css_class VARCHAR2(4000 BYTE),
  column_css_style VARCHAR2(4000 BYTE),
  column_hit_highlight VARCHAR2(4000 BYTE),
  column_link VARCHAR2(4000 BYTE),
  column_linktext VARCHAR2(4000 BYTE),
  column_link_attr VARCHAR2(4000 BYTE),
  column_link_checksum_type VARCHAR2(255 BYTE) CONSTRAINT wwv_regrepcol_checksum_type CHECK (column_link_checksum_type in (
                                '1', -- workspace
                                '2', -- user
                                '3'  -- session
                                )),
  column_alignment VARCHAR2(4000 BYTE),
  heading_alignment VARCHAR2(4000 BYTE),
  default_sort_column_sequence NUMBER,
  default_sort_dir VARCHAR2(255 BYTE),
  disable_sort_column VARCHAR2(1 BYTE),
  sum_column VARCHAR2(1 BYTE),
  hidden_column VARCHAR2(1 BYTE),
  display_when_cond_type VARCHAR2(255 BYTE),
  display_when_condition VARCHAR2(4000 BYTE),
  display_when_condition2 VARCHAR2(4000 BYTE),
  report_column_required_role VARCHAR2(255 BYTE),
  security_group_id NUMBER NOT NULL,
  last_updated_by VARCHAR2(255 BYTE),
  last_updated_on DATE,
  display_as VARCHAR2(255 BYTE) CONSTRAINT wwv_regrepcol_display_as CHECK ( display_as in (
                               'READONLY',
                               'DISPLAY_AND_SAVE',
                               'WITHOUT_MODIFICATION',
                               'ESCAPE_SC',
                               'TEXT',
                               'TEXT_FROM_LOV',
                               'TEXTAREA',
                               'SELECT_LIST',
                               'SELECT_LIST_FROM_LOV',
                               'SELECT_LIST_FROM_QUERY',
                               'CHECKBOX',
                               'RADIOGROUP',
                               'HIDDEN',
                               'HIDDEN_PROTECTED',
                               'POPUP',
                               'POPUP_QUERY',
                               'DATE_POPUP',
                               'PICK_DATE_USING_APP_FORMAT_MASK',
                               'PICK_DATE_USING_APP_DATE_FORMAT',
                               'PICK_DATE_USING_FORMAT_MASK',
                               'PICK_DATE_DD_MON_RR',
                               'PICK_DATE_DD_MON_RR_HH_MI',
                               'PICK_DATE_DD_MON_RR_HH24_MI',
                               'PICK_DATE_DD_MON_YYYY',
                               'PICK_DATE_DD_MON_YYYY_HH_MI',
                               'PICK_DATE_DD_MON_YYYY_HH24_MI',
                               'PICK_DATE_DD_MM_YYYY',
                               'PICK_DATE_DD_MM_YYYY_HH_MI',
                               'PICK_DATE_DD_MM_YYYY_HH24_MI',
                               'PICK_DATE_MM_DD_YYYY',
                               'PICK_DATE_MM_DD_YYYY_HH_MI',
                               'PICK_DATE_MM_DD_YYYY_HH24_MI',
                               'PICK_DATE_DD_MON_YY',
                               'PICK_DATE_DD_MON_YY_HH_MI',
                               'PICK_DATE_DD_MON_YY_HH24_MI',
                               'PICK_DATE_YYYY_MM_DD',
                               'PICK_DATE_YYYY_MM_DD_HH_MI',
                               'PICK_DATE_YYYY_MM_DD_HH24_MI',
                               'PICK_DATE_RR_MON_DD',
                               'PICK_DATE_RR_MON_DD_HH_MI',
                               'PICK_DATE_RR_MON_DD_HH24_MI',
                               'PICK_DATE_DD_MM_YYYY_DASH',
                               'PICK_DATE_DD_MM_YYYY_HH_MI_DASH',
                               'PICK_DATE_DD_MM_YYYY_HH24_MI_DASH',
                               'PICK_DATE_DD_MM_YYYY_DOT',
                               'PICK_DATE_DD_MM_YYYY_HH_MI_DOT',
                               'PICK_DATE_DD_MM_YYYY_HH24_MI_DOT',
                               'PICK_DATE_YYYY_DD_MM_DOT',
                               'PICK_DATE_YYYY_DD_MM_HH_MI_DOT',
                               'PICK_DATE_YYYY_DD_MM_HH24_MI_DOT',
                               'PICK_DATE_YYYY_MM_DD_SLASH',
                               'PICK_DATE_YYYY_MM_DD_HH_MI_SLASH',
                               'PICK_DATE_YYYY_MM_DD_HH24_MI_SLASH'
                               )),
  named_lov NUMBER,
  inline_lov VARCHAR2(4000 BYTE),
  lov_show_nulls VARCHAR2(3 BYTE) CONSTRAINT wwv_flow_regrepcol_lovn CHECK (lov_show_nulls in (
                               'YES',
                               'NO')),
  lov_null_text VARCHAR2(255 BYTE),
  lov_null_value VARCHAR2(255 BYTE),
  column_width NUMBER,
  column_height NUMBER,
  cattributes VARCHAR2(4000 BYTE),
  cattributes_element VARCHAR2(4000 BYTE),
  column_comment VARCHAR2(4000 BYTE),
  pk_col_source_type VARCHAR2(1 BYTE) CONSTRAINT wwv_flow_regrepcol_src_type CHECK (pk_col_source_type in (
                                   'S',
                                   'F',
                                   'T')),
  pk_col_source CLOB,
  derived_column VARCHAR2(1 BYTE) CONSTRAINT wwv_flow_regrepcol_derv_col CHECK (derived_column in (
                                   'Y',
                                   'N')),
  column_default VARCHAR2(4000 BYTE),
  column_default_type VARCHAR2(255 BYTE),
  lov_display_extra VARCHAR2(30 BYTE),
  include_in_export VARCHAR2(1 BYTE) CONSTRAINT wwv_flow_regrepcol_incl_exp CHECK (include_in_export in (
                                   'Y',
                                   'N')),
  print_col_width VARCHAR2(4000 BYTE),
  print_col_align VARCHAR2(4000 BYTE),
  ref_schema VARCHAR2(255 BYTE),
  ref_table_name VARCHAR2(255 BYTE),
  ref_column_name VARCHAR2(255 BYTE),
  CONSTRAINT report_column_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT report_column_to_region_fk FOREIGN KEY (region_id) REFERENCES wwv_flow_page_plugs ("ID") ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX"
LOB (pk_col_source) STORE AS BASICFILE (
  ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  CACHE READS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT));