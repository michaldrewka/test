CREATE TABLE wwv_flow_worksheet_privs (
  "ID" NUMBER NOT NULL,
  worksheet_id NUMBER NOT NULL,
  application_user VARCHAR2(255 BYTE),
  view_priv VARCHAR2(1 BYTE) CONSTRAINT wwv_flow_worksheet_priv_q_ck CHECK (view_priv  in ('Y','N')),
  edit_priv VARCHAR2(1 BYTE) CONSTRAINT wwv_flow_worksheet_priv_e_ck CHECK (edit_priv  in ('Y','N')),
  develop_priv VARCHAR2(1 BYTE) CONSTRAINT wwv_flow_worksheet_priv_d_ck CHECK (develop_priv  in ('Y','N')),
  row_filter_1_db_col VARCHAR2(255 BYTE),
  row_filter_1_expr VARCHAR2(30 BYTE),
  row_filter_1_value VARCHAR2(4000 BYTE),
  row_filter_2_db_col VARCHAR2(255 BYTE),
  row_filter_2_expr VARCHAR2(30 BYTE),
  row_filter_2_value VARCHAR2(4000 BYTE),
  created_on DATE NOT NULL,
  created_by VARCHAR2(255 BYTE) NOT NULL,
  updated_on DATE,
  updated_by VARCHAR2(255 BYTE),
  security_group_id NUMBER NOT NULL,
  CONSTRAINT wwv_flow_worksheet_priv_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_flow_worksheet_priv_fk FOREIGN KEY (worksheet_id) REFERENCES wwv_flow_worksheets ("ID") ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";