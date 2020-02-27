CREATE OR REPLACE FORCE VIEW apex_migration_rev_rpts (project_id,project_name,migration_type,dbid,report_id,report_name,source_name,source_type,source_syntax,source_status,"OWNER",status,created_on,created_by,last_updated_on,last_updated_by,"SCHEMA",workspace,workspace_id) AS
select
        a.project_id                                    project_id,
     --
        d.migration_name                                project_name,
     --
        d.migration_type                                migration_type,
     --
        a.dbid                                          dbid,
     --
        r.reportid                                      report_id,
     --
        r.report_name                                   report_name,
     --
        r.source_name                                   source_name,
     --
        r.source_type                                   source_type,
     --
        r.source_syntax                                 source_syntax,
     --
        r.source_status                                 source_status,
     --
        r.owner                                         owner,
     --
        r.status                                        status,
     --
        r.created_on                                    created_on,
     --
        r.created_by                                    created_by,
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
        wwv_mig_rev_reports r,
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
and     r.security_group_id = a.security_group_id
and     r.project_id = a.project_id
and     r.dbid = a.dbid
and     w.provisioning_company_id = a.security_group_id
and     w.provisioning_company_id = s.security_group_id
order by w.provisioning_company_id, r.project_id, r.reportid, r.dbid;
COMMENT ON TABLE apex_migration_rev_rpts IS 'Available MS Access report in the Application Express (Apex) Application Migrations Migration Projects';
COMMENT ON COLUMN apex_migration_rev_rpts.project_id IS 'Primary key that identifies the migration project';
COMMENT ON COLUMN apex_migration_rev_rpts.project_name IS 'Identifies name of the migration project';
COMMENT ON COLUMN apex_migration_rev_rpts.migration_type IS 'Identifies the type of Migration Project';
COMMENT ON COLUMN apex_migration_rev_rpts.dbid IS 'Identifies the unique number of the original MS Access database';
COMMENT ON COLUMN apex_migration_rev_rpts.report_id IS 'Identifies the unique number of the report in the original MS Access database';
COMMENT ON COLUMN apex_migration_rev_rpts.report_name IS 'Identifies the name of the report in the original MS Access database';
COMMENT ON COLUMN apex_migration_rev_rpts.source_name IS 'Identifies the name of the source object associated with the original MS Access report';
COMMENT ON COLUMN apex_migration_rev_rpts.source_type IS 'Identifies the type of source object associated with the original MS Access report';
COMMENT ON COLUMN apex_migration_rev_rpts.source_syntax IS 'Identifies the syntax of the source object associated with the original MS Access report';
COMMENT ON COLUMN apex_migration_rev_rpts.source_status IS 'Identifies the status of the source object: valid or invalid';
COMMENT ON COLUMN apex_migration_rev_rpts."OWNER" IS 'Identfies the owner of the original MS Access report';
COMMENT ON COLUMN apex_migration_rev_rpts.status IS 'Identfies the status of the report object: exclude or include in the migration process';
COMMENT ON COLUMN apex_migration_rev_rpts.created_on IS 'Date the report was created in the original MS Access database';
COMMENT ON COLUMN apex_migration_rev_rpts.created_by IS 'Identidies the MS Access User Name who created the original MS Access report';
COMMENT ON COLUMN apex_migration_rev_rpts.last_updated_on IS 'Date of most recent changes to the Migration Project';
COMMENT ON COLUMN apex_migration_rev_rpts.last_updated_by IS 'Identifies the APEX User Name who last modified the MS Access database';
COMMENT ON COLUMN apex_migration_rev_rpts."SCHEMA" IS 'Identifies the name of database schema associated with the Migration Project';
COMMENT ON COLUMN apex_migration_rev_rpts.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_migration_rev_rpts.workspace_id IS 'Primary key that identifies the workspace';