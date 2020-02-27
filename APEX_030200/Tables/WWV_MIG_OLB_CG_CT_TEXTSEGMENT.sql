CREATE TABLE wwv_mig_olb_cg_ct_textsegment (
  "ID" NUMBER NOT NULL,
  compoundtext_id NUMBER NOT NULL,
  security_group_id NUMBER NOT NULL,
  "NAME" VARCHAR2(4000 BYTE),
  foregroundcolor VARCHAR2(4000 BYTE),
  fontspacing VARCHAR2(4000 BYTE),
  fontweight VARCHAR2(4000 BYTE),
  fontstyle VARCHAR2(4000 BYTE),
  fontsize VARCHAR2(4000 BYTE),
  fontname VARCHAR2(4000 BYTE),
  "TEXT" VARCHAR2(4000 BYTE),
  subclasssubobject VARCHAR2(4000 BYTE),
  dirtyinfo VARCHAR2(4000 BYTE),
  select_for_app VARCHAR2(1 BYTE) DEFAULT 'N' NOT NULL CONSTRAINT wwv_mig_olb_cg_ct_ts_sel_f_app CHECK (select_for_app in ('Y', 'N')),
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
  CONSTRAINT wwv_mig_olb_cg_ct_txtsegmnt_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_mig_olb_cg_ct_ts_ct_id_fk FOREIGN KEY (compoundtext_id) REFERENCES wwv_mig_olb_cg_compoundtext ("ID") ON DELETE CASCADE,
  CONSTRAINT wwv_mig_olb_cg_ct_ts_sg_id_fk FOREIGN KEY (security_group_id) REFERENCES wwv_flow_companies (provisioning_company_id) ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";