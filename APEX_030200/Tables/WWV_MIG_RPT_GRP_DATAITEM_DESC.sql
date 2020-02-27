CREATE TABLE wwv_mig_rpt_grp_dataitem_desc (
  "ID" NUMBER NOT NULL,
  item_id NUMBER NOT NULL,
  security_group_id NUMBER NOT NULL,
  "ALIAS" VARCHAR2(4000 BYTE),
  expression VARCHAR2(4000 BYTE),
  descriptiveexpression VARCHAR2(4000 BYTE),
  datadescriptor_order VARCHAR2(4000 BYTE),
  datatype VARCHAR2(10 BYTE) DEFAULT 'number' CONSTRAINT wwv_mig_grp_itemdesc_type CHECK (datatype in('character','number',
                                                             'date','graphic',
                                                             'long','raw',
                                                             'longRaw','vchar2',
                                                             'vchar','rowid',
                                                             'mlabel','ref','object',
                                                             'collect','blob','clob',
                                                             'nclob','bfile','unknown')),
  oracledatatype VARCHAR2(4000 BYTE) DEFAULT 'character',
  width VARCHAR2(4000 BYTE),
  "SCALE" VARCHAR2(4000 BYTE),
  "PRECISION" VARCHAR2(4000 BYTE),
  refdescendant VARCHAR2(3 BYTE) DEFAULT 'no' CONSTRAINT wwv_mig_grp_itemdesc_desc CHECK (refdescendant in('yes','no')),
  relationoperands VARCHAR2(4000 BYTE),
  select_for_app VARCHAR2(1 BYTE) DEFAULT 'Y' NOT NULL CONSTRAINT wwv_mig_itemdesc_sel_for_app CHECK (select_for_app in ('Y', 'N')),
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
  CONSTRAINT wwv_mig_grp_itemdesc_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_mig_grp_itemdesc_id_fk FOREIGN KEY (item_id) REFERENCES wwv_mig_rpt_grp_dataitem ("ID") ON DELETE CASCADE,
  CONSTRAINT wwv_mig_grp_itemdesc_sg_id_fk FOREIGN KEY (security_group_id) REFERENCES wwv_flow_companies (provisioning_company_id) ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";