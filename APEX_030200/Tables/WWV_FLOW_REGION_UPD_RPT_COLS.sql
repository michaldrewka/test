CREATE TABLE wwv_flow_region_upd_rpt_cols (
  "ID" NUMBER NOT NULL,
  flow_id NUMBER NOT NULL,
  security_group_id NUMBER NOT NULL,
  plug_id NUMBER NOT NULL,
  column_sequence NUMBER NOT NULL,
  query_column_name VARCHAR2(255 BYTE),
  display_as VARCHAR2(255 BYTE) CONSTRAINT wwv_flow_upc_display_as CHECK ( display_as in (
                                 'DISPLAY_AND_SAVE',
                                 'WITHOUT_MODIFICATION',
                                 'ESCAPE_SC',
                                 'TEXT',
                                 'TEXTAREA',
                                 'SELECT_LIST',
                                 'SELECT_LIST_FROM_LOV',
                                 'SELECT_LIST_FROM_QUERY',
                                 'HIDDEN',
                                 'POPUP',
                                 'DATE_POPUP'
                                 )),
  named_lov NUMBER,
  inline_lov VARCHAR2(4000 BYTE),
  lov_show_nulls VARCHAR2(3 BYTE) CONSTRAINT wwv_flow_upd_rpt_cols_lovn CHECK (lov_show_nulls in (
                                 'YES',
                                 'NO')),
  lov_null_text VARCHAR2(255 BYTE),
  lov_null_value VARCHAR2(255 BYTE),
  column_width NUMBER,
  column_height NUMBER,
  cattributes VARCHAR2(4000 BYTE),
  cattributes_element VARCHAR2(4000 BYTE),
  column_comment VARCHAR2(4000 BYTE),
  CONSTRAINT wwv_flow_upd_rpt_col PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_flow_urc_to_flow_fk FOREIGN KEY (flow_id) REFERENCES wwv_flows ("ID") ON DELETE CASCADE,
  CONSTRAINT wwv_flow_urc_to_plug_fk FOREIGN KEY (plug_id) REFERENCES wwv_flow_page_plugs ("ID") ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";