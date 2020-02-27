CREATE OR REPLACE FORCE VIEW apex_application_supp_objects (workspace,application_id,application_name,build_options,include_in_application_export,welcome_message,license_message,validation_message,installation_message,installation_success_message,installation_failure_message,installation_scripts,upgrade_when_query,upgrade_message,upgrade_confirm_message,upgrade_success_message,upgrade_failure_message,upgrade_scripts,deinstall_message,deinstall_success_message,deinstallation_script,last_updated_by,last_updated_on,created_by,created_on,configuration_message,build_options_message,required_free_kb,required_system_privileges,required_names_available,supporting_object_id) AS
select
    w.short_name                     workspace,
    f.ID                             application_id,
    f.NAME                           application_name,
    --
    (select count(*)
    from wwv_flow_install_build_opt
    where install_id = i.id)         build_options,
    --
    decode(i.INCLUDE_IN_EXPORT_YN,
      'Y','Yes',
      'N','No',
      i.INCLUDE_IN_EXPORT_YN)        include_in_application_export,
    i.WELCOME_MESSAGE                ,
    i.LICENSE_MESSAGE                ,
    i.VALIDATION_MESSAGE             ,
    --
    i.INSTALL_MESSAGE                installation_message,
    i.INSTALL_SUCCESS_MESSAGE        installation_success_message,
    i.INSTALL_FAILURE_MESSAGE        installation_failure_message,
    (select count(*)
     from wwv_flow_install_scripts
     where i.id = install_id
       and nvl(script_type,'INSTALL') = 'INSTALL')
                                     installation_scripts,
    --
    i.get_version_sql_query          upgrade_when_query,
    i.upgrade_message                upgrade_message,
    i.upgrade_confirm_message        upgrade_confirm_message,
    i.upgrade_success_message        upgrade_success_message,
    i.upgrade_failure_message        upgrade_failure_message,
    (select count(*)
     from wwv_flow_install_scripts
     where i.id = install_id
       and nvl(script_type,'INSTALL') = 'UPGRADE')
                                     upgrade_scripts,
    --
    --
    i.DEINSTALL_MESSAGE              ,
    i.DEINSTALL_SUCCESS_MESSAGE      ,
    --i.DEINSTALL_FAILURE_MESSAGE      ,
    i.DEINSTALL_SCRIPT               deinstallation_script,
    --
    --i.PROMPT_SUBSTITUTION_01_YN      ,
    --i.PROMPT_SUBSTITUTION_02_YN      ,
    --i.PROMPT_SUBSTITUTION_03_YN      ,
    --i.PROMPT_SUBSTITUTION_04_YN      ,
    --i.PROMPT_SUBSTITUTION_05_YN      ,
    --i.PROMPT_SUBSTITUTION_06_YN      ,
    --i.PROMPT_SUBSTITUTION_07_YN      ,
    --i.PROMPT_SUBSTITUTION_08_YN      ,
    --i.PROMPT_SUBSTITUTION_09_YN      ,
    --i.PROMPT_SUBSTITUTION_10_YN      ,
    --i.PROMPT_SUBSTITUTION_11_YN      ,
    --i.PROMPT_SUBSTITUTION_12_YN      ,
    --i.PROMPT_SUBSTITUTION_13_YN      ,
    --i.PROMPT_SUBSTITUTION_14_YN      ,
    --i.PROMPT_SUBSTITUTION_15_YN      ,
    --i.PROMPT_SUBSTITUTION_16_YN      ,
    --i.PROMPT_SUBSTITUTION_17_YN      ,
    --i.PROMPT_SUBSTITUTION_18_YN      ,
    --i.PROMPT_SUBSTITUTION_19_YN      ,
    --i.PROMPT_SUBSTITUTION_20_YN      ,
    ----
    --i.PROMPT_IF_MULT_AUTH_YN         ,
    --i.PROMPT_BUILD_OPTIONS           ,
    --
    i.LAST_UPDATED_BY                ,
    i.LAST_UPDATED_ON                ,
    i.CREATED_BY                     ,
    i.CREATED_ON                     ,
    --
    --i.INSTALL_PROMPT_01              ,
    --i.INSTALL_PROMPT_02              ,
    --i.INSTALL_PROMPT_03              ,
    --i.INSTALL_PROMPT_04              ,
    --i.INSTALL_PROMPT_05              ,
    --i.INSTALL_PROMPT_06              ,
    --i.INSTALL_PROMPT_07              ,
    --i.INSTALL_PROMPT_08              ,
    --i.INSTALL_PROMPT_09              ,
    --i.INSTALL_PROMPT_10              ,
    --i.INSTALL_PROMPT_11              ,
    --i.INSTALL_PROMPT_12              ,
    --i.INSTALL_PROMPT_13              ,
    --i.INSTALL_PROMPT_14              ,
    --i.INSTALL_PROMPT_15              ,
    --i.INSTALL_PROMPT_16              ,
    --i.INSTALL_PROMPT_17              ,
    --i.INSTALL_PROMPT_18              ,
    --i.INSTALL_PROMPT_19              ,
    --i.INSTALL_PROMPT_20              ,
    i.CONFIGURATION_MESSAGE          ,
    -- obsolete i.TRIGGER_INSTALL_WHEN_COND      ,
    -- obsolete i.TRIGGER_INSTALL_WHEN_EXP1      ,
    -- obsolete i.TRIGGER_INSTALL_WHEN_EXP2      ,
    -- obsolete i.TRIGGER_FAILURE_MESSAGE        ,
    i.BUILD_OPTIONS_MESSAGE          ,
    i.REQUIRED_FREE_KB               ,
    i.REQUIRED_SYS_PRIVS             required_system_privileges,
    i.REQUIRED_NAMES_AVAILABLE       ,
    --
    i.id                             supporting_object_id
