CREATE OR REPLACE trigger wwv_flows_biu_html_repo
    before insert or update on wwv_flow_html_repository
    for each row
begin
    :new.upper_html_name := upper(:new.html_name);
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
      :new.html_tag := '#IMAGE_PREFIX#' || :new.html_name;
    else
      if :new.flow_id = 0 then
        :new.html_tag := '#COMPANY_IMAGES#' || :new.html_name;
      else
        :new.html_tag := '#FLOW_IMAGES#' || :new.html_name;
      end if;
    end if;
end;
/