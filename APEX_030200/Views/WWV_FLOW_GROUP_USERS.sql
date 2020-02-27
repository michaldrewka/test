CREATE OR REPLACE FORCE VIEW wwv_flow_group_users ("GROUP_ID",group_name,user_id) AS
select g.id group_id,
          g.group_name,
          ug.user_id
  from WWV_FLOW_FND_GROUP_USERS ug,
         WWV_FLOW_FND_USER_GROUPS g
where g.id = ug.group_id
   and ug.security_group_id = (
             select nv('FLOW_SECURITY_GROUP_ID') s
             from dual);