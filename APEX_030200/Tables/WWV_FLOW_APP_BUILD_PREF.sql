CREATE TABLE wwv_flow_app_build_pref (
  "ID" NUMBER NOT NULL,
  security_group_id NUMBER NOT NULL,
  default_parsing_schema VARCHAR2(255 BYTE),
  default_authentication_scheme VARCHAR2(255 BYTE),
  default_application_theme NUMBER,
  default_tabs VARCHAR2(255 BYTE),
  default_proxy_server VARCHAR2(500 BYTE),
  default_language VARCHAR2(255 BYTE),
  default_language_derived VARCHAR2(255 BYTE),
  date_format VARCHAR2(255 BYTE),
  created_on DATE,
  created_by VARCHAR2(255 BYTE),
  updated_on DATE,
  updated_by VARCHAR2(255 BYTE),
  CONSTRAINT wwv_flow_app_bldprf_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_flow_app_bldprf_fk FOREIGN KEY (security_group_id) REFERENCES wwv_flow_companies (provisioning_company_id) ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";