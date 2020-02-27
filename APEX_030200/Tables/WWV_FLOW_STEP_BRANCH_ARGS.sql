CREATE TABLE wwv_flow_step_branch_args (
  "ID" NUMBER NOT NULL,
  flow_step_branch_id NUMBER,
  branch_arg_sequence NUMBER NOT NULL,
  branch_arg_source_type VARCHAR2(30 BYTE) CONSTRAINT valid_fstepbrancharg_srctype CHECK (branch_arg_source_type in (
         'VALUE_OF_ITEM',
         'STATIC_ASSIGNMENT',
         'FUNCTION_BODY',
         'QUERY',
         'PLSQL_EXPRESSION',
         'SQL_EXPRESSION')),
  branch_arg_source CLOB,
  security_group_id NUMBER NOT NULL,
  last_updated_by VARCHAR2(255 BYTE),
  last_updated_on DATE,
  branch_arg_comment VARCHAR2(4000 BYTE),
  CONSTRAINT wwv_flow_step_branch_args_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_flow_step_branch_args_fk FOREIGN KEY (flow_step_branch_id) REFERENCES wwv_flow_step_branches ("ID") ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX"
LOB (branch_arg_source) STORE AS BASICFILE (
  ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  CACHE READS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MAXEXTENTS 2147483645
  FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT));