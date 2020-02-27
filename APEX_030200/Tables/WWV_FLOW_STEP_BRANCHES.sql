CREATE TABLE wwv_flow_step_branches (
  "ID" NUMBER NOT NULL,
  flow_id NUMBER NOT NULL,
  flow_step_id NUMBER,
  branch_action VARCHAR2(4000 BYTE),
  branch_point VARCHAR2(30 BYTE) CONSTRAINT valid_fsbranch_point CHECK (branch_point in (
                      'BEFORE_HEADER',
                      'BEFORE_COMPUTATION',
                      'BEFORE_VALIDATION',
                      'BEFORE_PROCESSING',
                      'AFTER_PROCESSING')),
  branch_when_button_id NUMBER,
  branch_type VARCHAR2(255 BYTE) NOT NULL CONSTRAINT valid_fsbranch_branchtype CHECK (branch_type in (
                      'BRANCH_TO_FUNCTION_RETURNING_PAGE',
                      'BRANCH_TO_FUNCTION_RETURNING_URL',
                      'BRANCH_TO_PAGE_IDENT_BY_ITEM',
                      'BRANCH_TO_URL_IDENT_BY_ITEM',
                      'BRANCH_TO_STEP',
                      'BRANCH_TO_PAGE_ACCEPT',
                      'PLSQL',
                      'REDIRECT_URL',
                      'BRANCH_TO_ENTRY_POINT',
                      'BRANCH_TO_ENTRY_POINT_IDENT_BY_ITEM')),
  branch_sequence NUMBER,
  clear_page_cache VARCHAR2(4000 BYTE),
  save_state_before_branch_yn VARCHAR2(1 BYTE) CONSTRAINT wwv_flow_step_branches_svstate CHECK (save_state_before_branch_yn in ('Y','N')),
  branch_condition_type VARCHAR2(255 BYTE),
  branch_condition VARCHAR2(4000 BYTE),
  branch_condition_text VARCHAR2(4000 BYTE),
  required_patch NUMBER,
  security_scheme VARCHAR2(255 BYTE),
  security_group_id NUMBER NOT NULL,
  last_updated_by VARCHAR2(255 BYTE),
  last_updated_on DATE,
  branch_comment VARCHAR2(4000 BYTE),
  CONSTRAINT wwv_flow_step_branches_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_flow_step_branches_fk FOREIGN KEY (flow_id) REFERENCES wwv_flows ("ID") ON DELETE CASCADE,
  CONSTRAINT wwv_flow_step_branches_fk2 FOREIGN KEY (flow_id,flow_step_id) REFERENCES wwv_flow_steps (flow_id,"ID") ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";