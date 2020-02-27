CREATE INDEX wwv_mig_olb_olt_bit_itm_id_idx ON wwv_mig_olb_olt_blk_item_trigr(item_id)
NOCOMPRESS
PCTFREE 10 INITRANS 2 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";