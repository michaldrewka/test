CREATE OR REPLACE FORCE VIEW apex_application_processes (workspace,application_id,application_name,process_sequence,process_point,process_type,process_name,"PROCESS",error_message,condition_type,condition_expression1,condition_expression2,build_option,authorization_scheme,authorization_scheme_id,last_updated_by,last_updated_on,component_comment,application_process_id,component_signature) AS
select
    w.short_name                     workspace,
    f.ID                             application_id,
    f.NAME                           application_name,
    --
    p.PROCESS_SEQUENCE               process_sequence,
    --
    decode(p.PROCESS_POINT,
      'BEFORE_HEADER','On Load: Before Header (page template header)',
      'AFTER_HEADER','On Load: After Header (page template header)',
      'BEFORE_BOX_BODY','On Load: Before Body Region(s)',
      'AFTER_BOX_BODY','On Load: After Body Region(s)',
      'BEFORE_FOOTER','On Load: Before Footer (page template footer)',
      'AFTER_FOOTER','On Load: After Footer (page template footer)',
      'ON_SUBMIT_BEFORE_COMPUTATION','On Submit: After Page Submission - Before Computations and Validations',
      'AFTER_SUBMIT','On Submit: After Page Submission - After Computations and Validations',
      'AFTER_AUTHENTICATION','On New Session: After Authentication',
      'ON_DEMAND','On Demand: Run this application process when requested by a page process',
      p.process_point)               process_point,
    --
    decode(p.PROCESS_TYPE,
      'PLSQL','PL/SQL Anonymous Block',
      p.PROCESS_TYPE)                process_type,
    --
    p.PROCESS_NAME                   process_name,
    p.PROCESS_SQL_CLOB               process,
    p.PROCESS_ERROR_MESSAGE          error_message,
    --
    nvl((select r
    from apex_standard_conditions
    where d = p.PROCESS_WHEN_TYPE ),
    p.PROCESS_WHEN_TYPE)
                                     condition_type,
    p.PROCESS_WHEN                   condition_expression1,
    p.PROCESS_WHEN2                  condition_expression2,
    --p.PROCESS_WHEN_TYPE2             ,
    --p.ITEM_NAME                      ,
    nvl((select case when p.required_patch > 0 then PATCH_NAME else '{Not '||PATCH_NAME||'}' end PATCH_NAME
     from   wwv_flow_patches
     where  id =abs(p.REQUIRED_PATCH)),
     p.REQUIRED_PATCH)               build_option,
     --
     decode(substr(p.SECURITY_SCHEME,1,1),'!','Not ')||
     nvl((select name
     from    wwv_flow_security_schemes
     where   to_char(id)= ltrim(p.SECURITY_SCHEME,'!')
     and     flow_id = f.id),
     p.SECURITY_SCHEME)              authorization_scheme,
    p.SECURITY_SCHEME                authorization_scheme_id,
    p.LAST_UPDATED_BY                last_updated_by,
    p.LAST_UPDATED_ON                last_updated_on,
    p.PROCESS_COMMENT                component_comment,
    p.id                             application_process_id,
    --
    p.PROCESS_NAME
    ||' seq='||lpad(p.PROCESS_SEQUENCE,5,'00000')
    ||' '||p.PROCESS_POINT
    ||' '||decode(p.PROCESS_TYPE,'PLSQL','PL/SQL Anonymous Block',p.PROCESS_TYPE)
    ||' txt='||dbms_lob.substr(p.PROCESS_SQL_CLOB,50,1)||dbms_lob.getlength(p.PROCESS_SQL_CLOB)
    ||' m='||substr(p.PROCESS_ERROR_MESSAGE,1,30)||length(p.PROCESS_ERROR_MESSAGE)
    ||' cond='||p.PROCESS_WHEN_TYPE
    ||substr(p.PROCESS_WHEN,1,20)||length(p.PROCESS_WHEN)
    ||substr(p.PROCESS_WHEN2,1,20)||length(p.PROCESS_WHEN2)
    ||' b='||nvl((select name from    wwv_flow_security_schemes where   to_char(id)= abs(p.REQUIRED_PATCH) and flow_id = f.id),p.REQUIRED_PATCH)
    ||' s='||decode(substr(p.SECURITY_SCHEME,1,1),'!','Not ')||
     nvl((select name
     from    wwv_flow_security_schemes
     where   to_char(id)= ltrim(p.SECURITY_SCHEME,'!')
     and     flow_id = f.id),
     p.SECURITY_SCHEME)
    component_signature
from wwv_flow_processing p,
     wwv_flows f,
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(nv('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = s.security_group_id) and
      f.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.schema = f.owner and
      s.security_group_id = w.PROVISIONING_COMPANY_ID and
      f.id = p.flow_id and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      w.PROVISIONING_COMPANY_ID != 0 and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10);
COMMENT ON TABLE apex_application_processes IS 'Identifies Application Processes which can run for every page, on login or upon demand';
COMMENT ON COLUMN apex_application_processes.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_processes.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_processes.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_processes.process_sequence IS 'Identifies the sequence that processes will be considered for execution within each process point';
COMMENT ON COLUMN apex_application_processes.process_point IS 'Identifies the point of execution of this process';
COMMENT ON COLUMN apex_application_processes.process_type IS 'Identifies the type of process this is';
COMMENT ON COLUMN apex_application_processes.process_name IS 'Identifies this process';
COMMENT ON COLUMN apex_application_processes."PROCESS" IS 'Text of the Application Process';
COMMENT ON COLUMN apex_application_processes.error_message IS 'Identifies the error message to be displayed if this processes raises an exception';
COMMENT ON COLUMN apex_application_processes.condition_type IS 'Specifies a condition type from the Application Process that conditionally controls whether this Application Process is performed.';
COMMENT ON COLUMN apex_application_processes.condition_expression1 IS 'Specifies an expression based on the specific condition type selected.';
COMMENT ON COLUMN apex_application_processes.condition_expression2 IS 'Specifies an expression based on the specific condition type selected.';
COMMENT ON COLUMN apex_application_processes.build_option IS 'Application Process will be available for execution if the Build Option is enabled';
COMMENT ON COLUMN apex_application_processes.authorization_scheme IS 'An authorization scheme must evaluate to TRUE in order for this process to be executed';
COMMENT ON COLUMN apex_application_processes.authorization_scheme_id IS 'Foreign Key';
COMMENT ON COLUMN apex_application_processes.last_updated_by IS 'Apex developer who made last update';
COMMENT ON COLUMN apex_application_processes.last_updated_on IS 'Date of last update';
COMMENT ON COLUMN apex_application_processes.component_comment IS 'Developer comment';
COMMENT ON COLUMN apex_application_processes.application_process_id IS 'Primary key of this Application Process';
COMMENT ON COLUMN apex_application_processes.component_signature IS 'Identifies attributes defined at a given component level to facilitate application comparisons';