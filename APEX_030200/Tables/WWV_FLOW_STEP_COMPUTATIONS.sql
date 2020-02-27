CREATE TABLE wwv_flow_step_computations (
  "ID" NUMBER NOT NULL,
  flow_id NUMBER NOT NULL,
  flow_step_id NUMBER,
  computation_sequence NUMBER,
  computation_item VARCHAR2(255 BYTE) NOT NULL,
  computation_point VARCHAR2(255 BYTE) CONSTRAINT valid_fstepcomp_point CHECK (computation_point in (
                          'ON_NEW_INSTANCE',
                          'BEFORE_HEADER',
                          'AFTER_HEADER',
                          'BEFORE_BOX_BODY',
                          'AFTER_BOX_BODY',
                          'BEFORE_FOOTER',
                          'AFTER_FOOTER',
                          'AFTER_SUBMIT')),
  computation_item_type VARCHAR2(30 BYTE) CONSTRAINT valid_fstepcomp_itemtype CHECK (computation_item_type in (
                          'VARCHAR',
                          'VC_ARR',
                          'NUMBER')),
  computation_type VARCHAR2(30 BYTE) CONSTRAINT valid_fstepcomp_comptype CHECK (computation_type in (
                          'STATIC_ASSIGNMENT',
                          'FUNCTION_BODY',
                          'QUERY',
                          'PLSQL_EXPRESSION',
                          'SQL_EXPRESSION',
                          'SQL_EXPRESION',
                          'ITEM_VALUE')),
  computation_processed VARCHAR2(30 BYTE) CONSTRAINT valid_fstepcomp_compproc CHECK (computation_processed in (
                          'ON_NEW_INSTANCE',
                          'REPLACE_EXISTING',
                          'ADD_TO_EXISTING',
                          'RAISE_ERROR_ON_REPLACE',
                          'REPLACE_NULL_VALUES')),
  computation VARCHAR2(4000 BYTE),
  compute_when VARCHAR2(4000 BYTE),
  compute_when_type VARCHAR2(255 BYTE),
  compute_when_text VARCHAR2(4000 BYTE),
  computation_error_message VARCHAR2(4000 BYTE),
  required_patch NUMBER,
  security_scheme VARCHAR2(255 BYTE),
  security_group_id NUMBER NOT NULL,
  last_updated_by VARCHAR2(255 BYTE),
  last_updated_on DATE,
  computation_comment VARCHAR2(4000 BYTE),
  CONSTRAINT wwv_flow_step_comp_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_flow_step_comp_fk FOREIGN KEY (flow_id) REFERENCES wwv_flows ("ID") ON DELETE CASCADE,
  CONSTRAINT wwv_flow_step_comp_fk2 FOREIGN KEY (flow_id,flow_step_id) REFERENCES wwv_flow_steps (flow_id,"ID") ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";