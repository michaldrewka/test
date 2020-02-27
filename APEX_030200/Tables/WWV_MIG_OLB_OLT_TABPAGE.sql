CREATE TABLE wwv_mig_olb_olt_tabpage (
  "ID" NUMBER NOT NULL,
  objectlibrarytab_id NUMBER NOT NULL,
  security_group_id NUMBER NOT NULL,
  "NAME" VARCHAR2(4000 BYTE),
  "LABEL" VARCHAR2(4000 BYTE),
  dirtyinfo VARCHAR2(4000 BYTE),
  backcolor VARCHAR2(4000 BYTE),
  tabpage_comment VARCHAR2(4000 BYTE),
  enabled VARCHAR2(4000 BYTE),
  fillpattern VARCHAR2(4000 BYTE),
  foregroundcolor VARCHAR2(4000 BYTE),
  parentfilename VARCHAR2(4000 BYTE),
  parentfilepath VARCHAR2(4000 BYTE),
  parentmodule VARCHAR2(4000 BYTE),
  parentmoduletype VARCHAR2(4000 BYTE),
  parentname VARCHAR2(4000 BYTE),
  parentsourcelevel1objectname VARCHAR2(4000 BYTE),
  parentsourcelevel1objecttype VARCHAR2(4000 BYTE),
  parenttype VARCHAR2(4000 BYTE),
  persistentclientinfolength VARCHAR2(4000 BYTE),
  smartclass VARCHAR2(4000 BYTE),
  subclasssubobject VARCHAR2(4000 BYTE),
  "VISIBLE" VARCHAR2(4000 BYTE),
  visualattributename VARCHAR2(4000 BYTE),
  select_for_app VARCHAR2(1 BYTE) DEFAULT 'Y' NOT NULL CONSTRAINT wwv_mig_olb_t_tabpag_sel_f_app CHECK (select_for_app in ('Y', 'N')),
  applicable VARCHAR2(1 BYTE) DEFAULT 'Y',
  "COMPLETE" VARCHAR2(1 BYTE) DEFAULT 'N',
  "PRIORITY" NUMBER(1) DEFAULT 3,
  assignee VARCHAR2(255 BYTE),
  notes VARCHAR2(4000 BYTE),
  tags VARCHAR2(4000 BYTE),
  created_on DATE,
  created_by VARCHAR2(400 BYTE),
  last_updated_on DATE,
  last_updated_by VARCHAR2(400 BYTE),
  CONSTRAINT wwv_mig_olb_olt_tabpage_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_mig_olb_t_tabpage_oltid_fk FOREIGN KEY (objectlibrarytab_id) REFERENCES wwv_mig_olb_objectlibrarytab ("ID") ON DELETE CASCADE,
  CONSTRAINT wwv_mig_olb_t_tabpage_sg_id_fk FOREIGN KEY (security_group_id) REFERENCES wwv_flow_companies (provisioning_company_id) ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";