CREATE OR REPLACE FORCE VIEW apex_themes (theme_number,theme_name,theme_type,workspace,workspace_id) AS
select x.theme_number,
       x.theme_name,
       x.theme_type,
       x.workspace,
       x.workspace_id
from (-- repository theme
      select 'Theme - '||i theme_name,
             i theme_number,
             'BUILTIN' theme_type,
             null workspace,
             null workspace_id
      from wwv_flow_dual100
      where i <=20
      union all
      -- public theme
      select distinct htf.escape_sc(t.theme_name)||' - '||t.theme_id theme_name,
             theme_id theme_number,
             'PUBLIC' theme_type,
             null workspace,
             null workspace_id
      from wwv_flow_themes t,
           wwv_flow_companies w,
           wwv_flow_company_schemas s,
           (select nvl(nv('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
      where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = w.provisioning_company_id) and
            s.security_group_id = w.provisioning_company_id and
            (user in ('SYS','SYSTEM', 'APEX_030200') or w.provisioning_company_id != 10) and
            t.security_group_id = 11 and
            t.theme_security_group_id is null
      union all
      -- workspace theme
      select distinct htf.escape_sc(t.theme_name)||' - '||t.theme_id theme_name,
             theme_id theme_number,
             'WORKSPACE' theme_type,
             w.short_name workspace,
             w.provisioning_company_id workspace_id
      from wwv_flow_themes t,
           wwv_flow_companies w,
           wwv_flow_company_schemas s,
           (select nvl(nv('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
      where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = w.provisioning_company_id) and
            s.security_group_id = w.provisioning_company_id and
            (user in ('SYS','SYSTEM', 'APEX_030200') or w.provisioning_company_id != 10) and
            t.security_group_id = 11 and
            w.provisioning_company_id = t.theme_security_group_id and
            (t.theme_security_group_id = d.sgid or t.theme_security_group_id = s.security_group_id)
      ) x
order by 1;
COMMENT ON TABLE apex_themes IS 'List of APEX built-in, public and workspace themes';
COMMENT ON COLUMN apex_themes.theme_number IS 'Identifies the theme number associated with all templates within the theme';
COMMENT ON COLUMN apex_themes.theme_name IS 'Identifies the name of the theme';
COMMENT ON COLUMN apex_themes.theme_type IS 'Identifies the theme type as APEX built-in, public or workspace themes';
COMMENT ON COLUMN apex_themes.workspace IS 'Identifies a workspace where the theme exists';
COMMENT ON COLUMN apex_themes.workspace_id IS 'Identifies the primary key of the workspace where the theme exists';