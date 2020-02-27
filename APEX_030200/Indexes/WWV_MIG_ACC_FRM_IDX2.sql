CREATE INDEX wwv_mig_acc_frm_idx2 ON wwv_mig_acc_forms(dbid)
NOCOMPRESS
PCTFREE 10 INITRANS 2 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";