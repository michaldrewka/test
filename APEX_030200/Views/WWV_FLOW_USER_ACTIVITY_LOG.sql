CREATE OR REPLACE FORCE VIEW wwv_flow_user_activity_log (time_stamp,component_type,component_name,component_attribute,information,elap,num_rows,userid,ip_address,user_agent,flow_id,step_id,session_id,sqlerrm,sqlerrm_component_type,sqlerrm_component_name,page_mode,application_info) AS
select time_stamp, component_type, component_name, component_attribute,
           information, elap, num_rows, userid, ip_address, user_agent,
           flow_id, step_id, session_id, sqlerrm, sqlerrm_component_type, sqlerrm_component_name,
           page_mode, application_info
      from wwv_flow_activity_log
     where security_group_id = (select wwv_flow.get_sgid from dual where rownum = 1);