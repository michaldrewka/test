CREATE TABLE wwv_flow_sw_detail_results (
  "ID" NUMBER NOT NULL,
  result_id NUMBER NOT NULL,
  file_id NUMBER NOT NULL,
  seq_id NUMBER NOT NULL,
  stmt_num NUMBER NOT NULL,
  stmt_text CLOB DEFAULT empty_clob(),
  result CLOB DEFAULT empty_clob(),
  result_size NUMBER,
  result_rows NUMBER,
  msg VARCHAR2(4000 BYTE),
  "SUCCESS" VARCHAR2(1 BYTE) DEFAULT 'N' CONSTRAINT wwv_run_success_flg CHECK ("SUCCESS" in (
                          'Y',
                          'N')),
  "FAILURE" VARCHAR2(1 BYTE) DEFAULT 'N' CONSTRAINT wwv_run_failure_flag CHECK ("FAILURE" in (
                          'Y',
                          'N')),
  started DATE NOT NULL,
  start_time NUMBER NOT NULL,
  ended DATE,
  end_time NUMBER,
  run_complete VARCHAR2(1 BYTE) DEFAULT 'N' CONSTRAINT wwv_stmt_run_complete_flag CHECK (run_complete in (
                          'Y',
                          'N')),
  last_updated DATE,
  security_group_id NUMBER NOT NULL,
  CONSTRAINT wwv_flow_sw_d_result_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_flow_sw_d_result_fk FOREIGN KEY (result_id) REFERENCES wwv_flow_sw_results ("ID") ON DELETE CASCADE,
  CONSTRAINT wwv_flow_sw_d_result_fk2 FOREIGN KEY (security_group_id) REFERENCES wwv_flow_companies (provisioning_company_id) ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX"
LOB (result) STORE AS BASICFILE (
  ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  NOCACHE LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MAXEXTENTS 2147483645
  FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT))
LOB (stmt_text) STORE AS BASICFILE (
  ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  CACHE READS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MAXEXTENTS 2147483645
  FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT));