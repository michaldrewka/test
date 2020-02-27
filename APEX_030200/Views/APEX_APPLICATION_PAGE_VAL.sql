CREATE OR REPLACE FORCE VIEW apex_application_page_val (workspace,application_id,application_name,page_id,page_name,validation_name,validation_sequence,validation_type,validation_expression1,validation_expression2,condition_type,condition_expression1,condition_expression2,when_button_pressed,validation_failure_text,associated_item,error_display_location,build_option,authorization_scheme,authorization_scheme_id,last_updated_by,last_updated_on,component_comment,validation_id,component_signature) AS
select
     w.short_name                  workspace,
     p.flow_id                     application_id,
     f.name                        application_name,
     p.id                          page_id,
     p.name                        page_name,
     --
     v.VALIDATION_NAME             validation_name,
     v.VALIDATION_SEQUENCE         validation_sequence,
     --
     decode(v.VALIDATION_TYPE,
        'EXISTS','Exists',
        'FUNC_BODY_RETURNING_BOOLEAN','Function Returning Boolean',
        'FUNC_BODY_RETURNING_ERR_TEXT','Function Returning Error Text',
        'ITEM_NOT_NULL','Item specified is NOT NULL',
        'ITEM_IN_VALIDATION_CONTAINS_AT_LEAST_ONE_CHAR_IN_STRING2','Item in Expression 1 contains at least one of the characters in Expression 2',
        'ITEM_IN_VALIDATION_CONTAINS_ONLY_CHAR_IN_STRING2','Item in Expression 1 contains only characters in Expression 2',
        'ITEM_IN_VALIDATION_NOT_EQ_STRING2','Item in Expression 1 does NOT equal string literal in Expression2',
        'ITEM_IN_VALIDATION_CONTAINS_NO_CHAR_IN_STRING2','Item in Expression 1 does not contain any of the characters in Expression 2',
        'ITEM_IN_VALIDATION_EQ_STRING2','Item in Expression 1 equals string literal in Expression 2',
        'ITEM_IN_VALIDATION_NOT_IN_STRING2','Item in Expression 1 is NOT contained in Expression 2',
        'ITEM_IN_VALIDATION_IN_STRING2','Item in Expression 1 is contained in Expression 2',
        'ITEM_NOT_ZERO','Item specified is NOT zero',
        'ITEM_CONTAINS_NO_SPACES','Item specified contains no spaces',
        'ITEM_NOT_NULL_OR_ZERO','Item specified is NOT NULL or zero',
        'ITEM_IS_ALPHANUMERIC','Item specified is alphanumeric',
        'ITEM_IS_NUMERIC','Item specified is numeric',
        'ITEM_IS_DATE','Item specified is a valid date',
        'NOT_EXISTS','NOT Exists',
        'PLSQL_ERROR','PL/SQL Error',
        'PLSQL_EXPRESSION','PL/SQL Expression',
        'REGULAR_EXPRESSION','Regular Expression',
        'SQL_EXPRESION','SQL Expression',
         v.VALIDATION_TYPE)        validation_type,
     v.VALIDATION                  validation_expression1,
     v.VALIDATION2                 validation_expression2,
     --
     nvl((select r from apex_standard_conditions where d = v.VALIDATION_CONDITION_TYPE),v.VALIDATION_CONDITION_TYPE)
                                   condition_type,
     v.VALIDATION_CONDITION        condition_expression1,
     v.VALIDATION_CONDITION2       condition_expression2,
     --
     (select button_name
      from wwv_flow_step_buttons
      where id = v.WHEN_BUTTON_PRESSED
      union
      select name
      from wwv_flow_step_items
      where id = v.WHEN_BUTTON_PRESSED)
                                   when_button_pressed,
     --
     v.ERROR_MESSAGE               validation_failure_text,
     (select name from wwv_flow_step_items
      where id = v.ASSOCIATED_ITEM and
            flow_id = f.id)        associated_item,
     v.ERROR_DISPLAY_LOCATION      error_display_location,
     (select case when v.required_patch > 0 then PATCH_NAME else '{Not '||PATCH_NAME||'}' end PATCH_NAME
     from wwv_flow_patches
     where id= abs(v.REQUIRED_PATCH))   build_option,
     --
     decode(substr(v.SECURITY_SCHEME,1,1),'!','Not ')||
     nvl((select name
     from    wwv_flow_security_schemes
     where   to_char(id) = ltrim(v.SECURITY_SCHEME,'!')
     and     flow_id = f.id),
     v.SECURITY_SCHEME)            authorization_scheme,
     v.SECURITY_SCHEME             authorization_scheme_id,
     --
     v.LAST_UPDATED_BY             last_updated_by,
     v.LAST_UPDATED_ON             last_updated_on,
     v.VALIDATION_COMMENT          component_comment,
     v.id                          validation_id,
     'seq='||v.VALIDATION_SEQUENCE
     ||',item='||(select name from wwv_flow_step_items where id=v.ASSOCIATED_ITEM)
     ||',type='||v.VALIDATION_TYPE
     ||',val='||substr(v.VALIDATION,1,40)||'.'||length(v.VALIDATION)||'.'
      ||substr(v.VALIDATION2,1,40)||'.'||length(v.VALIDATION2)||'.'
     ||decode(v.VALIDATION_CONDITION_TYPE,null,null,',cond='||v.VALIDATION_CONDITION_TYPE||'.'||
         substr(v.VALIDATION_CONDITION,1,30)||length(v.VALIDATION_CONDITION)||'.'||
         substr(v.VALIDATION_CONDITION2,1,30)||length(v.VALIDATION_CONDITION2))
     component_signature
