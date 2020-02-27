CREATE TABLE wwv_mig_frm_rev_blocks (
  "ID" NUMBER NOT NULL,
  block_id NUMBER NOT NULL,
  security_group_id NUMBER NOT NULL,
  "NAME" VARCHAR2(4000 BYTE),
  querydatasourcename VARCHAR2(4000 BYTE),
  querydatasourcetype VARCHAR2(4000 BYTE),
  enforcedprimarykey VARCHAR2(4000 BYTE),
  singlerecord VARCHAR2(4000 BYTE),
  databaseblock VARCHAR2(4000 BYTE),
  updateallowed VARCHAR2(4000 BYTE),
  insertallowed VARCHAR2(4000 BYTE),
  recordsdisplaycount VARCHAR2(4000 BYTE),
  select_for_app VARCHAR2(1 BYTE) DEFAULT 'Y' NOT NULL CONSTRAINT wwv_mig_frm_rev_blk_sel CHECK (select_for_app in ('Y', 'N')),
  created_on TIMESTAMP,
  created_by VARCHAR2(400 BYTE),
  last_updated_on DATE,
  last_updated_by VARCHAR2(400 BYTE),
  CONSTRAINT wwv_mig_frm_rev_blocks_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_mig_frm_rev_blk_sg_id_fk FOREIGN KEY (security_group_id) REFERENCES wwv_flow_companies (provisioning_company_id) ON DELETE CASCADE,
  CONSTRAINT wwv_mig_frm_rev_blocks_id_fk FOREIGN KEY (block_id) REFERENCES wwv_mig_frm_blocks ("ID") ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";