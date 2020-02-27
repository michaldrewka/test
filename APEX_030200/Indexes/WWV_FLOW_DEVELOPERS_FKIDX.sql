CREATE INDEX wwv_flow_developers_fkidx ON wwv_flow_developers(security_group_id,userid)
NOCOMPRESS
PCTFREE 10 INITRANS 2 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";