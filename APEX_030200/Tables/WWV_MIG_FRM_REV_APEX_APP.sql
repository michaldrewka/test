CREATE TABLE wwv_mig_frm_rev_apex_app (
  "ID" NUMBER NOT NULL,
  project_id NUMBER NOT NULL,
  security_group_id NUMBER NOT NULL,
  flow_id NUMBER(11) NOT NULL,
  page_id NUMBER NOT NULL,
  list_template_name VARCHAR2(400 BYTE),
  list_item_type VARCHAR2(100 BYTE),
  list_item_icon VARCHAR2(400 BYTE),
  "OWNER" VARCHAR2(400 BYTE),
  created_on DATE,
  created_by VARCHAR2(400 BYTE),
  last_updated_on DATE,
  last_updated_by VARCHAR2(400 BYTE),
  CONSTRAINT wwv_mig_frm_rev_apex_app_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_mig_frm_rev_apex_app_fk FOREIGN KEY (project_id) REFERENCES wwv_mig_projects ("ID") ON DELETE CASCADE,
  CONSTRAINT wwv_mig_frm_rev_apxapp_sgid_fk FOREIGN KEY (security_group_id) REFERENCES wwv_flow_companies (provisioning_company_id) ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";