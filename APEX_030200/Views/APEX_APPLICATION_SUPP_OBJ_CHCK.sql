CREATE OR REPLACE FORCE VIEW apex_application_supp_obj_chck (workspace,application_id,application_name,check_id,check_name,check_sequence,check_type,check_expression1,check_expression2,error_message,condition_type,condition_expression1,condition_expression2,last_updated_by,last_updated_on,created_by,created_on) AS
select
    w.short_name                     workspace,
    f.ID                             application_id,
    f.NAME                           application_name,
    --
    c.ID                             check_id,
    c.NAME                           check_name,
    c.SEQUENCE                       check_sequence,
    --
    c.CHECK_TYPE                     check_type,
    c.CHECK_CONDITION                check_expression1,
    c.CHECK_CONDITION2               check_expression2,
    --
    --c.SUCCESS_MESSAGE                ,
    c.FAILURE_MESSAGE                error_message,
    --
    c.CONDITION_TYPE                 condition_type,
    c.CONDITION                      condition_expression1,
    c.CONDITION2                     condition_expression2,
    --
    c.LAST_UPDATED_BY                last_updated_by,
    c.LAST_UPDATED_ON                last_updated_on,
    c.CREATED_BY                     created_by,
    c.CREATED_ON                     created_on
from
     wwv_flow_install_checks c,
     wwv_flows f,
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(nv('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = s.security_group_id) and
      f.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.schema = f.owner and
      s.security_group_id = w.PROVISIONING_COMPANY_ID and
      f.id = c.flow_id and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      w.PROVISIONING_COMPANY_ID != 0 and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10);
COMMENT ON TABLE apex_application_supp_obj_chck IS 'Identifies the Supporting Object pre-installation checks to ensure the database is compatible with the objects to be installed';
COMMENT ON COLUMN apex_application_supp_obj_chck.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_supp_obj_chck.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_supp_obj_chck.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_supp_obj_chck.check_id IS 'Specifies the ID for this validation.';
COMMENT ON COLUMN apex_application_supp_obj_chck.check_name IS 'Specifies the name for this validation.';
COMMENT ON COLUMN apex_application_supp_obj_chck.check_sequence IS 'Specifies the sequence for this validation. The sequence number determines the order of evaluation.';
COMMENT ON COLUMN apex_application_supp_obj_chck.check_type IS 'Specifies the condition type that must be met during installation before installation scripts are run.';
COMMENT ON COLUMN apex_application_supp_obj_chck.check_expression1 IS 'Use this attribute to conditionally control whether installation can continue. Values correspond to the specific condition type selected.';
COMMENT ON COLUMN apex_application_supp_obj_chck.check_expression2 IS 'Use this attribute to conditionally control whether installation can continue. Values correspond to the specific condition type selected.';
COMMENT ON COLUMN apex_application_supp_obj_chck.error_message IS 'Enter a message to be displayed when the conditions of this validation are not met.';
COMMENT ON COLUMN apex_application_supp_obj_chck.condition_type IS 'Specifies a condition type from the list that conditionally controls whether this validation is performed.';
COMMENT ON COLUMN apex_application_supp_obj_chck.condition_expression1 IS 'Specifies an expression based on the specific condition type selected.';
COMMENT ON COLUMN apex_application_supp_obj_chck.condition_expression2 IS 'Specifies an expression based on the specific condition type selected.';
COMMENT ON COLUMN apex_application_supp_obj_chck.last_updated_by IS 'Apex developer who made last update';
COMMENT ON COLUMN apex_application_supp_obj_chck.last_updated_on IS 'Date of last update';
COMMENT ON COLUMN apex_application_supp_obj_chck.created_by IS 'Identifies the User Name of the Apex developer who created this check condition';
COMMENT ON COLUMN apex_application_supp_obj_chck.created_on IS 'Identifies the date that this component was created';