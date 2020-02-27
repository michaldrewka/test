CREATE TABLE wwv_flow_compound_conditions (
  "ID" NUMBER NOT NULL,
  flow_id NUMBER,
  condition_logical_operator VARCHAR2(255 BYTE) CONSTRAINT wwv_flow_comp_cond_oper CHECK (condition_logical_operator in ('OR','AND','NOR','NAND')),
  condition_disabled_y_n VARCHAR2(1 BYTE) CONSTRAINT wwv_flow_comp_cond_flag CHECK (condition_disabled_y_n in ('Y','N')),
  condition_term_count NUMBER NOT NULL,
  term1_cond_type VARCHAR2(255 BYTE),
  term1_cond_exp1 VARCHAR2(4000 BYTE),
  term1_cond_exp2 VARCHAR2(4000 BYTE),
  term2_cond_type VARCHAR2(255 BYTE),
  term2_cond_exp1 VARCHAR2(4000 BYTE),
  term2_cond_exp2 VARCHAR2(4000 BYTE),
  term3_cond_type VARCHAR2(255 BYTE),
  term3_cond_exp1 VARCHAR2(4000 BYTE),
  term3_cond_exp2 VARCHAR2(4000 BYTE),
  term4_cond_type VARCHAR2(255 BYTE),
  term4_cond_exp1 VARCHAR2(4000 BYTE),
  term4_cond_exp2 VARCHAR2(4000 BYTE),
  term5_cond_type VARCHAR2(255 BYTE),
  term5_cond_exp1 VARCHAR2(4000 BYTE),
  term5_cond_exp2 VARCHAR2(4000 BYTE),
  term6_cond_type VARCHAR2(255 BYTE),
  term6_cond_exp1 VARCHAR2(4000 BYTE),
  term6_cond_exp2 VARCHAR2(4000 BYTE),
  term7_cond_type VARCHAR2(255 BYTE),
  term7_cond_exp1 VARCHAR2(4000 BYTE),
  term7_cond_exp2 VARCHAR2(4000 BYTE),
  term8_cond_type VARCHAR2(255 BYTE),
  term8_cond_exp1 VARCHAR2(4000 BYTE),
  term8_cond_exp2 VARCHAR2(4000 BYTE),
  security_group_id NUMBER NOT NULL,
  last_updated_by VARCHAR2(255 BYTE) NOT NULL,
  last_updated_on DATE NOT NULL,
  CONSTRAINT wwv_flow_compound_conds_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_flow_comp_cond_fk FOREIGN KEY (flow_id) REFERENCES wwv_flows ("ID") ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";