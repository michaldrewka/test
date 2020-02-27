CREATE OR REPLACE FORCE VIEW apex_application_pages (workspace,application_id,application_name,page_id,page_name,page_title,media_type,tab_set,page_alias,page_function,allow_duplicate_submissions,include_apex_css_js_yn,focus_cursor,header_text,body_header,footer_text,help_text,page_template,authorization_scheme,authorization_scheme_id,build_option,page_html_header,page_html_onload,page_requires_authentication,page_access_protection,regions,items,buttons,computations,validations,processes,branches,report_columns,page_group,page_group_id,on_dup_submission_goto_url,error_notification_text,form_autocomplete,cached,cache_timeout_seconds,cached_by_user,cache_condition_type,cache_condition_exp_1,cache_condition_exp_2,page_comment,cached_regions,last_updated_by,last_updated_on,component_signature) AS
select
    w.short_name                          workspace,
    p.flow_id                             application_id,
    f.name                                application_name,
    --
    p.id                                  page_id,
    p.name                                page_name,
    p.STEP_TITLE                          page_title,
    p.media_type                          media_type,
    p.TAB_SET                             tab_set,
    p.ALIAS                               page_alias,
    decode(substr(p.PAGE_COMPONENT_MAP,1,2),
         '01','Tabular Form',
         '02','Form',
         '03','Report',
         '04','Chart',
         '05','Web Service',
         '06','Navigation Page',
         '07','Tree',
         '08','Calendar',
         '09','URL',
         '10','Dynamic HTML',
         '11','Static HTML',
         '12','Login',
         '13','Home',
         '14','Page Zero',
         '15','Empty Page',
         '16','Dynamic Form',
         '17','Wizard Form',
         'Unknown')                       page_function,
    decode(
      p.ALLOW_DUPLICATE_SUBMISSIONS,
      'N','No','Y','Yes',null,'Yes',
      p.ALLOW_DUPLICATE_SUBMISSIONS)      allow_duplicate_submissions,
    --
    decode(INCLUDE_APEX_CSS_JS_YN,null,'Yes','Y','Yes','N','No','Unknown') INCLUDE_APEX_CSS_JS_YN,
    --
    decode(p.FIRST_ITEM,
      'AUTO_FIRST_ITEM','First Item on Page',
      'NO_FIRST_ITEM','Do not focus cursor',
      p.FIRST_ITEM)                       focus_cursor,
    p.WELCOME_TEXT                        Header_Text,
    p.BOX_WELCOME_TEXT                    Body_Header,
    --p.BOX_FOOTER_TEXT                     Body_footer,
    p.FOOTER_TEXT                         Footer_Text,
    p.HELP_TEXT                           help_text,
    (select name
     from wwv_flow_templates
     where id = p.STEP_TEMPLATE)          page_template,
     --
    decode(substr(p.REQUIRED_ROLE,1,1),'!','Not ')||
    nvl((select name
     from   wwv_flow_security_schemes
     where  to_char(id) = ltrim(p.REQUIRED_ROLE,'!')
     and    flow_id = f.id),
     p.REQUIRED_ROLE)                     authorization_scheme,
    p.required_role                       authorization_scheme_id,
     --
    (select case when p.required_patch > 0 then PATCH_NAME else '{Not '||PATCH_NAME||'}' end PATCH_NAME
     from   wwv_flow_patches
     where  id =abs(p.REQUIRED_PATCH))         build_option,
    p.HTML_PAGE_HEADER                    page_html_header,
    p.HTML_PAGE_ONLOAD                    page_html_onload,
    --sec
    decode(p.PAGE_IS_PUBLIC_Y_N,
      'N','Yes','Y','No','Yes')            page_requires_Authentication,
    decode(nvl(p.PROTECTION_LEVEL,'N'),
       'N','Unrestricted',
       'C','Arguments Must Have Checksum',
       'U','No Arguments Allowed',
       'D','No URL Access',
       p.PROTECTION_LEVEL )               page_access_protection,
    --
    (select count(*) from wwv_flow_page_plugs where flow_id = f.id and page_id = p.id) regions,
    (select count(*) from wwv_flow_step_items ii where flow_id = f.id and flow_step_id = p.id and nvl(ii.display_as,'x') != 'BUTTON') items,
    (select count(*) from wwv_flow_step_buttons where flow_id = f.id and flow_step_id = p.id) +
    (select count(*) from wwv_flow_step_items ii where flow_id = f.id and flow_step_id = p.id and nvl(ii.display_as,'x') = 'BUTTON') buttons,
    (select count(*) from wwv_flow_step_computations where flow_id = f.id and flow_step_id = p.id) computations,
    (select count(*) from wwv_flow_step_validations where flow_id = f.id and flow_step_id = p.id) validations,
    (select count(*) from wwv_flow_step_processing where flow_id = f.id and flow_step_id = p.id) processes,
    (select count(*) from wwv_flow_step_branches where flow_id = f.id and flow_step_id = p.id) branches,
    (select count(*) from wwv_flow_region_report_column where flow_id = f.id and region_id in (select id from wwv_flow_page_plugs where flow_id = f.id and page_id = p.id)) report_columns,
    --
    (select 	GROUP_NAME
     from     wwv_flow_page_groups
     where    id = p.group_id and
              flow_id = p.flow_id)        page_group,
    p.group_id                            page_group_id,
    --
    ON_DUP_SUBMISSION_GOTO_URL            ,
    ERROR_NOTIFICATION_TEXT               ,
    decode(autocomplete_on_off,null,'On','ON','On','OFF','Off') form_autocomplete,
    decode(CACHE_PAGE_YN,null,'No','N','No','Y','Yes',cache_page_yn) cached,
    CACHE_TIMEOUT_SECONDS                 cache_timeout_seconds,
    decode(CACHE_BY_USER_YN,null,'No','N','No','Y','Yes',cache_by_user_yn) cached_by_user,
    CACHE_WHEN_CONDITION_TYPE             cache_condition_type,
    CACHE_WHEN_CONDITION_E1               cache_condition_exp_1,
    CACHE_WHEN_CONDITION_E2               cache_condition_exp_2,
    page_comment                          page_comment,
    (select count(*) from WWV_FLOW_PAGE_PLUGS where flow_id = f.id and page_id = p.id and PLUG_CACHING in ('CACHED','CACHED_BY_USER'))  cached_regions,
    --
    p.LAST_UPDATED_BY                     last_updated_by,
    p.LAST_UPDATED_ON                     last_updated_on,
    --
    lpad(p.id,5,'00000')
    ||p.step_title||
    ',tabset='||p.tab_set
    ||' help='||dbms_lob.getlength(p.HELP_TEXT)||
    decode(p.BOX_WELCOME_TEXT,null,null,'bodyhead='||length(p.BOX_WELCOME_TEXT))||
    decode(p.ALIAS,null,null,' alias='||p.ALIAS)||
    (select name from wwv_flow_templates where id = p.STEP_TEMPLATE)||
    --mh bug
    --nvl((select name from wwv_flow_security_schemes where to_char(id) = ltrim(p.REQUIRED_ROLE,'!') and flow_id = f.id),p.REQUIRED_ROLE)||
    nvl((select name from wwv_flow_security_schemes where to_char(id) = ltrim(p.REQUIRED_ROLE,'!') and flow_id = f.id),
    decode(substr(p.REQUIRED_ROLE,1,1),'!','Not ')||
    nvl((select name
     from   wwv_flow_security_schemes
     where  to_char(id) = ltrim(p.REQUIRED_ROLE,'!')
     and    flow_id = f.id),
     p.REQUIRED_ROLE)
    )||
    --
    (select PATCH_NAME from wwv_flow_patches where id =abs(p.REQUIRED_PATCH))||
    decode(p.FIRST_ITEM,'AUTO_FIRST_ITEM','First Item on Page','NO_FIRST_ITEM','Do not focus cursor',p.FIRST_ITEM)||
    decode(p.WELCOME_TEXT,null,null,'head='||length(p.WELCOME_TEXT))||
    decode(p.FOOTER_TEXT,null,null,',foot='||length(FOOTER_TEXT))||
    ',PgAuth='||decode(p.PAGE_IS_PUBLIC_Y_N,'N','Yes','Y','No','Yes')||
    ','||decode(nvl(p.PROTECTION_LEVEL,'N'),
       'N','Unrestricted',
       'C','Arguments Must Have Checksum',
       'U','No Arguments Allowed',
       'D','No URL Access',
       p.PROTECTION_LEVEL )||
     ',onload='||length(p.HTML_PAGE_ONLOAD)||
     ',hh='||nvl(length(p.HTML_PAGE_HEADER),0)
     component_signature
