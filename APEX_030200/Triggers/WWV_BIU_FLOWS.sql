CREATE OR REPLACE trigger wwv_biu_flows
    before insert or update on wwv_flows
    for each row
begin
    if inserting and :new.id is null then
        :new.id := wwv_flow_id.next_val;
    end if;
    if :new.webdb_logging is null then
        :new.webdb_logging := 'YES';
    end if;
    if inserting and :new.home_link is null then
        :new.home_link := 'f?p='||:new.id;
    end if;
    :new.flow_language          := lower(:new.flow_language);
    :new.substitution_string_01 := upper(:new.substitution_string_01);
    :new.substitution_string_02 := upper(:new.substitution_string_02);
    :new.substitution_string_03 := upper(:new.substitution_string_03);
    :new.substitution_string_04 := upper(:new.substitution_string_04);
    :new.substitution_string_05 := upper(:new.substitution_string_05);
    :new.substitution_string_06 := upper(:new.substitution_string_06);
    :new.substitution_string_07 := upper(:new.substitution_string_07);
    :new.substitution_string_08 := upper(:new.substitution_string_08);
    :new.owner := upper(:new.owner);
    if :new.build_status is null then
       :new.build_status := 'RUN_AND_BUILD';
    end if;
    --
    if inserting and :new.global_id is null then
        :new.global_id := wwv_flow_id.next_val;
    end if;
    --
    -- trim white space
    --
    for i in 1..10 loop
        :new.CUSTOM_AUTHENTICATION_PROCESS  := rtrim(:new.CUSTOM_AUTHENTICATION_PROCESS );
        :new.CUSTOM_AUTHENTICATION_PROCESS  := rtrim(:new.CUSTOM_AUTHENTICATION_PROCESS ,chr(10));
        :new.CUSTOM_AUTHENTICATION_PROCESS  := rtrim(:new.CUSTOM_AUTHENTICATION_PROCESS ,chr(13));
    end loop;

    :new.alias := upper(:new.alias);

    if :new.alias is null then
       :new.alias := 'F'||:new.id;
    end if;

    if updating and :old.checksum_salt is null or :new.checksum_salt <> :old.checksum_salt then
        :new.checksum_salt_last_reset := sysdate;
    end if;

    if :new.alias is null then
       :new.alias := 'F'||:new.id;
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
    if user <> 'SYS' then
        :new.last_updated_on := sysdate;
        :new.last_updated_by := nvl(wwv_flow.g_user,user);
    end if;
end;
/