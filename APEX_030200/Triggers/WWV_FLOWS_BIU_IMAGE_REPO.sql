CREATE OR REPLACE trigger wwv_flows_biu_image_repo
    before insert or update on wwv_flow_image_repository
    for each row
begin
    :new.upper_image_name := upper(:new.image_name);
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
      :new.image_tag := '#IMAGE_PREFIX#' || :new.image_name;
    else
      if :new.flow_id = 0 then
        :new.image_tag := '#WORKSPACE_IMAGES#' || :new.image_name;
      else
        :new.image_tag := '#APP_IMAGES#' || :new.image_name;
      end if;
    end if;
end;
/