CREATE OR REPLACE FORCE VIEW apex_workspace_log_summary_usr (workspace,apex_user,applications,page_views,distinct_pages,total_elapsed_time,average_elapsed_time,minimum_elapsed_time,maximum_elapsed_time,total_rows_queried,distinct_ip_addresses,distinct_agents,distinct_apex_sessions,page_views_with_errors,dynamic_page_views,cached_page_views,first_view,last_view,period_in_days,last_1_minute,last_5_minutes,last_10_minutes,last_15_minutes,last_30_minutes,last_1_hour,last_2_hours,last_6_hours,last_12_hours,last_24_hours,last_48_hours,last_7_days,last_14_days,today_hh01,today_hh02,today_hh03,today_hh04,today_hh05,today_hh06,today_hh07,today_hh08,today_hh09,today_hh10,today_hh11,today_hh12,today_hh13,today_hh14,today_hh15,today_hh16,today_hh17,today_hh18,today_hh19,today_hh20,today_hh21,today_hh22,today_hh23,today_hh24,today) AS
select
           w.short_name                           workspace,
           nvl(l.userid,'PUBLIC')                 apex_user,
           count(distinct l.flow_id)              applications,
           count(*)                               page_views,
           count(distinct l.flow_id||'.'||l.step_id) distinct_pages,
           sum(l.elap)                            total_elapsed_time,
           avg(l.elap)                            average_elapsed_time,
           min(l.elap)                            minimum_elapsed_time,
           max(l.elap)                            maximum_elapsed_time,
           sum(l.num_rows)                        total_rows_queried,
           count(distinct l.ip_address)           distinct_ip_addresses,
           count(distinct l.USER_AGENT)           distinct_agents,
           count(distinct l.session_id)           distinct_apex_sessions,
           sum(decode(l.sqlerrm,null,0,1))        page_views_with_errors,
           sum(decode(l.page_mode,'D',1,'C',1,0)) dynamic_page_views,
           sum(decode(l.page_mode,'R',1,0))       cached_page_views,
           min(l.time_stamp)                      first_view,
           max(l.time_stamp)                      last_view,
           max(l.time_stamp)-min(l.time_stamp)    period_in_days,
           --
           sum(decode(greatest(s.the_date - (1/1440),l.time_stamp),l.time_stamp,1,0) )  last_1_minute,
           sum(decode(greatest(s.the_date - (5/1440),l.time_stamp),l.time_stamp,1,0) )  last_5_minutes,
           sum(decode(greatest(s.the_date - (10/1440),l.time_stamp),l.time_stamp,1,0) ) last_10_minutes,
           sum(decode(greatest(s.the_date - (15/1440),l.time_stamp),l.time_stamp,1,0) ) last_15_minutes,
           sum(decode(greatest(s.the_date - (30/1440),l.time_stamp),l.time_stamp,1,0) ) last_30_minutes,
           sum(decode(greatest(s.the_date - (1/24),l.time_stamp),l.time_stamp,1,0) )    last_1_hour,
           sum(decode(greatest(s.the_date - (2/24),l.time_stamp),l.time_stamp,1,0) )    last_2_hours,
           sum(decode(greatest(s.the_date - (6/24),l.time_stamp),l.time_stamp,1,0) )    last_6_hours,
           sum(decode(greatest(s.the_date - (2/24),l.time_stamp),l.time_stamp,1,0) )    last_12_hours,
           sum(decode(greatest(s.the_date - 1,l.time_stamp),l.time_stamp,1,0)      )    last_24_hours,
           sum(decode(greatest(s.the_date - 2,l.time_stamp),l.time_stamp,1,0)      )    last_48_hours,
           sum(decode(greatest(s.the_date - 7,l.time_stamp),l.time_stamp,1,0)      )    last_7_days,
           sum(decode(greatest(s.the_date - 14,l.time_stamp),l.time_stamp,1,0)     )    last_14_days,
           --
           sum(decode(greatest(trunc(s.the_date),l.time_stamp),l.time_stamp,decode(to_char(l.time_stamp,'HH24'),'01',1,0),0))  today_HH01,
           sum(decode(greatest(trunc(s.the_date),l.time_stamp),l.time_stamp,decode(to_char(l.time_stamp,'HH24'),'02',1,0),0))  today_HH02,
           sum(decode(greatest(trunc(s.the_date),l.time_stamp),l.time_stamp,decode(to_char(l.time_stamp,'HH24'),'03',1,0),0))  today_HH03,
           sum(decode(greatest(trunc(s.the_date),l.time_stamp),l.time_stamp,decode(to_char(l.time_stamp,'HH24'),'04',1,0),0))  today_HH04,
           sum(decode(greatest(trunc(s.the_date),l.time_stamp),l.time_stamp,decode(to_char(l.time_stamp,'HH24'),'05',1,0),0))  today_HH05,
           sum(decode(greatest(trunc(s.the_date),l.time_stamp),l.time_stamp,decode(to_char(l.time_stamp,'HH24'),'06',1,0),0))  today_HH06,
           sum(decode(greatest(trunc(s.the_date),l.time_stamp),l.time_stamp,decode(to_char(l.time_stamp,'HH24'),'07',1,0),0))  today_HH07,
           sum(decode(greatest(trunc(s.the_date),l.time_stamp),l.time_stamp,decode(to_char(l.time_stamp,'HH24'),'08',1,0),0))  today_HH08,
           sum(decode(greatest(trunc(s.the_date),l.time_stamp),l.time_stamp,decode(to_char(l.time_stamp,'HH24'),'09',1,0),0))  today_HH09,
           sum(decode(greatest(trunc(s.the_date),l.time_stamp),l.time_stamp,decode(to_char(l.time_stamp,'HH24'),'10',1,0),0))  today_HH10,
           sum(decode(greatest(trunc(s.the_date),l.time_stamp),l.time_stamp,decode(to_char(l.time_stamp,'HH24'),'11',1,0),0))  today_HH11,
           sum(decode(greatest(trunc(s.the_date),l.time_stamp),l.time_stamp,decode(to_char(l.time_stamp,'HH24'),'12',1,0),0))  today_HH12,
           sum(decode(greatest(trunc(s.the_date),l.time_stamp),l.time_stamp,decode(to_char(l.time_stamp,'HH24'),'13',1,0),0))  today_HH13,
           sum(decode(greatest(trunc(s.the_date),l.time_stamp),l.time_stamp,decode(to_char(l.time_stamp,'HH24'),'14',1,0),0))  today_HH14,
           sum(decode(greatest(trunc(s.the_date),l.time_stamp),l.time_stamp,decode(to_char(l.time_stamp,'HH24'),'15',1,0),0))  today_HH15,
           sum(decode(greatest(trunc(s.the_date),l.time_stamp),l.time_stamp,decode(to_char(l.time_stamp,'HH24'),'16',1,0),0))  today_HH16,
           sum(decode(greatest(trunc(s.the_date),l.time_stamp),l.time_stamp,decode(to_char(l.time_stamp,'HH24'),'17',1,0),0))  today_HH17,
           sum(decode(greatest(trunc(s.the_date),l.time_stamp),l.time_stamp,decode(to_char(l.time_stamp,'HH24'),'18',1,0),0))  today_HH18,
           sum(decode(greatest(trunc(s.the_date),l.time_stamp),l.time_stamp,decode(to_char(l.time_stamp,'HH24'),'19',1,0),0))  today_HH19,
           sum(decode(greatest(trunc(s.the_date),l.time_stamp),l.time_stamp,decode(to_char(l.time_stamp,'HH24'),'20',1,0),0))  today_HH20,
           sum(decode(greatest(trunc(s.the_date),l.time_stamp),l.time_stamp,decode(to_char(l.time_stamp,'HH24'),'21',1,0),0))  today_HH21,
           sum(decode(greatest(trunc(s.the_date),l.time_stamp),l.time_stamp,decode(to_char(l.time_stamp,'HH24'),'22',1,0),0))  today_HH22,
           sum(decode(greatest(trunc(s.the_date),l.time_stamp),l.time_stamp,decode(to_char(l.time_stamp,'HH24'),'23',1,0),0))  today_HH23,
           sum(decode(greatest(trunc(s.the_date),l.time_stamp),l.time_stamp,decode(to_char(l.time_stamp,'HH24'),'24',1,0),0))  today_HH24,
           sum(decode(greatest(trunc(s.the_date),l.time_stamp),l.time_stamp,1,0))                                              today
