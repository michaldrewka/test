CREATE TABLE wwv_flow_themes (
  "ID" NUMBER NOT NULL,
  flow_id NUMBER NOT NULL,
  theme_id NUMBER NOT NULL,
  security_group_id NUMBER NOT NULL,
  theme_name VARCHAR2(255 BYTE) NOT NULL,
  default_page_template NUMBER,
  error_template NUMBER,
  printer_friendly_template NUMBER,
  breadcrumb_display_point VARCHAR2(2000 BYTE),
  sidebar_display_point VARCHAR2(2000 BYTE),
  login_template NUMBER,
  default_button_template NUMBER,
  default_region_template NUMBER,
  default_chart_template NUMBER,
  default_form_template NUMBER,
  default_reportr_template NUMBER,
  default_tabform_template NUMBER,
  default_wizard_template NUMBER,
  default_menur_template NUMBER,
  default_listr_template NUMBER,
  default_report_template NUMBER,
  default_label_template NUMBER,
  default_menu_template NUMBER,
  default_calendar_template NUMBER,
  default_list_template NUMBER,
  default_option_label NUMBER,
  default_required_label NUMBER,
  theme_description VARCHAR2(4000 BYTE),
  theme_image BLOB,
  theme_image_mime_type VARCHAR2(255 BYTE),
  custom_image VARCHAR2(1 BYTE),
  theme_security_group_id NUMBER,
  calendar_icon VARCHAR2(255 BYTE),
  calendar_icon_attr VARCHAR2(4000 BYTE),
  last_updated_on DATE,
  last_updated_by VARCHAR2(255 BYTE),
  CONSTRAINT wwv_flow_themes_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_flow_themes_2f_fk FOREIGN KEY (flow_id) REFERENCES wwv_flows ("ID") ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX"
LOB (theme_image) STORE AS BASICFILE (
  ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  NOCACHE LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT));