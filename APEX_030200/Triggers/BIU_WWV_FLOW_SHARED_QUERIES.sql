CREATE OR REPLACE trigger biu_wwv_flow_shared_queries
  before insert or update on wwv_flow_shared_queries
  for each row
begin
    if inserting then
        if :new.id is null then
            :new.id := wwv_flow_id.next_val;
        end if;
	      :new.created_on := sysdate;
	      :new.created_by := v('USER');
    end if;
    --
    -- vpd
    --
    if :new.security_group_id is null then
       :new.security_group_id := nvl(wwv_flow_security.g_security_group_id,0);
    end if;
    --
    -- last updated
    --
    if not wwv_flow.g_import_in_progress then
        :new.last_updated_on := sysdate;
        :new.last_updated_by := wwv_flow.g_user;
        update wwv_flows set
           last_updated_on = sysdate,
           last_updated_by = wwv_flow.g_user
        where
           id = :new.flow_id and
           security_group_id = :new.security_group_id;
    end if;
end;
/