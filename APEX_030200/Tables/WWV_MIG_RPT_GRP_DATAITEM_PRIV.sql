CREATE TABLE wwv_mig_rpt_grp_dataitem_priv (
  "ID" NUMBER NOT NULL,
  item_id NUMBER NOT NULL,
  security_group_id NUMBER NOT NULL,
  sqldatatype VARCHAR2(4000 BYTE),
  adtname VARCHAR2(4000 BYTE),
  schemaname VARCHAR2(4000 BYTE),
  refexpanded VARCHAR2(30 BYTE) DEFAULT 'no' CONSTRAINT wwv_mig_rpt_grp_itempriv_ref CHECK (refexpanded in ('yes','no')),
  displaywithparentcolumn VARCHAR2(3 BYTE) DEFAULT 'no' CONSTRAINT wwv_mig_rpt_grp_itempriv_dis CHECK (displaywithparentcolumn in ('yes','no')),
  parentcolumn VARCHAR2(4000 BYTE),
  cdata CLOB,
  select_for_app VARCHAR2(1 BYTE) DEFAULT 'Y' NOT NULL CONSTRAINT wwv_mig_itempriv_sel_for_app CHECK (select_for_app in ('Y', 'N')),
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
  CONSTRAINT wwv_mig_grp_itempriv_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_mig_grp_itempriv_id_fk FOREIGN KEY (item_id) REFERENCES wwv_mig_rpt_grp_dataitem ("ID") ON DELETE CASCADE,
  CONSTRAINT wwv_mig_grp_itempriv_sg_id_fk FOREIGN KEY (security_group_id) REFERENCES wwv_flow_companies (provisioning_company_id) ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX"
LOB (cdata) STORE AS BASICFILE (
  ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  NOCACHE LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MAXEXTENTS 2147483645
  FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT));