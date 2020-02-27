CREATE OR REPLACE FORCE VIEW apex_application_auth (workspace,application_id,application_name,is_subscribed,authentication_scheme_name,description,page_sentry_function,session_verify_function,invalid_session_page,invalid_session_url,pre_authentication_process,authentication_function,post_authentication_process,cookie_name,cookie_path,cookie_domain,cookie_secure,ldap_host,ldap_port,ldap_dn_string,ldap_username_edit_function,logout_url,help_text,last_updated_by,last_updated_on,authentication_scheme_id,referenced_schema_id,component_signature) AS
select
    w.short_name                     workspace,
    f.ID                             application_id,
    f.NAME                           application_name,
    --
    decode(a.REFERENCE_ID,
      null,'No','Yes')               is_subscribed,
    a.NAME                           authentication_scheme_name,
    a.DESCRIPTION                    ,
    a.PAGE_SENTRY_FUNCTION           page_sentry_function,
    a.SESS_VERIFY_FUNCTION           session_verify_function,
    a.INVALID_SESSION_PAGE           invalid_session_page,
    a.INVALID_SESSION_URL            invalid_session_url,
    --
    a.PRE_AUTH_PROCESS               pre_authentication_process,
    a.AUTH_FUNCTION                  authentication_function,
    a.POST_AUTH_PROCESS              post_authentication_process,
    --
    a.COOKIE_NAME                    cookie_name,
    a.COOKIE_PATH                    cookie_path,
    a.COOKIE_DOMAIN                  cookie_domain,
    decode(a.USE_SECURE_COOKIE_YN,'Y','Yes','N','No','No') cookie_secure,
    --
    a.LDAP_HOST                      ldap_host,
    a.LDAP_PORT                      ldap_port,
    a.LDAP_STRING                    ldap_dn_string,
    --
    a.ATTRIBUTE_01                   ldap_username_edit_function,
    a.ATTRIBUTE_02                   logout_url,
    a.ATTRIBUTE_03                   help_text,
    --a.ATTRIBUTE_04                   ,
    --a.ATTRIBUTE_05                   ,
    --a.ATTRIBUTE_06                   ,
    --a.ATTRIBUTE_07                   ,
    --a.ATTRIBUTE_08                   ,
    --
    --(select PATCH_NAME
    -- from   wwv_flow_patches
    -- where  id =a.REQUIRED_PATCH)    build_option,
    --
    a.LAST_UPDATED_BY                ,
    a.LAST_UPDATED_ON                ,
    a.id                             authentication_scheme_id,
    a.reference_id                   referenced_schema_id,
    --
    a.NAME
    ||' '||decode(a.REFERENCE_ID,null,'No','Yes')
    ||dbms_lob.substr(a.PAGE_SENTRY_FUNCTION,20,1)||dbms_lob.getlength(a.PAGE_SENTRY_FUNCTION)||'.'
    ||dbms_lob.substr(a.SESS_VERIFY_FUNCTION,20,1)||dbms_lob.getlength(a.SESS_VERIFY_FUNCTION)||'.'
    ||substr(a.INVALID_SESSION_PAGE,1,20)||length(a.INVALID_SESSION_PAGE)||'.'
    ||substr(a.INVALID_SESSION_URL ,1,20)||length(a.INVALID_SESSION_URL )||'.'
    ||dbms_lob.substr(a.PRE_AUTH_PROCESS,20,1)||dbms_lob.getlength(a.PRE_AUTH_PROCESS    )||'.'
    ||dbms_lob.substr(a.AUTH_FUNCTION   ,20,1)||dbms_lob.getlength(a.AUTH_FUNCTION       )||'.'
    ||dbms_lob.substr(a.POST_AUTH_PROCESS,20,1)||dbms_lob.getlength(a.POST_AUTH_PROCESS   )||'.'
    ||substr(a.COOKIE_NAME         ,1,20)||length(a.COOKIE_NAME         )||'.'
    ||substr(a.COOKIE_PATH         ,1,20)||length(a.COOKIE_PATH         )||'.'
    ||substr(a.COOKIE_DOMAIN       ,1,20)||length(a.COOKIE_DOMAIN       )||'.'
    ||substr(a.USE_SECURE_COOKIE_YN,1,1)||length(a.USE_SECURE_COOKIE_YN)||'.'
    ||substr(a.LDAP_HOST           ,1,20)||length(a.LDAP_HOST           )||'.'
    ||substr(a.LDAP_PORT           ,1,20)||length(a.LDAP_PORT           )||'.'
    ||substr(a.LDAP_STRING         ,1,20)||length(a.LDAP_STRING         )||'.'
    ||substr(a.ATTRIBUTE_01        ,1,20)||length(a.ATTRIBUTE_01        )||'.'
    ||substr(a.ATTRIBUTE_02        ,1,20)||length(a.ATTRIBUTE_02        )||'.'
    ||substr(a.ATTRIBUTE_03        ,1,20)||length(a.ATTRIBUTE_03        )
    component_signature
