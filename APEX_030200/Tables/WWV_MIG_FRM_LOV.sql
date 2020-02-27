CREATE TABLE wwv_mig_frm_lov (
  "ID" NUMBER NOT NULL,
  formmodule_id NUMBER NOT NULL,
  security_group_id NUMBER NOT NULL,
  "NAME" VARCHAR2(4000 BYTE),
  title VARCHAR2(4000 BYTE),
  height VARCHAR2(4000 BYTE),
  width VARCHAR2(4000 BYTE),
  xposition VARCHAR2(4000 BYTE),
  yposition VARCHAR2(4000 BYTE),
  recordgroupname VARCHAR2(4000 BYTE),
  dirtyinfo VARCHAR2(4000 BYTE),
  autoposition VARCHAR2(4000 BYTE) DEFAULT 'false',
  visualattributename VARCHAR2(4000 BYTE),
  parenttype VARCHAR2(4000 BYTE),
  parentname VARCHAR2(4000 BYTE),
  parentmodule VARCHAR2(4000 BYTE),
  parentmoduletype VARCHAR2(4000 BYTE),
  autocolumnwidth VARCHAR2(4000 BYTE) DEFAULT 'false',
  autodisplay VARCHAR2(4000 BYTE) DEFAULT 'false',
  autorefresh VARCHAR2(4000 BYTE) DEFAULT 'false',
  autoselect VARCHAR2(4000 BYTE) DEFAULT 'false',
  autoskip VARCHAR2(4000 BYTE) DEFAULT 'false',
  backcolor VARCHAR2(4000 BYTE),
  lov_comment VARCHAR2(4000 BYTE),
  fillpattern VARCHAR2(4000 BYTE),
  filterbeforedisplay VARCHAR2(4000 BYTE) DEFAULT 'false',
  fontname VARCHAR2(4000 BYTE),
  fontsize VARCHAR2(4000 BYTE),
  fontspacing VARCHAR2(4000 BYTE),
  fontstyle VARCHAR2(4000 BYTE),
  fontweight VARCHAR2(4000 BYTE),
  foregroundcolor VARCHAR2(4000 BYTE),
  languagedirection VARCHAR2(4000 BYTE),
  listtype VARCHAR2(4000 BYTE),
  oldlovtext VARCHAR2(4000 BYTE),
  parentfilename VARCHAR2(4000 BYTE),
  parentfilepath VARCHAR2(4000 BYTE),
  persistentclientinfolength VARCHAR2(4000 BYTE),
  smartclass VARCHAR2(4000 BYTE) DEFAULT 'false',
  subclassobjectgroup VARCHAR2(4000 BYTE) DEFAULT 'false',
  select_for_app VARCHAR2(1 BYTE) DEFAULT 'Y' NOT NULL CONSTRAINT wwv_mig_frm_lov_sel_for_app CHECK (select_for_app in ('Y', 'N')),
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
  CONSTRAINT wwv_mig_frm_lov_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_mig_frm_lov_frmmdl_id_fk FOREIGN KEY (formmodule_id) REFERENCES wwv_mig_frm_formmodules ("ID") ON DELETE CASCADE,
  CONSTRAINT wwv_mig_frm_lov_sg_id_fk FOREIGN KEY (security_group_id) REFERENCES wwv_flow_companies (provisioning_company_id) ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";