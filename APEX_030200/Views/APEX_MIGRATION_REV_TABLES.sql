CREATE OR REPLACE FORCE VIEW apex_migration_rev_tables (project_id,project_name,migration_type,dbid,table_id,orig_table_name,mig_table_name,"OWNER",status,primarykey_name,created_on,created_by,last_updated_on,last_updated_by,"SCHEMA",workspace,workspace_id) AS
select
        a.project_id                                    project_id,
     --
        d.migration_name                                project_name,
     --
        d.migration_type                                migration_type,
     --
        a.dbid                                          dbid,
     --
        f.tblid                                         table_id,
     --
        f.orig_table_name                               orig_table_name,
     --
        f.mig_table_name                                mig_table_name,
     --
        f.owner                                         owner,
     --
        f.status                                        status,
     --
        f.primarykey_name                               primarykey_name,
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
        wwv_mig_rev_tables f,
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
order by w.provisioning_company_id, f.project_id, f.tblid, f.dbid;
COMMENT ON TABLE apex_migration_rev_tables IS 'Available Application Express (Apex) Application Migrations Migration Projects';
COMMENT ON COLUMN apex_migration_rev_tables.project_id IS 'Primary key that identifies the migration project';
COMMENT ON COLUMN apex_migration_rev_tables.project_name IS 'Identifies name of the migration project';
COMMENT ON COLUMN apex_migration_rev_tables.migration_type IS 'Identifies the type of Migration Project';
COMMENT ON COLUMN apex_migration_rev_tables.dbid IS 'Identifies the unique number of the original MS Access database';
COMMENT ON COLUMN apex_migration_rev_tables.table_id IS 'Identifies the unique number of the original MS Access table';
COMMENT ON COLUMN apex_migration_rev_tables.orig_table_name IS 'Identifies the name of the original MS Access table';
COMMENT ON COLUMN apex_migration_rev_tables.mig_table_name IS 'Identifies the name of the migrated table associated with the MS Access table';
COMMENT ON COLUMN apex_migration_rev_tables."OWNER" IS 'Identifies the owner of the original MS Access table';
COMMENT ON COLUMN apex_migration_rev_tables.status IS 'Identifies the status of the migrated table: valid or invalid based upon existence of a primary key on the table';
COMMENT ON COLUMN apex_migration_rev_tables.primarykey_name IS 'Identifies the name of the primary key';
COMMENT ON COLUMN apex_migration_rev_tables.created_on IS 'Identifies the name of the user who created the original MS Access database';
COMMENT ON COLUMN apex_migration_rev_tables.created_by IS 'Identifies the name of the user who created the original MS Access database';
COMMENT ON COLUMN apex_migration_rev_tables.last_updated_on IS 'Date of most recent changes to the Migration Project';
COMMENT ON COLUMN apex_migration_rev_tables.last_updated_by IS 'Identifies the APEX User Name who last modified the Migration Project';