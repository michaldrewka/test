CREATE TABLE wwv_flow_query_object (
  "ID" NUMBER NOT NULL,
  query_id NUMBER NOT NULL,
  object_owner VARCHAR2(30 BYTE) NOT NULL,
  object_name VARCHAR2(30 BYTE) NOT NULL,
  object_alias VARCHAR2(255 BYTE) NOT NULL,
  security_group_id NUMBER NOT NULL,
  last_updated_by VARCHAR2(255 BYTE),
  last_updated_on DATE,
  CONSTRAINT query_object_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT query_object_to_query_fk FOREIGN KEY (query_id) REFERENCES wwv_flow_query_definition ("ID") ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";