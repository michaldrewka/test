CREATE OR REPLACE FORCE VIEW apex_workspace_log_summary (workspace,application_id,application_name,page_views,distinct_pages,total_elapsed_time,average_elapsed_time,minimum_elapsed_time,maximum_elapsed_time,total_rows_queried,ip_addresses,agents,apex_sessions,page_views_with_errors,dynamic_page_views,cached_page_views,first_view,last_view,period_in_days) AS
select
           w.short_name                           workspace,
           l.flow_id                              application_id,
           f.name                                 application_name,
           count(*)                               page_views,
           count(distinct l.step_id)              distinct_pages,
           sum(l.elap)                            total_elapsed_time,
           avg(l.elap)                            average_elapsed_time,
           min(l.elap)                            minimum_elapsed_time,
           max(l.elap)                            maximum_elapsed_time,
           sum(l.num_rows)                        total_rows_queried,
           count(distinct l.ip_address)           ip_addresses,
           count(distinct l.USER_AGENT)           agents,
           count(distinct l.session_id)           apex_sessions,
           sum(decode(l.sqlerrm,null,0,1))        page_views_with_errors,
           sum(decode(l.page_mode,'D',1,'C',1,0)) dynamic_page_views,
           sum(decode(l.page_mode,'R',1,0))       cached_page_views,
           min(l.time_stamp)                      first_view,
           max(l.time_stamp)                      last_view,
           max(l.time_stamp)-min(l.time_stamp)    period_in_days
from wwv_flow_activity_log l,
     wwv_flows f,
     wwv_flow_companies w,
     (select nvl(v('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (l.security_group_id in (select security_group_id from  wwv_flow_company_schemas where schema = user) or
       user in ('SYS','SYSTEM', 'APEX_030200')  or
       d.sgid = l.security_group_id) and
       --
       l.security_group_id = w.PROVISIONING_COMPANY_ID and
       l.flow_id = f.id(+) and
       l.time_stamp > sysdate - 14 and
      w.PROVISIONING_COMPANY_ID != 0 and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10)
group by w.short_name, l.flow_id, f.name;
COMMENT ON TABLE apex_workspace_log_summary IS 'Page view activity log summarized by application for the last 14 days';
COMMENT ON COLUMN apex_workspace_log_summary.workspace IS 'Workspace for which this page view log was recorded';
COMMENT ON COLUMN apex_workspace_log_summary.application_id IS 'Application ID for which this page view log was recorded';
COMMENT ON COLUMN apex_workspace_log_summary.application_name IS 'Application Name for which this page view log was recorded';
COMMENT ON COLUMN apex_workspace_log_summary.page_views IS 'Page views aggregated by Workspace and Application';
COMMENT ON COLUMN apex_workspace_log_summary.distinct_pages IS 'Distinct page views aggregated by Workspace and Application';
COMMENT ON COLUMN apex_workspace_log_summary.total_elapsed_time IS 'Total elapsed time generating page source aggregated by Workspace and Application';
COMMENT ON COLUMN apex_workspace_log_summary.average_elapsed_time IS 'Average elapsed time generating page source aggregated by Workspace and Application';
COMMENT ON COLUMN apex_workspace_log_summary.minimum_elapsed_time IS 'Minimum elapsed time generating page source aggregated by Workspace and Application';
COMMENT ON COLUMN apex_workspace_log_summary.maximum_elapsed_time IS 'Maximum elapsed time generating page source aggregated by Workspace and Application';
COMMENT ON COLUMN apex_workspace_log_summary.total_rows_queried IS 'Total rows queried by the Apex reporting engine aggregated by Workspace and Application';
COMMENT ON COLUMN apex_workspace_log_summary.ip_addresses IS 'Distinct IP addresses aggregated by Workspace and Application';
COMMENT ON COLUMN apex_workspace_log_summary.agents IS 'Distinct User Agents aggregated by Workspace and Application';
COMMENT ON COLUMN apex_workspace_log_summary.apex_sessions IS 'Count of sessions aggregated by Workspace and Application';
COMMENT ON COLUMN apex_workspace_log_summary.page_views_with_errors IS 'Count of page views generating error text aggregated by Workspace and Application';
COMMENT ON COLUMN apex_workspace_log_summary.dynamic_page_views IS 'Count of dynamic page views aggregated by Workspace and Application';
COMMENT ON COLUMN apex_workspace_log_summary.cached_page_views IS 'Count of static page views aggregated by Workspace and Application';
COMMENT ON COLUMN apex_workspace_log_summary.first_view IS 'First logged page by Workspace and Application';
COMMENT ON COLUMN apex_workspace_log_summary.last_view IS 'Most recently logged page by Workspace and Application';
COMMENT ON COLUMN apex_workspace_log_summary.period_in_days IS 'Period in days between first logged page view and most recent page view';