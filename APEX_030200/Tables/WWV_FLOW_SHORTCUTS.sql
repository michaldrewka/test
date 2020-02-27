CREATE TABLE wwv_flow_shortcuts (
  "ID" NUMBER NOT NULL,
  flow_id NUMBER NOT NULL,
  security_group_id NUMBER NOT NULL,
  shortcut_name VARCHAR2(255 BYTE) NOT NULL,
  shortcut_consideration_seq NUMBER,
  shortcut_type VARCHAR2(30 BYTE) CONSTRAINT wwv_flow_valid_shortcut_type CHECK (shortcut_type in (
                             'HTML_TEXT',
                             'HTML_TEXT_ESCAPE_SC',
                             'FUNCTION_BODY',
                             'IMAGE',
                             'MESSAGE',
                             'MESSAGE_ESCAPE_JS',
                             'TEXT_ESCAPE_JS')),
  shortcut_condition_type1 VARCHAR2(255 BYTE),
  shortcut_condition1 VARCHAR2(4000 BYTE),
  shortcut_condition_type2 VARCHAR2(255 BYTE),
  shortcut_condition2 VARCHAR2(4000 BYTE),
  build_option NUMBER,
  error_text VARCHAR2(4000 BYTE),
  shortcut CLOB,
  reference_id NUMBER,
  last_updated_by VARCHAR2(255 BYTE),
  last_updated_on DATE,
  comments VARCHAR2(4000 BYTE),
  CONSTRAINT wwv_flow_shortcuts_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_flow_shortcuts_to_flow_fk FOREIGN KEY (flow_id) REFERENCES wwv_flows ("ID") ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX"
LOB (shortcut) STORE AS BASICFILE (
  ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  CACHE READS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT));