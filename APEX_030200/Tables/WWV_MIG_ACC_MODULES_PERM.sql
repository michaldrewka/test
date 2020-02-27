CREATE TABLE wwv_mig_acc_modules_perm (
  "ID" NUMBER NOT NULL,
  project_id NUMBER,
  security_group_id NUMBER,
  dbid NUMBER NOT NULL,
  moduleid NUMBER(11),
  userid NUMBER(11),
  permissionid NUMBER(11) NOT NULL,
  "PERMISSION" NUMBER(11),
  permission_desc VARCHAR2(1000 BYTE),
  created_on DATE,
  created_by VARCHAR2(400 BYTE),
  last_updated_on DATE,
  last_updated_by VARCHAR2(400 BYTE),
  CONSTRAINT wwv_mig_acc_mdl_perm_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_mig_acc_mdl_fk FOREIGN KEY (project_id,dbid,moduleid) REFERENCES wwv_mig_acc_modules (project_id,dbid,moduleid) ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";