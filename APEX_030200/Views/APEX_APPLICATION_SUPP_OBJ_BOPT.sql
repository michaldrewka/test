CREATE OR REPLACE FORCE VIEW apex_application_supp_obj_bopt (workspace,application_id,application_name,build_option,default_status,developer_comment,install_build_option_id) AS
select
    w.short_name                     workspace,
    f.ID                             application_id,
    f.NAME                           application_name,
    --
    (select patch_name
     from   wwv_flow_patches
     where  id=i.BUILD_OPT_ID)       build_option,
    --
    decode(
    (select patch_status
     from   wwv_flow_patches
     where  id=i.BUILD_OPT_ID),
     'INCLUDE','Include',
     'EXCLUDE','Exclude',
     i.BUILD_OPT_ID)                 default_status,
    --
    (select patch_comment
     from   wwv_flow_patches
     where  id=i.BUILD_OPT_ID)       developer_comment,
     i.id                            install_build_option_id
from wwv_flow_install_build_opt i,
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
COMMENT ON TABLE apex_application_supp_obj_bopt IS 'Identifies the Application Build Options that will be exposed to the Supporting Object installation';
COMMENT ON COLUMN apex_application_supp_obj_bopt.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_supp_obj_bopt.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_supp_obj_bopt.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_supp_obj_bopt.build_option IS 'Identifies the Application Build Option that will be prompted for during the installation of the Supporting Objects';
COMMENT ON COLUMN apex_application_supp_obj_bopt.default_status IS 'Identifies the default Status (Excluded, Included) of the Build Option';
COMMENT ON COLUMN apex_application_supp_obj_bopt.developer_comment IS 'Identifies the developer comment applied to the Build Option definition';
COMMENT ON COLUMN apex_application_supp_obj_bopt.install_build_option_id IS 'Primary Key of this Supporting Object Build Option';