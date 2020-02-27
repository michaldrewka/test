CREATE OR REPLACE procedure wwv_flow_copy_button (
    p_button_id_from         in number,
    p_button_name_to         in varchar2,
    p_button_text_to         in varchar2,
    p_button_page_id_to      in number default null,
    p_button_region_to       in number default null,
    p_button_sequence_to     in number default null)

--  Copyright (c) Oracle Corporation 2001. All Rights Reserved.
--
--    DESCRIPTION
--      Copy one flow button to another
--
--    SECURITY
--
--
--    NOTES
--      This is called from with the flow builder HTML designer.
--

is
    l_last  varchar2(255) := null;
begin
    --
    -- WWV_FLOW_PAGE_PLUGS
    --
    l_last := 'WWV_FLOW_STEP_BUTTONS';
    for c1 in (select * from wwv_flow_step_buttons where id = p_button_id_from ) loop
        insert into  wwv_flow_step_buttons (
           ID,
           FLOW_ID,
           FLOW_STEP_ID,
           BUTTON_SEQUENCE,
           BUTTON_PLUG_ID,
           BUTTON_NAME,
           BUTTON_IMAGE,
           BUTTON_IMAGE_ALT,
           BUTTON_POSITION,
           BUTTON_REDIRECT_URL,
           BUTTON_CONDITION,
           BUTTON_CONDITION2,
           BUTTON_CONDITION_TYPE,
           BUTTON_IMAGE_ATTRIBUTES,
           REQUIRED_PATCH,
           SECURITY_SCHEME,
           BUTTON_ALIGNMENT,
           BUTTON_CATTRIBUTES)
        values (
            null,
           c1.FLOW_ID,
           nvl(p_button_page_id_to,c1.flow_step_id),
           p_button_sequence_to,
           p_button_region_to,
           p_button_name_to,
           c1.BUTTON_IMAGE,
           p_button_text_to,
           c1.BUTTON_POSITION,
           c1.BUTTON_REDIRECT_URL,
           c1.BUTTON_CONDITION,
           c1.BUTTON_CONDITION2,
           c1.BUTTON_CONDITION_TYPE,
           c1.BUTTON_IMAGE_ATTRIBUTES,
           c1.REQUIRED_PATCH,
           c1.SECURITY_SCHEME,
           c1.BUTTON_ALIGNMENT,
           c1.BUTTON_CATTRIBUTES);
    end loop;
exception when others then
    rollback;
    raise_application_error (-20001,wwv_flow_lang.system_message('wwv_flow_copy_button.execution_err',l_last,sqlerrm));
end wwv_flow_copy_button;
/