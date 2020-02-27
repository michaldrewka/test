CREATE OR REPLACE trigger wwv_biu_install
    before insert or update on wwv_flow_install
    for each row
begin
    if inserting and :new.id is null then
        :new.id := wwv_flow_id.next_val;
    end if;

    if :new.flow_id is null then
       :new.flow_id := v('FB_FLOW_ID');
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
       if inserting then
          :new.created_by := nvl(wwv_flow.g_user,user);
          :new.created_on := sysdate;
       elsif updating then
          :new.last_updated_by := nvl(wwv_flow.g_user,user);
          :new.last_updated_on := sysdate;
       end if;
       update wwv_flows set
           last_updated_on = sysdate,
           last_updated_by = wwv_flow.g_user
        where
           id = :new.flow_id and
           security_group_id = :new.security_group_id;
    end if;

    :new.prompt_substitution_01_yn := nvl(:new.prompt_substitution_01_yn, 'N');
    :new.prompt_substitution_02_yn := nvl(:new.prompt_substitution_02_yn, 'N');
    :new.prompt_substitution_03_yn := nvl(:new.prompt_substitution_03_yn, 'N');
    :new.prompt_substitution_04_yn := nvl(:new.prompt_substitution_04_yn, 'N');
    :new.prompt_substitution_05_yn := nvl(:new.prompt_substitution_05_yn, 'N');
    :new.prompt_substitution_06_yn := nvl(:new.prompt_substitution_06_yn, 'N');
    :new.prompt_substitution_07_yn := nvl(:new.prompt_substitution_07_yn, 'N');
    :new.prompt_substitution_08_yn := nvl(:new.prompt_substitution_08_yn, 'N');
    :new.prompt_substitution_09_yn := nvl(:new.prompt_substitution_09_yn, 'N');
    :new.prompt_substitution_10_yn := nvl(:new.prompt_substitution_10_yn, 'N');
    :new.prompt_substitution_11_yn := nvl(:new.prompt_substitution_11_yn, 'N');
    :new.prompt_substitution_12_yn := nvl(:new.prompt_substitution_12_yn, 'N');
    :new.prompt_substitution_13_yn := nvl(:new.prompt_substitution_13_yn, 'N');
    :new.prompt_substitution_14_yn := nvl(:new.prompt_substitution_14_yn, 'N');
    :new.prompt_substitution_15_yn := nvl(:new.prompt_substitution_15_yn, 'N');
    :new.prompt_substitution_16_yn := nvl(:new.prompt_substitution_16_yn, 'N');
    :new.prompt_substitution_17_yn := nvl(:new.prompt_substitution_17_yn, 'N');
    :new.prompt_substitution_18_yn := nvl(:new.prompt_substitution_18_yn, 'N');
    :new.prompt_substitution_19_yn := nvl(:new.prompt_substitution_19_yn, 'N');
    :new.prompt_substitution_20_yn := nvl(:new.prompt_substitution_20_yn, 'N');

end;
/