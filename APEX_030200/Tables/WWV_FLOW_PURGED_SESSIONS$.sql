CREATE TABLE wwv_flow_purged_sessions$ (
  purge_date DATE,
  purged_sessions NUMBER,
  min_session_id NUMBER,
  max_session_id NUMBER,
  min_session_date DATE,
  max_session_date DATE,
  elap_seconds NUMBER,
  security_group_id NUMBER NOT NULL
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";