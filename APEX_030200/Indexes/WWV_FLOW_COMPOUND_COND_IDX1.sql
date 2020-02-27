CREATE INDEX wwv_flow_compound_cond_idx1 ON wwv_flow_compound_conditions(flow_id)
NOCOMPRESS
PCTFREE 10 INITRANS 2 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";