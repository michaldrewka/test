CREATE TABLE wwv_flow_activity_log2$ (
  time_stamp DATE NOT NULL,
  component_type VARCHAR2(255 BYTE),
  component_name VARCHAR2(255 BYTE),
  component_attribute VARCHAR2(4000 BYTE),
  information VARCHAR2(4000 BYTE),
  elap NUMBER,
  num_rows NUMBER,
  userid VARCHAR2(255 BYTE),
  ip_address VARCHAR2(4000 BYTE),
  user_agent VARCHAR2(4000 BYTE),
  flow_id NUMBER,
  step_id NUMBER,
  session_id NUMBER,
  security_group_id NUMBER NOT NULL,
  sqlerrm VARCHAR2(4000 BYTE),
  sqlerrm_component_type VARCHAR2(255 BYTE),
  sqlerrm_component_name VARCHAR2(255 BYTE),
  page_mode VARCHAR2(1 BYTE),
  cached_regions NUMBER,
  application_info VARCHAR2(4000 BYTE)
) NOCOMPRESS
PCTFREE 10 INITRANS 8 LOGGING
STORAGE(INITIAL 1048576 NEXT 1048576
FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";