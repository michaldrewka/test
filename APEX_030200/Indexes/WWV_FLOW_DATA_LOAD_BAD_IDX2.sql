CREATE INDEX wwv_flow_data_load_bad_idx2 ON wwv_flow_data_load_bad_log(security_group_id)
NOCOMPRESS
PCTFREE 10 INITRANS 2 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";