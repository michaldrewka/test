CREATE TABLE wwv_flow_step_validations (
  "ID" NUMBER NOT NULL,
  flow_id NUMBER NOT NULL,
  flow_step_id NUMBER,
  validation_name VARCHAR2(255 BYTE) NOT NULL,
  validation_sequence NUMBER,
  "VALIDATION" VARCHAR2(4000 BYTE),
  validation2 VARCHAR2(4000 BYTE),
  validation_type VARCHAR2(255 BYTE) CONSTRAINT wwv_valid_fsval_valtype CHECK (validation_type in (
                              'ITEM_NOT_NULL',
                              'ITEM_NOT_NULL_OR_ZERO',
                              'ITEM_NOT_ZERO',
                              'ITEM_IS_ALPHANUMERIC',
                              'ITEM_IS_NUMERIC',
                              'ITEM_IS_NOT_NUMERIC',
                              'ITEM_IS_DATE',
                              'ITEM_CONTAINS_NO_SPACES',
                              'SQL_EXPRESION',
                              'SQL_EXPRESSION',
                              'PLSQL_EXPRESION',
                              'PLSQL_EXPRESSION',
                              'REGULAR_EXPRESSION',
                              'FUNC_BODY_RETURNING_ERR_TEXT',
                              'FUNC_BODY_RETURNING_BOOLEAN',
                              'PLSQL_ERROR',
                              'NOT_EXISTS',
                              'EXISTS',
                              'ITEM_IN_VALIDATION_IN_STRING2',
                              'ITEM_IN_VALIDATION_NOT_IN_STRING2',
                              'ITEM_IN_VALIDATION_EQ_STRING2',
                              'ITEM_IN_VALIDATION_NOT_EQ_STRING2',
                              'ITEM_IN_VALIDATION_CONTAINS_AT_LEAST_ONE_CHAR_IN_STRING2',
                              'ITEM_IN_VALIDATION_CONTAINS_ONLY_CHAR_IN_STRING2',
                              'ITEM_IN_VALIDATION_CONTAINS_NO_CHAR_IN_STRING2'
                              )),
  validation_condition VARCHAR2(4000 BYTE),
  validation_condition2 VARCHAR2(4000 BYTE),
  validation_condition_type VARCHAR2(255 BYTE),
  when_button_pressed NUMBER,
  error_message VARCHAR2(4000 BYTE),
  associated_item NUMBER,
  error_display_location VARCHAR2(255 BYTE) CONSTRAINT wwv_valid_val_edl CHECK (error_display_location in (
                              'INLINE_WITH_FIELD',
                              'INLINE_WITH_FIELD_AND_NOTIFICATION',
                              'INLINE_IN_NOTIFICATION',
                              'ON_ERROR_PAGE')),
  required_patch NUMBER,
  security_scheme VARCHAR2(255 BYTE),
  security_group_id NUMBER NOT NULL,
  last_updated_by VARCHAR2(255 BYTE),
  last_updated_on DATE,
  validation_comment VARCHAR2(4000 BYTE),
  CONSTRAINT wwv_flow_step_val_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_flow_step_val_fk FOREIGN KEY (flow_id) REFERENCES wwv_flows ("ID") ON DELETE CASCADE,
  CONSTRAINT wwv_flow_step_val_fk2 FOREIGN KEY (flow_id,flow_step_id) REFERENCES wwv_flow_steps (flow_id,"ID") ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";