from wwv_flow_install i,
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
COMMENT ON TABLE apex_application_supp_objects IS 'Identifies the Supporting Object installation messages';
COMMENT ON COLUMN apex_application_supp_objects.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_supp_objects.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_supp_objects.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_supp_objects.build_options IS 'Count of Build Options referenced in this applications supporting object installation wizard';
COMMENT ON COLUMN apex_application_supp_objects.include_in_application_export IS 'Flag that specifies if the application export will include the supporting object definitions and scripts';
COMMENT ON COLUMN apex_application_supp_objects.welcome_message IS 'After successfully importing and installing an application definition, the installation wizard prompts the user to install supporting objects for the application.';
COMMENT ON COLUMN apex_application_supp_objects.license_message IS 'If the use of this application requires the user to accept a license, enter it here. The user will be prompted to accept the message before installing database objects.';
COMMENT ON COLUMN apex_application_supp_objects.validation_message IS 'Message to display above the list of installation validations when this application installs.';
COMMENT ON COLUMN apex_application_supp_objects.installation_message IS 'Message to display during installation confirmation before the installation scripts are run and configuration options are applied.';
COMMENT ON COLUMN apex_application_supp_objects.installation_success_message IS 'Enter a message to display after all installation scripts have run without errors.';
COMMENT ON COLUMN apex_application_supp_objects.installation_failure_message IS 'Enter a message to display after installation scripts have been run with errors.';
COMMENT ON COLUMN apex_application_supp_objects.installation_scripts IS 'Count of installation SQL scripts';
COMMENT ON COLUMN apex_application_supp_objects.upgrade_when_query IS 'SQL query that returns at least one row if supporting objects exist, which means an upgrade should be performed';
COMMENT ON COLUMN apex_application_supp_objects.upgrade_message IS 'Message to display before this application''s supporting objects are upgraded';
COMMENT ON COLUMN apex_application_supp_objects.upgrade_confirm_message IS 'Message to display during upgrade confirmation before the upgrade scripts are run and configuration options are applied';
COMMENT ON COLUMN apex_application_supp_objects.upgrade_success_message IS 'Message to display after all upgrade scripts have run without errors';
COMMENT ON COLUMN apex_application_supp_objects.upgrade_failure_message IS 'Message to display after upgrade scripts have been run with errors';
COMMENT ON COLUMN apex_application_supp_objects.upgrade_scripts IS 'Count of upgrade SQL scripts';
COMMENT ON COLUMN apex_application_supp_objects.deinstall_message IS 'Enter a message to display during deinstallation confirmation when this application is deinstalled.';
COMMENT ON COLUMN apex_application_supp_objects.deinstall_success_message IS 'Enter a message to display after all deinstallation scripts have run.';
COMMENT ON COLUMN apex_application_supp_objects.deinstallation_script IS 'The deinstallation SQL script, uses SQL*plus like script syntax';
COMMENT ON COLUMN apex_application_supp_objects.last_updated_by IS 'Apex developer who made last update';
COMMENT ON COLUMN apex_application_supp_objects.last_updated_on IS 'Date of last update';
COMMENT ON COLUMN apex_application_supp_objects.created_by IS 'Apex developer who created the component';
COMMENT ON COLUMN apex_application_supp_objects.created_on IS 'Date created';
COMMENT ON COLUMN apex_application_supp_objects.configuration_message IS 'Message to display above the application substitution prompts when this application installs.';
COMMENT ON COLUMN apex_application_supp_objects.build_options_message IS 'Message to display above the build option prompts when this application installs.';
COMMENT ON COLUMN apex_application_supp_objects.required_free_kb IS 'Freespace required to install this application.';
COMMENT ON COLUMN apex_application_supp_objects.required_system_privileges IS 'Identifies the system privileges required to install this application.';
COMMENT ON COLUMN apex_application_supp_objects.required_names_available IS 'Installation is prevented if these objects already exist in the parsing schema.';
COMMENT ON COLUMN apex_application_supp_objects.supporting_object_id IS 'Primary Key of this component';