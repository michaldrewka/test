CREATE OR REPLACE trigger wwv_biu_flows_audit
    before insert or update or delete on wwv_flows
    for each row
declare
    l_action varchar2(1);
begin
    if inserting then
       l_action := 'I';
    elsif updating then
       -- skip audit procedure call if update is just updating the audit column
       if :new.last_updated_on <> :old.last_updated_on then
           return;
       end if;
       l_action := 'U';
    else
       l_action := 'D';
    end if;
    begin
    wwv_flow_audit.audit_action (
       p_table_name => 'WWV_FLOWS',
       p_action     => l_action,
       p_table_pk   => nvl(:old.id,:new.id));
    exception when others then null;
    end;
end;
/