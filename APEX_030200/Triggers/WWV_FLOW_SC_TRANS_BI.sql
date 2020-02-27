CREATE OR REPLACE TRIGGER wwv_flow_sc_trans_bi
    before insert or update on wwv_flow_sc_trans
    for each row
declare
  l_tid number;
begin
    -- set security group id if null
    if :new.security_group_id is null then
       :new.security_group_id := nvl(wwv_flow_security.g_security_group_id,0);
    end if;
    -- set t_id as I need to amintain the order of transactions as they occured
    if inserting and :new.transaction_id is null then
        select nvl(max(transaction_id),0)+1 into l_tid from wwv_flow_sc_trans where session_id = :new.session_id;
        :new.transaction_id := l_tid;
        :new.transaction_status := 'N';
        :new.created_on := sysdate;
    else
        :new.updated_on := sysdate;
    end if;
end;
/