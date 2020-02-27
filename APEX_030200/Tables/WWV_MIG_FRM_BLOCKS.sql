CREATE TABLE wwv_mig_frm_blocks (
  "ID" NUMBER NOT NULL,
  formmodule_id NUMBER NOT NULL,
  security_group_id NUMBER NOT NULL,
  "NAME" VARCHAR2(4000 BYTE),
  block_comment CLOB,
  querydatasourcename VARCHAR2(4000 BYTE),
  querydatasourcetype VARCHAR2(4000 BYTE),
  enforcedprimarykey VARCHAR2(4000 BYTE),
  singlerecord VARCHAR2(4000 BYTE),
  databaseblock VARCHAR2(4000 BYTE),
  updateallowed VARCHAR2(4000 BYTE) DEFAULT 'true',
  insertallowed VARCHAR2(4000 BYTE) DEFAULT 'true',
  recordsdisplaycount VARCHAR2(4000 BYTE),
  backcolor VARCHAR2(4000 BYTE),
  recordvisualattributegroupname VARCHAR2(4000 BYTE),
  scrollbartabpagename VARCHAR2(4000 BYTE),
  scrollbarxposition VARCHAR2(4000 BYTE),
  scrollbaryposition VARCHAR2(4000 BYTE),
  showscrollbar VARCHAR2(4000 BYTE) DEFAULT 'false',
  scrollbarlength VARCHAR2(4000 BYTE),
  scrollbarwidth VARCHAR2(4000 BYTE),
  scrollbarcanvasname VARCHAR2(4000 BYTE),
  dirtyinfo VARCHAR2(4000 BYTE),
  visualattributename VARCHAR2(4000 BYTE),
  dmldataname VARCHAR2(4000 BYTE),
  dmldatatype VARCHAR2(4000 BYTE),
  deleteallowed VARCHAR2(4000 BYTE) DEFAULT 'true',
  queryallowed VARCHAR2(4000 BYTE),
  recordorientation VARCHAR2(4000 BYTE),
  enforcedcolumnsecurity VARCHAR2(4000 BYTE),
  lockmode VARCHAR2(4000 BYTE),
  keymode VARCHAR2(4000 BYTE),
  navigationstyle VARCHAR2(4000 BYTE),
  recordsfetchedcount VARCHAR2(4000 BYTE),
  recordsbufferedcount VARCHAR2(4000 BYTE),
  previousnavigationblockname VARCHAR2(4000 BYTE),
  nextnavigationblockname VARCHAR2(4000 BYTE),
  whereclause VARCHAR2(4000 BYTE),
  orderbyclause VARCHAR2(4000 BYTE),
  scrollbarorientation VARCHAR2(4000 BYTE),
  parenttype VARCHAR2(4000 BYTE),
  parentname VARCHAR2(4000 BYTE),
  parentmodule VARCHAR2(4000 BYTE),
  parentmoduletype VARCHAR2(4000 BYTE),
  foregroundcolor VARCHAR2(4000 BYTE),
  fillpattern VARCHAR2(4000 BYTE),
  dmlreturnvalue VARCHAR2(4000 BYTE),
  includerefitem VARCHAR2(4000 BYTE),
  precompsummary VARCHAR2(4000 BYTE),
  queryallrecords VARCHAR2(4000 BYTE),
  reversedirection VARCHAR2(4000 BYTE),
  subclassobjectgroup VARCHAR2(4000 BYTE),
  updatechangedcolumns VARCHAR2(4000 BYTE),
  dmlarraysize VARCHAR2(4000 BYTE),
  languagedirection VARCHAR2(4000 BYTE),
  maximumquerytime VARCHAR2(4000 BYTE),
  maximumrecordsfetched VARCHAR2(4000 BYTE),
  persistentclientinfolength VARCHAR2(4000 BYTE),
  "ALIAS" VARCHAR2(4000 BYTE),
  deleteprocedurename VARCHAR2(4000 BYTE),
  updateprocedurename VARCHAR2(4000 BYTE),
  insertprocedurename VARCHAR2(4000 BYTE),
  lockprocedurename VARCHAR2(4000 BYTE),
  optionhint VARCHAR2(4000 BYTE),
  parentfilename VARCHAR2(4000 BYTE),
  parentfilepath VARCHAR2(4000 BYTE),
  smartclass VARCHAR2(4000 BYTE),
  select_for_app VARCHAR2(1 BYTE) DEFAULT 'Y' NOT NULL CONSTRAINT wwv_mig_frm_blk_sel_for_app CHECK (select_for_app in ('Y', 'N')),
  applicable VARCHAR2(1 BYTE) DEFAULT 'Y',
  "COMPLETE" VARCHAR2(1 BYTE) DEFAULT 'N',
  "PRIORITY" NUMBER(1) DEFAULT 3,
  assignee VARCHAR2(255 BYTE),
  notes VARCHAR2(4000 BYTE),
  tags VARCHAR2(4000 BYTE),
  enhanced_query CLOB,
  use_query VARCHAR2(30 BYTE) CONSTRAINT use_query_option CHECK (use_query in ('CUSTOM', 'ENHANCED','ORIGINAL','NONE')),
  custom_query CLOB,
  original_query CLOB,
  created_on TIMESTAMP,
  created_by VARCHAR2(400 BYTE),
  last_updated_on DATE,
  last_updated_by VARCHAR2(400 BYTE),
  CONSTRAINT wwv_mig_frm_blocks_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_mig_frm_blk_frmmdl_id_fk FOREIGN KEY (formmodule_id) REFERENCES wwv_mig_frm_formmodules ("ID") ON DELETE CASCADE,
  CONSTRAINT wwv_mig_frm_blk_sg_id_fk FOREIGN KEY (security_group_id) REFERENCES wwv_flow_companies (provisioning_company_id) ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX"
LOB (block_comment) STORE AS BASICFILE (
  ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  NOCACHE LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MAXEXTENTS 2147483645
  FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT))
LOB (custom_query) STORE AS BASICFILE (
  ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  NOCACHE LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MAXEXTENTS 2147483645
  FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT))
LOB (enhanced_query) STORE AS BASICFILE (
  ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  NOCACHE LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MAXEXTENTS 2147483645
  FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT))
LOB (original_query) STORE AS BASICFILE (
  ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  NOCACHE LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MAXEXTENTS 2147483645
  FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT));