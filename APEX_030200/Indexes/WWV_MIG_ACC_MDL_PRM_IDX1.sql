CREATE INDEX wwv_mig_acc_mdl_prm_idx1 ON wwv_mig_acc_modules_perm(moduleid)
NOCOMPRESS
PCTFREE 10 INITRANS 2 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";