CREATE TABLE wwv_mig_frm_blk_relations (
  "ID" NUMBER NOT NULL,
  block_id NUMBER NOT NULL,
  security_group_id NUMBER NOT NULL,
  "NAME" VARCHAR2(4000 BYTE),
  relationtype VARCHAR2(4000 BYTE),
  autoquery VARCHAR2(4000 BYTE),
  deleterecord VARCHAR2(4000 BYTE),
  detailblock VARCHAR2(4000 BYTE),
  joincondition VARCHAR2(4000 BYTE),
  preventmasterlessoperations VARCHAR2(4000 BYTE),
  "DEFERRED" VARCHAR2(4000 BYTE),
  dirtyinfo VARCHAR2(4000 BYTE),
  relation_comment CLOB,
  detailitemref VARCHAR2(4000 BYTE),
  subclasssubobject VARCHAR2(4000 BYTE),
  persistentclientinfolength VARCHAR2(4000 BYTE),
  select_for_app VARCHAR2(1 BYTE) DEFAULT 'N' NOT NULL CONSTRAINT wwv_mig_frm_blkrel_sel_for_app CHECK (select_for_app in ('Y', 'N')),
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
  CONSTRAINT wwv_mig_frm_blk_rel_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_mig_frm_blk_rel_blk_id_fk FOREIGN KEY (block_id) REFERENCES wwv_mig_frm_blocks ("ID") ON DELETE CASCADE,
  CONSTRAINT wwv_mig_frm_blk_rel_sg_id_fk FOREIGN KEY (security_group_id) REFERENCES wwv_flow_companies (provisioning_company_id) ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX"
LOB (relation_comment) STORE AS BASICFILE (
  ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  NOCACHE LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MAXEXTENTS 2147483645
  FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT));