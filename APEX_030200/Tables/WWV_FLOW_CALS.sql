CREATE TABLE wwv_flow_cals (
  "ID" NUMBER NOT NULL,
  flow_id NUMBER NOT NULL,
  plug_id NUMBER NOT NULL,
  start_date VARCHAR2(255 BYTE),
  end_date VARCHAR2(255 BYTE),
  begin_at_start_of_interval VARCHAR2(1 BYTE) CONSTRAINT wwv_flow_val_calendar_si CHECK (begin_at_start_of_interval in ('Y','N')),
  date_item VARCHAR2(255 BYTE) DEFAULT null,
  display_as VARCHAR2(100 BYTE),
  display_item VARCHAR2(255 BYTE),
  display_type VARCHAR2(10 BYTE) CONSTRAINT wwv_flow_dis_calendar_typ CHECK (display_type in ('NONE','COL','CUS')),
  item_format VARCHAR2(4000 BYTE),
  easy_sql_owner VARCHAR2(255 BYTE),
  easy_sql_table VARCHAR2(255 BYTE),
  date_column VARCHAR2(255 BYTE),
  display_column VARCHAR2(255 BYTE),
  start_of_week NUMBER,
  template_id NUMBER,
  item_link VARCHAR2(4000 BYTE),
  day_link VARCHAR2(4000 BYTE),
  start_time NUMBER,
  end_time NUMBER,
  time_format VARCHAR2(6 BYTE) CONSTRAINT wwv_flow_dis_time_format CHECK (time_format in ('12HOUR','24HOUR') ),
  week_start_day NUMBER,
  week_end_day NUMBER,
  date_type_column VARCHAR2(255 BYTE),
  security_group_id NUMBER NOT NULL,
  last_updated_by VARCHAR2(255 BYTE),
  last_updated_on DATE,
  calendar_type VARCHAR2(1 BYTE),
  calendar_comments VARCHAR2(4000 BYTE),
  CONSTRAINT wwv_flow_cals_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_flow_cal_to_flow_fk FOREIGN KEY (flow_id) REFERENCES wwv_flows ("ID") ON DELETE CASCADE,
  CONSTRAINT wwv_flow_plug_calendar_fk FOREIGN KEY (plug_id) REFERENCES wwv_flow_page_plugs ("ID") ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";