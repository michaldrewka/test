CREATE OR REPLACE package wwv_flow_sc_transactions as

function add_trans(p_session in number,
                    p_user in varchar2,
                    p_schema in varchar2,
                    p_type in varchar2,
                    p_rows in number,
                    p_binds in varchar2,
                    p_sql in varchar2) return number;

procedure set_identifier(p_client_id in varchar2);

procedure set_client(p_user in varchar2);

procedure set_mod(p_mod in varchar2, p_sql in varchar2);

procedure set_action(p_name in varchar2);

procedure sc_job (p_session in number, p_user in varchar2);

end;
/