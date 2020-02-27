CREATE OR REPLACE FORCE VIEW wwv_flow_templates_all (flow_id,theme_id,theme_class_id,temp_type,"NAME","ID") AS
select flow_id, theme_id, theme_class_id, 'PAGE' temp_type, name ,id from wwv_flow_templates -- page
union all
select flow_id, theme_id, theme_class_id, 'REGION' temp_type, PAGE_PLUG_TEMPLATE_NAME ,id from wwv_flow_page_plug_templates -- region
union all
select flow_id, theme_id, theme_class_id, 'REPORT' temp_type, ROW_TEMPLATE_NAME ,id from wwv_flow_row_templates -- report
union all
select flow_id, theme_id, theme_class_id, 'LIST' temp_type, LIST_TEMPLATE_NAME ,id from wwv_flow_list_templates -- list
union all
select flow_id, theme_id, theme_class_id, 'LABEL' temp_type, TEMPLATE_NAME ,id from wwv_flow_field_templates -- label
union all
select flow_id, theme_id, theme_class_id, 'BUTTON' temp_type, TEMPLATE_NAME ,id from wwv_flow_button_templates -- button
union all
select flow_id, theme_id, theme_class_id, 'MENU' temp_type, name ,id from wwv_flow_menu_templates -- menu
union all
select flow_id, theme_id, theme_class_id, 'CALENDAR' temp_type, name  ,id from wwv_flow_cal_templates -- calendar
union all
select flow_id, theme_id, theme_class_id, 'POPUP' temp_type, page_name ,id from wwv_flow_popup_lov_template -- popup_lov
;