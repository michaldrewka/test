CREATE INDEX wwv_flow_sw_stmts_idx3 ON wwv_flow_sw_stmts(security_group_id,file_id,isrunnable,stmt_id,stmt_number)
COMPRESS 2
PCTFREE 10 INITRANS 2 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";