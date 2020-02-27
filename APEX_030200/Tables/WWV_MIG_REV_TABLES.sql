CREATE TABLE wwv_mig_rev_tables (
  "ID" NUMBER NOT NULL,
  project_id NUMBER,
  dbid NUMBER,
  tblid NUMBER(11) NOT NULL,
  security_group_id NUMBER,
  primarykey_name VARCHAR2(400 BYTE),
  orig_table_name VARCHAR2(400 BYTE),
  mig_table_name VARCHAR2(400 BYTE),
  "OWNER" VARCHAR2(400 BYTE),
  status VARCHAR2(400 BYTE),
  created_on DATE,
  created_by VARCHAR2(400 BYTE),
  last_updated_on DATE,
  last_updated_by VARCHAR2(400 BYTE),
  CONSTRAINT wwv_flow_rev_tbl_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_mig_rev_tbl_fk FOREIGN KEY (project_id,dbid,tblid) REFERENCES wwv_mig_acc_tables (project_id,dbid,tblid) ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";