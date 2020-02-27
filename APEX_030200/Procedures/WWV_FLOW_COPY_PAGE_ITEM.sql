CREATE OR REPLACE procedure wwv_flow_copy_page_item (
    p_copy_from_item_id     in number,
    p_copy_to_item_name     in varchar2,
    p_copy_to_item_sequence in varchar2,
    p_copy_to_page_id       in number default null,
    p_copy_to_item_plug     in varchar2 default null,
    p_copy_to_prompt        in varchar2 default null,
    p_copy_to_source_type   in varchar2 default null,
    p_copy_to_source        in varchar2 default null)

--  Copyright (c) Oracle Corporation 1999 - 2009. All Rights Reserved.
--
--    DESCRIPTION
--      Copy one application page item to another
--
--    SECURITY
--
--
--    NOTES
--      This is called from with the flow builder HTML designer.
--

is
    l_last  varchar2(255) := null;
    l_id    number := null;
begin
    --
    -- WWV_FLOW_STEP_ITEMS
    --
    l_last := 'WWV_FLOW_STEP_ITEMS';
    for c1 in (
        select *
        from wwv_flow_step_items
        where id = p_copy_from_item_id ) loop
        insert into WWV_FLOW_STEP_ITEMS (
            id,
            flow_id,
            flow_step_id,
            name,
            name_length,
            data_type,
            accept_processing,
            item_sequence,
            item_plug_id,
            use_cache_before_default,
            item_default,
            item_default_type,
            prompt,
            pre_element_text,
            post_element_text,
            format_mask,
            source,
            source_type,
            source_post_computation,
            display_as,
            named_lov,
            lov,
            lov_columns,
            lov_display_null,
            lov_null_text,
            lov_null_value,
            lov_translated,
            lov_display_extra,
            cSize,
            cMaxlength,
            cHeight,
            cAttributes,
            cAttributes_element,
            tag_attributes,
            tag_attributes2,
            begin_on_new_line,
            begin_on_new_field,
            colspan,
            rowspan,
            label_alignment,
            field_alignment,
            display_when,
            display_when2,
            display_when_type,
            is_Persistent,
            security_scheme,
            required_patch,
            item_comment,
            button_image,
            button_image_attr,
            item_field_template,
            read_only_when,
            read_only_when2,
            read_only_when_type,
            read_only_disp_attr,
            protection_level,
            escape_on_http_input,
            encrypt_session_state_yn)
        values (
            null,
            c1.flow_id,
            nvl(p_copy_to_page_id,c1.flow_step_id),
            p_copy_to_item_name,
            c1.name_length,
            c1.data_type,
            c1.accept_processing,
            p_copy_to_item_sequence,
            replace(p_copy_to_item_plug,'%null%',null),
            c1.use_cache_before_default,
            c1.item_default,
            c1.item_default_type,
            p_copy_to_prompt,
            c1.pre_element_text,
            c1.post_element_text,
            c1.format_mask,
            p_copy_to_source,
            replace(p_copy_to_source_type,'%null%',null),
            c1.source_post_computation,
            c1.display_as,
            c1.named_lov,
            c1.lov,
            c1.lov_columns,
            c1.lov_display_null,
            c1.lov_null_text,
            c1.lov_null_value,
            c1.lov_translated,
            c1.lov_display_extra,
            c1.cSize,
            c1.cMaxlength,
            c1.cHeight,
            c1.cAttributes,
            c1.cAttributes_element,
            c1.tag_attributes,
            c1.tag_attributes2,
            c1.begin_on_new_line,
            c1.begin_on_new_field,
            c1.colspan,
            c1.rowspan,
            c1.label_alignment,
            c1.field_alignment,
            c1.display_when,
            c1.display_when2,
            c1.display_when_type,
            c1.is_Persistent,
            c1.security_scheme,
            c1.required_patch,
            c1.item_comment,
            c1.button_image,
            c1.button_image_attr,
            c1.item_field_template,
            c1.read_only_when,
            c1.read_only_when2,
            c1.read_only_when_type,
            c1.read_only_disp_attr,
            c1.protection_level,
            c1.escape_on_http_input,
            c1.encrypt_session_state_yn)
    returning id into l_id;

    -----------------
    -- copy item help
    --
    for c2 in (select help_text, reference_id
               from   wwv_flow_step_item_help
               where  flow_id = c1.flow_id
               and    flow_item_id = p_copy_from_item_id)
    loop
        insert into wwv_flow_step_item_help
        (flow_id, flow_item_id, help_text, reference_id)
        values
        (c1.flow_id, l_id, c2.help_text, c2.reference_id);
    end loop;
    end loop;
exception when others then
    rollback;
    raise_application_error (-20001,wwv_flow_lang.system_message('wwv_flow_copy_page_item.execution_err',l_last,sqlerrm));
end wwv_flow_copy_page_item;
/