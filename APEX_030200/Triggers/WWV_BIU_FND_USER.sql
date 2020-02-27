CREATE OR REPLACE trigger wwv_biu_fnd_user
    before insert or update on wwv_flow_fnd_user
    for each row
begin
    if inserting and :new.user_id is null then
        if :new.user_id is null then :new.user_id := wwv_flow_id.next_val; end if;
    end if;
    if inserting then
        :new.creation_date := sysdate;
        :new.created_by := nvl(wwv_flow.g_user,user);
    end if;
    if inserting and :new.account_expiry is null then
        :new.account_expiry := sysdate;
    end if;
    if :new.start_date is null then
        :new.start_date := sysdate;
    end if;
    if :new.end_date is null then
        :new.end_date := :new.start_date + (365*20);
    end if;
    :new.user_name := upper(:new.user_name);
    :new.allow_access_to_schemas := upper(:new.allow_access_to_schemas);
    :new.last_updated_by := nvl(wwv_flow.g_user,user);
    :new.last_update_date := sysdate;
    if :new.security_group_id is null then
       :new.security_group_id := nvl(wwv_flow_security.g_security_group_id,0);
    end if;
    :new.user_name := upper(:new.user_name);
    if INSERTING and :new.web_password is not null then
      if wwv_flow_fnd_user_pw_pref.web_password_format is null or
         wwv_flow_fnd_user_pw_pref.web_password_format = 'CLEAR_TEXT' then
         -- not hashed, so hash it
         :new.web_password2 := utl_raw.cast_to_raw(
             wwv_crypt.one_way_hash_str(:new.web_password||:new.security_group_id||:new.user_name));
         wwv_flow_fnd_user_api.g_password_save := utl_raw.cast_to_raw(wwv_crypt.one_way_hash_str(:new.web_password||:new.security_group_id));
         :new.web_password := null;
         :new.web_password_raw := null;
      elsif wwv_flow_fnd_user_pw_pref.web_password_format = 'HEX_ENCODED_DIGEST' then
         -- already hashed no need to do it again, however decode it
         :new.web_password := utl_raw.cast_to_varchar2(:new.web_password);
         if wwv_flow_api.g_fnd_user_password_action = true then
           :new.web_password_raw := utl_raw.cast_to_raw(:new.web_password);
         end if;
      elsif wwv_flow_fnd_user_pw_pref.web_password_format = 'HEX_ENCODED_DIGEST_V2' then
         -- apex v3.0 format already hashed with security group id and user name
         :new.web_password2 := :new.web_password;
         :new.web_password := null;
         :new.web_password_raw := null;
      elsif wwv_flow_fnd_user_pw_pref.web_password_format = 'DIGEST' then
         -- its already as you want it so do nothing
         null;
      end if;
    elsif UPDATING and :new.web_password is not null then
       if :old.web_password is null or :new.web_password != :old.web_password  then
		       if wwv_flow_fnd_user_pw_pref.web_password_format is null or
		          wwv_flow_fnd_user_pw_pref.web_password_format = 'CLEAR_TEXT' then
		          :new.web_password2 := utl_raw.cast_to_raw(
		              wwv_crypt.one_way_hash_str(:new.web_password||:new.security_group_id||:new.user_name));
              wwv_flow_fnd_user_api.g_password_save := utl_raw.cast_to_raw(wwv_crypt.one_way_hash_str(:new.web_password||:new.security_group_id));
		          :new.web_password := null;
		          :new.web_password_raw := null;
		          :new.account_expiry := sysdate;
		       end if;
		   end if;
    else
    	if :old.web_password2 is not null then
         :new.web_password2 := :old.web_password2;
    	   :new.web_password := null;
         :new.web_password_raw := null;
      elsif :old.web_password is not null then
      	 :new.web_password := :old.web_password;
      end if;
    end if;
end wwv_biu_fnd_user;
/