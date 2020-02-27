CREATE UNIQUE INDEX wwv_flow_session_idx2 ON wwv_flow_sessions$(session_id_hashed)
NOCOMPRESS
PCTFREE 10 INITRANS 2 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";