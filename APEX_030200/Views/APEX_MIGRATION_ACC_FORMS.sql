CREATE OR REPLACE FORCE VIEW apex_migration_acc_forms (project_id,project_name,migration_type,dbid,form_id,form_name,form_caption,gridx,gridy,has_module,inside_height,inside_width,logical_pagewidth,modal,popup,recordsource,"TAG","VISIBLE",width,created_on,created_by,last_updated_on,last_updated_by,startupform,"SCHEMA",workspace,workspace_id) AS
select
        a.project_id                                    project_id,
     --
        d.migration_name                                project_name,
     --
        d.migration_type                                migration_type,
     --
        a.dbid                                          dbid,
     --
        f.formid                                       form_id,
     --
        f.formname                                     form_name,
     --
        f.formcaption                                  form_caption,
     --
        f.gridx                                        gridx,
     --
        f.gridy                                        gridy,
     --
        f.hasmodule                                    has_module,
     --
        f.insideheight                                 inside_height,
     --
        f.insidewidth                                  inside_width,
     --
        f.logicalpagewidth                             logical_pagewidth,
     --
        f.modal                                        modal,
     --
        f.popup                                        popup,
     --
        f.recordsource                                 recordsource,
     --
        f.tag                                          tag,
     --
        f.visible                                      visible,
     --
        f.width                                        width,
     --
        f.created_on                                   created_on,
     --
        f.created_by                                   created_by,
     --
        a.last_updated_on                              last_updated_on,
     --
        a.last_updated_by                              last_updated_by,
     --
        decode(a.startupform, f.formname, a.startupform, null) startupform,
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
        wwv_mig_acc_forms f,
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
COMMENT ON TABLE apex_migration_acc_forms IS 'Available MS Access forms in the Application Express (Apex) Application Migrations Migration Projects';
COMMENT ON COLUMN apex_migration_acc_forms.project_id IS 'Primary key that identifies the migration project';
COMMENT ON COLUMN apex_migration_acc_forms.project_name IS 'Identifies name of the migration project';
COMMENT ON COLUMN apex_migration_acc_forms.migration_type IS 'Identifies the type of Migration Project';
COMMENT ON COLUMN apex_migration_acc_forms.dbid IS 'Identifies the unique number of the original MS Access database';
COMMENT ON COLUMN apex_migration_acc_forms.form_id IS 'Identifies the unique number of the form in the original MS Access database';
COMMENT ON COLUMN apex_migration_acc_forms.form_name IS 'Identifies the name of the form in the original MS Access database';
COMMENT ON COLUMN apex_migration_acc_forms.form_caption IS 'A text description associated with a form in the original MS Access database';
COMMENT ON COLUMN apex_migration_acc_forms.gridx IS 'Identifies the horizontal division of the alignment grid of the form in the original MS Access database';
COMMENT ON COLUMN apex_migration_acc_forms.gridy IS 'Identifies the vertical division of the alignment grid of the form in the original MS Access database';
COMMENT ON COLUMN apex_migration_acc_forms.has_module IS 'Identifies whether the form has an associated VB module';
COMMENT ON COLUMN apex_migration_acc_forms.inside_height IS 'A number representing the height of a form window';
COMMENT ON COLUMN apex_migration_acc_forms.inside_width IS 'A number representing the width of a form window';
COMMENT ON COLUMN apex_migration_acc_forms.logical_pagewidth IS 'A number representing the width of the printable page less the margins of a form in the original MS Access database';
COMMENT ON COLUMN apex_migration_acc_forms.modal IS 'Identifies whether a form is modal and needs to be closed before moving focus elsewhere';
COMMENT ON COLUMN apex_migration_acc_forms.popup IS 'Identifies whether a form is a pop-up form';
COMMENT ON COLUMN apex_migration_acc_forms.recordsource IS 'Identifies the recordsource of the form: a table, query, SQL query or null';
COMMENT ON COLUMN apex_migration_acc_forms."TAG" IS 'Stores an extra information on a form';
COMMENT ON COLUMN apex_migration_acc_forms."VISIBLE" IS 'Identifies whether the form is visible and should be displayed';
COMMENT ON COLUMN apex_migration_acc_forms.width IS 'Identifies the width of the form';
COMMENT ON COLUMN apex_migration_acc_forms.created_on IS 'Date the form was created in the original MS Access database';
COMMENT ON COLUMN apex_migration_acc_forms.created_by IS 'Identidies the MS Access User Name who created the original MS Access form';
COMMENT ON COLUMN apex_migration_acc_forms.last_updated_on IS 'Date of most recent changes to the Migration Project';
COMMENT ON COLUMN apex_migration_acc_forms.last_updated_by IS 'Identifies the APEX User Name who last modified the MS Access database';
COMMENT ON COLUMN apex_migration_acc_forms.startupform IS 'Identifies the name of the startup form in the MS Access database';
COMMENT ON COLUMN apex_migration_acc_forms."SCHEMA" IS 'Identifies the name of database schema associated with the Migration Project';
COMMENT ON COLUMN apex_migration_acc_forms.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_migration_acc_forms.workspace_id IS 'Primary key that identifies the workspace';