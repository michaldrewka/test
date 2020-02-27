CREATE OR REPLACE FORCE VIEW apex_application_substitutions (workspace,application_id,application_name,substitution_string,substitution_value) AS
select w.short_name             workspace,
       f.ID                     application_id,
       f.NAME                   application_name,
       f.SUBSTITUTION_STRING_01 substitution_string,
       f.SUBSTITUTION_VALUE_01  substitution_value
from wwv_flows f,
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(v('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = w.PROVISIONING_COMPANY_ID) and
      f.security_group_id = w.PROVISIONING_COMPANY_ID and
      f.security_group_id = s.SECURITY_GROUP_ID and
      s.schema = f.owner and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      w.PROVISIONING_COMPANY_ID != 0 and
      f.SUBSTITUTION_STRING_01 is not null
union all
select w.short_name             workspace,
       f.ID                     application_id,
       f.NAME                   application_name,
       f.SUBSTITUTION_STRING_02 substitution_string,
       f.SUBSTITUTION_VALUE_02  substitution_value
from wwv_flows f,
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(v('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = w.PROVISIONING_COMPANY_ID) and
      f.security_group_id = w.PROVISIONING_COMPANY_ID and
      f.security_group_id = s.SECURITY_GROUP_ID and
      s.schema = f.owner and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      w.PROVISIONING_COMPANY_ID != 0 and
      f.SUBSTITUTION_STRING_02 is not null
union all
select w.short_name             workspace,
       f.ID                     application_id,
       f.NAME                   application_name,
       f.SUBSTITUTION_STRING_03 substitution_string,
       f.SUBSTITUTION_VALUE_03  substitution_value
from wwv_flows f,
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(v('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = w.PROVISIONING_COMPANY_ID) and
      f.security_group_id = w.PROVISIONING_COMPANY_ID and
      f.security_group_id = s.SECURITY_GROUP_ID and
      s.schema = f.owner and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      w.PROVISIONING_COMPANY_ID != 0 and
      f.SUBSTITUTION_STRING_03 is not null
union all
select w.short_name             workspace,
       f.ID                     application_id,
       f.NAME                   application_name,
       f.SUBSTITUTION_STRING_04 substitution_string,
       f.SUBSTITUTION_VALUE_04  substitution_value
from wwv_flows f,
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(v('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = w.PROVISIONING_COMPANY_ID) and
      f.security_group_id = w.PROVISIONING_COMPANY_ID and
      f.security_group_id = s.SECURITY_GROUP_ID and
      s.schema = f.owner and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      w.PROVISIONING_COMPANY_ID != 0 and
      f.SUBSTITUTION_STRING_04 is not null
union all
select w.short_name             workspace,
       f.ID                     application_id,
       f.NAME                   application_name,
       f.SUBSTITUTION_STRING_05 substitution_string,
       f.SUBSTITUTION_VALUE_05  substitution_value
from wwv_flows f,
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(v('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = w.PROVISIONING_COMPANY_ID) and
      f.security_group_id = w.PROVISIONING_COMPANY_ID and
      f.security_group_id = s.SECURITY_GROUP_ID and
      s.schema = f.owner and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      w.PROVISIONING_COMPANY_ID != 0 and
      f.SUBSTITUTION_STRING_05 is not null
union all
select w.short_name             workspace,
       f.ID                     application_id,
       f.NAME                   application_name,
       f.SUBSTITUTION_STRING_06 substitution_string,
       f.SUBSTITUTION_VALUE_06  substitution_value
from wwv_flows f,
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(v('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = w.PROVISIONING_COMPANY_ID) and
      f.security_group_id = w.PROVISIONING_COMPANY_ID and
      f.security_group_id = s.SECURITY_GROUP_ID and
      s.schema = f.owner and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      w.PROVISIONING_COMPANY_ID != 0 and
      f.SUBSTITUTION_STRING_06 is not null
union all
select w.short_name             workspace,
       f.ID                     application_id,
       f.NAME                   application_name,
       f.SUBSTITUTION_STRING_07 substitution_string,
       f.SUBSTITUTION_VALUE_07  substitution_value
from wwv_flows f,
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(v('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = w.PROVISIONING_COMPANY_ID) and
      f.security_group_id = w.PROVISIONING_COMPANY_ID and
      f.security_group_id = s.SECURITY_GROUP_ID and
      s.schema = f.owner and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      w.PROVISIONING_COMPANY_ID != 0 and
      f.SUBSTITUTION_STRING_07 is not null
union all
select w.short_name             workspace,
       f.ID                     application_id,
       f.NAME                   application_name,
       f.SUBSTITUTION_STRING_08 substitution_string,
       f.SUBSTITUTION_VALUE_08  substitution_value
from wwv_flows f,
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(v('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = w.PROVISIONING_COMPANY_ID) and
      f.security_group_id = w.PROVISIONING_COMPANY_ID and
      f.security_group_id = s.SECURITY_GROUP_ID and
      s.schema = f.owner and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      w.PROVISIONING_COMPANY_ID != 0 and
      f.SUBSTITUTION_STRING_08 is not null
union all
select w.short_name             workspace,
       f.ID                     application_id,
       f.NAME                   application_name,
       f.SUBSTITUTION_STRING_09 substitution_string,
       f.SUBSTITUTION_VALUE_09  substitution_value
from wwv_flows f,
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(v('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = w.PROVISIONING_COMPANY_ID) and
      f.security_group_id = w.PROVISIONING_COMPANY_ID and
      f.security_group_id = s.SECURITY_GROUP_ID and
      s.schema = f.owner and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      w.PROVISIONING_COMPANY_ID != 0 and
      f.SUBSTITUTION_STRING_09 is not null
union all
select w.short_name             workspace,
       f.ID                     application_id,
       f.NAME                   application_name,
       f.SUBSTITUTION_STRING_10 substitution_string,
       f.SUBSTITUTION_VALUE_10  substitution_value
from wwv_flows f,
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(v('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = w.PROVISIONING_COMPANY_ID) and
      f.security_group_id = w.PROVISIONING_COMPANY_ID and
      f.security_group_id = s.SECURITY_GROUP_ID and
      s.schema = f.owner and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      w.PROVISIONING_COMPANY_ID != 0 and
      f.SUBSTITUTION_STRING_10 is not null;
COMMENT ON TABLE apex_application_substitutions IS 'Application level definitions of substitution strings.';
COMMENT ON COLUMN apex_application_substitutions.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_substitutions.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_substitutions.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_substitutions.substitution_string IS 'Name of substitution string';
COMMENT ON COLUMN apex_application_substitutions.substitution_value IS 'Value of substitution string';