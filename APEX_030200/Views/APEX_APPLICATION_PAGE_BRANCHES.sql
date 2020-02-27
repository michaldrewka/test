CREATE OR REPLACE FORCE VIEW apex_application_page_branches (workspace,application_id,application_name,page_id,page_name,branch_action,branch_point,when_button_pressed,branch_type,process_sequence,condition_type,condition_expression1,condition_expression2,save_state_before_branch,build_option,authorization_scheme,authorization_scheme_id,last_updated_by,last_updated_on,component_comment,branch_id,branch_when_button_id,component_signature) AS
select
     w.short_name                   workspace,
     p.flow_id                      application_id,
     f.name                         application_name,
     p.id                           page_id,
     p.name                         page_name,
     --
     b.BRANCH_ACTION                branch_action,
     b.BRANCH_POINT                 branch_point,
     decode(b.BRANCH_WHEN_BUTTON_ID,
     null,null,(select button_name
      from wwv_flow_step_buttons
      where id = b.BRANCH_WHEN_BUTTON_ID
      union
      select name
      from wwv_flow_step_items
      where id = b.BRANCH_WHEN_BUTTON_ID))
                                    when_button_pressed,
     decode(b.BRANCH_TYPE,
       'BRANCH_TO_FUNCTION_RETURNING_PAGE','Branch to Function Returning a Page',
       'BRANCH_TO_FUNCTION_RETURNING_URL', 'Branch to Function Returning a URL',
       'BRANCH_TO_PAGE_IDENT_BY_ITEM',     'Branch to Page Identified by Item (Use Item Name)',
       'BRANCH_TO_PAGE_ACCEPT',            'Branch to Page Accept Processing (not common)',
       'BRANCH_TO_STEP',                   'Branch to Page',
       'BRANCH_TO_URL_IDENT_BY_ITEM',      'Branch to URL Identified by Item (Use Item Name)',
       'PLSQL',                            'Branch to PL/SQL Procedure',
       'REDIRECT_URL',                     'Branch to Page or URL',
       b.BRANCH_TYPE)               branch_type,
     b.BRANCH_SEQUENCE              process_sequence,
     --b.CLEAR_PAGE_CACHE,
     nvl((select r from apex_standard_conditions where d = b.BRANCH_CONDITION_TYPE),b.BRANCH_CONDITION_TYPE)
                                    condition_type,
     b.BRANCH_CONDITION             condition_expression1,
     b.BRANCH_CONDITION_TEXT        condition_expression2,
     decode(nvl(b.save_state_before_branch_yn,'N'),'N','No','Yes')  save_state_before_branch,
     (select case when b.required_patch > 0 then PATCH_NAME else '{Not '||PATCH_NAME||'}' end PATCH_NAME
     from wwv_flow_patches
     where id=  abs(b.REQUIRED_PATCH))   build_option,
     --
     decode(substr(b.SECURITY_SCHEME,1,1),'!','Not ')||
     nvl((select name
     from    wwv_flow_security_schemes
     where   to_char(id) = ltrim(b.SECURITY_SCHEME,'!')
     and     flow_id = f.id),
     b.SECURITY_SCHEME)             authorization_scheme,
     b.SECURITY_SCHEME              authorization_scheme_id,
     b.LAST_UPDATED_BY              last_updated_by,
     b.LAST_UPDATED_ON              last_updated_on,
     b.BRANCH_COMMENT               component_comment,
     b.id                           branch_id,
     b.BRANCH_WHEN_BUTTON_ID        branch_when_button_id,
     --
     'Point='||BRANCH_POINT
     ||',seq='||lpad(b.BRANCH_SEQUENCE,5,'00000')
     ||',act='||substr(b.BRANCH_ACTION,1,30)||'.'||length(b.BRANCH_ACTION)
     ||',type='||decode(b.BRANCH_TYPE,
       'BRANCH_TO_FUNCTION_RETURNING_PAGE','Branch to Function Returning a Page',
       'BRANCH_TO_FUNCTION_RETURNING_URL', 'Branch to Function Returning a URL',
       'BRANCH_TO_PAGE_IDENT_BY_ITEM',     'Branch to Page Identified by Item (Use Item Name)',
       'BRANCH_TO_PAGE_ACCEPT',            'Branch to Page Accept Processing (not common)',
       'BRANCH_TO_STEP',                   'Branch to Page',
       'BRANCH_TO_URL_IDENT_BY_ITEM',      'Branch to URL Identified by Item (Use Item Name)',
       'PLSQL',                            'Branch to PL/SQL Procedure',
       'REDIRECT_URL',                     'Branch to Page or URL',
       b.BRANCH_TYPE)||'.'
     ||decode(b.BRANCH_WHEN_BUTTON_ID,null,null,(select button_name from wwv_flow_step_buttons where id = b.BRANCH_WHEN_BUTTON_ID
     union
     select name from wwv_flow_step_items where id = b.BRANCH_WHEN_BUTTON_ID))||
     decode(substr(b.SECURITY_SCHEME,1,1),'!','Not ')||
     nvl((select name from wwv_flow_security_schemes where to_char(id) = ltrim(b.SECURITY_SCHEME,'!') and flow_id = f.id),b.SECURITY_SCHEME)||
     'cond='||nvl((select r from apex_standard_conditions where d = b.BRANCH_CONDITION_TYPE),b.BRANCH_CONDITION_TYPE)||
        '.'||substr(b.BRANCH_CONDITION,1,20)||'.'||length(b.BRANCH_CONDITION)||'.'||length(b.BRANCH_CONDITION_TEXT)||
     'save='||decode(nvl(b.save_state_before_branch_yn,'N'),'N','No','Yes')||
     'build='||(select PATCH_NAME from wwv_flow_patches where id=  abs(b.REQUIRED_PATCH))
     component_signature
