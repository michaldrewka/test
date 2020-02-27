CREATE TABLE wwv_flow_ws_parameters (
  "ID" NUMBER NOT NULL,
  ws_opers_id NUMBER,
  "NAME" VARCHAR2(255 BYTE),
  input_or_output VARCHAR2(1 BYTE) CONSTRAINT wwv_flow_ws_parms_chk1 CHECK (input_or_output in ('I','O','H','A')),
  parm_type VARCHAR2(255 BYTE),
  type_is_xsd VARCHAR2(1 BYTE) CONSTRAINT wwv_flow_ws_parms_chk2 CHECK (type_is_xsd in ('Y','N')),
  parent_id NUMBER,
  security_group_id NUMBER NOT NULL,
  last_updated_by VARCHAR2(255 BYTE),
  last_updated_on DATE,
  CONSTRAINT wwv_flow_ws_parms_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_flow_ws_parms_fk FOREIGN KEY (ws_opers_id) REFERENCES wwv_flow_ws_operations ("ID") ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";