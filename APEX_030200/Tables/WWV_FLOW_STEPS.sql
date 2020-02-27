CREATE TABLE wwv_flow_steps (
  "ID" NUMBER NOT NULL,
  flow_id NUMBER NOT NULL,
  tab_set VARCHAR2(255 BYTE),
  "NAME" VARCHAR2(255 BYTE) NOT NULL,
  "ALIAS" VARCHAR2(255 BYTE),
  page_component_map VARCHAR2(255 BYTE),
  step_title VARCHAR2(255 BYTE),
  step_sub_title VARCHAR2(255 BYTE),
  step_sub_title_type VARCHAR2(30 BYTE) CONSTRAINT valid_fsteps_subtitletype CHECK (step_sub_title_type in (
                        'NO_DISPLAY_FOR_CUSTOM_LOOK1',
                        'NO_DISPLAY_FOR_CUSTOM_LOOK2',
                        'NO_DISPLAY_FOR_CUSTOM_LOOK3',
                        'DISPLAY_FOR_CUSTOM_LOOK1_ONLY',
                        'DISPLAY_FOR_CUSTOM_LOOK2_ONLY',
                        'DISPLAY_FOR_CUSTOM_LOOK3_ONLY',
                        'TEXT_WITH_SUBSTITUTIONS',
                        'SQL_EXPRESSION',
                        'SQL_EXPRESION')),
  first_item VARCHAR2(255 BYTE),
  include_apex_css_js_yn VARCHAR2(1 BYTE),
  welcome_text VARCHAR2(4000 BYTE),
  box_welcome_text VARCHAR2(4000 BYTE),
  box_footer_text VARCHAR2(4000 BYTE),
  footer_text VARCHAR2(4000 BYTE),
  help_text CLOB,
  step_template NUMBER,
  box_image VARCHAR2(255 BYTE),
  required_role VARCHAR2(255 BYTE),
  required_patch NUMBER,
  html_page_header CLOB,
  html_page_onload VARCHAR2(4000 BYTE),
  allow_duplicate_submissions VARCHAR2(1 BYTE) CONSTRAINT valid_all_dup_page_sub CHECK (allow_duplicate_submissions in (
                              'Y',
                              'N')),
  on_dup_submission_goto_url VARCHAR2(4000 BYTE),
  page_is_public_y_n VARCHAR2(1 BYTE) CONSTRAINT wwv_flow_pages_pgpub_flag CHECK (page_is_public_y_n in ('Y','N')),
  protection_level VARCHAR2(1 BYTE) CONSTRAINT valid_fsteps_protection_level CHECK (protection_level in ('N','C','U','D')),
  security_group_id NUMBER NOT NULL,
  error_notification_text VARCHAR2(4000 BYTE),
  autocomplete_on_off VARCHAR2(3 BYTE),
  id2 NUMBER,
  cache_page_yn VARCHAR2(1 BYTE),
  cache_timeout_seconds NUMBER,
  cache_by_user_yn VARCHAR2(1 BYTE),
  cache_when_condition_type VARCHAR2(255 BYTE),
  cache_when_condition_e1 VARCHAR2(4000 BYTE),
  cache_when_condition_e2 VARCHAR2(4000 BYTE),
  created_on DATE,
  created_by VARCHAR2(255 BYTE),
  last_updated_by VARCHAR2(255 BYTE),
  last_updated_on DATE,
  "GROUP_ID" NUMBER,
  media_type VARCHAR2(255 BYTE),
  page_comment VARCHAR2(4000 BYTE),
  CONSTRAINT wwv_flow_steps_pk PRIMARY KEY (flow_id,"ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_flow_steps_fk FOREIGN KEY (flow_id) REFERENCES wwv_flows ("ID") ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX"
LOB (help_text) STORE AS BASICFILE (
  ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  NOCACHE LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT))
LOB (html_page_header) STORE AS BASICFILE (
  ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  CACHE READS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT));