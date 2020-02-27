CREATE TABLE wwv_mig_rpt_reportprivate (
  "ID" NUMBER NOT NULL,
  report_id NUMBER NOT NULL,
  security_group_id NUMBER NOT NULL,
  defaultreporttype VARCHAR2(4000 BYTE),
  versionflags VARCHAR2(4000 BYTE),
  versionflags2 VARCHAR2(4000 BYTE),
  lastmodified VARCHAR2(4000 BYTE),
  charpromptmustsplit VARCHAR2(4000 BYTE),
  charpromptmaysplit VARCHAR2(4000 BYTE),
  minfieldresizerate VARCHAR2(4000 BYTE),
  minfontpoints VARCHAR2(4000 BYTE),
  templatename VARCHAR2(4000 BYTE),
  iscustomname VARCHAR2(4000 BYTE),
  mailtext VARCHAR2(4000 BYTE),
  texttokenfile VARCHAR2(4000 BYTE),
  imagetokenfile VARCHAR2(4000 BYTE),
  sectiontitle VARCHAR2(4000 BYTE),
  select_for_app VARCHAR2(1 BYTE) DEFAULT 'Y' NOT NULL CONSTRAINT wwv_mig_rptpriv_select_for_app CHECK (select_for_app in ('Y', 'N')),
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
  CONSTRAINT wwv_mig_rptpriv_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_mig_rptpriv_id_fk FOREIGN KEY (report_id) REFERENCES wwv_mig_report ("ID") ON DELETE CASCADE,
  CONSTRAINT wwv_mig_rptpriv_sg_id_fk FOREIGN KEY (security_group_id) REFERENCES wwv_flow_companies (provisioning_company_id) ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";