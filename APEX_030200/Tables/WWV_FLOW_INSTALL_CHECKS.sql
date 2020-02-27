CREATE TABLE wwv_flow_install_checks (
  "ID" NUMBER NOT NULL,
  flow_id NUMBER NOT NULL,
  security_group_id NUMBER NOT NULL,
  install_id NUMBER NOT NULL,
  "NAME" VARCHAR2(255 BYTE) NOT NULL,
  "SEQUENCE" NUMBER NOT NULL,
  check_type VARCHAR2(255 BYTE),
  check_condition VARCHAR2(4000 BYTE),
  check_condition2 VARCHAR2(4000 BYTE),
  failure_message VARCHAR2(4000 BYTE),
  condition_type VARCHAR2(255 BYTE),
  "CONDITION" VARCHAR2(4000 BYTE),
  condition2 VARCHAR2(4000 BYTE),
  last_updated_by VARCHAR2(255 BYTE),
  last_updated_on DATE,
  created_by VARCHAR2(255 BYTE),
  created_on DATE,
  CONSTRAINT wwv_flow_install_checks_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_flow_install_checks_fk FOREIGN KEY (flow_id) REFERENCES wwv_flows ("ID"),
  CONSTRAINT wwv_flow_install_checks_fk2 FOREIGN KEY (security_group_id) REFERENCES wwv_flow_companies (provisioning_company_id),
  CONSTRAINT wwv_flow_install_checks_fk3 FOREIGN KEY (install_id) REFERENCES wwv_flow_install ("ID") ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";