from wwv_flow_steps p,
     wwv_flows f,
     wwv_flow_company_schemas s,
     wwv_flow_companies w,
     (select nvl(nv('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = s.security_group_id) and
      f.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.schema = f.owner and
      f.security_group_id = p.security_group_id and
      f.id = p.flow_id and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      w.PROVISIONING_COMPANY_ID != 0 and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10);
COMMENT ON TABLE apex_application_pages IS 'A Page definition is the basic building block of page. Page components including regions, items, buttons, computations, branches, validations, and processes further define the definition of a page.';
COMMENT ON COLUMN apex_application_pages.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_pages.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_pages.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_pages.page_id IS 'Identifies the page.  The primary key of a page is the combination of the Application ID and the Page ID.';
COMMENT ON COLUMN apex_application_pages.page_name IS 'Identifies a page within an application';
COMMENT ON COLUMN apex_application_pages.page_title IS 'Used by page templates to display the HTML title tag';
COMMENT ON COLUMN apex_application_pages.media_type IS 'Page-level Internet media type, used in the Content-Type HTTP header';
COMMENT ON COLUMN apex_application_pages.tab_set IS 'Identifies the standard Tab Set to be used for this page. A Tab Set is a collection of tabs, the current tab is a property of the tab and is identified by page ID.';
COMMENT ON COLUMN apex_application_pages.page_alias IS 'An alphanumeric identifier which can be used as a more readable identifier then the page ID.';
COMMENT ON COLUMN apex_application_pages.page_function IS 'Primary function of the page based using a best guess method.';
COMMENT ON COLUMN apex_application_pages.allow_duplicate_submissions IS 'Determines if a rendered page may be posted more then once, for example by pressing reload.  Defaults to Yes.';
COMMENT ON COLUMN apex_application_pages.include_apex_css_js_yn IS 'Determines if Oracle APEX will automatically include APEX standard CSS and JS in the page hearder.  Typical value is Yes';
COMMENT ON COLUMN apex_application_pages.focus_cursor IS 'Specifies if Apex should automatically focus the cursor in the first field on page load';
COMMENT ON COLUMN apex_application_pages.header_text IS 'Text or HTML that will appear immediately following the Page Template Header and before the Page Template Body content.';
COMMENT ON COLUMN apex_application_pages.body_header IS 'Text or HTML that will appear before the Page Template #BOX_BODY# substitution string';
COMMENT ON COLUMN apex_application_pages.footer_text IS 'Text or HTML that will appear before the Page Template Footer and after the Page Template Body content.';
COMMENT ON COLUMN apex_application_pages.help_text IS 'Page help text';
COMMENT ON COLUMN apex_application_pages.page_template IS 'Identifies the page template, if no page template is specified the application default page template will be used';
COMMENT ON COLUMN apex_application_pages.authorization_scheme IS 'An authorization scheme must evaluate to TRUE in order for this page to be displayed';
COMMENT ON COLUMN apex_application_pages.authorization_scheme_id IS 'Foreign Key';
COMMENT ON COLUMN apex_application_pages.build_option IS 'Page will only be displayed if no Build Option is specified or if the Build Options is enabled';
COMMENT ON COLUMN apex_application_pages.page_html_header IS 'Identifies text that replaces the #HEAD# substitution string in the Page Template';
COMMENT ON COLUMN apex_application_pages.page_html_onload IS 'Identifies JavaScript or text to be substituted in for the Page Template #ONLOAD# substitution string';
COMMENT ON COLUMN apex_application_pages.page_requires_authentication IS 'Specifies whether this page has been defined as "Public" or requires authentication';
COMMENT ON COLUMN apex_application_pages.page_access_protection IS 'Identifies the Page Access Protection level which is used to restrict the setting of session state or to require checksums to pass session state';
COMMENT ON COLUMN apex_application_pages.regions IS 'Number of regions defined for this page';
COMMENT ON COLUMN apex_application_pages.items IS 'Number of items defined for this page';
COMMENT ON COLUMN apex_application_pages.buttons IS 'Number of buttons defined for this page';
COMMENT ON COLUMN apex_application_pages.computations IS 'Number of computations defined for this page';
COMMENT ON COLUMN apex_application_pages.validations IS 'Number of validations defined for this page';
COMMENT ON COLUMN apex_application_pages.processes IS 'Number of processes defined for this page';
COMMENT ON COLUMN apex_application_pages.branches IS 'Number of branches defined for this page';
COMMENT ON COLUMN apex_application_pages.report_columns IS 'Number of report columns defined for this page';
COMMENT ON COLUMN apex_application_pages.page_group IS 'Identifies assigned page group';
COMMENT ON COLUMN apex_application_pages.page_group_id IS 'Foreign Key';
COMMENT ON COLUMN apex_application_pages.on_dup_submission_goto_url IS 'Application Express displays an error message and a link to this URL to continue with the application';
COMMENT ON COLUMN apex_application_pages.error_notification_text IS 'Enter the error message displayed when an error occurs on this page. The error message will be substituted for #NOTIFICATION_MESSAGE# in the page template.';
COMMENT ON COLUMN apex_application_pages.form_autocomplete IS 'Whether or not to enable autocomplete for forms';
COMMENT ON COLUMN apex_application_pages.cached IS 'Whether or not to enable page caching';
COMMENT ON COLUMN apex_application_pages.cache_timeout_seconds IS 'Amount of time for which a cached page is valid.';
COMMENT ON COLUMN apex_application_pages.cached_by_user IS 'Cached by user yes or no';
COMMENT ON COLUMN apex_application_pages.cache_condition_type IS 'If the condition returns true, the page is displayed from cache.';
COMMENT ON COLUMN apex_application_pages.cache_condition_exp_1 IS 'Cache condition expression 1';
COMMENT ON COLUMN apex_application_pages.cache_condition_exp_2 IS 'Cache condition expression 2';
COMMENT ON COLUMN apex_application_pages.page_comment IS 'Page comment';
COMMENT ON COLUMN apex_application_pages.last_updated_by IS 'Apex developer who made last update';
COMMENT ON COLUMN apex_application_pages.last_updated_on IS 'Date of last update';
COMMENT ON COLUMN apex_application_pages.component_signature IS 'Identifies attributes defined at a given component level to facilitate application comparisons';