CREATE INDEX wwv_mig_frm_rev_lcm_sg_idx ON wwv_mig_frm_rev_lovcolmaps(security_group_id)
NOCOMPRESS
PCTFREE 10 INITRANS 2 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";