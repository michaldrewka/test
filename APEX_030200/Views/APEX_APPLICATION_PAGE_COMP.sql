CREATE OR REPLACE FORCE VIEW apex_application_page_comp (workspace,application_id,application_name,page_id,page_name,item_name,execution_sequence,computation_point,computation_type,computation,condition_type,condition_expression1,condition_expression2,error_message,build_option,authorization_scheme,authorization_scheme_id,last_updated_by,last_updated_on,component_comment,component_signature,computation_id) AS
select
     w.short_name                   workspace,
     p.flow_id                      application_id,
     f.name                         application_name,
     p.id                           page_id,
     p.name                         page_name,
     --
     c.COMPUTATION_ITEM             item_name,
     c.COMPUTATION_SEQUENCE         execution_sequence,
     --
     decode(c.COMPUTATION_POINT,
       'ON_NEW_INSTANCE','On New Instance (e.g. On Login)',
       'BEFORE_HEADER','Before Header',
       'AFTER_HEADER','After Header',
       'BEFORE_BOX_BODY','Before Region(s)',
       'AFTER_BOX_BODY','After Region(s)',
       'BEFORE_FOOTER','Before Footer',
       'AFTER_FOOTER','After Footer',
       'AFTER_SUBMIT','After Submit',
       c.COMPUTATION_POINT)         computation_point,
     --
     decode(c.COMPUTATION_TYPE,
        'STATIC_ASSIGNMENT','Static Assignment',
        'FUNCTION_BODY','PL/SQL Function Body',
        'QUERY','SQL Query',
        'SQL_EXPRESSION','SQL Expression',
        'PLSQL_EXPRESSION','PL/SQL Expression',
        'ITEM_VALUE','Item Value',
        c.COMPUTATION_TYPE)         computation_type,
     --c.COMPUTATION_PROCESSED        computation_processed,
     c.COMPUTATION                  computation,
     --
     decode(c.COMPUTE_WHEN_TYPE,'%'||'null%',null,
     nvl((select r from apex_standard_conditions where d = c.COMPUTE_WHEN_TYPE),c.COMPUTE_WHEN_TYPE))
                                    condition_type,
     c.COMPUTE_WHEN                 condition_expression1,
     c.COMPUTE_WHEN_TEXT            condition_expression2,
     c.COMPUTATION_ERROR_MESSAGE    error_message,
     (select case when c.required_patch > 0 then PATCH_NAME else '{Not '||PATCH_NAME||'}' end PATCH_NAME
     from wwv_flow_patches
     where id= abs(c.REQUIRED_PATCH))    build_option,
     --
     decode(substr(c.SECURITY_SCHEME,1,1),'!','Not ')||
     nvl((select name
     from    wwv_flow_security_schemes
     where   to_char(id) = ltrim(c.SECURITY_SCHEME,'!')
     and     flow_id = f.id),
     c.SECURITY_SCHEME)             authorization_scheme,
     c.SECURITY_SCHEME              authorization_scheme_id,
     c.LAST_UPDATED_BY              last_updated_by,
     c.LAST_UPDATED_ON              last_updated_on,
     c.COMPUTATION_COMMENT          component_comment,
     --
     c.COMPUTATION_ITEM
     ||c.COMPUTATION_SEQUENCE
     ||c.COMPUTATION_POINT
     ||c.COMPUTATION_TYPE
     ||length(c.COMPUTATION)
     ||c.COMPUTE_WHEN_TYPE
     ||length(c.COMPUTE_WHEN)||length(c.COMPUTE_WHEN_TEXT)
     ||length(c.COMPUTATION_ERROR_MESSAGE)
     ||(select case when c.required_patch > 0 then PATCH_NAME else '{Not '||PATCH_NAME||'}' end PATCH_NAME
     from wwv_flow_patches
     where id= abs(c.REQUIRED_PATCH))
     ||decode(substr(c.SECURITY_SCHEME,1,1),'!','Not ')||
     nvl((select name
     from    wwv_flow_security_schemes
     where   to_char(id) = ltrim(c.SECURITY_SCHEME,'!')
     and     flow_id = f.id),
     c.SECURITY_SCHEME)             component_signature,
     --
     c.id                           computation_id
from wwv_flow_step_computations c,
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
      f.security_group_id = c.security_group_id and
      f.id = p.flow_id and
      f.id = c.flow_id and
      p.id = c.flow_step_id and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      w.PROVISIONING_COMPANY_ID != 0 and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10);
COMMENT ON TABLE apex_application_page_comp IS 'Identifies the computation of Item Session State';
COMMENT ON COLUMN apex_application_page_comp.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_page_comp.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_page_comp.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_page_comp.page_id IS 'Identifies the application';
COMMENT ON COLUMN apex_application_page_comp.page_name IS 'Identifies a page within an application';
COMMENT ON COLUMN apex_application_page_comp.item_name IS 'Item name to compute the value of';
COMMENT ON COLUMN apex_application_page_comp.execution_sequence IS 'Identifies the execution order of the computations within each computation point';
COMMENT ON COLUMN apex_application_page_comp.computation_point IS 'Identifies the computation point that the computation will be considered for execution';
COMMENT ON COLUMN apex_application_page_comp.computation_type IS 'Identifies the type of computation, reference the Computation attribute.';
COMMENT ON COLUMN apex_application_page_comp.computation IS 'Identifies the Computation which corresponds to the Computation Type';
COMMENT ON COLUMN apex_application_page_comp.condition_type IS 'Identifies the condition type used to conditionally execute the Page Computation';
COMMENT ON COLUMN apex_application_page_comp.condition_expression1 IS 'Specifies an expression based on the specific condition type selected.';
COMMENT ON COLUMN apex_application_page_comp.condition_expression2 IS 'Specifies an expression based on the specific condition type selected.';
COMMENT ON COLUMN apex_application_page_comp.error_message IS 'Identifies the error message to display if the Page Computation raises an error';
COMMENT ON COLUMN apex_application_page_comp.build_option IS 'Page Computation will be considered for execution if the Build Option is enabled';
COMMENT ON COLUMN apex_application_page_comp.authorization_scheme IS 'An authorization scheme must evaluate to TRUE in order for this computation to be considered for execution';
COMMENT ON COLUMN apex_application_page_comp.authorization_scheme_id IS 'Foriegn Key';
COMMENT ON COLUMN apex_application_page_comp.last_updated_by IS 'Apex developer who made last update';
COMMENT ON COLUMN apex_application_page_comp.last_updated_on IS 'Date of last update';
COMMENT ON COLUMN apex_application_page_comp.component_comment IS 'Developer comment';
COMMENT ON COLUMN apex_application_page_comp.component_signature IS 'Identifies attributes defined at a given component level to facilitate application comparisons';
COMMENT ON COLUMN apex_application_page_comp.computation_id IS 'Primary key of this page computation';