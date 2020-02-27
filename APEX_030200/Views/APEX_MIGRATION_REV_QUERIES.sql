CREATE OR REPLACE FORCE VIEW apex_migration_rev_queries (project_id,project_name,migration_type,dbid,query_id,orig_qry_name,mig_view_name,orig_sql,mig_sql,"OWNER",status,created_on,created_by,last_updated_on,last_updated_by,"SCHEMA",workspace,workspace_id) AS
select
        a.project_id                                    project_id,
     --
        d.migration_name                                project_name,
     --
        d.migration_type                                migration_type,
     --
        a.dbid                                          dbid,
     --
        f.qryid                                         query_id,
     --
        f.orig_qry_name                                 orig_qry_name,
     --
        f.mig_view_name                                 mig_view_name,
     --
        f.orig_sql                                      orig_sql,
     --
        f.mig_sql                                       mig_sql,
     --
        f.owner                                         owner,
     --
        f.status                                        status,
     --
        f.created_on                                    created_on,
     --
        f.created_by                                    created_by,
     --
        a.last_updated_on                               last_updated_on,
     --
        a.last_updated_by                               last_updated_by,
     --
	s.schema                                        schema,
     --
	w.short_name                                    workspace,
     --
	w.provisioning_company_id                       workspace_id
     --
from
        wwv_mig_access a,
     --
        wwv_mig_rev_queries f,
     --
        wwv_flow_company_schemas s,
     --
        wwv_mig_projects d,
     --
        wwv_flow_companies w,
     --
        (select nvl(nv('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) g
     --
where
        (s.schema = user or user in ('SYS','SYSTEM','APEX_030200') or g.sgid = w.PROVISIONING_COMPANY_ID)
and     w.PROVISIONING_COMPANY_ID != 0
and     a.database_schema = s.schema
and     a.project_id = d.id
and     a.security_group_id = d.security_group_id
and     f.security_group_id = a.security_group_id
and     f.project_id = a.project_id
and     f.dbid = a.dbid
and     w.provisioning_company_id = a.security_group_id
and     w.provisioning_company_id = s.security_group_id
order by w.provisioning_company_id, f.project_id, f.qryid, f.dbid;
COMMENT ON TABLE apex_migration_rev_queries IS 'Available MS Access report in the Application Express (Apex) Application Migrations Migration Projects';
COMMENT ON COLUMN apex_migration_rev_queries.project_id IS 'Primary key that identifies the migration project';
COMMENT ON COLUMN apex_migration_rev_queries.project_name IS 'Identifies name of the migration project';
COMMENT ON COLUMN apex_migration_rev_queries.migration_type IS 'Identifies the type of Migration Project';
COMMENT ON COLUMN apex_migration_rev_queries.dbid IS 'Identifies the unique number of the original MS Access database';
COMMENT ON COLUMN apex_migration_rev_queries.query_id IS 'Identifies the unique number of the query in the original MS Access database';
COMMENT ON COLUMN apex_migration_rev_queries.orig_qry_name IS 'Identifies the name of the original MS Access query';
COMMENT ON COLUMN apex_migration_rev_queries.mig_view_name IS 'Identifies the name of the migrated view associated with the MS Access query';
COMMENT ON COLUMN apex_migration_rev_queries.orig_sql IS 'Identifies the SQL syntax of the original query in the original MS Access database';
COMMENT ON COLUMN apex_migration_rev_queries.mig_sql IS 'Identifies the SQL syntax of the migrated view';
COMMENT ON COLUMN apex_migration_rev_queries."OWNER" IS 'Identifies the owner of the MS Access database';
COMMENT ON COLUMN apex_migration_rev_queries.status IS 'Identifies the status of the migrated view: valid or invalid';
COMMENT ON COLUMN apex_migration_rev_queries.created_on IS 'Date the QUERY was created in the original MS Access database';
COMMENT ON COLUMN apex_migration_rev_queries.created_by IS 'Identidies the MS Access User Name who created the original MS Access query';
COMMENT ON COLUMN apex_migration_rev_queries.last_updated_on IS 'Date of most recent changes to the Migration Project';
COMMENT ON COLUMN apex_migration_rev_queries.last_updated_by IS 'Identifies the APEX User Name who last modified the MS Access database';
COMMENT ON COLUMN apex_migration_rev_queries."SCHEMA" IS 'Identifies the name of database schema associated with the Migration Project';
COMMENT ON COLUMN apex_migration_rev_queries.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_migration_rev_queries.workspace_id IS 'Primary key that identifies the workspace';