from wwv_flow_activity_log l,
     wwv_flows f,
     wwv_flow_companies w,
     (select nvl(v('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d,
     (select sysdate the_date from dual) s
where (l.security_group_id in (select security_group_id from  wwv_flow_company_schemas where schema = user) or
       user in ('SYS','SYSTEM', 'APEX_030200')  or
       d.sgid = l.security_group_id) and
       --
       l.security_group_id = w.PROVISIONING_COMPANY_ID and
       l.flow_id = f.id(+) and
       l.time_stamp > sysdate - 14 and
      w.PROVISIONING_COMPANY_ID != 0 and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10)
group by w.short_name, nvl(l.userid,'PUBLIC');
COMMENT ON TABLE apex_workspace_log_summary_usr IS 'Page view activity log summarized by user for the last two weeks';
COMMENT ON COLUMN apex_workspace_log_summary_usr.workspace IS 'Name of Workspace that generated the page view log entry';
COMMENT ON COLUMN apex_workspace_log_summary_usr.apex_user IS 'Name of the Apex User name associated with the page view log entry';
COMMENT ON COLUMN apex_workspace_log_summary_usr.applications IS 'Number of applications contained in the aggregation by Apex User Name and Workspace';
COMMENT ON COLUMN apex_workspace_log_summary_usr.page_views IS 'Page views aggregated by Apex User Name and Workspace';
COMMENT ON COLUMN apex_workspace_log_summary_usr.distinct_pages IS 'Distinct page views aggregated by Apex User Name and Workspace';
COMMENT ON COLUMN apex_workspace_log_summary_usr.total_elapsed_time IS 'Total elapsed time logged aggregated by Apex User Name and Workspace';
COMMENT ON COLUMN apex_workspace_log_summary_usr.average_elapsed_time IS 'Average elapsed time logged aggregated by Apex User Name and Workspace';
COMMENT ON COLUMN apex_workspace_log_summary_usr.minimum_elapsed_time IS 'Minimum elapsed time logged aggregated by Apex User Name and Workspace';
COMMENT ON COLUMN apex_workspace_log_summary_usr.maximum_elapsed_time IS 'Maximum elapsed time aggregated by Apex User Name and Workspace';
COMMENT ON COLUMN apex_workspace_log_summary_usr.total_rows_queried IS 'Total rows queried by the Apex reporting engine aggregated by Apex User Name and Workspace';
COMMENT ON COLUMN apex_workspace_log_summary_usr.distinct_ip_addresses IS 'Distinct IP addresses aggregated by Apex User Name and Workspace';
COMMENT ON COLUMN apex_workspace_log_summary_usr.distinct_agents IS 'Distinct User Agents aggregated by Apex User Name and Workspace';
COMMENT ON COLUMN apex_workspace_log_summary_usr.distinct_apex_sessions IS 'Distinct Apex Sessions aggregated by Apex User Name and Workspace';
COMMENT ON COLUMN apex_workspace_log_summary_usr.page_views_with_errors IS 'Count of page views with recorded errors aggregated by Apex User Name and Workspace';
COMMENT ON COLUMN apex_workspace_log_summary_usr.dynamic_page_views IS 'Count of dynamic page views aggregated by Apex User Name and Workspace';
COMMENT ON COLUMN apex_workspace_log_summary_usr.cached_page_views IS 'Count of cached page views aggregated by Apex User Name and Workspace';
COMMENT ON COLUMN apex_workspace_log_summary_usr.first_view IS 'Date of first page view by Apex User Name and Workspace';
COMMENT ON COLUMN apex_workspace_log_summary_usr.last_view IS 'Date of most recent page view by Apex User Name and Workspace';
COMMENT ON COLUMN apex_workspace_log_summary_usr.period_in_days IS 'Period in days between the first recorded page view an the most recent page view';
COMMENT ON COLUMN apex_workspace_log_summary_usr.last_1_minute IS 'Page views recorded in the last 1 minute aggregated by Apex User Name and Workspace';
COMMENT ON COLUMN apex_workspace_log_summary_usr.last_5_minutes IS 'Page views recorded in the last 5 minutes aggregated by Apex User Name and Workspace';
COMMENT ON COLUMN apex_workspace_log_summary_usr.last_10_minutes IS 'Page views recorded in the last 10 minutes aggregated by Apex User Name and Workspace';
COMMENT ON COLUMN apex_workspace_log_summary_usr.last_15_minutes IS 'Page views recorded in the last 15 minutes aggregated by Apex User Name and Workspace';
COMMENT ON COLUMN apex_workspace_log_summary_usr.last_30_minutes IS 'Page views recorded in the last 30 minutes aggregated by Apex User Name and Workspace';
COMMENT ON COLUMN apex_workspace_log_summary_usr.last_1_hour IS 'Page views recorded in the last 1 hour aggregated by Apex User Name and Workspace';
COMMENT ON COLUMN apex_workspace_log_summary_usr.last_2_hours IS 'Page views recorded in the last 2 hours aggregated by Apex User Name and Workspace';
COMMENT ON COLUMN apex_workspace_log_summary_usr.last_6_hours IS 'Page views recorded in the last 6 hours aggregated by Apex User Name and Workspace';
COMMENT ON COLUMN apex_workspace_log_summary_usr.last_12_hours IS 'Page views recorded in the last 12 hours aggregated by Apex User Name and Workspace';
COMMENT ON COLUMN apex_workspace_log_summary_usr.last_24_hours IS 'Page views recorded in the last 24 hours aggregated by Apex User Name and Workspace';
COMMENT ON COLUMN apex_workspace_log_summary_usr.last_48_hours IS 'Page views recorded in the last 48 hours aggregated by Apex User Name and Workspace';
COMMENT ON COLUMN apex_workspace_log_summary_usr.last_7_days IS 'Page views recorded in the last 7 days aggregated by Apex User Name and Workspace';
COMMENT ON COLUMN apex_workspace_log_summary_usr.last_14_days IS 'Page views recorded in the last 14 days aggregated by Apex User Name and Workspace';
COMMENT ON COLUMN apex_workspace_log_summary_usr.today_hh01 IS 'Page views recorded today for the hour 00-01';
COMMENT ON COLUMN apex_workspace_log_summary_usr.today_hh02 IS 'Page views recorded today for the hour 01-02';
COMMENT ON COLUMN apex_workspace_log_summary_usr.today_hh03 IS 'Page views recorded today for the hour 02-03';
COMMENT ON COLUMN apex_workspace_log_summary_usr.today_hh04 IS 'Page views recorded today for the hour 03-04';
COMMENT ON COLUMN apex_workspace_log_summary_usr.today_hh05 IS 'Page views recorded today for the hour 04-05';
COMMENT ON COLUMN apex_workspace_log_summary_usr.today_hh06 IS 'Page views recorded today for the hour 05-06';
COMMENT ON COLUMN apex_workspace_log_summary_usr.today_hh07 IS 'Page views recorded today for the hour 06-07';
COMMENT ON COLUMN apex_workspace_log_summary_usr.today_hh08 IS 'Page views recorded today for the hour 07-08';
COMMENT ON COLUMN apex_workspace_log_summary_usr.today_hh09 IS 'Page views recorded today for the hour 08-09';
COMMENT ON COLUMN apex_workspace_log_summary_usr.today_hh10 IS 'Page views recorded today for the hour 09-10';
COMMENT ON COLUMN apex_workspace_log_summary_usr.today_hh11 IS 'Page views recorded today for the hour 10-11';
COMMENT ON COLUMN apex_workspace_log_summary_usr.today_hh12 IS 'Page views recorded today for the hour 11-12';
COMMENT ON COLUMN apex_workspace_log_summary_usr.today_hh13 IS 'Page views recorded today for the hour 12-13';
COMMENT ON COLUMN apex_workspace_log_summary_usr.today_hh14 IS 'Page views recorded today for the hour 13-14';
COMMENT ON COLUMN apex_workspace_log_summary_usr.today_hh15 IS 'Page views recorded today for the hour 14-15';
COMMENT ON COLUMN apex_workspace_log_summary_usr.today_hh16 IS 'Page views recorded today for the hour 15-16';
COMMENT ON COLUMN apex_workspace_log_summary_usr.today_hh17 IS 'Page views recorded today for the hour 16-17';
COMMENT ON COLUMN apex_workspace_log_summary_usr.today_hh18 IS 'Page views recorded today for the hour 17-18';
COMMENT ON COLUMN apex_workspace_log_summary_usr.today_hh19 IS 'Page views recorded today for the hour 18-19';
COMMENT ON COLUMN apex_workspace_log_summary_usr.today_hh20 IS 'Page views recorded today for the hour 19-20';
COMMENT ON COLUMN apex_workspace_log_summary_usr.today_hh21 IS 'Page views recorded today for the hour 20-21';
COMMENT ON COLUMN apex_workspace_log_summary_usr.today_hh22 IS 'Page views recorded today for the hour 21-22';
COMMENT ON COLUMN apex_workspace_log_summary_usr.today_hh23 IS 'Page views recorded today for the hour 22-23';
COMMENT ON COLUMN apex_workspace_log_summary_usr.today_hh24 IS 'Page views recorded today for the hour 23-24';
COMMENT ON COLUMN apex_workspace_log_summary_usr.today IS 'Todays date on the server to provide greater context for people in different timezones';