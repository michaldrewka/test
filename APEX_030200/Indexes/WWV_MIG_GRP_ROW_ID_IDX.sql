CREATE INDEX wwv_mig_grp_row_id_idx ON wwv_mig_rpt_grp_rowdelim("GROUP_ID")
NOCOMPRESS
PCTFREE 10 INITRANS 2 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";