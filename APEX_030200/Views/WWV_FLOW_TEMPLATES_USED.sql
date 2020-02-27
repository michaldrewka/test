CREATE OR REPLACE FORCE VIEW wwv_flow_templates_used (flow_id,temp_type,"ID","NAME",theme_id,theme_class_id) AS
select t."FLOW_ID",t."TEMP_TYPE",t."ID", a.name, to_char(a.theme_id),a.theme_class_id from (
select flow_id, 'PAGE' temp_type ,to_char(step_template) id from wwv_flow_steps where step_template is not null
-- region
union all
select flow_id, 'REGION', to_char(plug_template) from wwv_flow_page_plugs where (plug_template != 0 and plug_template is not null)
-- report
union all
select flow_id,'REPORT',to_char(plug_query_row_template) from wwv_flow_page_plugs where (plug_query_row_template not in (1,2,3) and plug_query_row_template is not null)
-- list
union all
select flow_id,'LIST',to_char(list_template_id) from wwv_flow_page_plugs where list_template_id is not null
--select flow_id, 'LIST',display_row_template_id from wwv_flow_lists where display_row_template_id is not null
-- label
union all
select flow_id, 'LABEL',to_char(item_field_template) from wwv_flow_step_items where item_field_template is not null
-- button
union all
select flow_id,'BUTTON',to_char(nvl(button_image,'-99')) id from (select flow_id,substr(button_image,10) button_image from wwv_flow_step_buttons where substr(button_image,1,9) = 'template:')
union all
select flow_id,'BUTTON',to_char(nvl(tag_attributes,'-99')) id from (select flow_id,substr(tag_attributes,10) tag_attributes from wwv_flow_step_items where substr(tag_attributes,1,9) = 'template:')
-- menu
union all
select flow_id,'MENU',to_char(menu_template_id) from wwv_flow_page_plugs where menu_template_id is not null
-- calendar
union all
select flow_id, 'CALENDAR',to_char(template_id) from wwv_flow_cals where template_id is not null
-- default page template
union all
select id, 'PAGE' temp_type, to_char(default_page_template) from wwv_flows
) t, wwv_flow_templates_all a where a.temp_type = t.temp_type and a.id = t.id;