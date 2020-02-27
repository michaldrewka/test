CREATE TABLE wwv_flow_step_buttons (
  "ID" NUMBER NOT NULL,
  flow_id NUMBER NOT NULL,
  flow_step_id NUMBER,
  button_sequence NUMBER,
  button_plug_id NUMBER,
  button_name VARCHAR2(2000 BYTE),
  button_image VARCHAR2(2000 BYTE),
  button_image_alt VARCHAR2(2000 BYTE),
  button_position VARCHAR2(30 BYTE) CONSTRAINT valid_fstepb_position CHECK (button_position in (
                              'LEFT_OF_TITLE',
                              'RIGHT_OF_TITLE',
                              'ABOVE_BOX',
                              'TOP',
                              'BOTTOM',
                              'TOP_AND_BOTTOM',
                              'TEMPLATE_DEFAULT',
                              'BELOW_BOX',
                              'REGION_TEMPLATE_CREATE',
                              'REGION_TEMPLATE_CREATE2',
                              'REGION_TEMPLATE_CLOSE',
                              'REGION_TEMPLATE_EXPAND',
                              'REGION_TEMPLATE_EDIT',
                              'REGION_TEMPLATE_NEXT',
                              'REGION_TEMPLATE_PREVIOUS',
                              'REGION_TEMPLATE_CHANGE',
                              'REGION_TEMPLATE_DELETE',
                              'REGION_TEMPLATE_COPY',
                              'REGION_TEMPLATE_HELP',
                              'RIGHT_OF_IR_SEARCH_BAR'
                              ) and button_position is not null),
  button_alignment VARCHAR2(30 BYTE) CONSTRAINT wwv_flow_valid_fbutton_align CHECK (button_alignment in ('LEFT','MIDDLE','RIGHT')),
  button_redirect_url VARCHAR2(4000 BYTE),
  button_condition VARCHAR2(4000 BYTE),
  button_condition2 VARCHAR2(4000 BYTE),
  button_condition_type VARCHAR2(255 BYTE),
  button_image_attributes VARCHAR2(500 BYTE),
  button_cattributes VARCHAR2(2000 BYTE),
  database_action VARCHAR2(30 BYTE),
  required_patch NUMBER,
  security_scheme VARCHAR2(255 BYTE),
  security_group_id NUMBER NOT NULL,
  last_updated_by VARCHAR2(255 BYTE),
  last_updated_on DATE,
  button_comment VARCHAR2(4000 BYTE),
  CONSTRAINT wwv_flow_step_buttons_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_flow_step_buttons_fk1 FOREIGN KEY (flow_id) REFERENCES wwv_flows ("ID") ON DELETE CASCADE,
  CONSTRAINT wwv_flow_step_buttons_fk2 FOREIGN KEY (flow_id,flow_step_id) REFERENCES wwv_flow_steps (flow_id,"ID") ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";