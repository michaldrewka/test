CREATE TABLE wwv_flow_icon_bar (
  "ID" NUMBER NOT NULL,
  flow_id NUMBER NOT NULL,
  icon_sequence NUMBER NOT NULL,
  icon_image VARCHAR2(255 BYTE),
  icon_image2 VARCHAR2(255 BYTE),
  icon_image3 VARCHAR2(255 BYTE),
  icon_subtext VARCHAR2(255 BYTE),
  icon_subtext2 VARCHAR2(255 BYTE),
  icon_subtext3 VARCHAR2(255 BYTE),
  icon_target VARCHAR2(4000 BYTE),
  icon_image_alt VARCHAR2(4000 BYTE),
  icon_height NUMBER,
  icon_width NUMBER,
  icon_height2 NUMBER,
  icon_width2 NUMBER,
  icon_height3 NUMBER,
  icon_width3 NUMBER,
  icon_bar_disp_cond VARCHAR2(4000 BYTE),
  icon_bar_disp_cond_type VARCHAR2(255 BYTE),
  icon_bar_flow_cond_instr VARCHAR2(4000 BYTE),
  begins_on_new_line VARCHAR2(30 BYTE) CONSTRAINT valid_ficon_beginonnewline CHECK (begins_on_new_line in ('NO','YES')),
  cell_colspan NUMBER,
  onclick VARCHAR2(4000 BYTE),
  required_patch NUMBER,
  security_scheme VARCHAR2(255 BYTE),
  reference_id NUMBER,
  security_group_id NUMBER NOT NULL,
  last_updated_by VARCHAR2(255 BYTE),
  last_updated_on DATE,
  icon_bar_comment VARCHAR2(4000 BYTE),
  CONSTRAINT wwv_flow_icon_bar_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_flow_icon_bar_fk FOREIGN KEY (flow_id) REFERENCES wwv_flows ("ID") ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";