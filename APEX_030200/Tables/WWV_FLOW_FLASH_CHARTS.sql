CREATE TABLE wwv_flow_flash_charts (
  "ID" NUMBER NOT NULL,
  flow_id NUMBER NOT NULL,
  page_id NUMBER,
  region_id NUMBER NOT NULL,
  default_chart_type VARCHAR2(255 BYTE) NOT NULL,
  chart_title VARCHAR2(255 BYTE),
  chart_width NUMBER,
  chart_height NUMBER,
  chart_animation VARCHAR2(255 BYTE),
  display_attr VARCHAR2(4000 BYTE),
  dial_tick_attr VARCHAR2(4000 BYTE),
  margins VARCHAR2(4000 BYTE),
  omit_label_interval NUMBER,
  color_scheme VARCHAR2(255 BYTE),
  custom_colors VARCHAR2(4000 BYTE),
  bgtype VARCHAR2(255 BYTE),
  bgcolor1 VARCHAR2(30 BYTE),
  bgcolor2 VARCHAR2(30 BYTE),
  gradient_rotation NUMBER,
  x_axis_title VARCHAR2(4000 BYTE),
  x_axis_min NUMBER,
  x_axis_max NUMBER,
  x_axis_grid_spacing NUMBER,
  x_axis_prefix VARCHAR2(4000 BYTE),
  x_axis_postfix VARCHAR2(4000 BYTE),
  x_axis_group_sep VARCHAR2(1 BYTE) CONSTRAINT wwv_flow_flash_charts_xgroup CHECK (x_axis_group_sep in ('Y','N')),
  x_axis_decimal_place NUMBER,
  y_axis_title VARCHAR2(4000 BYTE),
  y_axis_min NUMBER,
  y_axis_max NUMBER,
  y_axis_grid_spacing NUMBER,
  y_axis_prefix VARCHAR2(4000 BYTE),
  y_axis_postfix VARCHAR2(4000 BYTE),
  y_axis_group_sep VARCHAR2(1 BYTE) CONSTRAINT wwv_flow_flash_charts_ygroup CHECK (y_axis_group_sep in ('Y','N')),
  y_axis_decimal_place NUMBER,
  async_update VARCHAR2(1 BYTE) CONSTRAINT wwv_flow_flash_charts_update CHECK (async_update in ('Y','N')),
  async_time NUMBER,
  names_font VARCHAR2(4000 BYTE),
  names_rotation NUMBER,
  values_font VARCHAR2(4000 BYTE),
  values_rotation NUMBER,
  hints_font VARCHAR2(4000 BYTE),
  legend_font VARCHAR2(4000 BYTE),
  grid_labels_font VARCHAR2(4000 BYTE),
  chart_title_font VARCHAR2(4000 BYTE),
  x_axis_title_font VARCHAR2(4000 BYTE),
  y_axis_title_font VARCHAR2(4000 BYTE),
  use_chart_xml VARCHAR2(1 BYTE) CONSTRAINT wwv_flow_flash_charts_xml CHECK (use_chart_xml in ('Y','N')),
  chart_xml CLOB,
  attribute_01 VARCHAR2(4000 BYTE),
  attribute_02 VARCHAR2(4000 BYTE),
  attribute_03 VARCHAR2(4000 BYTE),
  attribute_04 VARCHAR2(4000 BYTE),
  attribute_05 VARCHAR2(4000 BYTE),
  created_on DATE NOT NULL,
  created_by VARCHAR2(255 BYTE) NOT NULL,
  updated_on DATE,
  updated_by VARCHAR2(255 BYTE),
  security_group_id NUMBER NOT NULL,
  CONSTRAINT wwv_flow_flash_charts_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_flow_flash_charts_fk FOREIGN KEY (flow_id) REFERENCES wwv_flows ("ID") ON DELETE CASCADE,
  CONSTRAINT wwv_flow_flash_charts_fk2 FOREIGN KEY (region_id) REFERENCES wwv_flow_page_plugs ("ID") ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX"
LOB (chart_xml) STORE AS BASICFILE (
  ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  CACHE LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT));