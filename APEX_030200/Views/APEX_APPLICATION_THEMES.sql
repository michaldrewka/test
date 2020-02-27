CREATE OR REPLACE FORCE VIEW apex_application_themes (workspace,application_id,application_name,theme_number,theme_name,default_page_template,default_button_template,default_region_template,default_chart_rg_template,default_form_rg_template,default_report_region_template,default_tabular_form_template,default_wizard_template,default_breadcrumb_rg_template,default_list_region_template,default_report_row_template,default_item_label_template,default_breadcrumb_template,default_calendar_template,default_list_template,default_option_label,default_required_label,last_updated_on,last_updated_by,calendar_icon_image_name,calendar_icon_attributes,theme_id,theme_description,component_signature) AS
select
    w.short_name                                                                                             workspace,
    f.ID                                                                                                     application_id,
    f.NAME                                                                                                   application_name,
    --
    t.theme_id                                                                                               theme_number,
    t.theme_name                                                                                             theme_name,
    (select name from wwv_flow_templates where id = t.default_page_template)                                 default_page_template,
    --t.error_template                   ,
    --t.printer_friendly_template        ,
    --t.breadcrumb_display_point         ,
    --t.sidebar_display_point,
    --t.login_template                   ,
    (select template_name from wwv_flow_button_templates where id = t.default_button_template )              default_button_template,
    (select page_plug_template_name from wwv_flow_page_plug_templates where id = t.default_region_template)  default_region_template,
    (select page_plug_template_name from wwv_flow_page_plug_templates where id = t.default_chart_template)   default_chart_rg_template,
    (select page_plug_template_name from wwv_flow_page_plug_templates where id = t.default_form_template)    default_form_rg_template,
    (select page_plug_template_name from wwv_flow_page_plug_templates where id = t.default_reportr_template) default_report_region_template,
    (select page_plug_template_name from wwv_flow_page_plug_templates where id = t.default_tabform_template) default_tabular_form_template,
    (select page_plug_template_name from wwv_flow_page_plug_templates where id = t.default_wizard_template)  default_wizard_template,
    (select page_plug_template_name from wwv_flow_page_plug_templates where id = t.default_menur_template)   default_breadcrumb_rg_template,
    (select page_plug_template_name from wwv_flow_page_plug_templates where id = t.default_listr_template)   default_list_region_template,
    (select row_template_name from wwv_flow_row_templates where id = t.default_report_template)              default_report_row_template,
    (select template_Name from wwv_flow_field_templates where id = t.default_label_template)                 default_item_label_template,
    (select name from wwv_flow_menu_templates where id = t.default_menu_template)                            default_breadcrumb_template,
    (select name from wwv_flow_cal_templates where id = t.default_calendar_template)                         default_calendar_template,
    (select list_template_name from wwv_flow_list_templates where id = t.default_list_template)              default_list_template,
    (select template_Name from wwv_flow_field_templates where id = t.default_option_label)                   default_option_label,
    (select template_Name from wwv_flow_field_templates where id = t.default_required_label)                 default_required_label,
    t.last_updated_on                                                                                        last_updated_on,
    t.last_updated_by                                                                                        last_updated_by,
    t.calendar_icon                                                                                          calendar_icon_image_name,
    t.calendar_icon_attr                                                                                     calendar_icon_attributes,
    t.id                                                                                                     theme_id,
    t.theme_description                                                                                      theme_description,
    --
    t.theme_id
    ||' n='||substr(t.theme_name                                                                                             ,1,30)
    ||' p='||substr((select name from wwv_flow_templates where id = t.default_page_template)                                 ,1,30)
    ||' e='||substr((select name from wwv_flow_templates where id = t.error_template),1,30)
    ||' b='||substr((select template_name from wwv_flow_button_templates where id = t.default_button_template )              ,1,30)
    ||' r='||substr((select page_plug_template_name from wwv_flow_page_plug_templates where id = t.default_region_template)  ,1,30)
    ||' c='||substr((select page_plug_template_name from wwv_flow_page_plug_templates where id = t.default_chart_template)   ,1,30)
    ||' f='||substr((select page_plug_template_name from wwv_flow_page_plug_templates where id = t.default_form_template)    ,1,30)
    ||' r='||substr((select page_plug_template_name from wwv_flow_page_plug_templates where id = t.default_reportr_template) ,1,30)
    ||' t='||substr((select page_plug_template_name from wwv_flow_page_plug_templates where id = t.default_tabform_template) ,1,30)
    ||' w='||substr((select page_plug_template_name from wwv_flow_page_plug_templates where id = t.default_wizard_template)  ,1,30)
    ||' b='||substr((select page_plug_template_name from wwv_flow_page_plug_templates where id = t.default_menur_template)   ,1,30)
    ||' l='||substr((select page_plug_template_name from wwv_flow_page_plug_templates where id = t.default_listr_template)   ,1,30)
    ||' r='||substr((select row_template_name from wwv_flow_row_templates where id = t.default_report_template)              ,1,30)
    ||' i='||substr((select template_Name from wwv_flow_field_templates where id = t.default_label_template)                 ,1,30)
    ||' b='||substr((select name from wwv_flow_menu_templates where id = t.default_menu_template)                            ,1,30)
    ||' c='||substr((select name from wwv_flow_cal_templates where id = t.default_calendar_template)                         ,1,30)
    ||' l='||substr((select list_template_name from wwv_flow_list_templates where id = t.default_list_template)              ,1,30)
    ||' l='||substr((select template_Name from wwv_flow_field_templates where id = t.default_option_label)                   ,1,30)
    ||' l='||substr((select template_Name from wwv_flow_field_templates where id = t.default_required_label)                 ,1,30)
    ||' c='||substr(t.calendar_icon,1,30)
    ||' c='||substr(t.calendar_icon_attr,1,30)
    component_signature
