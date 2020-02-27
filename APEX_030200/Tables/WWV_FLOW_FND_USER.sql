CREATE TABLE wwv_flow_fnd_user (
  user_id NUMBER NOT NULL,
  user_name VARCHAR2(100 BYTE) NOT NULL,
  first_name VARCHAR2(255 BYTE),
  last_name VARCHAR2(255 BYTE),
  known_as VARCHAR2(255 BYTE),
  last_update_date DATE NOT NULL,
  last_updated_by VARCHAR2(255 BYTE),
  creation_date DATE NOT NULL,
  created_by VARCHAR2(255 BYTE),
  start_date DATE,
  end_date DATE,
  description VARCHAR2(240 BYTE),
  password_date DATE,
  password_accesses_left NUMBER(15),
  password_lifespan_accesses NUMBER(15),
  password_lifespan_days NUMBER(15),
  employee_id NUMBER(15),
  person_type VARCHAR2(1 BYTE),
  email_address VARCHAR2(240 BYTE),
  person_id NUMBER,
  security_group_id NUMBER NOT NULL,
  web_password VARCHAR2(255 BYTE),
  web_password2 RAW(255),
  web_password_raw RAW(255),
  default_schema VARCHAR2(30 BYTE),
  allow_access_to_schemas VARCHAR2(4000 BYTE),
  attribute_01 VARCHAR2(4000 BYTE),
  attribute_02 VARCHAR2(4000 BYTE),
  attribute_03 VARCHAR2(4000 BYTE),
  attribute_04 VARCHAR2(4000 BYTE),
  attribute_05 VARCHAR2(4000 BYTE),
  attribute_06 VARCHAR2(4000 BYTE),
  attribute_07 VARCHAR2(4000 BYTE),
  attribute_08 VARCHAR2(4000 BYTE),
  attribute_09 VARCHAR2(4000 BYTE),
  attribute_10 VARCHAR2(4000 BYTE),
  last_login DATE,
  builder_login_count NUMBER,
  last_agent VARCHAR2(4000 BYTE),
  last_ip VARCHAR2(4000 BYTE),
  account_locked VARCHAR2(1 BYTE) CONSTRAINT fnd_user_account_locked CHECK (account_locked in ('Y','N')),
  account_expiry DATE,
  failed_access_attempts NUMBER,
  last_failed_login DATE,
  first_password_use_occurred VARCHAR2(1 BYTE) CONSTRAINT fnd_user_first_pw_use CHECK (first_password_use_occurred in ('Y','N')),
  change_password_on_first_use VARCHAR2(1 BYTE) CONSTRAINT fnd_user_change_pw_on_first CHECK (change_password_on_first_use in ('Y','N')),
  CONSTRAINT wwv_flow_fnd_user_pk UNIQUE (user_id) USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_flow_fnd_user_fk FOREIGN KEY (security_group_id) REFERENCES wwv_flow_companies (provisioning_company_id) ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";