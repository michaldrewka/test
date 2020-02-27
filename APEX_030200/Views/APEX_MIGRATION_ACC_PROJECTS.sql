CREATE OR REPLACE FORCE VIEW apex_migration_acc_projects (project_id,project_name,description,migration_type,project_owner,accdb_pathname,"TABLES",queries,forms,reports,pages,modules,relations,jetversion,accessversion,dbname,dbid,dbsize,isappdb,isattacheddb,startupform,linkdbid,created_by,last_modified_on,last_modified_by,"SCHEMA",workspace,workspace_id) AS
select
        a.project_id                                    project_id,
     --
        d.migration_name                                project_name,
     --
        d.description                                   description,
     --
        d.migration_type                                migration_type,
     --
        d.created_by                                    project_owner,
     --
        a.dbpathname                                    accdb_pathname,
     --
       (select count(*) from wwv_mig_acc_tables
        where project_id = a.project_id
        and security_group_id = a.security_group_id
        and dbid = a.dbid)                              tables,
     --
       (select count(*) from wwv_mig_acc_queries
        where project_id = a.project_id
        and security_group_id = a.security_group_id
        and dbid = a.dbid)                              queries,
     --
       (select count(*) from wwv_mig_acc_forms
        where project_id = a.project_id
        and security_group_id = a.security_group_id
        and dbid = a.dbid)                              forms,
     --
       (select count(*) from wwv_mig_acc_reports
        where project_id = a.project_id
        and security_group_id = a.security_group_id
        and dbid = a.dbid)                              reports,
     --
       (select count(*) from wwv_mig_acc_pages
        where project_id = a.project_id
        and security_group_id = a.security_group_id
        and dbid = a.dbid)                              pages,
     --
       (select count(*) from wwv_mig_acc_modules
        where project_id = a.project_id
        and security_group_id = a.security_group_id
        and dbid = a.dbid)                              modules,
     --
       (select count(*) from wwv_mig_acc_relations
        where project_id = a.project_id
        and security_group_id = a.security_group_id
        and dbid = a.dbid)                              relations,
     --
        a.jetversion                                    jetversion,
     --
        a.accessversion                                 accessversion,
     --
        a.dbname                                        dbname,
     --
        a.dbid                                          dbid,
     --
        a.dbsize                                        dbsize,
     --
        a.isappdb                                       isappdb,
     --
        a.isattacheddb                                  isattacheddb,
     --
        a.startupform                                   startupform,
     --
        a.linkdbid                                      linkdbid,
     --
        a.created_by                                    created_by,
     --
        d.last_updated_on                               last_modified_on,
     --
        d.last_updated_by                               last_modified_by,
     --
        s.schema                                        schema,
     --
        w.short_name                                    workspace,
     --
        w.provisioning_company_id                       workspace_id
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
where
        (s.schema = user or user in ('SYS','SYSTEM','APEX_030200') or g.sgid = w.PROVISIONING_COMPANY_ID)
and     w.PROVISIONING_COMPANY_ID != 0
and     a.database_schema = s.schema
and     a.project_id = d.id
and     a.security_group_id = d.security_group_id
and     w.provisioning_company_id = a.security_group_id
and     w.provisioning_company_id = s.security_group_id
order by w.PROVISIONING_COMPANY_ID, a.project_id;
COMMENT ON TABLE apex_migration_acc_projects IS 'Available Application Express (Apex) Application Migrations MS Access Migration Projects';
COMMENT ON COLUMN apex_migration_acc_projects.project_id IS 'Primary key that identifies the migration project';
COMMENT ON COLUMN apex_migration_acc_projects.project_name IS 'Identifies name of the migration project';
COMMENT ON COLUMN apex_migration_acc_projects.description IS 'A brief description of the migration project';
COMMENT ON COLUMN apex_migration_acc_projects.migration_type IS 'Identifies the type of Migration Project';
COMMENT ON COLUMN apex_migration_acc_projects.project_owner IS 'Identifies the Apex User Name who created and owns the Migration Project';
COMMENT ON COLUMN apex_migration_acc_projects.accdb_pathname IS 'Identifies full path name and location of the Microsoft Access database the migration project is based on';
COMMENT ON COLUMN apex_migration_acc_projects."TABLES" IS 'Number of tables in the original MS Access database';
COMMENT ON COLUMN apex_migration_acc_projects.queries IS 'Number of queries in the original MS Access database';
COMMENT ON COLUMN apex_migration_acc_projects.forms IS 'Number of forms in the original MS Access database';
COMMENT ON COLUMN apex_migration_acc_projects.reports IS 'Number of reports in the original MS Access database';
COMMENT ON COLUMN apex_migration_acc_projects.modules IS 'Number of modules in the original MS Access database';
COMMENT ON COLUMN apex_migration_acc_projects.relations IS 'Number of relationships in the original MS Access database';
COMMENT ON COLUMN apex_migration_acc_projects.jetversion IS 'Version of Microsoft Jet for MS Access associated with captured Microsoft Access database';
COMMENT ON COLUMN apex_migration_acc_projects.accessversion IS 'Version of Microsoft Access database captured, which the migration project is based on';
COMMENT ON COLUMN apex_migration_acc_projects.dbname IS 'Identifies the name of the original MS Access database';
COMMENT ON COLUMN apex_migration_acc_projects.dbid IS 'Identifies the unique number of the original MS Access database';
COMMENT ON COLUMN apex_migration_acc_projects.dbsize IS 'Identifies the size of the original MS Access database';
COMMENT ON COLUMN apex_migration_acc_projects.isappdb IS 'Identifies whether the MS Access database is a single or parent database';
COMMENT ON COLUMN apex_migration_acc_projects.isattacheddb IS 'Identifies whether the MS Access database is attached to a parent database';
COMMENT ON COLUMN apex_migration_acc_projects.startupform IS 'Identifies the name of the startup form in the MS Access database';
COMMENT ON COLUMN apex_migration_acc_projects.linkdbid IS 'Identifies the unique number of the MS Access database that this parent database is linked to';
COMMENT ON COLUMN apex_migration_acc_projects.created_by IS 'Identifies the name of the user who created the original MS Access database';
COMMENT ON COLUMN apex_migration_acc_projects.last_modified_on IS 'Date of most recent changes to the Migration Project';
COMMENT ON COLUMN apex_migration_acc_projects.last_modified_by IS 'Identifies the APEX User Name who last modified the Migration Project';
COMMENT ON COLUMN apex_migration_acc_projects."SCHEMA" IS 'Identifies the name of database schema associated with the Migration Project';
COMMENT ON COLUMN apex_migration_acc_projects.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_migration_acc_projects.workspace_id IS 'Primary key that identifies the workspace';