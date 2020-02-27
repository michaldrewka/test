CREATE TABLE wwv_flow_model_pages (
  "ID" NUMBER NOT NULL,
  model_id NUMBER NOT NULL,
  page_id NUMBER,
  parent_page_id NUMBER,
  display_sequence NUMBER,
  page_type VARCHAR2(255 BYTE) CONSTRAINT wwv_flow_mp_page_type CHECK (page_type in (
                                    'BLANK',
                                    'REPORT',
                                    'FORM',
                                    'TABULARFORM',
                                    'REPORTANDFORM',
                                    'PIE_CHART',
                                    'BAR_CHART',
                                    'MASTERDETAIL')),
  page_source VARCHAR2(255 BYTE) CONSTRAINT wwv_flow_mp_page_source CHECK (page_source in (
                                    'TABLE',
                                    'QUERY',
                                    'SPREADSHEET')),
  page_name VARCHAR2(255 BYTE),
  "SOURCE" CLOB,
  security_group_id NUMBER NOT NULL,
  block_id NUMBER,
  report_id NUMBER,
  mig_comments VARCHAR2(4000 BYTE),
  created_by VARCHAR2(255 BYTE) NOT NULL,
  created_on DATE NOT NULL,
  last_updated_by VARCHAR2(255 BYTE),
  last_updated_on DATE,
  CONSTRAINT wwv_flow_model_pages_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_flow_model_pages_fk FOREIGN KEY (model_id) REFERENCES wwv_flow_models ("ID") ON DELETE CASCADE,
  CONSTRAINT wwv_flow_model_pages_fk2 FOREIGN KEY (parent_page_id) REFERENCES wwv_flow_model_pages ("ID") ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX"
LOB ("SOURCE") STORE AS BASICFILE (
  ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  NOCACHE LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MAXEXTENTS 2147483645
  FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT));