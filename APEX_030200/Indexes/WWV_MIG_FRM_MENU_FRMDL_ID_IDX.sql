CREATE INDEX wwv_mig_frm_menu_frmdl_id_idx ON wwv_mig_frm_fmb_menu(formmodule_id)
NOCOMPRESS
PCTFREE 10 INITRANS 2 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";