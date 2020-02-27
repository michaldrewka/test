CREATE OR REPLACE FORCE VIEW apex_application_temp_region (workspace,application_id,application_name,template_name,theme_number,theme_class,"TEMPLATE",template2,template3,plug_table_bgcolor,plug_heading_bgcolor,plug_font_size,is_subscribed,subscribed_from,last_updated_by,last_updated_on,translatable,component_comment,region_template_id,component_signature) AS
select
    w.short_name                     workspace,
    f.ID                             application_id,
    f.NAME                           application_name,
    --
    t.PAGE_PLUG_TEMPLATE_NAME        template_name,
    t.THEME_ID                       theme_number,
    --
    decode(t.THEME_CLASS_ID,
        'RETURN_VALUE','DISPLAY_VALUE',
        '1','Hide and Show Region',
        '2','Sidebar Region',
        '3','Sidebar Region, Alternative 1',
        '4','Button Region with Title',
        '5','Navigation Region',
        '6','Breadcrumb Region',
        '7','Borderless Region',
        '8','Form Region',
        '9','Reports Region',
        '10','Reports Region, Alternative 1',
        '11','Region without Title',
        '12','Wizard Region',
        '13','Reports Region 100% Width',
        '16','Navigation Region, Alternative 1',
        '17','Button Region without Title',
        '18','Bracketed Region',
        '19','Region without Buttons and Title',
        '20','Wizard Region with Icon',
        '21','Custom 1',
        '22','Custom 2',
        '23','Custom 3',
        '24','Custom 4',
        '25','Custom 5',
        '26','Custom 6',
        '27','Custom 7',
        '28','Custom 8',
        '29','List Region with Icon',
        '30','Chart Region',
        t.theme_class_id)            theme_class,
    --
    t.TEMPLATE,
    t.TEMPLATE2,
    t.TEMPLATE3,
    t.PLUG_TABLE_BGCOLOR,
    t.PLUG_HEADING_BGCOLOR,
    t.PLUG_FONT_SIZE,
    --
    decode(t.REFERENCE_ID,
    null,'No','Yes')                 is_subscribed,
    (select flow_id||'. '||name
     from WWV_FLOW_PAGE_PLUG_TEMPLATES
     where id = t.REFERENCE_ID)      subscribed_from,
    --
    t.LAST_UPDATED_BY                last_updated_by,
    t.LAST_UPDATED_ON                last_updated_on,
    decode(t.TRANSLATE_THIS_TEMPLATE,
      'N','No','Y','Yes','Yes')      translatable,
    t.TEMPLATE_COMMENT               component_comment,
    t.id                             region_template_id,
    --
    t.PAGE_PLUG_TEMPLATE_NAME
    ||' t='||t.THEME_ID
    ||' c='||THEME_CLASS_ID
    ||' 1='||dbms_lob.substr(t.TEMPLATE,40,1)||'.'||dbms_lob.getlength(t.TEMPLATE)
    ||' 2='||dbms_lob.substr(t.TEMPLATE2,40,1)||'.'||dbms_lob.getlength(t.TEMPLATE2)
    ||' 3='||dbms_lob.substr(t.TEMPLATE3,40,1)||'.'||dbms_lob.getlength(t.TEMPLATE3)
    ||' b='||substr(t.PLUG_TABLE_BGCOLOR,1,20)
    ||' b='||substr(t.PLUG_HEADING_BGCOLOR,1,20)
    ||' f='||substr(t.PLUG_FONT_SIZE,1,20)
    ||' t='||TRANSLATE_THIS_TEMPLATE
    ||' r='||decode(t.REFERENCE_ID,null,'N','Y')
    component_signature
from WWV_FLOW_PAGE_PLUG_TEMPLATES t,
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
COMMENT ON TABLE apex_application_temp_region IS 'Identifies a regions HTML template display attributes';
COMMENT ON COLUMN apex_application_temp_region.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_temp_region.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_temp_region.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_temp_region.template_name IS 'Identifies the region template';
COMMENT ON COLUMN apex_application_temp_region.theme_number IS 'Identifies the theme number associated with all templates within the theme';
COMMENT ON COLUMN apex_application_temp_region.theme_class IS 'Identifies a specific usage for this template';
COMMENT ON COLUMN apex_application_temp_region."TEMPLATE" IS 'HTML that defined the appearance for a page region';
COMMENT ON COLUMN apex_application_temp_region.is_subscribed IS 'Identifies if this Region Template is subscribed from another Region Template';
COMMENT ON COLUMN apex_application_temp_region.subscribed_from IS 'Identifies the master component from which this component is subscribed';
COMMENT ON COLUMN apex_application_temp_region.last_updated_by IS 'Apex developer who made last update';
COMMENT ON COLUMN apex_application_temp_region.last_updated_on IS 'Date of last update';
COMMENT ON COLUMN apex_application_temp_region.translatable IS 'Identifies if this component is to be included in the list of translatable components';
COMMENT ON COLUMN apex_application_temp_region.component_comment IS 'Developer comment';
COMMENT ON COLUMN apex_application_temp_region.region_template_id IS 'Primary Key of this Region Template';
COMMENT ON COLUMN apex_application_temp_region.component_signature IS 'Identifies attributes defined at a given component level to facilitate application comparisons';