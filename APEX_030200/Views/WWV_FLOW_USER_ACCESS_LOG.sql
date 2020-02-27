CREATE OR REPLACE FORCE VIEW wwv_flow_user_access_log (login_name,authentication_method,"APPLICATION","OWNER",access_date,ip_address,remote_user,authentication_result,custom_status_text) AS
select login_name, authentication_method, application, owner, access_date, ip_address, remote_user, authentication_result, custom_status_text
      from wwv_flow_user_access_log_v
     where security_group_id = wwv_flow.get_sgid and security_group_id <> 0;