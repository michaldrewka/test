CREATE OR REPLACE trigger wwv_aiu_fnd_user
    after insert or update on wwv_flow_fnd_user
    for each row
declare
  l_hist_id number;
  l_found boolean;
begin
    if INSERTING and wwv_flow_fnd_user_api.g_password_save is not null then
				l_hist_id := wwv_flow_id.next_val;
		    insert into wwv_flow_password_history
		        (id, user_id, password, created, security_group_id)
		    values
		        (l_hist_id, :new.user_id, wwv_flow_fnd_user_api.g_password_save, trunc(sysdate), :new.security_group_id);
    elsif UPDATING and wwv_flow_fnd_user_api.g_password_save is not null then
				-- insert into history table only if this password with created date of today is not already saved
				l_found := false;
				for c1 in (select id into l_hist_id from wwv_flow_password_history
				    where user_id = :new.user_id and password = wwv_flow_fnd_user_api.g_password_save and created = trunc(sysdate) and security_group_id = :new.security_group_id) loop
				    l_found := true;
				    exit;
				end loop;
				if not l_found then
				    l_hist_id := wwv_flow_id.next_val;
				    insert into wwv_flow_password_history
				        (id, user_id, password, created, security_group_id)
				    values
				        (l_hist_id, :new.user_id, wwv_flow_fnd_user_api.g_password_save, trunc(sysdate), :new.security_group_id);
				end if;
    end if;
    wwv_flow_fnd_user_api.g_password_save := null;
end wwv_aiu_fnd_user;
/