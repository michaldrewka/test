CREATE OR REPLACE trigger wwv_biu_flow_sw_detail_results
    before insert or update on wwv_flow_sw_detail_results
    for each row
begin
    if inserting and :new.id is null then
        :new.id := wwv_flow_id.next_val;
    end if;
    if inserting then
        :new.started := sysdate;
    elsif updating then
    	  :new.last_updated := sysdate;
    end if;
    -- vpd
    --
    if :new.security_group_id is null then
       :new.security_group_id := nvl(wwv_flow_security.g_security_group_id,0);
    end if;
end;
/