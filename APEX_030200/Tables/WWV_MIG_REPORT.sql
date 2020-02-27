CREATE TABLE wwv_mig_report (
  "ID" NUMBER NOT NULL,
  file_id NUMBER NOT NULL,
  security_group_id NUMBER NOT NULL,
  dtdversion VARCHAR2(20 BYTE),
  "NAME" VARCHAR2(4000 BYTE),
  title VARCHAR2(4000 BYTE),
  beforeparameterformtrigger VARCHAR2(4000 BYTE),
  afterparameterformtrigger VARCHAR2(4000 BYTE),
  beforereporttrigger VARCHAR2(4000 BYTE),
  betweenpagestrigger VARCHAR2(4000 BYTE),
  afterreporttrigger VARCHAR2(4000 BYTE),
  unitofmeasurement VARCHAR2(10 BYTE) DEFAULT 'inch' CONSTRAINT wwv_mig_rep_unit_measure CHECK (unitofmeasurement in ('inch','centimeter','point')),
  previewertitle VARCHAR2(4000 BYTE),
  designincharacterunits VARCHAR2(4000 BYTE) DEFAULT 'no' CONSTRAINT wwv_mig_rep_designunit CHECK (designincharacterunits in ('yes','no')),
  xmltag VARCHAR2(4000 BYTE),
  xmltagattrs VARCHAR2(4000 BYTE),
  xmlprologtype VARCHAR2(4000 BYTE),
  xmlprologvalue VARCHAR2(4000 BYTE),
  xmlprologtext VARCHAR2(4000 BYTE),
  xmlprologfile VARCHAR2(4000 BYTE),
  author VARCHAR2(4000 BYTE),
  select_for_app VARCHAR2(1 BYTE) DEFAULT 'Y' NOT NULL CONSTRAINT wwv_mig_rep_select_for_app CHECK (select_for_app in ('Y', 'N')),
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
  CONSTRAINT wwv_mig_rep_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_mig_rep_file_id_fk FOREIGN KEY (file_id) REFERENCES wwv_mig_rpts ("ID") ON DELETE CASCADE,
  CONSTRAINT wwv_mig_rep_sg_id_fk FOREIGN KEY (security_group_id) REFERENCES wwv_flow_companies (provisioning_company_id) ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";