CREATE OR REPLACE FORCE VIEW apex_workspace_activity_log (workspace,apex_user,application_id,application_name,application_schema_owner,page_id,page_name,view_date,think_time,seconds_ago,log_context,elapsed_time,rows_queried,ip_address,agent,apex_session_id,error_message,error_on_component_type,error_on_component_name,page_view_mode,application_info,regions_from_cache,workspace_id) AS
select
           w.short_name              workspace,
           l.userid                  apex_user,
           l.flow_id                 application_id,
           f.name                    application_name,
           f.owner                   application_schema_owner,
           l.step_id                 page_id,
           (select name
            from wwv_flow_steps
            where id = l.step_id and
                  flow_id = f.id)    page_name,
           l.time_stamp              view_date,
           round(86400 * (l.time_stamp - lag(l.time_stamp) over (order by l.time_stamp, l.flow_id, l.userid, l.session_id))) think_time,
           round(86400 * (sysdate - l.time_stamp))     seconds_ago,
           --l.component_type          component_type,
           --l.component_name          component_name,
           l.component_attribute     log_context,
           --l.information             page_view_information,
           l.elap                    elapsed_time,
           l.num_rows                rows_queried,
           l.ip_address              ip_address,
           l.USER_AGENT              agent,
           l.session_id              apex_session_id,
           l.sqlerrm                 error_message,
           l.sqlerrm_component_type  error_on_component_type,
           l.sqlerrm_component_name  error_on_component_name,
           decode(l.page_mode,
             'D','Dynamic',
             'C','Cache Created',
             'R','Cached',
             'P','Partial Page',
             'A','Page Processing',
             l.page_mode)            page_view_mode,
           l.application_info,
           nvl(l.cached_regions,0)   regions_from_cache,
           l.security_group_id       workspace_id
from wwv_flow_activity_log l,
     wwv_flow_companies w,
     wwv_flows f,
     (select nvl(v('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (l.security_group_id in (select security_group_id from  wwv_flow_company_schemas where schema = user) or
       user in ('SYS','SYSTEM', 'APEX_030200')  or
       d.sgid = l.security_group_id) and
       --
      l.security_group_id = w.PROVISIONING_COMPANY_ID and
      l.flow_id = f.id(+) and
      l.time_stamp > sysdate - 14 and
      w.PROVISIONING_COMPANY_ID != 0 and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10);
COMMENT ON TABLE apex_workspace_activity_log IS 'Page view activity log detail.  One row is logged for each page view for application with logging enabled.';
COMMENT ON COLUMN apex_workspace_activity_log.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_workspace_activity_log.apex_user IS 'Name of the end user of the application';
COMMENT ON COLUMN apex_workspace_activity_log.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_workspace_activity_log.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_workspace_activity_log.application_schema_owner IS 'Parsing Schema of the Application';
COMMENT ON COLUMN apex_workspace_activity_log.page_id IS 'ID of the application page';
COMMENT ON COLUMN apex_workspace_activity_log.page_name IS 'Name of the application page';
COMMENT ON COLUMN apex_workspace_activity_log.view_date IS 'Date of page view with precision to the second';
COMMENT ON COLUMN apex_workspace_activity_log.think_time IS 'Think time in seconds by application and user with second level granularity';
COMMENT ON COLUMN apex_workspace_activity_log.log_context IS 'Context of Page View';
COMMENT ON COLUMN apex_workspace_activity_log.elapsed_time IS 'Elapsed time to generate page source';
COMMENT ON COLUMN apex_workspace_activity_log.rows_queried IS 'Number of rows fetched by the Apex reporting engine';
COMMENT ON COLUMN apex_workspace_activity_log.ip_address IS 'IP Address for this page view';
COMMENT ON COLUMN apex_workspace_activity_log.agent IS 'HTTP User Agent for this page view';
COMMENT ON COLUMN apex_workspace_activity_log.apex_session_id IS 'Apex Session ID for this page view';
COMMENT ON COLUMN apex_workspace_activity_log.error_message IS 'Error message raised for this page view';
COMMENT ON COLUMN apex_workspace_activity_log.error_on_component_type IS 'The component type that caused an error to be raised';
COMMENT ON COLUMN apex_workspace_activity_log.error_on_component_name IS 'The component name which caused the error to be raised';
COMMENT ON COLUMN apex_workspace_activity_log.page_view_mode IS 'The page view mode, typically Static or Dynamic';
COMMENT ON COLUMN apex_workspace_activity_log.application_info IS 'Information provided by the application to provide additional application context';
COMMENT ON COLUMN apex_workspace_activity_log.regions_from_cache IS 'Count of regions on this page that are rendered from cache';
COMMENT ON COLUMN apex_workspace_activity_log.workspace_id IS 'Primary Key of the Workspace';