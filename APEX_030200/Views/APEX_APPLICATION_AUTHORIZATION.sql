CREATE OR REPLACE FORCE VIEW apex_application_authorization (workspace,application_id,application_name,authorization_scheme_name,scheme_type,scheme,scheme_text,error_message,"CACHING",is_subscribed,last_updated_by,last_updated_on,component_comment,authorization_scheme_id,referenced_scheme_id,component_signature) AS
select
    w.short_name                     workspace,
    f.ID                             application_id,
    f.NAME                           application_name,
    --
    a.NAME                           authorization_scheme_name,
    a.SCHEME_TYPE                    scheme_type,
    a.SCHEME                         scheme,
    a.SCHEME_TEXT                    scheme_text,
    a.ERROR_MESSAGE                  error_message,
    --
    decode(a.CACHING,
      'BY_USER_BY_PAGE_VIEW','Once per page view',
      'BY_USER_BY_SESSION','Once per session',
      a.CACHING)                     caching,
    decode(a.REFERENCE_ID,null,'No','Yes') is_subscribed,
    a.LAST_UPDATED_BY                last_updated_by,
    a.LAST_UPDATED_ON                last_updated_on,
    a.COMMENTS                       component_comment,
    --
    a.id                             authorization_scheme_id,
    a.REFERENCE_ID                   referenced_scheme_id,
    --
    substr(a.NAME,1,30)||length(a.NAME         )
    ||' t='||substr(a.SCHEME_TYPE  ,1,30)||length(a.SCHEME_TYPE  )
    ||' s='||substr(a.SCHEME       ,1,30)||length(a.SCHEME       )
    ||' t='||substr(a.SCHEME_TEXT  ,1,30)||length(a.SCHEME_TEXT  )
    ||' e='||substr(a.ERROR_MESSAGE,1,30)||length(a.ERROR_MESSAGE)
    ||' s='||decode(a.CACHING,'BY_USER_BY_PAGE_VIEW','Once per page view','BY_USER_BY_SESSION','Once per session',substr(a.CACHING,1,20))
    ||' r='||decode(a.REFERENCE_ID,null,'No','Yes')
    component_signature
from WWV_FLOW_SECURITY_SCHEMES a,
     wwv_flows f,
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(nv('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = s.security_group_id) and
      f.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.schema = f.owner and
      f.id = a.flow_id and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      w.PROVISIONING_COMPANY_ID != 0 and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10);
COMMENT ON TABLE apex_application_authorization IS 'Identifies Authorization Schemes which can be applied at the application, page or component level';
COMMENT ON COLUMN apex_application_authorization.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_authorization.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_authorization.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_authorization.authorization_scheme_name IS 'Name of the Authorization Scheme';
COMMENT ON COLUMN apex_application_authorization.scheme_type IS 'Type of Authorization Scheme which defines how the Authorization Scheme Source will be interpreted';
COMMENT ON COLUMN apex_application_authorization.scheme IS 'Identifies the Authorization Scheme.  Session state my be referenced using bind variables for Schemes of type SQL or PL/SQL.';
COMMENT ON COLUMN apex_application_authorization.scheme_text IS 'Further Identifies an Authorization Scheme, used only for specific Authorization Scheme Types';
COMMENT ON COLUMN apex_application_authorization.error_message IS 'Identifies the Error Message end users will see when this Authentication Scheme fails';
COMMENT ON COLUMN apex_application_authorization."CACHING" IS 'Identifies the level of Caching used for this Authentication Scheme; typically by Session or Page View.';
COMMENT ON COLUMN apex_application_authorization.is_subscribed IS 'Identifies if this Authorization Scheme is subscribed from another Authorization Scheme.';
COMMENT ON COLUMN apex_application_authorization.last_updated_by IS 'Apex developer who made last update';
COMMENT ON COLUMN apex_application_authorization.last_updated_on IS 'Date of last update';
COMMENT ON COLUMN apex_application_authorization.component_comment IS 'Developer comment';
COMMENT ON COLUMN apex_application_authorization.authorization_scheme_id IS 'Primary Key of this Authorization Scheme';
COMMENT ON COLUMN apex_application_authorization.referenced_scheme_id IS 'Foreign Key of referenced Authorization Scheme';
COMMENT ON COLUMN apex_application_authorization.component_signature IS 'Identifies attributes defined at a given component level to facilitate application comparisons';