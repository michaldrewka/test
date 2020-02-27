CREATE OR REPLACE FORCE VIEW apex_release (version_no,api_compatibility,patch_applied) AS
select (select wwv_flows_release from dual) version_no,
       (select wwv_flows_version from dual) api_compatibility,
       (select wwv_flow_platform.get_preference('APEX_3_0_1_PATCH') from dual) patch_applied
  from dual;
COMMENT ON TABLE apex_release IS 'Identifies this release of Application Express';
COMMENT ON COLUMN apex_release.version_no IS 'The specific version number of this Application Express instance';
COMMENT ON COLUMN apex_release.api_compatibility IS 'The version of the API that this release is compatible with for importing applications or components';
COMMENT ON COLUMN apex_release.patch_applied IS 'The date a patch was applied if this instance was patched';