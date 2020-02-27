CREATE UNIQUE INDEX wwv_flow_language_map_idx1 ON wwv_flow_language_map(primary_language_flow_id,translation_flow_language_code)
NOCOMPRESS
PCTFREE 10 INITRANS 2 LOGGING
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";