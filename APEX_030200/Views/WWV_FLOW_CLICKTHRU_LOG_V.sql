CREATE OR REPLACE FORCE VIEW wwv_flow_clickthru_log_v (clickdate,"CATEGORY","ID",flow_user,ip,security_group_id) AS
select clickdate, category, id, flow_user, ip, security_group_id
      from wwv_flow_clickthru_log$
    union all
    select clickdate, category, id, flow_user, ip, security_group_id
      from wwv_flow_clickthru_log2$;