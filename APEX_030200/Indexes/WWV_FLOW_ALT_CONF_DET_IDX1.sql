CREATE UNIQUE INDEX wwv_flow_alt_conf_det_idx1 ON wwv_flow_alt_config_detail(config,table_dot_column,id_column_value,security_group_id)
NOCOMPRESS
PCTFREE 10 INITRANS 2 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";