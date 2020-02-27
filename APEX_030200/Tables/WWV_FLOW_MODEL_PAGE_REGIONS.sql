CREATE TABLE wwv_flow_model_page_regions (
  "ID" NUMBER NOT NULL,
  model_page_id NUMBER NOT NULL,
  region_id NUMBER,
  region_name VARCHAR2(4000 BYTE),
  region_source VARCHAR2(255 BYTE),
  "SOURCE" CLOB,
  display_sequence NUMBER,
  report_implementation VARCHAR2(30 BYTE) CONSTRAINT wwv_flow_mpr_rpt_impl_type CHECK (report_implementation in  (
                                    'CLASSIC',
                                    'INTERACTIVE'
                                )),
  search_enabled VARCHAR2(1 BYTE) CONSTRAINT wwv_flow_mpr_search_enables CHECK (search_enabled in (
                                    'Y',
                                    'N')),
  link_column VARCHAR2(255 BYTE),
  link_text VARCHAR2(255 BYTE),
  parent_link_from_column1 VARCHAR2(255 BYTE),
  parent_link_from_column2 VARCHAR2(255 BYTE),
  link_to_column1 VARCHAR2(255 BYTE),
  link_to_column2 VARCHAR2(255 BYTE),
  report_filter VARCHAR2(255 BYTE),
  column_heading_sorting VARCHAR2(255 BYTE),
  download_link VARCHAR2(255 BYTE),
  security_group_id NUMBER NOT NULL,
  created_by VARCHAR2(255 BYTE) NOT NULL,
  created_on DATE NOT NULL,
  last_updated_by VARCHAR2(255 BYTE),
  last_updated_on DATE,
  CONSTRAINT wwv_flow_mpr_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_flow_mpr_fk FOREIGN KEY (model_page_id) REFERENCES wwv_flow_model_pages ("ID") ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX"
LOB ("SOURCE") STORE AS BASICFILE (
  ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  NOCACHE LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MAXEXTENTS 2147483645
  FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT));