CREATE OR REPLACE FORCE VIEW apex_application_translations (workspace,application_id,application_name,translatable_message,language_code,message_text,last_updated_by,last_updated_on,developer_comment,translation_entry_id) AS
select
    w.short_name                     workspace,
    f.ID                             application_id,
    f.NAME                           application_name,
    --
    t.NAME                           translatable_message,
    t.MESSAGE_LANGUAGE               language_code,
    --
    t.MESSAGE_TEXT                   message_text,
    t.LAST_UPDATED_BY                last_updated_by,
    t.LAST_UPDATED_ON                last_updated_on,
    t.MESSAGE_COMMENT                developer_comment,
    t.id                             translation_entry_id
from WWV_FLOW_MESSAGES$ t,
     wwv_flows f,
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(nv('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = s.security_group_id) and
      f.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.schema = f.owner and
      s.security_group_id = w.PROVISIONING_COMPANY_ID and
      f.id = t.flow_id and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      /* keep this language map not exists */
      not exists (
        select 1 from wwv_flow_language_map
        where translation_flow_id = f.id) and
      w.PROVISIONING_COMPANY_ID != 0 and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10);
COMMENT ON TABLE apex_application_translations IS 'Identifies message primary language text and translated text';
COMMENT ON COLUMN apex_application_translations.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_translations.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_translations.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_translations.translatable_message IS 'Identifies the Message Name';
COMMENT ON COLUMN apex_application_translations.language_code IS 'Identifies the Language Code';
COMMENT ON COLUMN apex_application_translations.message_text IS 'Identifies the message text in the Language Code language';
COMMENT ON COLUMN apex_application_translations.last_updated_by IS 'Apex developer who made last update';
COMMENT ON COLUMN apex_application_translations.last_updated_on IS 'Date of last update';
COMMENT ON COLUMN apex_application_translations.developer_comment IS 'Developer Comment';
COMMENT ON COLUMN apex_application_translations.translation_entry_id IS 'Primary Key of this Translation Entry';