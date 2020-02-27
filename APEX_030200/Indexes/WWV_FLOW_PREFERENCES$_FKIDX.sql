CREATE INDEX wwv_flow_preferences$_fkidx ON wwv_flow_preferences$(security_group_id,user_id,preference_name)
NOCOMPRESS
PCTFREE 10 INITRANS 2 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";