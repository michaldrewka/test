CREATE OR REPLACE function apex_application_get_pg_tname (
    p_application_id   in number,
    p_page_id  in number)
    return varchar2
is
    r varchar2(255) := null;
begin
    for c1 in (
       select process_sql_clob
       from   wwv_flow_step_processing p,
              wwv_flows f,
              wwv_flow_companies w,
              (select nvl(v('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
       where  (f.owner = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = f.security_group_id) and
              f.security_group_id = w.PROVISIONING_COMPANY_ID and
              f.security_group_id = p.security_group_id and
              f.id = p.flow_id and
              p.flow_id = p_application_id and
              p.flow_step_id = p_page_id and
              p.PROCESS_TYPE = 'DML_FETCH_ROW'
              ) loop
       r := dbms_lob.substr(c1.process_sql_clob,255,1);
       r := substr(r,instr(r,':')+1);
       r := substr(r,1,instr(r,':')-1);
       exit;
    end loop;
    return r;
end;
/