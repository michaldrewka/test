CREATE OR REPLACE FORCE VIEW apex_application_temp_button (workspace,application_id,application_name,theme_number,theme_class,template_name,"TEMPLATE",is_subscribed,subscribed_from,last_updated_by,last_updated_on,translatable,component_comment,button_template_id,component_signature) AS
select
    w.short_name                     workspace,
    f.ID                             application_id,
    f.NAME                           application_name,
    --
    t.THEME_ID                       theme_number,
    decode(t.THEME_CLASS_ID,
       '1','Button',
       '2','Button, Alternative 3',
       '4','Button, Alternative 1',
       '5','Button, Alternative 2',
       '6','Custom 1',
       '7','Custom 2',
       '8','Custom 3',
       '9','Custom 4',
       '10','Custom 5',
       '11','Custom 6',
       '12','Custom 7',
       '13','Custom 8',
       t.THEME_CLASS_ID)             theme_class,
    --
    t.TEMPLATE_NAME                  template_name,
    t.TEMPLATE                       ,
    --
    decode(t.REFERENCE_ID,
    null,'No','Yes')                 is_subscribed,
    (select flow_id||'. '||name
     from WWV_FLOW_button_TEMPLATES
     where id = t.REFERENCE_ID)      subscribed_from,
    --
    t.LAST_UPDATED_BY                last_updated_by,
    t.LAST_UPDATED_ON                last_updated_on,
    --
    decode(t.TRANSLATE_THIS_TEMPLATE,
      'Y','Yes','N','No','Yes')      translatable,
    t.TEMPLATE_COMMENT               component_comment,
    t.id                             button_template_id,
    --
    t.template_name
    ||' t='||t.THEME_ID
    ||' c='||t.THEME_CLASS_ID
    component_signature
from WWV_FLOW_button_TEMPLATES t,
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
COMMENT ON TABLE apex_application_temp_button IS 'Identifies the HTML template markup used to display a Button';
COMMENT ON COLUMN apex_application_temp_button.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_temp_button.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_temp_button.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_temp_button.theme_number IS 'Identifies the templates corresponding theme';
COMMENT ON COLUMN apex_application_temp_button.theme_class IS 'Identifies a specific usage for this template';
COMMENT ON COLUMN apex_application_temp_button.template_name IS 'Identifies the button template';
COMMENT ON COLUMN apex_application_temp_button."TEMPLATE" IS 'HTML Template';
COMMENT ON COLUMN apex_application_temp_button.is_subscribed IS 'Identifies if this Button Template is subscribed from another Button Template';
COMMENT ON COLUMN apex_application_temp_button.subscribed_from IS 'Identifies the master component from which this component is subscribed';
COMMENT ON COLUMN apex_application_temp_button.last_updated_by IS 'Apex developer who made last update';
COMMENT ON COLUMN apex_application_temp_button.last_updated_on IS 'Date of last update';
COMMENT ON COLUMN apex_application_temp_button.translatable IS 'Identifies if this component is to be identified as translatable (yes or no)';
COMMENT ON COLUMN apex_application_temp_button.component_comment IS 'Developer comment';
COMMENT ON COLUMN apex_application_temp_button.button_template_id IS 'Primary Key of this Button Template';
COMMENT ON COLUMN apex_application_temp_button.component_signature IS 'Identifies attributes defined at a given component level to facilitate application comparisons';