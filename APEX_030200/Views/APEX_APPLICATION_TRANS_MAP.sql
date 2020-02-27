CREATE OR REPLACE FORCE VIEW apex_application_trans_map (workspace,map_id,primary_application_id,primary_application_name,translated_application_id,translated_app_language,translated_appl_img_dir,translation_comments,translation_map_comments,last_updated_by,last_updated_on) AS
select
    w.short_name                     workspace,
    m.ID                             map_id,
    m.primary_language_flow_id       primary_application_id,
    f.name                           primary_application_name,
    m.translation_flow_id            translated_application_id,
    m.translation_flow_language_code translated_app_language,
    m.translation_image_directory    translated_appl_img_dir,
    m.translation_comments           translation_comments,
    m.MAP_COMMENTS                   translation_map_comments,
    m.LAST_UPDATED_BY,
    m.LAST_UPDATED_ON
from
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     WWV_FLOW_LANGUAGE_MAP m,
     wwv_flows f,
     (select nvl(nv('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = w.PROVISIONING_COMPANY_ID) and
      s.security_group_id = w.PROVISIONING_COMPANY_ID and
      w.PROVISIONING_COMPANY_ID != 0  and
      w.PROVISIONING_COMPANY_ID = m.security_group_id and
      f.owner = s.schema and
      f.id = m.primary_language_flow_id;
COMMENT ON TABLE apex_application_trans_map IS 'Application Groups defined per workspace.  Applications can be associated with an application group.';
COMMENT ON COLUMN apex_application_trans_map.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_trans_map.map_id IS 'Unique ID that identifies this translation mapping';
COMMENT ON COLUMN apex_application_trans_map.primary_application_id IS 'Unique ID of the application that is the target of the translation';
COMMENT ON COLUMN apex_application_trans_map.primary_application_name IS 'Name of the application that is the target of the translation';
COMMENT ON COLUMN apex_application_trans_map.translated_application_id IS 'Unique ID of the translated application';
COMMENT ON COLUMN apex_application_trans_map.translated_app_language IS 'Language code, for example "fr" or "pt-br"';
COMMENT ON COLUMN apex_application_trans_map.translated_appl_img_dir IS 'Optional directory of translated images';
COMMENT ON COLUMN apex_application_trans_map.translation_comments IS 'Comments associated with this translation';
COMMENT ON COLUMN apex_application_trans_map.translation_map_comments IS 'Comments associated with this mapping';
COMMENT ON COLUMN apex_application_trans_map.last_updated_by IS 'Last user to update this translation mapping';
COMMENT ON COLUMN apex_application_trans_map.last_updated_on IS 'Date of last update to this translation mapping';