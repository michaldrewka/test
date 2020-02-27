CREATE OR REPLACE trigger wwv_flows_biu_css_repo
    before insert or update on wwv_flow_css_repository
    for each row
begin
    :new.upper_css_name := upper(:new.css_name);
    --
    if inserting and :new.id is null then
        :new.id := wwv_flow_id.next_val;
    end if;
    --
    -- vpd
    --
    if :new.security_group_id is null then
       :new.security_group_id := nvl(wwv_flow_security.g_security_group_id,0);
    end if;
    --
    --
    if :new.security_group_id = 10 then
      :new.css_tag := '#IMAGE_PREFIX#' || :new.css_name;
    else
      :new.css_tag := '#COMPANY_IMAGES#' || :new.css_name;
    end if;
end;
/