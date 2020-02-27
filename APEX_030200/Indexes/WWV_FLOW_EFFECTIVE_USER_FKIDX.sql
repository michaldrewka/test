CREATE INDEX wwv_flow_effective_user_fkidx ON wwv_flow_effective_userid_map(security_group_id,flow_id,userid)
NOCOMPRESS
PCTFREE 10 INITRANS 2 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";