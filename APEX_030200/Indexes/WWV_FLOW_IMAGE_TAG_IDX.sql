CREATE INDEX wwv_flow_image_tag_idx ON wwv_flow_image_repository(image_tag)
NOCOMPRESS
PCTFREE 10 INITRANS 2 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";