CREATE TABLE wwv_flow_worksheet_computation (
  "ID" NUMBER NOT NULL,
  flow_id NUMBER NOT NULL,
  page_id NUMBER,
  worksheet_id NUMBER NOT NULL,
  report_id NUMBER NOT NULL,
  db_column_name VARCHAR2(30 BYTE) NOT NULL,
  column_identifier VARCHAR2(10 BYTE) NOT NULL,
  computation_expr VARCHAR2(4000 BYTE),
  format_mask VARCHAR2(255 BYTE),
  column_type VARCHAR2(255 BYTE) CONSTRAINT wwv_flow_valid_ws_comp_type CHECK (column_type in (
                         'STRING',
                         'DATE',
                         'NUMBER',
                         'CLOB',
                         'OTHER')),
  column_label VARCHAR2(4000 BYTE) NOT NULL,
  report_label VARCHAR2(4000 BYTE) NOT NULL,
  created_on DATE NOT NULL,
  created_by VARCHAR2(255 BYTE) NOT NULL,
  updated_on DATE,
  updated_by VARCHAR2(255 BYTE),
  security_group_id NUMBER NOT NULL,
  CONSTRAINT wwv_flow_ws_comp_cols_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_flow_ws_comp_cols_uk UNIQUE (report_id,db_column_name) USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_flow_ws_comp_cols_uk2 UNIQUE (report_id,column_identifier) USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_flow_ws_comp_cols_fk FOREIGN KEY (report_id) REFERENCES wwv_flow_worksheet_rpts ("ID") ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";