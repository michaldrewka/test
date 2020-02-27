CREATE INDEX wwv_flow_translatable_key ON wwv_flow_translatable_text$(flow_id,page_id,translate_from_id)
NOCOMPRESS
PCTFREE 10 INITRANS 2 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";