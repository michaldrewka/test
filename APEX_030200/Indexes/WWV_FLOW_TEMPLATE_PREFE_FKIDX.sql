CREATE INDEX wwv_flow_template_prefe_fkidx ON wwv_flow_template_preferences(flow_id,"OWNER",template_preference)
NOCOMPRESS
PCTFREE 10 INITRANS 2 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";