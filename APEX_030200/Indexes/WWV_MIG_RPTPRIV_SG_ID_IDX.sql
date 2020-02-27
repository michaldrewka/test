CREATE INDEX wwv_mig_rptpriv_sg_id_idx ON wwv_mig_rpt_reportprivate(security_group_id)
NOCOMPRESS
PCTFREE 10 INITRANS 2 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";