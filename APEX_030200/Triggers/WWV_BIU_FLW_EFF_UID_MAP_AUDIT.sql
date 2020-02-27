CREATE OR REPLACE trigger wwv_biu_flw_eff_uid_map_audit
    before insert or update or delete on wwv_flow_effective_userid_map
    for each row
declare
    l_action varchar2(1);
begin
    if inserting then l_action := 'I'; elsif updating then l_action := 'U'; else l_action := 'D'; end if;
    begin
    wwv_flow_audit.audit_action (
       p_table_name => 'WWV_FLOW_EFFECTIVE_USERID_MAP',
       p_action     => l_action,
       p_table_pk   => nvl(:old.id,:new.id));
    exception when others then null;
    end;
end;
/