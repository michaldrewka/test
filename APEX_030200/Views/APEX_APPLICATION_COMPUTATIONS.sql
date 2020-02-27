CREATE OR REPLACE FORCE VIEW apex_application_computations (workspace,application_id,application_name,computation_sequence,computation_item,computation_point,computation_type,computation,authorization_scheme,authorization_scheme_id,build_option,condition_type,condition_expression1,condition_expression2,error_message,last_updated_by,last_updated_on,component_comment,application_computation_id,component_signature) AS
select
    w.short_name                     workspace,
    f.ID                             application_id,
    f.NAME                           application_name,
    --
    c.COMPUTATION_SEQUENCE           computation_sequence,
    c.COMPUTATION_ITEM               computation_item,
    c.COMPUTATION_POINT              computation_point,
    --c.COMPUTATION_ITEM_TYPE
    c.COMPUTATION_TYPE               computation_type,
    --c.COMPUTATION_PROCESSED          computation_processed,
    c.COMPUTATION                    computation,
    --
    decode(substr(c.SECURITY_SCHEME,1,1),'!','Not ')||
    nvl((select name
     from    wwv_flow_security_schemes
     where   to_char(id)= ltrim(c.SECURITY_SCHEME,'!')
     and     flow_id = f.id),
     c.SECURITY_SCHEME)              authorization_scheme,
    c.SECURITY_SCHEME                authorization_scheme_id,
    --
    nvl((select case when c.required_patch > 0 then PATCH_NAME else '{Not '||PATCH_NAME||'}' end PATCH_NAME
     from   wwv_flow_patches
     where  id =abs(c.REQUIRED_PATCH)),
     c.REQUIRED_PATCH)               build_option,
    --
    nvl((select r from apex_standard_conditions where d = c.COMPUTE_WHEN_TYPE),c.COMPUTE_WHEN_TYPE)
                                     condition_type,
    c.COMPUTE_WHEN                   condition_expression1,
    c.COMPUTE_WHEN_TEXT              condition_expression2,
    --
    c.COMPUTATION_ERROR_MESSAGE      error_message,
    c.LAST_UPDATED_BY                last_updated_by,
    c.LAST_UPDATED_ON                last_updated_on,
    c.COMPUTATION_COMMENT            component_comment,
    c.id                             application_computation_id,
    --
    c.COMPUTATION_ITEM
    ||' seq='||lpad(c.COMPUTATION_SEQUENCE,5,'00000')
    ||' p='||c.COMPUTATION_POINT
    ||' t='||c.COMPUTATION_TYPE
    ||' c='||substr(c.COMPUTATION,1,50)||length(c.COMPUTATION)
    ||' s='||decode(substr(c.SECURITY_SCHEME,1,1),'!','Not ')||
    nvl((select name
     from    wwv_flow_security_schemes
     where   to_char(id)= ltrim(c.SECURITY_SCHEME,'!')
     and     flow_id = f.id),
     c.SECURITY_SCHEME)
    ||' c='||c.COMPUTE_WHEN_TYPE
    ||substr(c.COMPUTE_WHEN,1,30)||length(c.COMPUTE_WHEN)
    ||substr(c.COMPUTE_WHEN_TEXT,1,30)||length(c.COMPUTE_WHEN_TEXT)
    ||' m='||substr(c.COMPUTATION_ERROR_MESSAGE,1,30)||length(c.COMPUTATION_ERROR_MESSAGE)
    component_signature
from wwv_flow_computations c,
     wwv_flows f,
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(nv('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = s.security_group_id) and
      f.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.schema = f.owner and
      f.id = c.flow_id and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      w.PROVISIONING_COMPANY_ID != 0 and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10);
COMMENT ON TABLE apex_application_computations IS 'Identifies Application Computations which can run for every page or on login';
COMMENT ON COLUMN apex_application_computations.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_computations.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_computations.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_computations.computation_sequence IS 'Identifies the sequence within the Display Point that this computation will be considered for execution';
COMMENT ON COLUMN apex_application_computations.computation_item IS 'Compute this item value; the purpose of this computation is to set this item''s value.';
COMMENT ON COLUMN apex_application_computations.computation_point IS 'Identifies a pre-defined point at which this computation will be performed';
COMMENT ON COLUMN apex_application_computations.computation_type IS 'Identifies the manner in which this computation will be performed';
COMMENT ON COLUMN apex_application_computations.computation IS 'Identifies the computation logic that corresponds to the computation type';
COMMENT ON COLUMN apex_application_computations.authorization_scheme IS 'An authorization scheme must evaluate to TRUE in order for this computation to be executed';
COMMENT ON COLUMN apex_application_computations.authorization_scheme_id IS 'Foreign Key';
COMMENT ON COLUMN apex_application_computations.condition_type IS 'Specifies a condition type from the application computation that conditionally controls whether this computation is performed.';
COMMENT ON COLUMN apex_application_computations.condition_expression1 IS 'Specifies an expression based on the specific condition type selected.';
COMMENT ON COLUMN apex_application_computations.condition_expression2 IS 'Specifies an expression based on the specific condition type selected.';
COMMENT ON COLUMN apex_application_computations.error_message IS 'Identifies the error text that is displayed if this computation raises an error';
COMMENT ON COLUMN apex_application_computations.last_updated_by IS 'Apex developer who made last update';
COMMENT ON COLUMN apex_application_computations.last_updated_on IS 'Date of last update';
COMMENT ON COLUMN apex_application_computations.component_comment IS 'Developer comment';
COMMENT ON COLUMN apex_application_computations.application_computation_id IS 'Identifies the primary key of this Application Computation';
COMMENT ON COLUMN apex_application_computations.component_signature IS 'Identifies attributes defined at a given component level to facilitate application comparisons';