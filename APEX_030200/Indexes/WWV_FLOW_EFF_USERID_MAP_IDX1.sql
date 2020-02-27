CREATE UNIQUE INDEX wwv_flow_eff_userid_map_idx1 ON wwv_flow_effective_userid_map(userid,effective_userid,flow_id,security_group_id)
NOCOMPRESS
PCTFREE 10 INITRANS 2 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";