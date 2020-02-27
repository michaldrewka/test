CREATE OR REPLACE FORCE VIEW wwv_flow_clickthru_log (clickdate,"CATEGORY","ID",flow_user,ip) AS
select clickdate, category, id, flow_user, ip
      from wwv_flow_clickthru_log_v
     where security_group_id = (select wwv_flow.get_sgid from dual);