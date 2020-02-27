CREATE OR REPLACE FORCE VIEW apex_application_page_proc (workspace,application_id,application_name,page_id,page_name,process_name,execution_sequence,process_point,process_type,runtime_where_clause,process_source,process_error_message,when_button_pressed,when_button_pressed_id,condition_type,condition_expression1,condition_expression2,run_process,return_key_into_item_1,return_key_into_item_2,success_message,build_option,authorization_scheme,authorization_scheme_id,last_updated_by,last_updated_on,component_comment,process_id,component_signature) AS
select
     w.short_name                   workspace,
     p.flow_id                      application_id,
     f.name                         application_name,
     p.id                           page_id,
     p.name                         page_name,
     --
     pr.process_name                process_name,
     pr.PROCESS_SEQUENCE            execution_sequence,
     --
     decode(pr.PROCESS_POINT,
       'RETURN_VALUE','DISPLAY_VALUE',
       'AFTER_AUTHENTICATION','On New Instance After Authentication',
       'BEFORE_HEADER','On Load - Before Header',
       'AFTER_HEADER','On Load - After Header',
       'BEFORE_BOX_BODY','On Load - Before Regions',
       'AFTER_BOX_BODY','On Load - After Regions',
       'BEFORE_FOOTER','On Load - Before Footer',
       'AFTER_FOOTER','On Load - After Footer',
       'ON_SUBMIT_BEFORE_COMPUTATION','On Submit - Before Computations and Validations ',
       'AFTER_SUBMIT','On Submit - After Computations and Validations',
       'AFTER_ERROR_HEADER','On Error - After Header',
       'BEFORE_ERROR_FOOTER','On Error - Before Footer',
       'BEFORE_SHOW_ITEMS','Deprecated - Before Showing page items',
       'AFTER_SHOW_ITEMS','Deprecated - After showing page items',
       pr.PROCESS_POINT)            process_point,
     --
     decode(pr.PROCESS_TYPE,
       'RETURN_VALUE','DISPLAY_VALUE',
       'GET_NEXT_OR_PREV_PK','Get Next or Previous Primary Key Value',
       'INITIALIZE_PAGINATION_FOR_ALL_PAGES','Reset Pagination For All Pages',
       'INITIALIZE_PAGE_PAGINATION','Reset Pagination For Page(s) (PageID,PageID,PageID)',
       'CLEAR_CACHE_CURRENT_FLOW','Clear Cache For Current Application (removes all session state for current application)',
       'CLEAR_CACHE_FOR_FLOWS','Clear Cache For Applications (removes all session state for listed applications)',
       'ADD_ROWS_TO_TABULAR_FORM','Add rows to tabular form',
       'WEB_SERVICE','Web Service',
       'CLOSE_WINDOW','Close popup window',
       'PLSQL','PL/SQL anonymous block',
       'PLSQL_DBMS_JOB','PL/SQL DBMS JOB (runs anonymous block asynchronously)',
       'RESET_PAGINATION','Reset Pagination',
       'CLEAR_CACHE_FOR_PAGES','Clear Cache for all Items on Pages (PageID,PageID,PageID)',
       'CLEAR_CACHE_FOR_ITEMS','Clear Cache for Items (ITEM,ITEM,ITEM)',
       'DML_FETCH_ROW','Automated Row Fetch',
       'DML_PROCESS_ROW','Automatic Row Processing (DML)',
       'SET_PREFERENCE_TO_ITEM_VALUE','Set Preference to value of Item',
       'SET_PREFERENCE_TO_ITEM_VALUE_IF_ITEM_NOT_NULL','Set Preference to value of Item if item is not null (PreferenceName:ITEM)',
       'MULTI_ROW_UPDATE','Multi Row Update',
       'RESET_SESSION_STATE','Clear Cache For Current Session (removes all state for current session)',
       'RESET_USER_PREFERENCES','Reset Preferences (remove all preferences for current user)',
       'INITIALIZE_ALL_PAGE_ITEMS','Initialize all page items',
       'ON_DEMAND','On Demand - Run an on-demand application process',
       'MULTI_ROW_DELETE','Multi Row Delete',
       pr.PROCESS_TYPE)             process_type,
     --pr.ITEM_NAME,
     pr.runtime_where_clause,
     pr.PROCESS_SQL_CLOB            process_source,
     pr.PROCESS_ERROR_MESSAGE       process_error_message,
     --
     (select button_name
      from wwv_flow_step_buttons
      where id = pr.PROCESS_WHEN_BUTTON_ID
      union
      select name
      from wwv_flow_step_items
      where id = pr.PROCESS_WHEN_BUTTON_ID)
                                    when_button_pressed,
     pr.PROCESS_WHEN_BUTTON_ID      when_button_pressed_id,
     --
     nvl((select r from apex_standard_conditions where d = pr.PROCESS_WHEN_TYPE),pr.PROCESS_WHEN_TYPE)
                                    condition_type,
     pr.PROCESS_WHEN                condition_expression1,
     pr.PROCESS_WHEN2               condition_expression2,
     --pr.PROCESS_WHEN_TYPE2,
     --
     decode(pr.PROCESS_IS_STATEFUL_Y_N,
       'Y','Once Per Session or When Reset',
       'N','Once Per Page Visit (default)',
       pr.PROCESS_IS_STATEFUL_Y_N)  run_process,
     --
     pr.RETURN_KEY_INTO_ITEM1       return_key_into_item_1,
     pr.RETURN_KEY_INTO_ITEM2       return_key_into_item_2,
     pr.PROCESS_SUCCESS_MESSAGE     success_message,
     --
     (select case when pr.required_patch > 0 then PATCH_NAME else '{Not '||PATCH_NAME||'}' end PATCH_NAME
     from wwv_flow_patches
     where id=abs(pr.REQUIRED_PATCH))    build_option,
     --
     decode(substr(pr.SECURITY_SCHEME,1,1),'!','Not ')||
     nvl((select name
      from   wwv_flow_security_schemes
      where  to_char(id) = ltrim(pr.SECURITY_SCHEME,'!')
      and    flow_id = f.id),
      pr.SECURITY_SCHEME)           authorization_scheme,
     pr.SECURITY_SCHEME             authorization_scheme_id,
     --
     pr.LAST_UPDATED_BY             last_updated_by,
     pr.LAST_UPDATED_ON             last_updated_on,
     pr.PROCESS_COMMENT             component_comment,
     pr.id                          process_id,
     --
     lpad(pr.PROCESS_SEQUENCE,5,'00000')
     ||',point='||decode(pr.PROCESS_POINT,
       'RETURN_VALUE','DISPLAY_VALUE',
       'AFTER_AUTHENTICATION','On New Instance After Authentication',
       'BEFORE_HEADER','On Load - Before Header',
       'AFTER_HEADER','On Load - After Header',
       'BEFORE_BOX_BODY','On Load - Before Regions',
       'AFTER_BOX_BODY','On Load - After Regions',
       'BEFORE_FOOTER','On Load - Before Footer',
       'AFTER_FOOTER','On Load - After Footer',
       'ON_SUBMIT_BEFORE_COMPUTATION','On Submit - Before Computations and Validations ',
       'AFTER_SUBMIT','On Submit - After Computations and Validations',
       'AFTER_ERROR_HEADER','On Error - After Header',
       'BEFORE_ERROR_FOOTER','On Error - Before Footer',
       'BEFORE_SHOW_ITEMS','Deprecated - Before Showing page items',
       'AFTER_SHOW_ITEMS','Deprecated - After showing page items',
       pr.PROCESS_POINT)
     ||',type='||decode(pr.PROCESS_TYPE,
       'RETURN_VALUE','DISPLAY_VALUE',
       'GET_NEXT_OR_PREV_PK','Get Next or Previous Primary Key Value',
       'INITIALIZE_PAGINATION_FOR_ALL_PAGES','Reset Pagination For All Pages',
       'INITIALIZE_PAGE_PAGINATION','Reset Pagination For Page(s) (PageID,PageID,PageID)',
       'CLEAR_CACHE_CURRENT_FLOW','Clear Cache For Current Application (removes all session state for current application)',
       'CLEAR_CACHE_FOR_FLOWS','Clear Cache For Applications (removes all session state for listed applications)',
       'ADD_ROWS_TO_TABULAR_FORM','Add rows to tabular form',
       'WEB_SERVICE','Web Service',
       'CLOSE_WINDOW','Close popup window',
       'PLSQL','PL/SQL anonymous block',
       'PLSQL_DBMS_JOB','PL/SQL DBMS JOB (runs anonymous block asynchronously)',
       'RESET_PAGINATION','Reset Pagination',
       'CLEAR_CACHE_FOR_PAGES','Clear Cache for all Items on Pages (PageID,PageID,PageID)',
       'CLEAR_CACHE_FOR_ITEMS','Clear Cache for Items (ITEM,ITEM,ITEM)',
       'DML_FETCH_ROW','Automated Row Fetch',
       'DML_PROCESS_ROW','Automatic Row Processing (DML)',
       'SET_PREFERENCE_TO_ITEM_VALUE','Set Preference to value of Item',
       'SET_PREFERENCE_TO_ITEM_VALUE_IF_ITEM_NOT_NULL','Set Preference to value of Item if item is not null (PreferenceName:ITEM)',
       'MULTI_ROW_UPDATE','Multi Row Update',
       'RESET_SESSION_STATE','Clear Cache For Current Session (removes all state for current session)',
       'RESET_USER_PREFERENCES','Reset Preferences (remove all preferences for current user)',
       'INITIALIZE_ALL_PAGE_ITEMS','Initialize all page items',
       'ON_DEMAND','On Demand - Run an on-demand application process',
       'MULTI_ROW_DELETE','Multi Row Delete',
       pr.PROCESS_TYPE)
       ||',src='||dbms_lob.substr(pr.PROCESS_SQL_CLOB,30,1)||'.'||
       dbms_lob.getlength(pr.PROCESS_SQL_CLOB)
       ||(select ',wbp='||button_name n from wwv_flow_step_buttons where id = pr.PROCESS_WHEN_BUTTON_ID
       union
       select ',wbp='||name n from wwv_flow_step_items where id = pr.PROCESS_WHEN_BUTTON_ID)
       ||decode(pr.PROCESS_ERROR_MESSAGE,null,null,',errm='||
       substr(pr.PROCESS_ERROR_MESSAGE,1,20)||length(pr.PROCESS_ERROR_MESSAGE))
       ||decode(pr.PROCESS_SUCCESS_MESSAGE,null,null,',succm='||
       substr(pr.PROCESS_SUCCESS_MESSAGE,1,20)||length(pr.PROCESS_SUCCESS_MESSAGE))
       ||nvl((select name from wwv_flow_security_schemes where to_char(id) = ltrim(pr.SECURITY_SCHEME,'!') and flow_id = f.id),pr.SECURITY_SCHEME)
       ||',cond='||pr.PROCESS_WHEN_TYPE
       ||substr(pr.PROCESS_WHEN,1,20)||length(pr.PROCESS_WHEN)||'.'
       ||substr(pr.PROCESS_WHEN2,1,20)||length(pr.PROCESS_WHEN2)
       ||(select PATCH_NAME from wwv_flow_patches where id=abs(pr.REQUIRED_PATCH))
       ||decode(pr.PROCESS_IS_STATEFUL_Y_N,'Y','Once Per Session or When Reset','N','Once Per Page Visit (default)',pr.PROCESS_IS_STATEFUL_Y_N)
     ||',key='||pr.RETURN_KEY_INTO_ITEM1||pr.RETURN_KEY_INTO_ITEM1
     component_signature
