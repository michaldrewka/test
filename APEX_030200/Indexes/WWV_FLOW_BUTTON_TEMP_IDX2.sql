CREATE UNIQUE INDEX wwv_flow_button_temp_idx2 ON wwv_flow_button_templates(flow_id,template_name,theme_id)
NOCOMPRESS
PCTFREE 10 INITRANS 2 LOGGING
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";