CREATE OR REPLACE FORCE VIEW apex_migration_rev_forms (project_id,project_name,migration_type,dbid,form_id,parent_formid,form_name,source_name,source_type,source_syntax,source_status,"OWNER",status,mig_type,created_on,created_by,last_updated_on,last_updated_by,"SCHEMA",workspace,workspace_id) AS
select
        a.project_id                                    project_id,
     --
        d.migration_name                                project_name,
     --
        d.migration_type                                migration_type,
     --
        a.dbid                                          dbid,
     --
        f.formid                                        form_id,
     --
        f.parent_formid                                 parent_formid,
     --
        f.form_name                                     form_name,
     --
        f.source_name                                   source_name,
     --
        f.source_type                                   source_type,
     --
        f.source_syntax                                 source_syntax,
     --
        f.source_status                                 source_status,
     --
        f.owner                                         owner,
     --
        f.status                                        status,
     --
        f.mig_type                                      mig_type,
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
        wwv_mig_rev_forms f,
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
order by w.provisioning_company_id, f.project_id, f.formid, f.dbid;
COMMENT ON TABLE apex_migration_rev_forms IS 'Available MS Access forms in the Application Express (Apex) Application Migrations Migration Projects';
COMMENT ON COLUMN apex_migration_rev_forms.project_id IS 'Primary key that identifies the migration project';
COMMENT ON COLUMN apex_migration_rev_forms.project_name IS 'Identifies name of the migration project';
COMMENT ON COLUMN apex_migration_rev_forms.migration_type IS 'Identifies the type of Migration Project';
COMMENT ON COLUMN apex_migration_rev_forms.dbid IS 'Identifies the unique number of the original MS Access database';
COMMENT ON COLUMN apex_migration_rev_forms.form_id IS 'Identifies the unique number of the form in the original MS Access database';
COMMENT ON COLUMN apex_migration_rev_forms.parent_formid IS 'Identifies the unique number of the parent or master form in the original MS Access database';
COMMENT ON COLUMN apex_migration_rev_forms.form_name IS 'Identifies the name of the form in the original MS Access database';
COMMENT ON COLUMN apex_migration_rev_forms.source_name IS 'Identifies the name of the source associated with the original MS Access form';
COMMENT ON COLUMN apex_migration_rev_forms.source_type IS 'Identifies the type of source associated with the original MS Access form: table, query, SQL query';
COMMENT ON COLUMN apex_migration_rev_forms.source_syntax IS 'Identifies the syntax of the source associated with the original MS Access form';
COMMENT ON COLUMN apex_migration_rev_forms.source_status IS 'Identifies the status of the source object: valid or invalid';
COMMENT ON COLUMN apex_migration_rev_forms."OWNER" IS 'Identifies the owner of the original MS Access form';
COMMENT ON COLUMN apex_migration_rev_forms.status IS 'Identifies the status of form: exclude or include in the migration process';
COMMENT ON COLUMN apex_migration_rev_forms.mig_type IS 'Identifies the type of object the form may be migrated to: form, reportandform, tabular form';
COMMENT ON COLUMN apex_migration_rev_forms.created_on IS 'Date the form was created in the original MS Access database';
COMMENT ON COLUMN apex_migration_rev_forms.created_by IS 'Identidies the MS Access User Name who created the original MS Access form';
COMMENT ON COLUMN apex_migration_rev_forms.last_updated_on IS 'Date of most recent changes to the Migration Project';
COMMENT ON COLUMN apex_migration_rev_forms.last_updated_by IS 'Identifies the APEX User Name who last modified the MS Access database';
COMMENT ON COLUMN apex_migration_rev_forms."SCHEMA" IS 'Identifies the name of database schema associated with the Migration Project';
COMMENT ON COLUMN apex_migration_rev_forms.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_migration_rev_forms.workspace_id IS 'Primary key that identifies the workspace';