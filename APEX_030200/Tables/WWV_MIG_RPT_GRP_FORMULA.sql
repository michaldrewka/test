CREATE TABLE wwv_mig_rpt_grp_formula (
  "ID" NUMBER NOT NULL,
  "GROUP_ID" NUMBER NOT NULL,
  security_group_id NUMBER NOT NULL,
  "NAME" VARCHAR2(4000 BYTE),
  "SOURCE" VARCHAR2(4000 BYTE),
  datatype VARCHAR2(10 BYTE) DEFAULT 'number' CONSTRAINT wwv_mig_rpt_grp_form_type CHECK (datatype in ('number','character','date')),
  valueifnull VARCHAR2(4000 BYTE),
  valueifnullformatmask VARCHAR2(4000 BYTE),
  breakorder VARCHAR2(15 BYTE) DEFAULT 'ascending' CONSTRAINT wwv_mig_rpt_grp_form_brk CHECK (breakorder in ('none','ascending','descending')),
  productorder VARCHAR2(4000 BYTE),
  readfromfile VARCHAR2(3 BYTE) DEFAULT 'no' CONSTRAINT wwv_mig_rpt_grp_form_fle CHECK (readfromfile in ('yes','no')),
  fileformat VARCHAR2(20 BYTE) DEFAULT 'text' CONSTRAINT wwv_mig_rpt_grp_form_fmt CHECK (fileformat in ('text','image','CGM',
                                                                'OracleDrawing','OracleImage',
                                                                'sound','video','OLE2','imageURL')),
  width VARCHAR2(4000 BYTE) DEFAULT '10',
  "SCALE" VARCHAR2(4000 BYTE) DEFAULT '0',
  "PRECISION" VARCHAR2(4000 BYTE) DEFAULT '0',
  templatesection VARCHAR2(10 BYTE) DEFAULT 'none' CONSTRAINT wwv_mig_rpt_grp_temp CHECK (templatesection in ('none','header','main','trailer')),
  defaultwidth VARCHAR2(4000 BYTE),
  defaultheight VARCHAR2(4000 BYTE),
  columnflags VARCHAR2(4000 BYTE),
  defaultlabel VARCHAR2(4000 BYTE),
  select_for_app VARCHAR2(1 BYTE) DEFAULT 'Y' NOT NULL CONSTRAINT wwv_mig_grpform_sel_for_app CHECK (select_for_app in ('Y', 'N')),
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
  CONSTRAINT wwv_mig_grp_form_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_mig_grp_form_id_fk FOREIGN KEY ("GROUP_ID") REFERENCES wwv_mig_rpt_datasrc_grp ("ID") ON DELETE CASCADE,
  CONSTRAINT wwv_mig_grp_form_sg_id_fk FOREIGN KEY (security_group_id) REFERENCES wwv_flow_companies (provisioning_company_id) ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";