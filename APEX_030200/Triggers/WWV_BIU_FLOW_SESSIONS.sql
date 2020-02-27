CREATE OR REPLACE trigger wwv_biu_flow_sessions
    before insert or update on wwv_flow_sessions$
    for each row
begin
    --
    -- note: new.id is typically never null on insert
    --
    if inserting and :new.id is null then
        :new.id := wwv_flow_id.next_val;
    end if;

    --
    --
    --
    if inserting then
        if :new.created_by is null then
            :new.created_by := user;
        end if;
			  if wwv_flow_utilities.db_version_is_at_least('10.1.0.3') then -- for 10.1.0.3 or higher database with dbms_crypto
			  	  wwv_flow_security.g_crypto_salt := wwv_flow_security.crypto_randombytes(p_numbytes => 32);
				else -- for pre 10.1.0.3 database w/o dbms_crypto
            --wwv_flow_security.g_crypto_salt := utl_raw.cast_to_raw(wwv_flow_element.g_element);
             wwv_flow_security.g_crypto_salt := wwv_flow_security.crypto_randombytes;
			  end if;
        if :new.session_id_hashed is null then
            :new.session_id_hashed := wwv_flow_security.hash_session_id;
            begin
                :new.ip_address := rawtohex(wwv_flow_security.g_crypto_salt);
            exception when others then
                :new.ip_address := null;
            end;
        end if;
        :new.created_on := sysdate;
        :new.last_changed := sysdate;
        if :new.remote_addr is null then
           :new.remote_addr := wwv_flow.g_remote_addr;
        end if;
    end if;

    --
    -- vpd
    --
    if :new.security_group_id is null then
       :new.security_group_id := nvl(wwv_flow_security.g_security_group_id,0);
    end if;
end;
/