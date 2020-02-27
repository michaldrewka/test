CREATE TABLE wwv_flow_sw_results (
  "ID" NUMBER NOT NULL,
  file_id NUMBER NOT NULL,
  job_id NUMBER,
  run_by VARCHAR2(255 BYTE) NOT NULL,
  run_as VARCHAR2(255 BYTE) NOT NULL,
  started DATE NOT NULL,
  start_time NUMBER NOT NULL,
  ended DATE,
  end_time NUMBER,
  status VARCHAR2(255 BYTE) CONSTRAINT wwv_flow_result_status CHECK (status in (
                          'SUBMITTED',
                          'EXECUTING',
                          'COMPLETE',
                          'CANCELED',
                          'CANCELING')),
  run_comments VARCHAR2(4000 BYTE),
  security_group_id NUMBER NOT NULL,
  CONSTRAINT wwv_flow_sw_result_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_flow_sw_result_fk2 FOREIGN KEY (security_group_id) REFERENCES wwv_flow_companies (provisioning_company_id) ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";