from wwv_flow_custom_auth_setups a,
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
COMMENT ON TABLE apex_application_auth IS 'Identifies the available Authentication Schemes defined for an Application';
COMMENT ON COLUMN apex_application_auth.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_auth.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_auth.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_auth.is_subscribed IS 'Identifies if this Authentication Scheme is subscribed from another Authentication Scheme.';
COMMENT ON COLUMN apex_application_auth.authentication_scheme_name IS 'Identifies this Authentication Scheme';
COMMENT ON COLUMN apex_application_auth.description IS 'Text discription of this Authentication Scheme';
COMMENT ON COLUMN apex_application_auth.page_sentry_function IS 'This function is executed by the Application Express engine before each page is shown or processed. If this function returns false (indicating perhaps that the user isn''t logged in), the engine redirects to a login page';
COMMENT ON COLUMN apex_application_auth.session_verify_function IS 'This function determines whether or not a valid session exists.';
COMMENT ON COLUMN apex_application_auth.invalid_session_page IS 'Specifies the page in this application that the engine should redirect to if the page sentry function returns false. This would normally be a login page.';
COMMENT ON COLUMN apex_application_auth.invalid_session_url IS 'Specifies a URL Application Express should redirect to if the authentication function returns false. This would normally be a URL to a login page or single signon portal. You can''t enter both a page and a URL for the invalid session redirect target.';
COMMENT ON COLUMN apex_application_auth.pre_authentication_process IS 'Code that will be executed after the login page is submitted and just before credentials verification is performed.';
COMMENT ON COLUMN apex_application_auth.authentication_function IS 'Specify the function that will verify the user''s login credentials. This function must return boolean to the login procedure that calls it. ';
COMMENT ON COLUMN apex_application_auth.post_authentication_process IS 'Specifies a block of code to be executed by the Application Express login procedure (login API) after the authentication step (login credentials verification).';
COMMENT ON COLUMN apex_application_auth.cookie_name IS 'Name for the session cookie to be set by the post-login procedure and checked by the Verify Session function.';
COMMENT ON COLUMN apex_application_auth.cookie_path IS 'Path attribute for the session cookie to be set by the post-login procedure and checked by the Verify Session function.';
COMMENT ON COLUMN apex_application_auth.cookie_domain IS 'Domain attribute for the session cookie to be set by the post-login procedure and checked by the Verify Session function. Defaults to null.';
COMMENT ON COLUMN apex_application_auth.cookie_secure IS 'Specifies whether to set the secure attribute of the session management cookie when sending cookie to browser. Secure cookies can be used only with HTTPS. Defaults to No.';
COMMENT ON COLUMN apex_application_auth.ldap_host IS 'The hostname of your LDAP directory server.';
COMMENT ON COLUMN apex_application_auth.ldap_port IS 'The port number of your LDAP directory host.';
COMMENT ON COLUMN apex_application_auth.ldap_dn_string IS 'The pattern used to construct the Domain Name (DN) argument to DBMS_LDAP.SIMPLE_BIND_S.';
COMMENT ON COLUMN apex_application_auth.ldap_username_edit_function IS 'A function that can refine the username captured in the login form into a format suitable for the LDAP call.';
COMMENT ON COLUMN apex_application_auth.logout_url IS 'Specify a URL to become the LOGOUT_URL substitution string.';
COMMENT ON COLUMN apex_application_auth.help_text IS 'Text to be displayed in login help popup window off login page. This should offer guidance and links to resources to assist users of the Application Express built-in login page, specific to the type of authentication your application is using (Open Door, Application Express account, or LDAP).';
COMMENT ON COLUMN apex_application_auth.last_updated_by IS 'Apex developer who made last update';
COMMENT ON COLUMN apex_application_auth.last_updated_on IS 'Date of last update';
COMMENT ON COLUMN apex_application_auth.authentication_scheme_id IS 'Primary Key of this component';
COMMENT ON COLUMN apex_application_auth.referenced_schema_id IS 'Foreign Key to referenced Authentication Scheme';
COMMENT ON COLUMN apex_application_auth.component_signature IS 'Identifies attributes defined at a given component level to facilitate application comparisons';