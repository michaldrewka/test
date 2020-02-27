CREATE OR REPLACE FORCE VIEW apex_workspace_clicks (workspace,"CATEGORY",apex_user,clickdate,click_id,clicker_ip,workspace_id) AS
select short_name                   workspace,
           category                     category,
           flow_user                    apex_user,
           clickdate                    clickdate,
           a.id                         click_id,
           ip                           clicker_ip,
           provisioning_company_id      workspace_id
      from (select clickdate, category, l.id, flow_user, ip, w.provisioning_company_id,
                   w.short_name, w.first_schema_provisioned
              from wwv_flow_clickthru_log$ l, wwv_flow_companies w
             where l.security_group_id = w.provisioning_company_id
            union all
            select clickdate, category, l.id, flow_user, ip, w.provisioning_company_id,
                   w.short_name, w.first_schema_provisioned
              from wwv_flow_clickthru_log2$ l, wwv_flow_companies w
             where l.security_group_id = w.provisioning_company_id
            ) a,
            wwv_flow_company_schemas s,
            (select nvl(nv('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
      where s.security_group_id = a.provisioning_company_id
        and a.first_schema_provisioned = s.schema
        and (d.sgid = a.provisioning_company_id or user = s.schema or user in ('SYS','SYSTEM','APEX_030200')) and
      (user in ('SYS','SYSTEM', 'APEX_030200') or a.PROVISIONING_COMPANY_ID != 10);
COMMENT ON TABLE apex_workspace_clicks IS 'Clicks in Application Express that are tracked by using APEX_UTIL.COUNT_CLICKS';
COMMENT ON COLUMN apex_workspace_clicks.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_workspace_clicks."CATEGORY" IS 'Optional category used to track the click';
COMMENT ON COLUMN apex_workspace_clicks.apex_user IS 'Name of Application Express user that clicked';
COMMENT ON COLUMN apex_workspace_clicks.clickdate IS 'Date of the recorded click';
COMMENT ON COLUMN apex_workspace_clicks.click_id IS 'Optional secondary ID to further track the click';
COMMENT ON COLUMN apex_workspace_clicks.clicker_ip IS 'The IP address of the clicker';
COMMENT ON COLUMN apex_workspace_clicks.workspace_id IS 'Primary key that identifies the workspace';