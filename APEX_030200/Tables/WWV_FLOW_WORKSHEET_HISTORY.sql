CREATE TABLE wwv_flow_worksheet_history (
  row_id NUMBER NOT NULL,
  worksheet_id NUMBER NOT NULL,
  column_name VARCHAR2(255 BYTE),
  old_value VARCHAR2(4000 BYTE),
  new_value VARCHAR2(4000 BYTE),
  application_user_id VARCHAR2(255 BYTE),
  change_date DATE,
  security_group_id NUMBER NOT NULL
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";