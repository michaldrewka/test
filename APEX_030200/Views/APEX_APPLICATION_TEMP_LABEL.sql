CREATE OR REPLACE FORCE VIEW apex_application_temp_label (workspace,application_id,application_name,theme_number,theme_class,template_name,before_label,after_label,is_subscribed,subscribed_from,on_error_before_label,on_error_after_label,last_updated_on,last_updated_by,translate_this_template,component_comment,label_template_id,component_signature) AS
select
    w.short_name                     workspace,
    f.ID                             application_id,
    f.NAME                           application_name,
    --
    t.THEME_ID                       theme_number,
    decode(t.THEME_CLASS_ID,
      '1','Optional Label with Help',
      '2','Required Label with Help',
      '3','Optional Label',
      '4','Required Label',
      '5','Custom 1',
      '6','Custom 2',
      '7','Custom 3',
      '8','Custom 4',
      '9','Custom 5',
      '10','Custom 6',
      '11','Custom 7',
      '12','Custom 8',
      '13','No Label',
      t.THEME_CLASS_ID)              theme_class,
    --
    t.TEMPLATE_NAME                  template_name,
    t.TEMPLATE_BODY1                 before_label,
    t.TEMPLATE_BODY2                 after_label,
    --
    decode(t.REFERENCE_ID,
    null,'No','Yes')                 is_subscribed,
    (select flow_id||'. '||name
     from WWV_FLOW_FIELD_TEMPLATES
     where id = t.REFERENCE_ID)      subscribed_from,
    --
    t.ON_ERROR_BEFORE_LABEL,
    t.ON_ERROR_AFTER_LABEL,
    t.LAST_UPDATED_ON                last_updated_on,
    t.LAST_UPDATED_BY                last_updated_by,
    t.TRANSLATE_THIS_TEMPLATE        ,
    t.TEMPLATE_COMMENT               component_comment,
    t.id                             label_template_id,
    --
    t.TEMPLATE_NAME
    ||' t='||t.THEME_ID
    ||' c='||t.THEME_CLASS_ID
    ||' 1='||substr(t.TEMPLATE_BODY1,1,40)||length(t.TEMPLATE_BODY1)
    ||' 2='||substr(t.TEMPLATE_BODY2,1,40)||length(t.TEMPLATE_BODY2)
    ||' r='||decode(t.REFERENCE_ID,null,'N','Y')
    ||' e='||substr(t.ON_ERROR_BEFORE_LABEL,1,40)||length(t.ON_ERROR_BEFORE_LABEL)
    ||' e='||substr(t.ON_ERROR_AFTER_LABEL,1,40)||length(t.ON_ERROR_AFTER_LABEL)
    ||' t='||t.TRANSLATE_THIS_TEMPLATE
    component_signature
from WWV_FLOW_FIELD_TEMPLATES t,
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
COMMENT ON TABLE apex_application_temp_label IS 'Identifies a Page Item Label HTML template display attributes';
COMMENT ON COLUMN apex_application_temp_label.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_temp_label.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_temp_label.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_temp_label.theme_number IS 'Identifies the theme number associated with all templates within the theme';
COMMENT ON COLUMN apex_application_temp_label.theme_class IS 'Identifies a specific usage for this template';
COMMENT ON COLUMN apex_application_temp_label.template_name IS 'Identifies the name of this Item Label Template';
COMMENT ON COLUMN apex_application_temp_label.before_label IS 'HTML to be displayed before an item label';
COMMENT ON COLUMN apex_application_temp_label.after_label IS 'HTML to be displayed after an item label';
COMMENT ON COLUMN apex_application_temp_label.is_subscribed IS 'Identifies if this Item Label Template is subscribed from another Item Label Template';
COMMENT ON COLUMN apex_application_temp_label.subscribed_from IS 'Identifies the master component from which this component is subscribed';
COMMENT ON COLUMN apex_application_temp_label.on_error_before_label IS 'HTML to precede the item label when a application displays an inline validation error message for the item';
COMMENT ON COLUMN apex_application_temp_label.on_error_after_label IS 'HTML to be appended to the item label when a application  displays an inline validation error message for the item';
COMMENT ON COLUMN apex_application_temp_label.last_updated_on IS 'Date of last update';
COMMENT ON COLUMN apex_application_temp_label.last_updated_by IS 'Apex developer who made last update';
COMMENT ON COLUMN apex_application_temp_label.translate_this_template IS 'Identifies if this template should be translated';
COMMENT ON COLUMN apex_application_temp_label.component_comment IS 'Developer comment';
COMMENT ON COLUMN apex_application_temp_label.label_template_id IS 'Primary Key of this Item Label Template';
COMMENT ON COLUMN apex_application_temp_label.component_signature IS 'Identifies attributes defined at a given component level to facilitate application comparisons';