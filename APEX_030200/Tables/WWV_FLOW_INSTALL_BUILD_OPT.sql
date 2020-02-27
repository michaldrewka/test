CREATE TABLE wwv_flow_install_build_opt (
  "ID" NUMBER NOT NULL,
  flow_id NUMBER NOT NULL,
  security_group_id NUMBER NOT NULL,
  install_id NUMBER NOT NULL,
  build_opt_id NUMBER NOT NULL,
  CONSTRAINT wwv_flow_install_build_opt_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_flow_install_build_opt_fk FOREIGN KEY (flow_id) REFERENCES wwv_flows ("ID"),
  CONSTRAINT wwv_flow_install_build_opt_fk2 FOREIGN KEY (security_group_id) REFERENCES wwv_flow_companies (provisioning_company_id),
  CONSTRAINT wwv_flow_install_build_opt_fk3 FOREIGN KEY (install_id) REFERENCES wwv_flow_install ("ID") ON DELETE CASCADE,
  CONSTRAINT wwv_flow_install_build_opt_fk4 FOREIGN KEY (build_opt_id) REFERENCES wwv_flow_patches ("ID") ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";