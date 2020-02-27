CREATE OR REPLACE FORCE VIEW apex_application_shortcuts (workspace,application_id,application_name,shortcut_name,shortcut_type,condition_type,condition_expression1,condition_expression2,error_text,build_option,shortcut,is_subscribed,subscribed_from,last_updated_by,last_updated_on,component_comments,shortcut_id,component_signature) AS
select
    w.short_name                     workspace,
    f.ID                             application_id,
    f.NAME                           application_name,
    --
    s.SHORTCUT_NAME                  shortcut_name,
    --s.SHORTCUT_CONSIDERATION_SEQ     consideration_sequence,
    s.SHORTCUT_TYPE                  shortcut_type,
    nvl((select r from apex_standard_conditions where d = s.SHORTCUT_CONDITION_TYPE1),s.SHORTCUT_CONDITION_TYPE1)
                                     condition_type,
    s.SHORTCUT_CONDITION1            condition_expression1,
    --s.SHORTCUT_CONDITION_TYPE2       ,
    s.SHORTCUT_CONDITION2            condition_expression2,
    s.ERROR_TEXT                     error_text,
    (select case when s.build_option > 0 then PATCH_NAME else '{Not '||PATCH_NAME||'}' end PATCH_NAME
     from   wwv_flow_patches
     where  id =abs(s.BUILD_OPTION))      build_option,
    s.SHORTCUT                       shortcut,
    --
    decode(s.REFERENCE_ID,
    null,'No','Yes')                 is_subscribed,
    (select flow_id||'. '||name n
     from wwv_flow_shortcuts
     where id = s.reference_id)      subscribed_from,
    --
    s.LAST_UPDATED_BY                last_updated_by,
    s.LAST_UPDATED_ON                last_updated_on,
    s.COMMENTS                       component_comments,
    s.id                             shortcut_id,
    --
    s.SHORTCUT_NAME
    ||' '||s.SHORTCUT_TYPE
    ||' cond='||s.SHORTCUT_CONDITION_TYPE1
    ||substr(s.SHORTCUT_CONDITION1,1,30)||length(s.shortcut_condition1)||'.'
    ||substr(s.SHORTCUT_CONDITION2,1,30)||length(s.shortcut_condition2)
    ||' e='||substr(s.ERROR_TEXT,1,30)||length(s.ERROR_TEXT)
    ||' bo='||(select PATCH_NAME
     from   wwv_flow_patches
     where  id =abs(s.BUILD_OPTION))
    ||' s='||dbms_lob.substr(s.SHORTCUT,50,1)||dbms_lob.getlength(s.SHORTCUT)
    ||' r='||decode(s.REFERENCE_ID,null,'No','Yes')
    component_signature
from wwv_flow_shortcuts s,
     wwv_flows f,
     wwv_flow_companies w,
     wwv_flow_company_schemas ws,
     (select nvl(nv('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (ws.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = ws.security_group_id) and
      f.security_group_id = w.PROVISIONING_COMPANY_ID and
      ws.security_group_id = w.PROVISIONING_COMPANY_ID and
      ws.schema = f.owner and
      f.id = s.flow_id and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      w.PROVISIONING_COMPANY_ID != 0 and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10);
COMMENT ON TABLE apex_application_shortcuts IS 'Identifies Application Shortcuts which can be referenced "MY_SHORTCUT" syntax';
COMMENT ON COLUMN apex_application_shortcuts.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_shortcuts.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_shortcuts.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_shortcuts.shortcut_name IS 'Identifies the Shortcut Name, which can be referenced using "SHORTCUT_NAME" syntax';
COMMENT ON COLUMN apex_application_shortcuts.shortcut_type IS 'The shortcut type identifies how the Shortcut text is to be interpreted; for example it could by PL/SQL or HTML.';
COMMENT ON COLUMN apex_application_shortcuts.condition_type IS 'Identifies the condition type used to conditionally execute the shortcut';
COMMENT ON COLUMN apex_application_shortcuts.condition_expression1 IS 'Specifies an expression based on the specific condition type selected.';
COMMENT ON COLUMN apex_application_shortcuts.condition_expression2 IS 'Specifies an expression based on the specific condition type selected.';
COMMENT ON COLUMN apex_application_shortcuts.error_text IS 'Text to be displayed if this shortcut raises an exception';
COMMENT ON COLUMN apex_application_shortcuts.build_option IS 'Shortcut will be available if the Build Option is enabled';
COMMENT ON COLUMN apex_application_shortcuts.shortcut IS 'Text and definition of this Shortcut';
COMMENT ON COLUMN apex_application_shortcuts.is_subscribed IS 'Identifies if this Shortcut is subscribed from another Shortcut';
COMMENT ON COLUMN apex_application_shortcuts.subscribed_from IS 'Identifies the master component from which this component is subscribed';
COMMENT ON COLUMN apex_application_shortcuts.last_updated_by IS 'Apex developer who made last update';
COMMENT ON COLUMN apex_application_shortcuts.last_updated_on IS 'Date of last update';
COMMENT ON COLUMN apex_application_shortcuts.component_comments IS 'Developer comments';
COMMENT ON COLUMN apex_application_shortcuts.shortcut_id IS 'Primary Key of this Shortcut';
COMMENT ON COLUMN apex_application_shortcuts.component_signature IS 'Identifies attributes defined at a given component level to facilitate application comparisons';