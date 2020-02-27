CREATE INDEX wwv_flow_region_report_flt_idx ON wwv_flow_region_report_filter(region_id)
NOCOMPRESS
PCTFREE 10 INITRANS 2 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";