from wwv_flow_step_processing pr,
     wwv_flow_steps p,
     wwv_flows f,
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(v('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = f.security_group_id) and
      f.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.schema = f.owner and
      f.security_group_id = p.security_group_id and
      f.security_group_id = pr.security_group_id and
      f.id = p.flow_id and
      f.id = pr.flow_id and
      p.id = pr.flow_step_id and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      w.PROVISIONING_COMPANY_ID != 0 and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10);
COMMENT ON TABLE apex_application_page_proc IS 'Identifies SQL or PL/SQL processing associated with a page';
COMMENT ON COLUMN apex_application_page_proc.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_page_proc.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_page_proc.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_page_proc.page_id IS 'Identifies the application';
COMMENT ON COLUMN apex_application_page_proc.page_name IS 'Identifies a page within an application';
COMMENT ON COLUMN apex_application_page_proc.process_name IS 'Identifies Page Process Name';
COMMENT ON COLUMN apex_application_page_proc.execution_sequence IS 'Identifies order of execution within each Process Point';
COMMENT ON COLUMN apex_application_page_proc.process_point IS 'Specifies the point at which the process is executed';
COMMENT ON COLUMN apex_application_page_proc.process_type IS 'Identifies process type';
COMMENT ON COLUMN apex_application_page_proc.runtime_where_clause IS 'Appended to Oracle APEX generated SELECT, UPDATE, and DELETE statements';
COMMENT ON COLUMN apex_application_page_proc.process_source IS 'Identifies the corresponding process text for the process type';
COMMENT ON COLUMN apex_application_page_proc.process_error_message IS 'Error message to be displayed when this process raises an exception';
COMMENT ON COLUMN apex_application_page_proc.when_button_pressed IS 'This process will only be executed if a user clicks the button identified';
COMMENT ON COLUMN apex_application_page_proc.when_button_pressed_id IS 'Foreign key to button';
COMMENT ON COLUMN apex_application_page_proc.condition_type IS 'Identifies the condition type used to conditionally execute the Page Process';
COMMENT ON COLUMN apex_application_page_proc.condition_expression1 IS 'Specifies an expression based on the specific condition type selected.';
COMMENT ON COLUMN apex_application_page_proc.condition_expression2 IS 'Specifies an expression based on the specific condition type selected.';
COMMENT ON COLUMN apex_application_page_proc.run_process IS 'Specifies when the process should run; Once Per Session or When Reset, or Once Per Page Visit';
COMMENT ON COLUMN apex_application_page_proc.return_key_into_item_1 IS 'After performing a SQL INSERT statement, take the first (or only) column of the primary key and return it into this item. Use this feature to get back ID fields populated from sequences within database triggers.';
COMMENT ON COLUMN apex_application_page_proc.return_key_into_item_2 IS 'After performing a SQL INSERT statement, take the second column of the primary key and return it into this item. Use this feature to get back ID fields populated from sequences within database triggers.';
COMMENT ON COLUMN apex_application_page_proc.success_message IS 'Identifies the message to be displayed upon successful execution of this Page Process';
COMMENT ON COLUMN apex_application_page_proc.build_option IS 'Page Process will be considered for execution if the Build Option is enabled';
COMMENT ON COLUMN apex_application_page_proc.authorization_scheme IS 'An authorization scheme must evaluate to TRUE in order for this Page Process to be considered for execution';
COMMENT ON COLUMN apex_application_page_proc.authorization_scheme_id IS 'Foreign Key';
COMMENT ON COLUMN apex_application_page_proc.last_updated_by IS 'Apex developer who made last update';
COMMENT ON COLUMN apex_application_page_proc.last_updated_on IS 'Date of last update';
COMMENT ON COLUMN apex_application_page_proc.component_comment IS 'Developer comment';
COMMENT ON COLUMN apex_application_page_proc.process_id IS 'Primary Key of this Page Process';
COMMENT ON COLUMN apex_application_page_proc.component_signature IS 'Identifies attributes defined at a given component level to facilitate application comparisons';