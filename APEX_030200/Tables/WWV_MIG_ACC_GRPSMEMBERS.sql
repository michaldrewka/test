CREATE TABLE wwv_mig_acc_grpsmembers (
  "ID" NUMBER NOT NULL,
  project_id NUMBER,
  security_group_id NUMBER,
  dbid NUMBER NOT NULL,
  grpmbrid NUMBER NOT NULL,
  userid NUMBER NOT NULL,
  groupid NUMBER NOT NULL,
  date_created DATE,
  date_modified DATE,
  created_on DATE,
  created_by VARCHAR2(400 BYTE),
  last_updated_on DATE,
  last_updated_by VARCHAR2(400 BYTE),
  CONSTRAINT wwv_mig_accgrpmbr_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_mig_accgrpsmbr_grp_fk FOREIGN KEY (project_id,dbid,groupid) REFERENCES wwv_mig_acc_groups (project_id,dbid,groupid) ON DELETE CASCADE,
  CONSTRAINT wwv_mig_accgrpsmbr_usr_fk FOREIGN KEY (project_id,dbid,userid) REFERENCES wwv_mig_acc_users (project_id,dbid,userid) ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";