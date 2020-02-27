CREATE TABLE wwv_mig_frm_visualattributes (
  "ID" NUMBER NOT NULL,
  formmodule_id NUMBER NOT NULL,
  security_group_id NUMBER NOT NULL,
  "NAME" VARCHAR2(4000 BYTE),
  fontname VARCHAR2(4000 BYTE),
  fontspacing VARCHAR2(4000 BYTE),
  fontstyle VARCHAR2(4000 BYTE),
  fontsize VARCHAR2(4000 BYTE),
  fontweight VARCHAR2(4000 BYTE),
  fillpattern VARCHAR2(4000 BYTE),
  backcolor VARCHAR2(4000 BYTE),
  foregroundcolor VARCHAR2(4000 BYTE),
  dirtyinfo VARCHAR2(4000 BYTE),
  parenttype VARCHAR2(4000 BYTE),
  parentname VARCHAR2(4000 BYTE),
  parentmodule VARCHAR2(4000 BYTE),
  parentmoduletype VARCHAR2(4000 BYTE),
  visualattribute_comment CLOB,
  frametitlebackcolor VARCHAR2(4000 BYTE),
  frametitlefillpattern VARCHAR2(4000 BYTE),
  frametitlefontname VARCHAR2(4000 BYTE),
  frametitlefontsize VARCHAR2(4000 BYTE),
  frametitlefontspacing VARCHAR2(4000 BYTE),
  frametitlefontstyle VARCHAR2(4000 BYTE),
  frametitlefontweight VARCHAR2(4000 BYTE),
  frametitleforegroundcolor VARCHAR2(4000 BYTE),
  parentfilename VARCHAR2(4000 BYTE),
  parentfilepath VARCHAR2(4000 BYTE),
  persistentclientinfolength VARCHAR2(4000 BYTE),
  promptbackcolor VARCHAR2(4000 BYTE),
  promptfillpattern VARCHAR2(4000 BYTE),
  promptfontname VARCHAR2(4000 BYTE),
  promptfontsize VARCHAR2(4000 BYTE),
  promptfontspacing VARCHAR2(4000 BYTE),
  promptfontstyle VARCHAR2(4000 BYTE),
  promptfontweight VARCHAR2(4000 BYTE),
  promptforegroundcolor VARCHAR2(4000 BYTE),
  smartclass VARCHAR2(4000 BYTE),
  subclassobjectgroup VARCHAR2(4000 BYTE),
  visualattributetype VARCHAR2(4000 BYTE),
  select_for_app VARCHAR2(1 BYTE) DEFAULT 'N' NOT NULL CONSTRAINT wwv_mig_frm_visat_sel_for_app CHECK (select_for_app in ('Y', 'N')),
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
  CONSTRAINT wwv_mig_frm_visat_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_mig_frm_visat_frmmdl_id_fk FOREIGN KEY (formmodule_id) REFERENCES wwv_mig_frm_formmodules ("ID") ON DELETE CASCADE,
  CONSTRAINT wwv_mig_frm_visat_sg_id_fk FOREIGN KEY (security_group_id) REFERENCES wwv_flow_companies (provisioning_company_id) ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX"
LOB (visualattribute_comment) STORE AS BASICFILE (
  ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  NOCACHE LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MAXEXTENTS 2147483645
  FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT));