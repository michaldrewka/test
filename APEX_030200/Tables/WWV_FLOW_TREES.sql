CREATE TABLE wwv_flow_trees (
  "ID" NUMBER NOT NULL,
  flow_id NUMBER NOT NULL,
  tree_name VARCHAR2(255 BYTE) NOT NULL,
  tree_type VARCHAR2(30 BYTE) CONSTRAINT wwv_flow_tree_type CHECK (tree_type in ('DYNAMIC','STATIC')),
  tree_query VARCHAR2(4000 BYTE),
  flow_item VARCHAR2(255 BYTE),
  security_group_id NUMBER NOT NULL,
  max_levels NUMBER NOT NULL CONSTRAINT wwv_flow_valid_level CHECK (max_levels between 1 and 100),
  unexpanded_parent VARCHAR2(4000 BYTE),
  unexpanded_parent_last VARCHAR2(4000 BYTE),
  expanded_parent VARCHAR2(4000 BYTE),
  expanded_parent_last VARCHAR2(4000 BYTE),
  leaf_node VARCHAR2(4000 BYTE),
  leaf_node_last VARCHAR2(4000 BYTE),
  drill_up VARCHAR2(4000 BYTE),
  name_link_anchor_tag VARCHAR2(4000 BYTE),
  name_link_not_anchor_tag VARCHAR2(4000 BYTE),
  indent_vertical_line VARCHAR2(4000 BYTE),
  indent_vertical_line_last VARCHAR2(4000 BYTE),
  before_tree VARCHAR2(4000 BYTE),
  after_tree VARCHAR2(4000 BYTE),
  level_1_template VARCHAR2(4000 BYTE),
  level_2_template VARCHAR2(4000 BYTE),
  level_3_template VARCHAR2(4000 BYTE),
  level_4_template VARCHAR2(4000 BYTE),
  level_5_template VARCHAR2(4000 BYTE),
  level_6_template VARCHAR2(4000 BYTE),
  level_7_template VARCHAR2(4000 BYTE),
  level_8_template VARCHAR2(4000 BYTE),
  last_updated_by VARCHAR2(255 BYTE),
  last_updated_on DATE,
  tree_comment VARCHAR2(4000 BYTE),
  CONSTRAINT wwv_flow_tree_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_flow_tree_fk FOREIGN KEY (flow_id) REFERENCES wwv_flows ("ID") ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";