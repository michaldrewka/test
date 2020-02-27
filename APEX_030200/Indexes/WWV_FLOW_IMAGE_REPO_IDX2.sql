CREATE INDEX wwv_flow_image_repo_idx2 ON wwv_flow_image_repository(file_object_id)
NOCOMPRESS
PCTFREE 10 INITRANS 2 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";