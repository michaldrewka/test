CREATE OR REPLACE PACKAGE wwv_flow_sample_app
IS

PROCEDURE remove_and_create_sample_app
  (v_owner IN VARCHAR2, v_security_group_id IN NUMBER, v_offset NUMBER, v_flow_id IN NUMBER);

PROCEDURE create_sample_app
  (v_flow_id IN NUMBER, v_security_group_id IN NUMBER, v_offset_id IN NUMBER, v_owner IN VARCHAR2);

PROCEDURE remove_sample_app (v_security_group_id IN NUMBER);

PROCEDURE create_tables (v_owner IN VARCHAR2);

PROCEDURE remove_tables (v_owner IN VARCHAR2);

PROCEDURE populate_tables (v_owner IN VARCHAR2, v_security_group_id IN NUMBER, v_flow_id IN NUMBER);

procedure load_product_info (v_owner IN VARCHAR2, v_flow_id NUMBER);

END wwv_flow_sample_app;
/