CREATE INDEX wwv_flow_lock_page_log_i2 ON wwv_flow_lock_page_log(lock_id)
NOCOMPRESS
PCTFREE 10 INITRANS 2 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";