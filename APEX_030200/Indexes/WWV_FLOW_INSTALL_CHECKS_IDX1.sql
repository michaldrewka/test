CREATE UNIQUE INDEX wwv_flow_install_checks_idx1 ON wwv_flow_install_checks(flow_id,"NAME")
NOCOMPRESS
PCTFREE 10 INITRANS 2 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";