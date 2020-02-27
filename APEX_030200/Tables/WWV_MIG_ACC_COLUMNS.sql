CREATE TABLE wwv_mig_acc_columns (
  "ID" NUMBER NOT NULL,
  project_id NUMBER,
  security_group_id NUMBER,
  dbid NUMBER NOT NULL,
  colid NUMBER(11) NOT NULL,
  tblid NUMBER(11),
  colname VARCHAR2(400 BYTE),
  coltype NUMBER(3),
  coltypedesc VARCHAR2(2000 BYTE),
  colautoincr NUMBER(1),
  nextcountervalue NUMBER(11),
  maxlengthsource NUMBER(11),
  avglengthsource NUMBER(11),
  coltextsize NUMBER(5),
  allowzerolength NUMBER(1),
  defaultvalue VARCHAR2(4000 BYTE),
  colrequired NUMBER(1),
  colcollatingorder NUMBER(11),
  colordposition NUMBER(3),
  validationrule VARCHAR2(4000 BYTE),
  validationtext VARCHAR2(4000 BYTE),
  columndescription VARCHAR2(4000 BYTE),
  columnhidden NUMBER,
  columnorder NUMBER,
  columnwidth NUMBER(11),
  decimalplaces NUMBER,
  foreignname VARCHAR2(1000 BYTE),
  validateonset NUMBER,
  created_on DATE,
  created_by VARCHAR2(400 BYTE),
  last_updated_on DATE,
  last_updated_by VARCHAR2(400 BYTE),
  CONSTRAINT wwv_mig_acc_col_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_mig_acc_col_dbid_fk FOREIGN KEY (project_id,dbid,tblid) REFERENCES wwv_mig_acc_tables (project_id,dbid,tblid) ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";