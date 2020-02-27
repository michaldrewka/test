CREATE INDEX wwv_flow_build_audit_trail_i5 ON wwv_flow_builder_audit_trail(security_group_id,flow_user,flow_id,audit_date)
NOCOMPRESS
PCTFREE 10 INITRANS 2 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";