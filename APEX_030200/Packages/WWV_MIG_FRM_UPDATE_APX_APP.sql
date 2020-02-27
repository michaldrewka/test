CREATE OR REPLACE PACKAGE wwv_mig_frm_update_apx_app
AS

PROCEDURE update_page_plug (
    p_flow_id                           IN  NUMBER,
    p_model_id                          IN  NUMBER,
    p_project_id                        IN  NUMBER,
    p_security_group_id                 IN  NUMBER
);

PROCEDURE set_apex_app_logo (
    p_app_name                          IN VARCHAR2,
    p_flow_id                           IN NUMBER,
    p_security_group_id                 IN NUMBER
);

PROCEDURE update_forms_pages (
    p_flow_id                           IN  NUMBER,
    p_model_id                          IN  NUMBER,
    p_project_id                        IN  NUMBER,
    p_security_group_id                 IN  NUMBER
);

end wwv_mig_frm_update_apx_app;
/