from wwv_flow_step_validations v,
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
      f.security_group_id = v.security_group_id and
      f.id = p.flow_id and
      f.id = v.flow_id and
      p.id = v.flow_step_id and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      w.PROVISIONING_COMPANY_ID != 0 and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10);
COMMENT ON TABLE apex_application_page_val IS 'Identifies Validations associated with an Application Page';
COMMENT ON COLUMN apex_application_page_val.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_page_val.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_page_val.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_page_val.page_id IS 'Identifies the application';
COMMENT ON COLUMN apex_application_page_val.page_name IS 'Identifies a page within an application';
COMMENT ON COLUMN apex_application_page_val.validation_name IS 'Identifies the name of the validation';
COMMENT ON COLUMN apex_application_page_val.validation_sequence IS 'Identifies the sequence in which this validation will be considered for execution';
COMMENT ON COLUMN apex_application_page_val.validation_type IS 'Specifies predefined validation type with the corresponding appropriate values in the Expression 1 and Expression 2 fields.';
COMMENT ON COLUMN apex_application_page_val.validation_expression1 IS 'Identifies the validation which corresponds to the specified Validation Type';
COMMENT ON COLUMN apex_application_page_val.validation_expression2 IS 'Identifies the validation which corresponds to the specified Validation Type';
COMMENT ON COLUMN apex_application_page_val.condition_type IS 'Identifies the condition type used to conditionally execute the Page Validation';
COMMENT ON COLUMN apex_application_page_val.condition_expression1 IS 'Specifies an expression based on the specific condition type selected.';
COMMENT ON COLUMN apex_application_page_val.condition_expression2 IS 'Specifies an expression based on the specific condition type selected.';
COMMENT ON COLUMN apex_application_page_val.when_button_pressed IS 'This validation will only be evaluated if the identified button is pressed';
COMMENT ON COLUMN apex_application_page_val.validation_failure_text IS 'Specifies the text that will be displayed in the event the validation raises an error';
COMMENT ON COLUMN apex_application_page_val.associated_item IS 'If applicable, select the item associated with this validation error message.';
COMMENT ON COLUMN apex_application_page_val.error_display_location IS 'The Error display location identifies where the validation error message will display. Messages can be displayed on an error page, or inline with the existing page. Inline validations are displayed in the "notification" area (defined as part of the page template), and/or within the item label.';
COMMENT ON COLUMN apex_application_page_val.build_option IS 'Page Computation will be considered for execution if the Build Option is enabled';
COMMENT ON COLUMN apex_application_page_val.authorization_scheme IS 'An authorization scheme must evaluate to TRUE in order for this validation to be considered for execution';
COMMENT ON COLUMN apex_application_page_val.authorization_scheme_id IS 'Foreign Key';
COMMENT ON COLUMN apex_application_page_val.last_updated_by IS 'Apex developer who made last update';
COMMENT ON COLUMN apex_application_page_val.last_updated_on IS 'Date of last update';
COMMENT ON COLUMN apex_application_page_val.component_comment IS 'Developer comment';
COMMENT ON COLUMN apex_application_page_val.validation_id IS 'Primary key of this page validation';
COMMENT ON COLUMN apex_application_page_val.component_signature IS 'Identifies attributes defined at a given component level to facilitate application comparisons';