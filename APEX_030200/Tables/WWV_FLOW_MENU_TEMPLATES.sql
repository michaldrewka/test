CREATE TABLE wwv_flow_menu_templates (
  "ID" NUMBER NOT NULL,
  flow_id NUMBER NOT NULL,
  "NAME" VARCHAR2(255 BYTE) NOT NULL,
  before_first VARCHAR2(4000 BYTE),
  current_page_option VARCHAR2(4000 BYTE),
  non_current_page_option VARCHAR2(4000 BYTE),
  menu_link_attributes VARCHAR2(4000 BYTE),
  between_levels VARCHAR2(4000 BYTE),
  after_last VARCHAR2(4000 BYTE),
  max_levels NUMBER,
  start_with_node VARCHAR2(255 BYTE),
  reference_id NUMBER,
  security_group_id NUMBER NOT NULL,
  last_updated_by VARCHAR2(255 BYTE),
  last_updated_on DATE,
  theme_id NUMBER,
  theme_class_id NUMBER,
  translate_this_template VARCHAR2(1 BYTE) CONSTRAINT wwv_flow_menu_trans_temp CHECK (translate_this_template in ('Y','N')),
  template_comments VARCHAR2(4000 BYTE),
  CONSTRAINT wwv_flow_menu_templs_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_flow_menus_t_flow_fk FOREIGN KEY (flow_id) REFERENCES wwv_flows ("ID") ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";