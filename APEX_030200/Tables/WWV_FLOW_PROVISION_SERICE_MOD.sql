CREATE TABLE wwv_flow_provision_serice_mod (
  "ID" NUMBER NOT NULL,
  security_group_id NUMBER NOT NULL,
  service_name VARCHAR2(255 BYTE) CONSTRAINT wwv_flow_ck_service_name CHECK (service_name in (
                                 'NEW_SCHEMA',
                                 'REMOVE_EXISTING_SERVICE',
                                 'REMOVE_EXISTING_SCHEMA',
                                 'CHANGE_DB_SIZE',
                                 'CHANGE_COMPANY_NAME',
                                 'CHANGE_END_SERVICE_DATE',
                                 'CHANGE_ADMIN_EMAIL',
                                 'CHANGE_ADMIN_NAME',
                                 'CHANGE_COMPANY_ADDRESS',
                                 'CHANGE_MAX_END_USERS',
                                 'CHANGE_MAX_PG_VIEWS_DAY')),
  service_attribute_1 VARCHAR2(4000 BYTE),
  service_attribute_2 VARCHAR2(4000 BYTE),
  service_attribute_3 VARCHAR2(4000 BYTE),
  service_attribute_4 VARCHAR2(4000 BYTE),
  service_attribute_5 VARCHAR2(4000 BYTE),
  service_attribute_6 VARCHAR2(4000 BYTE),
  service_attribute_7 VARCHAR2(4000 BYTE),
  service_attribute_8 VARCHAR2(4000 BYTE),
  requested_on DATE NOT NULL,
  requested_by VARCHAR2(255 BYTE),
  last_status_change_on DATE,
  last_status_change_by VARCHAR2(255 BYTE),
  request_status VARCHAR2(255 BYTE) CONSTRAINT wwv_flow_ck_prov_smod_status CHECK (request_status in (
                                 'IN_PROGRESS',
                                 'REQUESTED',
                                 'DECLINED',
                                 'APPROVED')),
  request_work_log VARCHAR2(4000 BYTE),
  request_comments VARCHAR2(4000 BYTE),
  CONSTRAINT wwv_flowpk_prov_service_mod PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX"
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";