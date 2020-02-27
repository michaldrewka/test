CREATE INDEX wwv_flow_dynamic_transl_fkidx ON wwv_flow_dynamic_translations$(security_group_id,flow_id,translate_to_lang_code)
NOCOMPRESS
PCTFREE 10 INITRANS 2 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";