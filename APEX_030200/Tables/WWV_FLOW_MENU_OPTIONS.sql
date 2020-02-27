CREATE TABLE wwv_flow_menu_options (
  "ID" NUMBER NOT NULL,
  parent_id NUMBER,
  menu_id NUMBER NOT NULL,
  flow_id NUMBER,
  option_sequence NUMBER,
  short_name VARCHAR2(255 BYTE) NOT NULL,
  long_name VARCHAR2(4000 BYTE),
  "LINK" VARCHAR2(4000 BYTE),
  page_id NUMBER,
  also_current_for_pages VARCHAR2(4000 BYTE),
  display_when_cond_type VARCHAR2(255 BYTE),
  display_when_condition VARCHAR2(4000 BYTE),
  display_when_condition2 VARCHAR2(4000 BYTE),
  security_scheme VARCHAR2(255 BYTE),
  required_patch NUMBER,
  security_group_id NUMBER NOT NULL,
  last_updated_by VARCHAR2(255 BYTE),
  last_updated_on DATE,
  menu_option_comment VARCHAR2(4000 BYTE),
  CONSTRAINT wwv_flow_menu_opts_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_flow_opt_menus_fk FOREIGN KEY (menu_id) REFERENCES wwv_flow_menus ("ID") ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";