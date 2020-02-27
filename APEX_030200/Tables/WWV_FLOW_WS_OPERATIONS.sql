CREATE TABLE wwv_flow_ws_operations (
  "ID" NUMBER NOT NULL,
  ws_id NUMBER,
  "NAME" VARCHAR2(255 BYTE),
  input_message_name VARCHAR2(255 BYTE),
  input_message_ns VARCHAR2(4000 BYTE),
  input_message_style VARCHAR2(255 BYTE),
  output_message_name VARCHAR2(255 BYTE),
  output_message_ns VARCHAR2(4000 BYTE),
  output_message_style VARCHAR2(255 BYTE),
  header_message_name VARCHAR2(4000 BYTE),
  header_message_style VARCHAR2(255 BYTE),
  soap_action VARCHAR2(4000 BYTE),
  security_group_id NUMBER NOT NULL,
  last_updated_by VARCHAR2(255 BYTE),
  last_updated_on DATE,
  CONSTRAINT wwv_flow_ws_opers_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_flow_ws_opers_fk FOREIGN KEY (ws_id) REFERENCES wwv_flow_shared_web_services ("ID") ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";