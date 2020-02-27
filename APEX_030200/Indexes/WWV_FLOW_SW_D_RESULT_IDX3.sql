CREATE INDEX wwv_flow_sw_d_result_idx3 ON wwv_flow_sw_detail_results(security_group_id,result_id,file_id)
COMPRESS 2
PCTFREE 10 INITRANS 2 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";