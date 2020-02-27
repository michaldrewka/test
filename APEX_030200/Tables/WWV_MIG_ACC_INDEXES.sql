CREATE TABLE wwv_mig_acc_indexes (
  "ID" NUMBER NOT NULL,
  project_id NUMBER,
  security_group_id NUMBER,
  dbid NUMBER NOT NULL,
  indid NUMBER(11) NOT NULL,
  tblid NUMBER(11),
  indname VARCHAR2(1000 BYTE),
  cnvindex NUMBER(1),
  isprimary NUMBER(1),
  isunique NUMBER(1),
  isforeign NUMBER(1),
  ignorenulls NUMBER(1),
  isrequired NUMBER(1),
  distinctcount NUMBER,
  isclustered NUMBER,
  created_on DATE,
  created_by VARCHAR2(400 BYTE),
  last_updated_on DATE,
  last_updated_by VARCHAR2(400 BYTE),
  CONSTRAINT wwv_mig_acc_idx_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_mig_acc_indexes_uk1 UNIQUE (project_id,dbid,tblid,indid) USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_mig_acc_ind_dbid_fk FOREIGN KEY (project_id,dbid,tblid) REFERENCES wwv_mig_acc_tables (project_id,dbid,tblid) ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";