from wwv_flow_themes t,
     wwv_flows f,
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(nv('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = s.security_group_id) and
      f.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.schema = f.owner and
      f.id = t.flow_id and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      w.PROVISIONING_COMPANY_ID != 0 and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10);
COMMENT ON TABLE apex_application_themes IS 'Identifies a named collection of Templates';
COMMENT ON COLUMN apex_application_themes.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_themes.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_themes.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_themes.theme_number IS 'Identifies the theme number associated with all templates within the theme';
COMMENT ON COLUMN apex_application_themes.theme_name IS 'Identifies the name of the theme';
COMMENT ON COLUMN apex_application_themes.default_page_template IS 'Identifies the default template when creating new components of a corresponding type';
COMMENT ON COLUMN apex_application_themes.default_button_template IS 'Identifies the default template when creating new components of a corresponding type';
COMMENT ON COLUMN apex_application_themes.default_region_template IS 'Identifies the default template when creating new components of a corresponding type';
COMMENT ON COLUMN apex_application_themes.default_chart_rg_template IS 'Identifies the default template when creating new components of a corresponding type';
COMMENT ON COLUMN apex_application_themes.default_form_rg_template IS 'Identifies the default template when creating new components of a corresponding type';
COMMENT ON COLUMN apex_application_themes.default_report_region_template IS 'Identifies the default template when creating new components of a corresponding type';
COMMENT ON COLUMN apex_application_themes.default_tabular_form_template IS 'Identifies the default template when creating new components of a corresponding type';
COMMENT ON COLUMN apex_application_themes.default_wizard_template IS 'Identifies the default template when creating new components of a corresponding type';
COMMENT ON COLUMN apex_application_themes.default_breadcrumb_rg_template IS 'Identifies the default template when creating new components of a corresponding type';
COMMENT ON COLUMN apex_application_themes.default_list_region_template IS 'Identifies the default template when creating new components of a corresponding type';
COMMENT ON COLUMN apex_application_themes.default_report_row_template IS 'Identifies the default template when creating new components of a corresponding type';
COMMENT ON COLUMN apex_application_themes.default_item_label_template IS 'Identifies the default template when creating new components of a corresponding type';
COMMENT ON COLUMN apex_application_themes.default_breadcrumb_template IS 'Identifies the default template when creating new components of a corresponding type';
COMMENT ON COLUMN apex_application_themes.default_calendar_template IS 'Identifies the default template when creating new components of a corresponding type';
COMMENT ON COLUMN apex_application_themes.default_list_template IS 'Identifies the default template when creating new components of a corresponding type';
COMMENT ON COLUMN apex_application_themes.default_option_label IS 'Identifies the default template when creating new components of a corresponding type';
COMMENT ON COLUMN apex_application_themes.default_required_label IS 'Identifies the default template when creating new components of a corresponding type';
COMMENT ON COLUMN apex_application_themes.last_updated_on IS 'Date of last update';
COMMENT ON COLUMN apex_application_themes.last_updated_by IS 'Apex developer who made last update';
COMMENT ON COLUMN apex_application_themes.calendar_icon_image_name IS 'Identifies the default template when creating new components of a corresponding type';
COMMENT ON COLUMN apex_application_themes.calendar_icon_attributes IS 'Identifies the default template when creating new components of a corresponding type';
COMMENT ON COLUMN apex_application_themes.theme_id IS 'Primary Key of the Theme';
COMMENT ON COLUMN apex_application_themes.theme_description IS 'Comment field';
COMMENT ON COLUMN apex_application_themes.component_signature IS 'Identifies attributes defined at a given component level to facilitate application comparisons';