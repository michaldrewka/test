CREATE TABLE wwv_mig_rev_forms (
  "ID" NUMBER NOT NULL,
  project_id NUMBER,
  dbid NUMBER,
  formid NUMBER(11) NOT NULL,
  parent_formid NUMBER(11),
  security_group_id NUMBER,
  form_name VARCHAR2(400 BYTE),
  source_name VARCHAR2(400 BYTE),
  source_type VARCHAR2(400 BYTE),
  source_syntax VARCHAR2(4000 BYTE),
  source_status VARCHAR2(10 BYTE),
  "OWNER" VARCHAR2(400 BYTE),
  status VARCHAR2(400 BYTE),
  mig_type VARCHAR2(100 BYTE),
  created_on DATE,
  created_by VARCHAR2(400 BYTE),
  last_updated_on DATE,
  last_updated_by VARCHAR2(400 BYTE),
  CONSTRAINT wwv_flow_rev_frm_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_mig_rev_frm_fk FOREIGN KEY (project_id,dbid,formid) REFERENCES wwv_mig_acc_forms (project_id,dbid,formid) ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";