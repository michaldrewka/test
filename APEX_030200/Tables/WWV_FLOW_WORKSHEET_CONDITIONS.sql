CREATE TABLE wwv_flow_worksheet_conditions (
  "ID" NUMBER NOT NULL,
  flow_id NUMBER NOT NULL,
  page_id NUMBER,
  worksheet_id NUMBER NOT NULL,
  report_id NUMBER NOT NULL,
  "NAME" VARCHAR2(255 BYTE),
  condition_type VARCHAR2(255 BYTE) CONSTRAINT wwv_flow_ws_c_type_ck CHECK (condition_type in ('FILTER','HIGHLIGHT','SEARCH')),
  allow_delete VARCHAR2(1 BYTE) NOT NULL CONSTRAINT wwv_flow_ws_c_del_ck CHECK (allow_delete in ('Y','N','R')),
  column_name VARCHAR2(4000 BYTE),
  "OPERATOR" VARCHAR2(30 BYTE),
  expr_type VARCHAR2(255 BYTE),
  expr VARCHAR2(4000 BYTE),
  expr2 VARCHAR2(4000 BYTE),
  condition_sql VARCHAR2(4000 BYTE),
  condition_display VARCHAR2(4000 BYTE),
  enabled VARCHAR2(1 BYTE) NOT NULL CONSTRAINT wwv_flow_ws_c_enabled_ck CHECK (enabled in ('Y','N')),
  highlight_sequence NUMBER,
  row_bg_color VARCHAR2(255 BYTE),
  row_font_color VARCHAR2(255 BYTE),
  row_format VARCHAR2(3 BYTE),
  column_bg_color VARCHAR2(255 BYTE),
  column_font_color VARCHAR2(255 BYTE),
  column_format VARCHAR2(3 BYTE),
  created_on DATE NOT NULL,
  created_by VARCHAR2(255 BYTE) NOT NULL,
  updated_on DATE,
  updated_by VARCHAR2(255 BYTE),
  security_group_id NUMBER NOT NULL,
  CONSTRAINT wwv_flow_worksheet_cond_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_flow_worksheet_cond_fk FOREIGN KEY (report_id) REFERENCES wwv_flow_worksheet_rpts ("ID") ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";