CREATE UNIQUE INDEX wwv_flow_template_pref_idx ON wwv_flow_template_preferences("OWNER",flow_id,template_preference,printer_template_preference,security_group_id)
NOCOMPRESS
PCTFREE 10 INITRANS 2 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";