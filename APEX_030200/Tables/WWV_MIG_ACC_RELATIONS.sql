CREATE TABLE wwv_mig_acc_relations (
  "ID" NUMBER NOT NULL,
  project_id NUMBER,
  security_group_id NUMBER,
  dbid NUMBER NOT NULL,
  relid NUMBER NOT NULL,
  relname VARCHAR2(400 BYTE),
  parenttblid NUMBER,
  childtblid NUMBER,
  isunique NUMBER,
  isenforced NUMBER,
  isinherited NUMBER,
  isupdatecascade NUMBER,
  isdeletecascade NUMBER,
  cnvrelation NUMBER,
  date_created DATE,
  date_modified DATE,
  created_on DATE,
  created_by VARCHAR2(400 BYTE),
  last_updated_on DATE,
  last_updated_by VARCHAR2(400 BYTE),
  CONSTRAINT wwv_mig_acc_tab_rel_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_mig_acc_relations_uk1 UNIQUE (project_id,dbid,relid) USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_mig_acc_rel_dbid_fk FOREIGN KEY (project_id,dbid) REFERENCES wwv_mig_access (project_id,dbid) ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";