CREATE OR REPLACE package wwv_flow_upgrade
--
--  Copyright (c) Oracle Corporation 2001 - 2002. All Rights Reserved.
--
--    NAME
--      wwv_flow_upgrade
--
--    DESCRIPTION
--      This package facilitates flows upgrades.
--      Follow the following steps to upgrade:
--      1. Install a new version of flows into a "new flows" schema.
--      2. Login to sqlplus as the "new flows" user.
--      3. exec wwv_flow_upgrade.copy_flow_meta_data('FLOWS1','FLOWS2')
--         assume flows1 is the old schema and flows2 is the new schema.
--      4. Review the upgrade log (see example query)
--      5. exec wwv_flow_upgrade.recreate_public_synonyms('FLOWS2')
--
--    NOTES
--      Example Log Query:
--         column upgrade_sequence format 9999
--         column upgrade_action format a44 wrapped
--         column upgrade_error format a50 wrapped
--         column upgrade_command format a50 wrapped
--         set linesize 160
--         set pagesize 1000
--         select upgrade_sequence, upgrade_action, upgrade_error, upgrade_command
--         from   wwv_flow_upgrade_progress
--         order by upgrade_id desc, upgrade_sequence desc
--
--      Example Log Query 2:
--         column upgrade_sequence format 9999
--         column upgrade_action format a44 wrapped
--         column upgrade_error format a50 wrapped
--         column upgrade_command format a50 wrapped
--         set linesize 160
--         set pagesize 1000
--         select upgrade_sequence, upgrade_action, upgrade_error, upgrade_command
--         from   wwv_flow_upgrade_progress
--         order by upgrade_id desc, upgrade_sequence
--
as
g_seq                number := 0;
g_upgrade_id         number := 0;
g_version_from       varchar2(255);
g_version_to         varchar2(255);
g_f number;
c number;
p number;
i number;
g_row_cnt            number := 0;
g_session_seq1       number := 0;
g_session_seq2       number := 0;
g_pref_name          wwv_flow.flow_vc_arr;
g_pref_value         wwv_flow.flow_vc_arr;
g_pref_desc          wwv_flow.flow_vc_arr;


procedure increment_session(
    p_old_schema        in varchar2,
    p_new_schema        in varchar2)
    ;

procedure log (
   p_action  in varchar2,
   p_error   in varchar2 default null,
   p_command in varchar2 default null)
   ;

procedure drop_public_synonyms
   --
   -- drop public synonyms to flow objects
   --
   -- sqlplus example:
   --    exec wwv_flow_upgrade.drop_public_synonyms;
   --
   ;

procedure drop_private_synonyms (
   --
   -- drop private synonyms to objects
   --
   -- sqlplus example:
   --    exec wwv_flow_upgrade.drop_private_synonyms('FLOWS2';
   --
   p_owner_to          in varchar2)
   ;

procedure create_private_synonyms (
   --
   -- create private synonyms only without dropping or granting
   -- sqlplus example:
   --    exec wwv_flow_upgrade.create_private_synonyms('FLOWS2')
   --
   p_owner_to          in varchar2)
   ;

procedure create_public_synonyms (
   --
   -- create public synonyms only without dropping or granting
   -- sqlplus example:
   --    exec wwv_flow_upgrade.create_public_synonyms('FLOWS2')
   --
   p_owner_to          in varchar2)
   ;

procedure grant_public_synonyms (
   --
   -- issue grants to public synonyms only without dropping or creating
   -- sqlplus example:
   --    exec wwv_flow_upgrade.grant_public_synonyms('FLOWS2')
   --
   p_owner_to          in varchar2)
   ;


procedure recreate_public_synonyms (
   --
   -- create all needed public synonyms for a flows environent.
   --
   -- sqlplus example:
   --    exec wwv_flow_upgrade.recreate_public_synonyms('FLOWS2')
   --
   p_owner_to          in varchar2)
   ;

procedure copy_flow_meta_data (
   --
   -- Copy flows meta data from once schema to another.
   --
   -- sqlplus example:
   --    exec wwv_flow_upgrade.copy_flow_meta_data('FLOWS1','FLOWS2')
   --
   p_owner_from        in varchar2,
   p_owner_to          in varchar2)
   ;

procedure remove_meta_data (
   --
   -- Remove meta data that is not owned by the internal user.
   -- WARNING running this procedure could remove your flows data!
   -- Without flow meta data you have not flows.
   --
   p_schema in varchar2)
   ;

procedure purge_log
   --
   -- delete all entries in the flow upgrade log
   --
   ;

procedure remove_jobs
    --
    -- Remove all of the standard dbms_jobs for a schema
    ;

procedure create_jobs(
    --
    -- Create all of the standard dbms_jobs for a given schema
    p_owner     in varchar2)
    ;

procedure flows_files_objects_create(
    --
    -- Create the proper grants and synonyms for the flows_files schema
    -- used for file upload / download
    p_flow_owner    in varchar2,
    p_owner         in varchar2 default 'FLOWS_FILES'
    )
    ;

procedure flows_files_objects_remove(
    --
    -- Remove the proper grants and synonyms for the flows_files schema
    -- used for file upload / download
    p_flow_owner    in varchar2,
    p_owner         in varchar2 default 'FLOWS_FILES'
    )
    ;

procedure meta_cleanup(
    p_from      in varchar2,
    P_to        in varchar2);

procedure report_column_cleanup;

procedure template_name_cleanup(
    p_owner     in varchar2);

procedure switch_schemas(
    --
    -- This procedure should be run after an additional copy of flows is installed,
    -- as it is the final step in the upgrade process.
    -- Once this procedure is run, you will be running in the new version of flows.
    -- This will:
    --     1.  Remove all old dbms_jobs
    --     2.  Create all new dbms_jobs
    --     3.  Drop All public synonyms
    --     4.  Create all new public synonyms
    --     5.  Perform all necessary grants on public synoyms
    p_from      in varchar2,
    P_to        in varchar2)
    ;


procedure copy_prefs (
    --
    -- Copys old preferences from schema1.WWV_FLOW_PLATFORM_PREFS
    -- to schema2.WWV_FLOW_PLATFORM_PREFS
    --
    p_owner_from        in varchar2,
    p_owner_to          in varchar2)
    ;
function to_template_id(
  p_in varchar2)
  return number;

procedure upgrade_to_030200(
    p_owner             in varchar2,
    p_from              in varchar2)
    ;

procedure sw_cleanup (
    p_from    in varchar2,
    p_to      in varchar2)
    ;

end wwv_flow_upgrade;
/