CREATE TABLE wwv_flow_step_processing (
  "ID" NUMBER NOT NULL,
  flow_id NUMBER NOT NULL,
  flow_step_id NUMBER,
  process_sequence NUMBER,
  process_point VARCHAR2(255 BYTE) CONSTRAINT valid_fsproc_point CHECK (process_point in (
                           'AFTER_AUTHENTICATION',
                           'ON_SUBMIT_BEFORE_COMPUTATION',
                           'BEFORE_HEADER',
                           'AFTER_HEADER',
                           'BEFORE_BOX_BODY',
                           'BEFORE_SHOW_ITEMS',
                           'AFTER_SHOW_ITEMS',
                           'AFTER_BOX_BODY',
                           'BEFORE_FOOTER',
                           'AFTER_FOOTER',
                           'AFTER_SUBMIT',
                           'AFTER_SUBMIT_BEFORE_VALIDATION',
                           'AFTER_ERROR_HEADER',
                           'BEFORE_ERROR_FOOTER')),
  process_type VARCHAR2(255 BYTE) CONSTRAINT wwv_valid_fsproc_type CHECK (process_type in (
                           'CLEAR_CACHE_CURRENT_FLOW',
                           'CLEAR_CACHE_FOR_FLOWS',
                           'SET_ITEM_USING_STATIC_ASSIGNMENT',
                           'SET_ITEM_USING_PLSQL_FUNCTION_BODY',
                           'SET_ITEM_USING_PLSQL_EXPRESSION',
                           'SET_ITEM_USING_SQL_QUERY',
                           'SET_ITEM_USING_SQL_EXPRESSION',
                           'WEB_SERVICE',
                           'ON_DEMAND',
                           'PLSQL',
                           'PLSQL_DBMS_JOB',
                           'RESET_PAGINATION',
                           'RESET_SESSION_STATE',
                           'CLEAR_CACHE_FOR_PAGES',
                           'CLEAR_CACHE_FOR_ITEMS',
                           'SET_PREFERENCE_TO_ITEM_VALUE',
                           'SET_PREFERENCE_TO_ITEM_VALUE_IF_ITEM_NOT_NULL',
                           'MULTI_ROW_UPDATE',
                           'MULTI_ROW_DELETE',
                           'ADD_ROWS_TO_TABULAR_FORM',
                           'RESET_PAGINATION_FOR_REGION',
                           'RESET_SORTING_FOR_REGION',
                           'DML_FETCH_ROW',
                           'DML_PROCESS_ROW',
                           'DML_PROCESS_INSERT_ROW',
                           'DML_PROCESS_UPDATE_ROW',
                           'DML_PROCESS_DELETE_ROW',
                           'RESET_USER_PREFERENCES',
                           'INITIALIZE_ALL_PAGE_ITEMS',
                           'INITIALIZE_SESSION',
                           'INITIALIZE_PAGE_PAGINATION',
                           'INITIALIZE_PAGINATION_FOR_ALL_PAGES',
                           'GET_NEXT_OR_PREV_PK',
                           'CLOSE_WINDOW'
                           )),
  process_name VARCHAR2(255 BYTE) NOT NULL,
  item_name VARCHAR2(255 BYTE),
  process_sql_clob CLOB,
  process_error_message VARCHAR2(4000 BYTE),
  process_when_button_id NUMBER,
  process_when VARCHAR2(4000 BYTE),
  process_when_type VARCHAR2(255 BYTE),
  process_when2 VARCHAR2(4000 BYTE),
  process_when_type2 VARCHAR2(255 BYTE) CONSTRAINT valid_fsproc_whentype2 CHECK (process_when_type2 in (
                           'CURRENT_PAGE_NOT_IN_CONDITION',
                           'CURRENT_PAGE_IN_CONDITION',
                           'NEVER',
                           'CONDITION_IN_REQUEST',
                           'CONDITION_NOT_IN_REQUEST',
                           'REQUEST_EQUALS_CONDITION',
                           'REQUEST_IN_CONDITION',
                           'REQUEST_NOT_IN_CONDITION',
                           'ITEM_IS_NULL',
                           'ITEM_IS_NOT_NULL',
                           'ITEM_IS_NOT_NULL_OR_ZERO')),
  process_is_stateful_y_n VARCHAR2(1 BYTE) CONSTRAINT valid_fsproc_stateful CHECK (process_is_stateful_y_n in ('Y','N')),
  runtime_where_clause VARCHAR2(4000 BYTE),
  return_key_into_item1 VARCHAR2(255 BYTE),
  return_key_into_item2 VARCHAR2(255 BYTE),
  process_success_message VARCHAR2(4000 BYTE),
  required_patch NUMBER,
  security_scheme VARCHAR2(255 BYTE),
  security_group_id NUMBER NOT NULL,
  last_updated_by VARCHAR2(255 BYTE),
  last_updated_on DATE,
  process_comment VARCHAR2(4000 BYTE),
  CONSTRAINT wwv_flow_step_proc_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_flow_step_proc_fk FOREIGN KEY (flow_id) REFERENCES wwv_flows ("ID") ON DELETE CASCADE,
  CONSTRAINT wwv_flow_step_proc_fk2 FOREIGN KEY (flow_id,flow_step_id) REFERENCES wwv_flow_steps (flow_id,"ID") ON DELETE CASCADE
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