CREATE OR REPLACE trigger wwv_biu_flow_developers_audit
    before insert or update or delete on wwv_flow_developers
    for each row
declare
    l_action varchar2(1);
begin
    if inserting then l_action := 'I'; elsif updating then l_action := 'U'; else l_action := 'D'; end if;
    begin
    wwv_flow_audit.audit_action (
       p_table_name => 'WWV_FLOW_DEVELOPERS',
       p_action     => l_action,
       p_table_pk   => nvl(:old.id,:new.id));
    exception when others then null;
    end;
end;
/