CREATE TABLE wwv_flow_processing (
  "ID" NUMBER NOT NULL,
  flow_id NUMBER NOT NULL,
  process_sequence NUMBER,
  process_point VARCHAR2(255 BYTE) CONSTRAINT valid_fproc_procpoint CHECK (process_point in (
                      'ON_DEMAND',
                      'ON_SUBMIT_BEFORE_COMPUTATION',
                      'AFTER_AUTHENTICATION',
                      'BEFORE_HEADER',
                      'AFTER_HEADER',
                      'AFTER_ERROR_HEADER',
                      'BEFORE_ERROR_FOOTER',
                      'BEFORE_BOX_BODY',
                      'BEFORE_SHOW_ITEMS',
                      'AFTER_SHOW_ITEMS',
                      'AFTER_BOX_BODY',
                      'BEFORE_FOOTER',
                      'AFTER_FOOTER',
                      'AFTER_SUBMIT_BEFORE_VALIDATION',
                      'AFTER_SUBMIT')),
  process_type VARCHAR2(255 BYTE) CONSTRAINT wwv_valid_proc_type CHECK (process_type in (
                           'SET_ITEM_USING_STATIC_ASSIGNMENT',
                           'SET_ITEM_USING_PLSQL_FUNCTION_BODY',
                           'SET_ITEM_USING_PLSQL_EXPRESSION',
                           'SET_ITEM_USING_SQL_EXPRESSION',
                           'SET_ITEM_USING_SQL_QUERY',
                           'PLSQL',
                           'INITIALIZE_ALL_PAGE_ITEMS'
                           )),
  process_name VARCHAR2(255 BYTE) NOT NULL,
  process_sql_clob CLOB,
  process_error_message VARCHAR2(4000 BYTE),
  process_when VARCHAR2(4000 BYTE),
  process_when_type VARCHAR2(255 BYTE),
  process_when2 VARCHAR2(4000 BYTE),
  process_when_type2 VARCHAR2(255 BYTE),
  item_name VARCHAR2(255 BYTE),
  required_patch NUMBER,
  security_scheme VARCHAR2(255 BYTE),
  runtime_where_clause VARCHAR2(4000 BYTE),
  security_group_id NUMBER NOT NULL,
  last_updated_by VARCHAR2(255 BYTE),
  last_updated_on DATE,
  process_comment VARCHAR2(4000 BYTE),
  CONSTRAINT wwv_flow_processing_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_flow_processing_fk FOREIGN KEY (flow_id) REFERENCES wwv_flows ("ID") ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX"
LOB (process_sql_clob) STORE AS BASICFILE (
  ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  CACHE READS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT));