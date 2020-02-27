CREATE OR REPLACE FORCE VIEW apex_applications (workspace,application_id,application_name,"ALIAS","OWNER",application_group,application_group_id,home_link,page_template,error_page_template,"LOGGING",application_primary_language,language_derived_from,date_format,image_prefix,authentication_scheme_type,login_url,logout_url,logo_type,logo,logo_attributes,public_user,proxy_server,media_type,authentication_scheme,"VERSION",availability_status,unavailable_text,restrict_to_user,debugging,exact_substitutions,build_status,vpd,authorization_scheme,authorization_scheme_id,last_updated_by,last_updated_on,theme_number,global_notification,session_state_protection,maximum_session_life_seconds,session_lifetime_exceeded_url,maximum_session_idle_seconds,session_idle_time_exceeded_url,pages,tabs,parent_tabs,application_items,application_processes,application_computations,shortcuts,web_services,trees,build_options,breadcrumbs,nav_bar_entries,lists,lists_of_values,themes,authentication_schemes,authorization_schemes,translation_messages,installation_scripts,cached_pages,cached_regions,component_signature,workspace_id) AS
select
    w.short_name                     workspace,
    f.ID                             application_id,
    f.NAME                           application_name,
    f.ALIAS                          alias,
    f.OWNER                          owner,
    (select group_name from wwv_flow_application_groups where id = f.group_id) application_group,
    group_id                         application_group_id,
    f.HOME_LINK                      home_link,
    (select name
     from wwv_flow_templates
     where id = f.DEFAULT_PAGE_TEMPLATE)
                                     page_template,
    (select name
     from wwv_flow_templates
     where id = f.ERROR_TEMPLATE)    error_page_template,
    decode(upper(f.WEBDB_LOGGING),
        'YES','Yes',
        'NO','No',f.WEBDB_LOGGING)   logging,
    f.FLOW_LANGUAGE                  application_primary_language,
    f.FLOW_LANGUAGE_DERIVED_FROM     language_derived_from,
    f.date_format                    date_format,
    f.FLOW_IMAGE_PREFIX              image_prefix,
    decode(f.AUTHENTICATION,
        'CUSTOM2','Authentication Scheme',
        'COOKIE', 'APEX Authentication',
        f.AUTHENTICATION)            authentication_scheme_type,
    f.LOGIN_URL                      login_url,
    f.LOGOUT_URL                     logout_url,
    decode(substr(f.LOGO_IMAGE,1,5),
       'TEXT:','Text Logo',
       'Image Logo')                 logo_type,
    f.LOGO_IMAGE                     logo,
    f.LOGO_IMAGE_ATTRIBUTES          logo_attributes,
    --f.PUBLIC_URL_PREFIX              public_url_prefix,
    f.PUBLIC_USER                    public_user,
    --f.DBAUTH_URL_PREFIX              db_auth_url_prefix,
    f.PROXY_SERVER                   proxy_server,
    f.media_type                     media_type,
    --
    (select max(ss.name) n from wwv_flow_custom_auth_setups ss where flow_id = f.id and instr(f.CUSTOM_AUTHENTICATION_PROCESS,to_char(id)) > 0)
                                       authentication_scheme,
    --f.CUSTOM_AUTHENTICATION_PAGE     custom_auth_page,
    --f.CUSTOM_AUTH_LOGIN_URL          custom_auth_login_url,
    f.FLOW_VERSION                     version,
    decode(f.FLOW_STATUS,
        'AVAILABLE','Available',
        'AVAILABLE_W_EDIT_LINK','Available with Edit Links',
        'DEVELOPERS_ONLY','Available to Developers Only',
        'RESTRICTED_ACCESS','Restricted Access',
        'UNAVAILABLE','Unavailable',
        'UNAVAILABLE_PLSQL','Unavailable (Status Shown with PL/SQL)',
        'UNAVAILABLE_URL','Unavailable (Redirect to URL)',
        f.flow_status)               availability_status,
    f.FLOW_UNAVAILABLE_TEXT          unavailable_text,
    f.RESTRICT_TO_USER_LIST          restrict_to_user,
    decode(f.APPLICATION_TAB_SET,
        1,'Allowed',0,'Not Allowed',
        'Allowed')                   debugging,
    decode(f.EXACT_SUBSTITUTIONS_ONLY,
       'N','No','Y','Yes',
       f.EXACT_SUBSTITUTIONS_ONLY)   exact_substitutions,
    decode(f.BUILD_STATUS,
       'RUN_ONLY','Run Only',
       'RUN_AND_BUILD','Run and Develop',
       f.BUILD_STATUS)               build_status,
    f.VPD                            vpd,
    --
    decode(substr(f.SECURITY_SCHEME,1,1),'!','Not ')||
    nvl((select name
     from   wwv_flow_security_schemes
     where  to_char(id) = ltrim(f.SECURITY_SCHEME,'!')
     and    flow_id = f.id),
     f.SECURITY_SCHEME)              authorization_scheme,
    f.security_scheme                authorization_scheme_id,
    --f.REJOIN_EXISTING_SESSIONS       rejoin_sessions,
    f.LAST_UPDATED_BY                last_updated_by,
    f.LAST_UPDATED_ON                last_updated_on,
    f.THEME_ID                       theme_number,
    f.GLOBAL_NOTIFICATION            global_notification,
    decode(f.PAGE_PROTECTION_ENABLED_Y_N,
      'Y','Enabled',
      'N','Disabled',
      'Disabled')                    Session_State_Protection,
    MAX_SESSION_LENGTH_SEC           Maximum_Session_Life_Seconds,
    ON_MAX_SESSION_TIMEOUT_URL       Session_Lifetime_Exceeded_URL,
    MAX_SESSION_IDLE_SEC             Maximum_Session_Idle_Seconds,
    ON_MAX_IDLE_TIMEOUT_URL          Session_Idle_Time_Exceeded_URL,
    -- sub components
    (select count(*) from wwv_flow_steps where flow_id = f.id)               pages,
    (select count(*) from wwv_flow_tabs where flow_id = f.id)                tabs,
    (select count(*) from wwv_flow_toplevel_tabs where flow_id = f.id)       parent_tabs,
    (select count(*) from wwv_flow_items where flow_id = f.id)               application_items,
    (select count(*) from wwv_flow_processing where flow_id = f.id)          application_processes,
    (select count(*) from wwv_flow_computations where flow_id = f.id)        application_computations,
    (select count(*) from wwv_flow_shortcuts where flow_id = f.id)           shortcuts,
    (select count(*) from wwv_flow_shared_web_services where flow_id = f.id) web_services,
    (select count(*) from wwv_flow_trees where flow_id = f.id)               trees,
    (select count(*) from wwv_flow_patches where flow_id = f.id)             build_options,
    (select count(*) from wwv_flow_menus where flow_id = f.id)               breadcrumbs,
    (select count(*) from wwv_flow_icon_bar where flow_id = f.id)            nav_bar_entries,
    (select count(*) from wwv_flow_lists where flow_id = f.id)               lists,
    (select count(*) from wwv_flow_lists_of_values$ where flow_id = f.id)    lists_of_values,
    (select count(*) from wwv_flow_themes where flow_id = f.id)              themes,
    (select count(*) from wwv_flow_custom_auth_setups where flow_id = f.id)  authentication_schemes,
    (select count(*) from WWV_FLOW_SECURITY_SCHEMES where flow_id = f.id)    authorization_schemes,
    (select count(*) from WWV_FLOW_MESSAGES$ where flow_id = f.id)           translation_messages,
    (select count(*) from wwv_flow_install_scripts where flow_id = f.id)     installation_scripts,
    (select count(*) from WWV_FLOW_STEPS where flow_id = f.id and CACHE_PAGE_YN = 'Y') cached_pages,
    (select count(*) from WWV_FLOW_PAGE_PLUGS where flow_id = f.id and PLUG_CACHING in ('CACHED','CACHED_BY_USER')) cached_regions,
    --
    'a='||f.ALIAS
    ||' o='||f.OWNER
    ||' h='||substr(f.HOME_LINK,1,20)||length(f.home_link)
    ||' t='||(select name
     from wwv_flow_templates
     where id = f.DEFAULT_PAGE_TEMPLATE)
    ||' l='||decode(upper(f.WEBDB_LOGGING),'YES','Yes','NO','No',f.WEBDB_LOGGING)
    ||' l='||f.FLOW_LANGUAGE||' '||f.FLOW_LANGUAGE_DERIVED_FROM
    ||' i='||substr(f.FLOW_IMAGE_PREFIX,1,20)||length(f.FLOW_IMAGE_PREFIX)
    ||' a='||substr(f.AUTHENTICATION,1,20)||length(f.AUTHENTICATION)
    ||' l='||substr(f.LOGIN_URL,1,20)||length(f.LOGIN_URL)
    ||' l='||substr(f.LOGOUT_URL,1,20)||length(f.LOGOUT_URL)
    ||' l='||decode(substr(f.LOGO_IMAGE,1,5),
       'TEXT:','TextLogo',
       'Image Logo')
    ||','||substr(f.LOGO_IMAGE,1,20)||length(f.LOGO_IMAGE)
    ||','||substr(f.LOGO_IMAGE_ATTRIBUTES,1,20)||length(f.LOGO_IMAGE_ATTRIBUTES)
    ||' p='||f.PUBLIC_USER
    ||' p='||substr(f.PROXY_SERVER,1,20)||length(f.PROXY_SERVER)
    ||' v='||f.FLOW_VERSION
    ||' s='||decode(f.FLOW_STATUS,
        'AVAILABLE','Available',
        'AVAILABLE_W_EDIT_LINK','AvailwEL',
        'DEVELOPERS_ONLY','DevOnly',
        'RESTRICTED_ACCESS','Rests',
        'UNAVAILABLE','Unavail',
        'UNAVAILABLE_PLSQL','UnavailPL/SQL)',
        'UNAVAILABLE_URL','UnavailableRedir',
        f.flow_status)
    ||' u='||substr(f.FLOW_UNAVAILABLE_TEXT,1,20)||length(f.FLOW_UNAVAILABLE_TEXT)
    ||' r='||substr(f.RESTRICT_TO_USER_LIST,1,20)||length(f.RESTRICT_TO_USER_LIST)
    ||' d='||decode(f.APPLICATION_TAB_SET,
        1,'Allowed',0,'!Allowed',
        'Allowed')
    ||' s='||decode(f.EXACT_SUBSTITUTIONS_ONLY,
       'N','No','Y','Yes',
       f.EXACT_SUBSTITUTIONS_ONLY)
    ||' s='||decode(f.BUILD_STATUS,
       'RUN_ONLY','Run Only',
       'RUN_AND_BUILD','Run+Dev',
       f.BUILD_STATUS)
    ||' v='||substr(f.VPD,1,20)||length(f.vpd)
    ||' a='||decode(substr(f.SECURITY_SCHEME,1,1),'!','Not ')||
    nvl((select name
     from   wwv_flow_security_schemes
     where  to_char(id) = ltrim(f.SECURITY_SCHEME,'!')
     and    flow_id = f.id),
     f.SECURITY_SCHEME)
    ||' t='||f.THEME_ID
    ||' gn='||substr(f.GLOBAL_NOTIFICATION,1,20)||length(f.GLOBAL_NOTIFICATION)
    ||' pp='||decode(f.PAGE_PROTECTION_ENABLED_Y_N,'Y','Enabled','N','Disabled','Disabled')
    ||' timeout='||MAX_SESSION_LENGTH_SEC||'.'||ON_MAX_SESSION_TIMEOUT_URL||'.'||MAX_SESSION_IDLE_SEC||'.'||ON_MAX_IDLE_TIMEOUT_URL
    component_signature,
    f.security_group_id workspace_id
from wwv_flows f,
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(nv('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = w.PROVISIONING_COMPANY_ID) and
      f.security_group_id = w.PROVISIONING_COMPANY_ID and
      f.security_group_id = s.SECURITY_GROUP_ID and
      s.schema = f.owner and
      /* keep this not exists */
      not exists (
        select 1 from wwv_flow_language_map m
        where m.translation_flow_id = f.id) and
      w.PROVISIONING_COMPANY_ID != 0 and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10);
COMMENT ON TABLE apex_applications IS 'Applications defined in the current workspace or database user.';
COMMENT ON COLUMN apex_applications.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_applications.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_applications.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_applications."ALIAS" IS 'Assigns an alternate alphanumeric application identifier';
COMMENT ON COLUMN apex_applications."OWNER" IS 'Identifies the database schema that this application will parse SQL and PL/SQL statements as';
COMMENT ON COLUMN apex_applications.application_group IS 'Identifies the name of the application group this application is associated with';
COMMENT ON COLUMN apex_applications.application_group_id IS 'Identifies the ID of the application group this application is associated with';
COMMENT ON COLUMN apex_applications.home_link IS 'URL used to navigate to the home page of the application';
COMMENT ON COLUMN apex_applications.page_template IS 'The default page template for displaying pages, may be overridden at the page level';
COMMENT ON COLUMN apex_applications.error_page_template IS 'Display unexpected errors on an error page using this page template.';
COMMENT ON COLUMN apex_applications."LOGGING" IS 'Determines whether or not user activity is recorded in the activity log';
COMMENT ON COLUMN apex_applications.application_primary_language IS 'Identifies the language in which an application is developed';
COMMENT ON COLUMN apex_applications.language_derived_from IS 'For use when translating an application; specifies how Apex determines or derives the application language';
COMMENT ON COLUMN apex_applications.date_format IS 'Application default date format.  Will set NLS_DATE_FORMAT prior to showing or posting a page';
COMMENT ON COLUMN apex_applications.image_prefix IS 'Determines the virtual path the Web server uses to point to the images directory distributed with Apex';
COMMENT ON COLUMN apex_applications.authentication_scheme_type IS 'Identifies the type of authentication, sheme based or APEX internal based';
COMMENT ON COLUMN apex_applications.login_url IS 'When running this application redirect to this URL';
COMMENT ON COLUMN apex_applications.logout_url IS 'Used as the LOGOUT_URL substitution string and identifies a URL to redirect to when the user wishes to logout of the application';
COMMENT ON COLUMN apex_applications.logo_type IS 'Identifies the logo as text or an image';
COMMENT ON COLUMN apex_applications.logo IS 'Used as the LOGO substitution string, declarative name of the application which can be referenced from page templates';
COMMENT ON COLUMN apex_applications.logo_attributes IS 'Attributes used to display the logo.  HTML SPAN tag attributes for text logos and HTML IMG tag attributes for logos that are images.';
COMMENT ON COLUMN apex_applications.public_user IS 'If the APP_USER equals this database schema name then the user is considered a public or unauthenticated user.  Based on this declarative IS_PUBLIC_USER conditions are determined.';
COMMENT ON COLUMN apex_applications.proxy_server IS 'Use this proxy server when a proxy server is needed';
COMMENT ON COLUMN apex_applications.media_type IS 'Application-level Internet media type, used in the Content-Type HTTP header';
COMMENT ON COLUMN apex_applications.authentication_scheme IS 'Identifies the current authentication method used by this application. The purpose of authentication is to determine the application users identity';
COMMENT ON COLUMN apex_applications."VERSION" IS 'Includes the application''s version number on a page';
COMMENT ON COLUMN apex_applications.availability_status IS 'Specifies whether or not the application is available or unavailable for use';
COMMENT ON COLUMN apex_applications.unavailable_text IS 'This attribute in conjunction with the Availability Status.  Identifies the text to display when the application is not available';
COMMENT ON COLUMN apex_applications.restrict_to_user IS 'Use this attribute in conjunction with the Availability Status "Restricted Access". Only the users listed in this attribute can run the application.';
COMMENT ON COLUMN apex_applications.debugging IS 'Determines whether pages may be display in debug mode.  Debugging is typically on for development and turned off for production.';
COMMENT ON COLUMN apex_applications.exact_substitutions IS 'Determines if text substitutions require a trailing dot.  This values should always be Yes.  Provided for compatibility with preproduction releases.';
COMMENT ON COLUMN apex_applications.build_status IS 'Determines if the application is available for development.  Production applications can be set to "Run Only" which will cause the application to appear in the Apex Application Builder.';
COMMENT ON COLUMN apex_applications.vpd IS 'Identifies PL/SQL that is dynamically executed immediately after the user is authenticated and before any application logic is processed.  This attribute can assign security policies to restrict access to database tables and views.';
COMMENT ON COLUMN apex_applications.authorization_scheme IS 'Identifies an Authorization Scheme that will be applied to all pages of the application';
COMMENT ON COLUMN apex_applications.authorization_scheme_id IS 'Identifies an Authorization Scheme foreign key';
COMMENT ON COLUMN apex_applications.last_updated_by IS 'Apex developer who made last update';
COMMENT ON COLUMN apex_applications.last_updated_on IS 'Date of last update';
COMMENT ON COLUMN apex_applications.theme_number IS 'Identifies the applications current user interface theme';
COMMENT ON COLUMN apex_applications.global_notification IS 'This text is displayed on every page of the application that uses a page template with the #GLOBAL_NOTIFICATION# substitution string';
COMMENT ON COLUMN apex_applications.session_state_protection IS 'Enabling Session State Protection can prevent hackers from tampering with URLs within your application.  When enabled pages and items can be set to require checksums to validate inputs.';
COMMENT ON COLUMN apex_applications.maximum_session_life_seconds IS 'Maximum lifetime of session in seconds';
COMMENT ON COLUMN apex_applications.session_lifetime_exceeded_url IS 'Go to URL when session lifetime exceeded';
COMMENT ON COLUMN apex_applications.maximum_session_idle_seconds IS 'Maximum session idle time in seconds';
COMMENT ON COLUMN apex_applications.session_idle_time_exceeded_url IS 'Go to URL when session idle time exceeded';
COMMENT ON COLUMN apex_applications.pages IS 'Count of subordinate objects';
COMMENT ON COLUMN apex_applications.tabs IS 'Count of subordinate objects';
COMMENT ON COLUMN apex_applications.parent_tabs IS 'Count of subordinate objects';
COMMENT ON COLUMN apex_applications.application_items IS 'Count of subordinate objects';
COMMENT ON COLUMN apex_applications.application_processes IS 'Count of subordinate objects';
COMMENT ON COLUMN apex_applications.application_computations IS 'Count of subordinate objects';
COMMENT ON COLUMN apex_applications.shortcuts IS 'Count of subordinate objects';
COMMENT ON COLUMN apex_applications.web_services IS 'Count of subordinate objects';
COMMENT ON COLUMN apex_applications.trees IS 'Count of subordinate objects';
COMMENT ON COLUMN apex_applications.build_options IS 'Count of subordinate objects';
COMMENT ON COLUMN apex_applications.breadcrumbs IS 'Count of subordinate objects';
COMMENT ON COLUMN apex_applications.nav_bar_entries IS 'Count of subordinate objects';
COMMENT ON COLUMN apex_applications.lists IS 'Count of subordinate objects';
COMMENT ON COLUMN apex_applications.lists_of_values IS 'Count of subordinate objects';
COMMENT ON COLUMN apex_applications.themes IS 'Count of subordinate objects';
COMMENT ON COLUMN apex_applications.authentication_schemes IS 'Count of subordinate objects';
COMMENT ON COLUMN apex_applications.authorization_schemes IS 'Count of subordinate objects';
COMMENT ON COLUMN apex_applications.translation_messages IS 'Count of subordinate objects';
COMMENT ON COLUMN apex_applications.installation_scripts IS 'Count of subordinate objects';
COMMENT ON COLUMN apex_applications.cached_pages IS 'Count of pages in this application that are defined as cachable';
COMMENT ON COLUMN apex_applications.cached_regions IS 'Count of page regions in this application that are defined as cachable';
COMMENT ON COLUMN apex_applications.component_signature IS 'Identifies attributes defined at a given component level to facilitate application comparisons';
COMMENT ON COLUMN apex_applications.workspace_id IS 'Primary Key of the Workspace';