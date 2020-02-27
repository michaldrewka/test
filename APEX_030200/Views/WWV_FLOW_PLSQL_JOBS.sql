CREATE OR REPLACE FORCE VIEW wwv_flow_plsql_jobs ("ID","JOB",flow_id,"OWNER",enduser,created,modified,status,system_status,system_modified,security_group_id) AS
select id, job, flow_id, owner, enduser, created, modified,
         status, system_status, system_modified, security_group_id
    from wwv_flow_jobs
   where security_group_id = (select nv('FLOW_SECURITY_GROUP_ID') sgid from dual);