from wwv_flow_step_branches b,
     wwv_flow_steps p,
     wwv_flows f,
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(v('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = s.security_group_id) and
      f.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.schema = f.owner and
      f.security_group_id = p.security_group_id and
      f.security_group_id = b.security_group_id and
      f.id = p.flow_id and
      f.id = b.flow_id and
      p.id = b.flow_step_id and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      w.PROVISIONING_COMPANY_ID != 0 and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10);
COMMENT ON TABLE apex_application_page_branches IS 'Identifies branch processing associated with a page.  A branch is a directive to navigate to a page or URL which is run at the conclusion of page accept processing.';
COMMENT ON COLUMN apex_application_page_branches.workspace IS 'A branch fires on page submit and direct a posted page to the next page to view';
COMMENT ON COLUMN apex_application_page_branches.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_page_branches.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_page_branches.page_id IS 'Identifies the application';
COMMENT ON COLUMN apex_application_page_branches.page_name IS 'Identifies a page within an application';
COMMENT ON COLUMN apex_application_page_branches.branch_action IS 'Identifies the branch target, typically a page';
COMMENT ON COLUMN apex_application_page_branches.branch_point IS 'Identifies the point at which the branch will be evaluated for execution';
COMMENT ON COLUMN apex_application_page_branches.when_button_pressed IS 'Identifies a button that must be pressed to consider the branch for execution';
COMMENT ON COLUMN apex_application_page_branches.branch_type IS 'Identifies how the branch action will be processed, typically identifies a page ID or URL';
COMMENT ON COLUMN apex_application_page_branches.process_sequence IS 'Identifies the order in which the branch will be evaluated for execution for each branch point';
COMMENT ON COLUMN apex_application_page_branches.condition_type IS 'Identifies a condition that must be met in order for this branch to be processed';
COMMENT ON COLUMN apex_application_page_branches.condition_expression1 IS 'Identifies a condition which is specific to the selected condition type';
COMMENT ON COLUMN apex_application_page_branches.condition_expression2 IS 'Identifies a condition which is specific to the selected condition type';
COMMENT ON COLUMN apex_application_page_branches.save_state_before_branch IS 'Yes - Save session state and clear cache before branch. No - Redirect to URL with clear-cache and session state settings';
COMMENT ON COLUMN apex_application_page_branches.build_option IS 'Build options enabled or disable components';
COMMENT ON COLUMN apex_application_page_branches.authorization_scheme IS 'An authorization scheme must evaluate to TRUE in order for this component to be processed';
COMMENT ON COLUMN apex_application_page_branches.authorization_scheme_id IS 'Foreign Key';
COMMENT ON COLUMN apex_application_page_branches.last_updated_by IS 'Apex developer who made last update';
COMMENT ON COLUMN apex_application_page_branches.last_updated_on IS 'Date of last update';
COMMENT ON COLUMN apex_application_page_branches.component_comment IS 'Developer comment';
COMMENT ON COLUMN apex_application_page_branches.branch_id IS 'Primary key for this component';
COMMENT ON COLUMN apex_application_page_branches.branch_when_button_id IS 'Foreign Key to Branch When Button ID';
COMMENT ON COLUMN apex_application_page_branches.component_signature IS 'Identifies attributes defined at a given component level to facilitate application comparisons';