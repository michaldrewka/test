CREATE UNIQUE INDEX wwv_flow_translatable_text_pk ON wwv_flow_translatable_text$(flow_id,page_id,translate_from_id,translate_from_flow_table,translate_from_flow_column,translate_to_lang_code)
NOCOMPRESS
PCTFREE 10 INITRANS 2 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";