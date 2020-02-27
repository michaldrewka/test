CREATE OR REPLACE FORCE VIEW apex_migration_projects (project_id,project_name,description,accdb_pathname,jetversion,migration_type,accessversion,project_owner,"SCHEMA",workspace,workspace_id,last_modified_on,last_modified_by) AS
select
        a.project_id                                    project_id,
     --
        d.migration_name                                project_name,
     --
	d.description                                   description,
     --
        a.dbpathname                                    accdb_pathname,
     --
        a.jetversion                                    jetversion,
     --
        d.migration_type                                migration_type,
     --
        a.accessversion                                 accessversion,
     --
        d.created_by                                    project_owner,
     --
        s.schema                                        schema,
     --
        w.short_name                                    workspace,
     --
        w.provisioning_company_id                       workspace_id,
     --
        d.last_updated_on                               last_modified_on,
     --
        d.last_updated_by                               last_modified_by
     --
from
        wwv_mig_access a,
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
and     w.provisioning_company_id = a.security_group_id
and     w.provisioning_company_id = s.security_group_id
order by w.PROVISIONING_COMPANY_ID, a.project_id;
COMMENT ON TABLE apex_migration_projects IS 'Available Application Express (Apex) Application Migrations Migration Projects';
COMMENT ON COLUMN apex_migration_projects.project_id IS 'Primary key that identifies the migration project';
COMMENT ON COLUMN apex_migration_projects.project_name IS 'Identifies name of the migration project';
COMMENT ON COLUMN apex_migration_projects.description IS 'A brief description of the migration project';
COMMENT ON COLUMN apex_migration_projects.accdb_pathname IS 'Identifies full path name and location of the Microsoft Access database the migration project is based on';
COMMENT ON COLUMN apex_migration_projects.jetversion IS 'Version of Microsoft Jet for MS Access associated with captured Microsoft Access database';
COMMENT ON COLUMN apex_migration_projects.migration_type IS 'Identifies the type of Migration Project';
COMMENT ON COLUMN apex_migration_projects.accessversion IS 'Version of Microsoft Access database captured, which the migration project is based on';
COMMENT ON COLUMN apex_migration_projects.project_owner IS 'Identifies the Apex User Name who created and owns the Migration Project';
COMMENT ON COLUMN apex_migration_projects."SCHEMA" IS 'Identified the name of database schema associated with the Migration Project';
COMMENT ON COLUMN apex_migration_projects.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_migration_projects.workspace_id IS 'Primary key that identifies the workspace';
COMMENT ON COLUMN apex_migration_projects.last_modified_on IS 'Date of most recent changes to the Migration Project';
COMMENT ON COLUMN apex_migration_projects.last_modified_by IS 'Identifies the APEX User Name who last modified the Migration Project';