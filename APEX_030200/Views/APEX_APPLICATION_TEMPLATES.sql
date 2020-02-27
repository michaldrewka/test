CREATE OR REPLACE FORCE VIEW apex_application_templates (workspace,application_id,application_name,theme_number,template_type,template_name,reference_count,last_updated_on,last_updated_by,is_subscribed,is_default,template_id) AS
select
  w.short_name                          workspace,
  ff.ID                                 application_id,
  ff.NAME                               application_name,
  x.theme_id                            theme_number,
  decode(x.template_type,
  'PAGE','Page',
  'REGION','Region',
  'LABEL','Item Label',
  'LIST','List',
  'POPUP_LOV','Popup List of Values',
  'CALENDAR','Calendar',
  'MENU','Breadcrumb',
  'BUTTON','Button',
  'REPORT','Report',
  x.template_type)                      template_type,
  x.template_name                       template_name,
  x.reference_count                     reference_count,
  x.last_updated_on                     last_updated_on,
  x.last_updated_by                     last_updated_by,
  decode(x.reference_id,null,
      'No',0,'No','Yes')                is_subscribed,
  decode(x.is_default,0,'No','Yes')     is_default,
  tid                                   template_id
from
     wwv_flows ff,
     wwv_flow_companies w,
     (select nvl(nv('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d,
(
select
    flow_id,
    'POPUP_LOV' template_type,
    'Popup LOV' template_name,
    1 reference_count,
    last_updated_on,
    last_updated_by,
    null reference_id,
    1 is_default,
    0 preview,
    theme_id,
    id tid
from wwv_flow_popup_lov_template plt
union all
select
    flow_id,
    'CALENDAR' template_type,
    NAME template_name,
    (select count(*) from WWV_FLOW_CALS where template_id = c.id and flow_id = c.flow_id )+
    (select count(*) from wwv_flows f where f.id = c.flow_id and f.default_calendar_template = c.id) reference_count,
    last_updated_on,
    last_updated_by,
    reference_id,
    (select count(*) from wwv_flows f where f.id = c.flow_id and f.default_calendar_template = c.id) is_default,
    0 preview,
    theme_id,
    id tid
from wwv_flow_cal_templates c
union all
select
    flow_id,
    'MENU'   template_type,
    NAME     template_name,
    (select count(*) from wwv_flow_page_plugs r where r.flow_id = m.flow_id and r.menu_template_id = m.id)+
    (select count(*) from wwv_flows f where f.id = m.flow_id and f.default_menu_template = m.id)
    reference_count,
    last_updated_on,
    last_updated_by,
    reference_id,
    (select count(*) from wwv_flows f where f.id = m.flow_id and f.default_menu_template = m.id) is_default,
    0 preview,
    theme_id,
    id tid
from wwv_flow_menu_templates m
union all
select
    flow_id,
    'BUTTON'             template_type,
    TEMPLATE_NAME        template_name,
    (select count(*)
     from wwv_flow_step_buttons sb
     where sb.flow_id = b.flow_id and
           substr(sb.button_image,1,9) = 'template:' and
           substr(sb.button_image,10) = to_char(b.id))+
    (select count(*) from wwv_flow_step_items si
     where flow_id = b.flow_id and
     si.TAG_ATTRIBUTES = 'template:'||to_char(b.id))+
    (select count(*) from wwv_flows f where f.id = b.flow_id and f.default_button_template = b.id) reference_count,
    last_updated_on,
    last_updated_by,
    reference_id,
    (select count(*) from wwv_flows f where f.id = b.flow_id and f.default_button_template = b.id) is_default,
    0 preview,
    theme_id,
    id tid
from wwv_flow_button_templates b
union all
select
    flow_id,
    'LABEL' template_type,
    TEMPLATE_NAME template_name,
    (select count(*) from wwv_flow_step_items i where i.flow_id = f.flow_id and i.ITEM_FIELD_TEMPLATE = f.id)+
    (select count(*) from wwv_flows f1 where f1.id = f.flow_id and f1.default_label_template = f.id) reference_count,
    last_updated_on, last_updated_by, reference_id,
    (select count(*) from wwv_flows fp where fp.id = f.flow_id and fp.default_label_template = f.id) is_default,
    0 preview,
    theme_id,
    id tid
from wwv_flow_field_templates f
union all
select
    flow_id,
    'LIST' template_type,
    l.LIST_TEMPLATE_NAME template_name,
    (select count(*) from wwv_flow_lists ll where ll.flow_id = l.flow_id and ll.DISPLAY_ROW_TEMPLATE_ID = l.id) +
    (select count(*) from wwv_flow_page_plugs p where p.flow_id = l.flow_id and p.list_template_id = l.id) +
    (select count(*) from wwv_flows f where f.id = l.flow_id and f.default_list_template = l.id) reference_count,
    last_updated_on, last_updated_by, reference_id,
    (select count(*) from wwv_flows f where f.id = l.flow_id and f.default_list_template = l.id) is_default,
    0 preview,
    theme_id,
    id tid
from wwv_flow_list_templates l
union all
select
    flow_id,
    'REPORT'                 template_type,
    ROW_TEMPLATE_NAME        template_name,
    (select count(*) from wwv_flow_page_plugs p where flow_id = ro.flow_id and p.PLUG_QUERY_ROW_TEMPLATE = ro.id) +
    (select count(*) from wwv_flows f where id = ro.flow_id and f.default_report_template = ro.id) reference_count,
    last_updated_on, last_updated_by, reference_id,
    (select count(*) from wwv_flows f where id = ro.flow_id and f.default_report_template = ro.id) is_default,
    ro.id preview,
    theme_id,
    id tid
from wwv_flow_row_templates ro
union all
select
    flow_id,
    'PAGE' template_type,
    name         template_name,
    (select count(*) from wwv_flow_steps s where flow_id = p.flow_id and s.step_template = p.id) +
    (select count(*) from wwv_flows f where flow_id = p.flow_id and f.DEFAULT_PAGE_TEMPLATE = p.id) +
    (select count(*) from wwv_flows f where flow_id = p.flow_id and f.error_template=p.id) +
    (select count(*) from wwv_flows f where flow_id = p.flow_id and f.printer_friendly_template=p.id) reference_count,
    last_updated_on, last_updated_by, reference_id,
    (select count(*) from wwv_flows f where flow_id = p.flow_id and f.DEFAULT_PAGE_TEMPLATE=p.id) is_default,
    p.id preview,
    theme_id,
    id tid
from wwv_flow_templates p
union all
select
    flow_id,
    'REGION' template_type,
    PAGE_PLUG_TEMPLATE_NAME template_name,
    (select count(*) from wwv_flow_page_plugs p where flow_id = r.flow_id and p.PLUG_TEMPLATE = r.id) +
    (select count(*) from wwv_flows f where  id = r.flow_id and f.default_region_template = r.id) reference_count,
    last_updated_on,
    last_updated_by,
    reference_id,
    (select count(*) from wwv_flows f where  id = r.flow_id and f.default_region_template = r.id)  is_default,
    r.id preview,
    theme_id,
    id tid
from wwv_flow_page_plug_templates r
) x
where (ff.owner = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = ff.security_group_id) and
      ff.security_group_id = w.PROVISIONING_COMPANY_ID and
      ff.id = x.flow_id and
      (d.sgid != 0 or nvl(ff.BUILD_STATUS,'x') != 'RUN_ONLY');
COMMENT ON TABLE apex_application_templates IS 'Identifies reference counts for templates of all types';
COMMENT ON COLUMN apex_application_templates.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_templates.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_templates.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_templates.theme_number IS 'Identifies the numeric identifier of this theme to which this template is associated';
COMMENT ON COLUMN apex_application_templates.template_type IS 'Identifies the Template Type';
COMMENT ON COLUMN apex_application_templates.template_name IS 'Name of the template';
COMMENT ON COLUMN apex_application_templates.reference_count IS 'Number of references to this template';
COMMENT ON COLUMN apex_application_templates.last_updated_on IS 'Date of last update';
COMMENT ON COLUMN apex_application_templates.last_updated_by IS 'Apex User Name who made the last update';
COMMENT ON COLUMN apex_application_templates.is_subscribed IS 'Identifies if this template is subscribed from another template';
COMMENT ON COLUMN apex_application_templates.is_default IS 'Identifies this template as the default template for new components created with a corresponding type';
COMMENT ON COLUMN apex_application_templates.template_id IS 'Primary key of this component';