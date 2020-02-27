CREATE TABLE wwv_flow_row_templates (
  "ID" NUMBER NOT NULL,
  flow_id NUMBER NOT NULL,
  row_template_name VARCHAR2(255 BYTE) NOT NULL,
  row_template_type VARCHAR2(30 BYTE) CONSTRAINT wwv_flow_row_template_ty CHECK (row_template_type in (
                                  'GENERIC_COLUMNS',
                                  'NAMED_COLUMNS')),
  before_column_heading VARCHAR2(4000 BYTE),
  column_heading_template VARCHAR2(4000 BYTE),
  after_column_heading VARCHAR2(4000 BYTE),
  row_template1 CLOB,
  row_template_condition1 VARCHAR2(4000 BYTE),
  row_template_display_cond1 VARCHAR2(30 BYTE),
  row_template2 CLOB,
  row_template_condition2 VARCHAR2(4000 BYTE),
  row_template_display_cond2 VARCHAR2(30 BYTE),
  row_template3 CLOB,
  row_template_condition3 VARCHAR2(4000 BYTE),
  row_template_display_cond3 VARCHAR2(30 BYTE),
  row_template4 CLOB,
  row_template_condition4 VARCHAR2(4000 BYTE),
  row_template_display_cond4 VARCHAR2(30 BYTE),
  row_template_before_rows VARCHAR2(4000 BYTE),
  row_template_after_rows VARCHAR2(4000 BYTE),
  row_template_before_first VARCHAR2(4000 BYTE),
  row_template_after_last VARCHAR2(4000 BYTE),
  row_template_table_attributes VARCHAR2(4000 BYTE),
  pagination_template VARCHAR2(4000 BYTE),
  next_page_template VARCHAR2(4000 BYTE),
  previous_page_template VARCHAR2(4000 BYTE),
  next_set_template VARCHAR2(4000 BYTE),
  previous_set_template VARCHAR2(4000 BYTE),
  row_style_mouse_over VARCHAR2(255 BYTE),
  row_style_mouse_out VARCHAR2(255 BYTE),
  row_style_checked VARCHAR2(255 BYTE),
  row_style_unchecked VARCHAR2(255 BYTE),
  reference_id NUMBER,
  security_group_id NUMBER NOT NULL,
  last_updated_by VARCHAR2(255 BYTE),
  last_updated_on DATE,
  theme_id NUMBER,
  theme_class_id NUMBER,
  translate_this_template VARCHAR2(1 BYTE) CONSTRAINT wwv_flow_report_trans_temp CHECK (translate_this_template in ('Y','N')),
  row_template_comment VARCHAR2(4000 BYTE),
  CONSTRAINT wwv_flow_row_template_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_flow_row_template_fk FOREIGN KEY (flow_id) REFERENCES wwv_flows ("ID") ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX"
LOB (row_template1) STORE AS BASICFILE (
  ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  CACHE READS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT))
LOB (row_template2) STORE AS BASICFILE (
  ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  CACHE READS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT))
LOB (row_template3) STORE AS BASICFILE (
  ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  CACHE READS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT))
LOB (row_template4) STORE AS BASICFILE (
  ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  CACHE READS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT));