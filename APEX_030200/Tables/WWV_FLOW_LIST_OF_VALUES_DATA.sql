CREATE TABLE wwv_flow_list_of_values_data (
  "ID" NUMBER NOT NULL,
  lov_id NUMBER,
  flow_id NUMBER,
  lov_disp_sequence NUMBER NOT NULL,
  lov_disp_value VARCHAR2(4000 BYTE) NOT NULL,
  lov_return_value VARCHAR2(4000 BYTE) NOT NULL,
  lov_template VARCHAR2(4000 BYTE),
  lov_disp_cond_type VARCHAR2(255 BYTE),
  lov_disp_cond VARCHAR2(4000 BYTE),
  lov_disp_cond2 VARCHAR2(4000 BYTE),
  required_patch NUMBER,
  security_group_id NUMBER NOT NULL,
  last_updated_by VARCHAR2(255 BYTE),
  last_updated_on DATE,
  lov_data_comment VARCHAR2(4000 BYTE),
  CONSTRAINT wwv_flow_lov_data_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_flow_lov_data_fk FOREIGN KEY (lov_id) REFERENCES wwv_flow_lists_of_values$ ("ID") ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";