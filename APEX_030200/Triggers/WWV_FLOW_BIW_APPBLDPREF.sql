CREATE OR REPLACE trigger wwv_flow_biw_appbldpref
before insert or update on  wwv_flow_app_build_pref
for each row
begin
  if inserting and :new.id is null then
     :new.id := wwv_flow_id.next_val;
  end if;
  if inserting then
     :new.created_on := sysdate;
     :new.created_by := v('USER');
  end if;
  if updating then
     :new.updated_on := sysdate;
     :new.updated_by := v('USER');
  end if;
  if :new.security_group_id is null then
     :new.security_group_id := nvl(wwv_flow_security.g_security_group_id,0);
  end if;
end;
/