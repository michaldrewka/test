CREATE INDEX wwv_flow_translatable_key2 ON wwv_flow_translatable_text$(flow_id,translate_from_flow_table,translate_from_flow_column)
NOCOMPRESS
PCTFREE 10 INITRANS 2 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";