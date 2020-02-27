CREATE OR REPLACE FORCE VIEW apex_application_supp_obj_scr (workspace,application_id,application_name,script_name,execution_sequence,script_type,sql_script,condition_type,condition_expression1,condition_expression2,last_updated_by,last_updated_on,created_by,created_on,supporting_object_script_id) AS
select
    w.short_name                     workspace,
    f.ID                             application_id,
    f.NAME                           application_name,
    --
    i.NAME                           script_name,
    i.SEQUENCE                       execution_sequence,
    decode(i.SCRIPT_TYPE,
           'UPGRADE','Upgrade',
           'INSTALL','Install',
           i.SCRIPT_TYPE)            script_type,
    --
    i.SCRIPT                         sql_script,
    --
    i.CONDITION_TYPE                 condition_type,
    i.CONDITION                      condition_expression1,
    i.CONDITION2                     condition_expression2,
    --
    i.LAST_UPDATED_BY                last_updated_by,
    i.LAST_UPDATED_ON                last_updated_on,
    i.CREATED_BY                     created_by,
    i.CREATED_ON                     created_on,
    --
    i.ID                             supporting_object_script_id
from wwv_flow_install_scripts i,
     wwv_flows f,
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(nv('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = s.security_group_id) and
      f.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.schema = f.owner and
      s.security_group_id = w.PROVISIONING_COMPANY_ID and
      f.id = i.flow_id and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      w.PROVISIONING_COMPANY_ID != 0 and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10);
COMMENT ON TABLE apex_application_supp_obj_scr IS 'Identifies the Supporting Object installation SQL Scripts';
COMMENT ON COLUMN apex_application_supp_obj_scr.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_supp_obj_scr.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_supp_obj_scr.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_supp_obj_scr.script_name IS 'Identifies the name of the installation SQL Script';
COMMENT ON COLUMN apex_application_supp_obj_scr.execution_sequence IS 'Identifies the execution of the installation SQL Script';
COMMENT ON COLUMN apex_application_supp_obj_scr.script_type IS 'Identifies whether this is an install or upgrade SQL Script';
COMMENT ON COLUMN apex_application_supp_obj_scr.sql_script IS 'Identifies the SQL Script.  Most basic SQL*plus syntax can be used to create database objects and load sample data.';
COMMENT ON COLUMN apex_application_supp_obj_scr.condition_type IS 'Identifies the condition type used to conditionally execute the Installation SQL Script';
COMMENT ON COLUMN apex_application_supp_obj_scr.condition_expression1 IS 'Specifies an expression based on the specific condition type selected.';
COMMENT ON COLUMN apex_application_supp_obj_scr.condition_expression2 IS 'Specifies an expression based on the specific condition type selected.';
COMMENT ON COLUMN apex_application_supp_obj_scr.last_updated_by IS 'Apex developer who made last update';
COMMENT ON COLUMN apex_application_supp_obj_scr.last_updated_on IS 'Date of last update';
COMMENT ON COLUMN apex_application_supp_obj_scr.created_by IS 'Apex User Name of the developer who created this SQL Script';
COMMENT ON COLUMN apex_application_supp_obj_scr.created_on IS 'Date that this SQL Script was created';
COMMENT ON COLUMN apex_application_supp_obj_scr.supporting_object_script_id IS 'Primary Key of this SQL Script component';