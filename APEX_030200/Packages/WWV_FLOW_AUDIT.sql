CREATE OR REPLACE package wwv_flow_audit as

    g_cascade boolean := false;

procedure audit_action (
    p_table_name              in varchar2,
    p_action                  in varchar2,
    p_table_pk                in number)
    ;

procedure remove_audit_trail (
    p_flow_id                 in number)
    ;

end wwv_flow_audit;
/