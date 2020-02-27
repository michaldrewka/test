CREATE TABLE wwv_mig_frm_formmodules (
  "ID" NUMBER NOT NULL,
  module_id NUMBER NOT NULL,
  security_group_id NUMBER NOT NULL,
  "NAME" VARCHAR2(4000 BYTE),
  title VARCHAR2(4000 BYTE),
  consolewindow VARCHAR2(4000 BYTE),
  menumodule VARCHAR2(4000 BYTE),
  runtimecomp VARCHAR2(4000 BYTE),
  dirtyinfo VARCHAR2(4000 BYTE),
  verticaltoolbarcanvas VARCHAR2(4000 BYTE),
  horizontaltoolbarcanvas VARCHAR2(4000 BYTE),
  formmodule_comment CLOB,
  initializemenu VARCHAR2(4000 BYTE),
  menurole VARCHAR2(4000 BYTE),
  firstnavigationblockname VARCHAR2(4000 BYTE),
  savepointmode VARCHAR2(4000 BYTE),
  validationunit VARCHAR2(4000 BYTE),
  recordvisualattributegroupname VARCHAR2(4000 BYTE),
  mousenavigationlimit VARCHAR2(4000 BYTE),
  use3dcontrols VARCHAR2(4000 BYTE),
  cursormode VARCHAR2(4000 BYTE),
  interactionmode VARCHAR2(4000 BYTE),
  isolationmode VARCHAR2(4000 BYTE),
  languagedirection VARCHAR2(4000 BYTE),
  maximumquerytime VARCHAR2(4000 BYTE),
  maximumrecordsfetched VARCHAR2(4000 BYTE),
  newdeferreqenf VARCHAR2(4000 BYTE),
  parentfilename VARCHAR2(4000 BYTE),
  parentfilepath VARCHAR2(4000 BYTE),
  parentmoduletype VARCHAR2(4000 BYTE),
  parenttype VARCHAR2(4000 BYTE),
  parentname VARCHAR2(4000 BYTE),
  parentmodule VARCHAR2(4000 BYTE),
  persistentclientinfolength VARCHAR2(4000 BYTE),
  helpbooktitle VARCHAR2(4000 BYTE),
  select_for_app VARCHAR2(1 BYTE) DEFAULT 'Y' NOT NULL CONSTRAINT wwv_mig_frm_frmmdl_sel_for_app CHECK (select_for_app in ('Y', 'N')),
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
  CONSTRAINT wwv_mig_frm_formmodules_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_mig_frm_frmmdl_mdl_id_fk FOREIGN KEY (module_id) REFERENCES wwv_mig_frm_modules ("ID") ON DELETE CASCADE,
  CONSTRAINT wwv_mig_frm_frmmdl_sg_id_fk FOREIGN KEY (security_group_id) REFERENCES wwv_flow_companies (provisioning_company_id) ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX"
LOB (formmodule_comment) STORE AS BASICFILE (
  ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  NOCACHE LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MAXEXTENTS 2147483645
  FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT));