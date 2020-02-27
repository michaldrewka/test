CREATE OR REPLACE FORCE VIEW apex_migration_acc_rpts (project_id,project_name,migration_type,dbid,report_id,report_name,report_caption,gridx,gridy,has_module,page_footer,page_header,recordsource,"TAG","VISIBLE",width,created_on,created_by,last_updated_on,last_updated_by,"SCHEMA",workspace,workspace_id) AS
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
        r.repname                                       report_name,
     --
        r.repcaption                                    report_caption,
     --
        r.gridx                                         gridx,
     --
        r.gridy                                         gridy,
     --
        r.hasmodule                                     has_module,
     --
        r.pagefooter                                    page_footer,
     --
        r.pageheader                                    page_header,
     --
        r.recordsource                                  recordsource,
     --
        r.tag                                           tag,
     --
        r.visible                                       visible,
     --
        r.width                                         width,
     --
        r.created_on                                    created_on,
     --
        r.created_by                                    created_by,
     --
        a.last_updated_on                              last_updated_on,
     --
        a.last_updated_by                              last_updated_by,
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
        wwv_mig_acc_reports r,
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
COMMENT ON TABLE apex_migration_acc_rpts IS 'Available MS Access report in the Application Express (Apex) Application Migrations Migration Projects';
COMMENT ON COLUMN apex_migration_acc_rpts.project_id IS 'Primary key that identifies the migration project';
COMMENT ON COLUMN apex_migration_acc_rpts.project_name IS 'Identifies name of the migration project';
COMMENT ON COLUMN apex_migration_acc_rpts.migration_type IS 'Identifies the type of Migration Project';
COMMENT ON COLUMN apex_migration_acc_rpts.dbid IS 'Identifies the unique number of the original MS Access database';
COMMENT ON COLUMN apex_migration_acc_rpts.report_id IS 'Identifies the unique number of the form in the original MS Access database';
COMMENT ON COLUMN apex_migration_acc_rpts.report_name IS 'Identifies the name of the form in the original MS Access database';
COMMENT ON COLUMN apex_migration_acc_rpts.report_caption IS 'A text description associated with a form in the original MS Access database';
COMMENT ON COLUMN apex_migration_acc_rpts.gridx IS 'Identifies the horizontal division of the alignment grid of the form in the original MS Access database';
COMMENT ON COLUMN apex_migration_acc_rpts.gridy IS 'Identifies the vertical division of the alignment grid of the form in the original MS Access database';
COMMENT ON COLUMN apex_migration_acc_rpts.has_module IS 'Identifies whether the form has an associated VB module';
COMMENT ON COLUMN apex_migration_acc_rpts.page_footer IS 'Identfies the positioning of page footer in relation to the report footer';
COMMENT ON COLUMN apex_migration_acc_rpts.page_header IS 'Identfies the positioning of page header in relation to the report header';
COMMENT ON COLUMN apex_migration_acc_rpts.recordsource IS 'Identifies the recordsource of the form: a table, query, SQL query or null';
COMMENT ON COLUMN apex_migration_acc_rpts."TAG" IS 'Stores an extra information on a form';
COMMENT ON COLUMN apex_migration_acc_rpts."VISIBLE" IS 'Identifies whether the form is visible and should be displayed';
COMMENT ON COLUMN apex_migration_acc_rpts.width IS 'Identifies the width of the form';
COMMENT ON COLUMN apex_migration_acc_rpts.created_on IS 'Date the form was created in the original MS Access database';
COMMENT ON COLUMN apex_migration_acc_rpts.created_by IS 'Identidies the MS Access User Name who created the original MS Access report';
COMMENT ON COLUMN apex_migration_acc_rpts.last_updated_on IS 'Date of most recent changes to the Migration Project';
COMMENT ON COLUMN apex_migration_acc_rpts.last_updated_by IS 'Identifies the APEX User Name who last modified the MS Access database';
COMMENT ON COLUMN apex_migration_acc_rpts."SCHEMA" IS 'Identifies the name of database schema associated with the Migration Project';
COMMENT ON COLUMN apex_migration_acc_rpts.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_migration_acc_rpts.workspace_id IS 'Primary key that identifies the workspace';