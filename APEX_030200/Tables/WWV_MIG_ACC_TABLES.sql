CREATE TABLE wwv_mig_acc_tables (
  "ID" NUMBER NOT NULL,
  project_id NUMBER,
  security_group_id NUMBER,
  dbid NUMBER NOT NULL,
  tblid NUMBER(11) NOT NULL,
  tblname VARCHAR2(400 BYTE),
  primarykey NUMBER(1),
  cnvtablestruct NUMBER(1),
  cnvmovedata NUMBER(1),
  cnvri NUMBER(1),
  cnvvalidation NUMBER(1),
  cnvdefault NUMBER(1),
  cnvaddtimestamp NUMBER(1),
  attachtablebacktoaccess NUMBER(1),
  savepassword NUMBER(1),
  cnvmakeupdateable NUMBER(1),
  retainlocalcopy NUMBER(1),
  syncwithserver NUMBER(1),
  ownerid NUMBER(11),
  validationtext VARCHAR2(4000 BYTE),
  validationrule VARCHAR2(4000 BYTE),
  numberofrows NUMBER(11),
  cachingtable NUMBER(1),
  description VARCHAR2(4000 BYTE),
  "ATTRIBUTES" NUMBER(11),
  conflicttable NUMBER(11),
  datecreated DATE,
  lastupdated DATE,
  recordcount NUMBER,
  orderbyon NUMBER(1),
  replicafilter NUMBER(11),
  sourcetablename VARCHAR2(1000 BYTE),
  "UPDATABLE" NUMBER,
  created_on DATE,
  created_by VARCHAR2(400 BYTE),
  last_updated_on DATE,
  last_updated_by VARCHAR2(400 BYTE),
  CONSTRAINT wwv_flow_acc_tbl_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_mig_acc_tables_uk1 UNIQUE (project_id,dbid,tblid) USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_mig_acc_tbl_dbid_fk FOREIGN KEY (project_id,dbid) REFERENCES wwv_mig_access (project_id,dbid) ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";