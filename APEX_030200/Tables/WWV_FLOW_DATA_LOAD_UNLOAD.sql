CREATE TABLE wwv_flow_data_load_unload (
  "ID" NUMBER NOT NULL,
  platform VARCHAR2(1 BYTE) DEFAULT 'W',
  file_columns VARCHAR2(4000 BYTE),
  data_type VARCHAR2(255 BYTE) CONSTRAINT valid_flow_data_type CHECK (data_type in (
                                  'XML IMPORT',
                                  'XML EXPORT',
                                  'ASCII EXPORT',
                                  'ASCII IMPORT',
                                  'EXCEL IMPORT')),
  data_schema VARCHAR2(255 BYTE),
  data_table VARCHAR2(255 BYTE),
  success_rows NUMBER,
  failed_rows NUMBER,
  data_id NUMBER,
  job_id NUMBER,
  security_group_id NUMBER,
  created_on DATE,
  created_by VARCHAR2(100 BYTE),
  created_by_id NUMBER,
  enclosed_by VARCHAR2(4 BYTE),
  separator VARCHAR2(1 BYTE) DEFAULT ',',
  CONSTRAINT wwv_flow_data_load_unload_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_flow_data_load_unload_fk FOREIGN KEY (security_group_id) REFERENCES wwv_flow_companies (provisioning_company_id) ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";