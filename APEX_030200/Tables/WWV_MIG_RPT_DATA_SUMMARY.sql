CREATE TABLE wwv_mig_rpt_data_summary (
  "ID" NUMBER NOT NULL,
  data_id NUMBER NOT NULL,
  security_group_id NUMBER NOT NULL,
  "NAME" VARCHAR2(4000 BYTE),
  "SOURCE" VARCHAR2(4000 BYTE),
  "FUNCTION" VARCHAR2(15 BYTE) DEFAULT 'sum' CONSTRAINT wwv_mig_repsum_func CHECK ("FUNCTION" in ('sum','average','median',
                                                              'minimum','maximum','count',
                                                              'first','last','percentOfTotal',
                                                              'percentile','stdDeviation','variance')),
  width VARCHAR2(4000 BYTE) DEFAULT '10',
  "SCALE" VARCHAR2(4000 BYTE) DEFAULT '0',
  "PRECISION" VARCHAR2(4000 BYTE) DEFAULT '0',
  "COMPUTE" VARCHAR2(4000 BYTE),
  "RESET" VARCHAR2(4000 BYTE),
  productorder VARCHAR2(4000 BYTE),
  valueifnull VARCHAR2(4000 BYTE),
  readfromfile VARCHAR2(3 BYTE) DEFAULT 'no' CONSTRAINT wwv_mig_repsum_read CHECK (readfromfile in ('yes','no')),
  fileformat VARCHAR2(15 BYTE) DEFAULT 'text' CONSTRAINT wwv_mig_repsum_format CHECK (fileformat in ('text','image','CGM',
                                                                'OracleDrawing','OracleImage',
                                                                'sound','video','OLE2','imageURL')),
  nullval VARCHAR2(4000 BYTE),
  defaultwidth VARCHAR2(4000 BYTE),
  defaultheight VARCHAR2(4000 BYTE),
  columnflags VARCHAR2(4000 BYTE),
  defaultlabel VARCHAR2(4000 BYTE),
  select_for_app VARCHAR2(1 BYTE) DEFAULT 'Y' NOT NULL CONSTRAINT wwv_mig_repsum_select_for_app CHECK (select_for_app in ('Y', 'N')),
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
  CONSTRAINT wwv_mig_repsum_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_mig_repsum_id_fk FOREIGN KEY (data_id) REFERENCES wwv_mig_rpt_data ("ID") ON DELETE CASCADE,
  CONSTRAINT wwv_mig_repsum_sg_id_fk FOREIGN KEY (security_group_id) REFERENCES wwv_flow_companies (provisioning_company_id) ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";