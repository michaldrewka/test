CREATE OR REPLACE FORCE VIEW apex_workspace_files (workspace_id,workspace_name,file_id,application_id,application_name,file_name,mime_type,file_size,created_by,email,created_on,file_type,"DOCUMENT") AS
select
    w.PROVISIONING_COMPANY_ID                           workspace_id,
    w.short_name                                        workspace_name,
    files.id                                            file_id,
    files.flow_id                                       application_id,
    f.name                                              application_name,
    nvl(files.title,files.filename)                     file_name,
    files.mime_type                                     mime_type,
    files.doc_size                                      file_size,
    files.created_by                                    created_by,
    (select max(email_address)
    from wwv_flow_fnd_user
    where security_group_id = w.PROVISIONING_COMPANY_ID
    and user_name=files.created_by)                     email,
    files.created_on                                    created_on,
    decode(files.file_type,
      'FLOW_EXPORT','Application Export',
      'IMAGE_EXPORT','Text Image Export',
      'PAGE_EXPORT','Application Page Export',
      'SCRIPT','SQL Script',
      'THEME','User Interface Theme Export',
      'XLIFF','XLIFF Application Translation Export',
      files.file_type)                                  file_type,
    files.blob_content                                  document
from WWV_FLOW_FILE_OBJECTS$ files,
     wwv_flows f,
     wwv_flow_company_schemas s,
     wwv_flow_companies w,
     (select nvl(v('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = s.security_group_id) and
      s.security_group_id = w.PROVISIONING_COMPANY_ID and
      (s.schema = f.owner or f.owner is null) and
      to_char(deleted_as_of,'MM.DD.YYYY') = '01.01.0001' and
      files.flow_id = f.id(+) and
      files.security_group_id = w.PROVISIONING_COMPANY_ID and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY' or f.name is null) and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10);
COMMENT ON TABLE apex_workspace_files IS 'Identifies uploaded files belonging to the workspace in the modplsql or EPG documents table';
COMMENT ON COLUMN apex_workspace_files.workspace_id IS 'Primary key that identifies the workspace';
COMMENT ON COLUMN apex_workspace_files.workspace_name IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_workspace_files.file_id IS 'Primary key that identifies the file';
COMMENT ON COLUMN apex_workspace_files.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_workspace_files.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_workspace_files.file_name IS 'Name of the file stored in a database BLOB';
COMMENT ON COLUMN apex_workspace_files.mime_type IS 'Mime type of the file used when fetching the file over the web';
COMMENT ON COLUMN apex_workspace_files.file_size IS 'Size of the file';
COMMENT ON COLUMN apex_workspace_files.created_by IS 'Identifies the Apex User Name who created the file';
COMMENT ON COLUMN apex_workspace_files.email IS 'Email address that corresponds to the Apex user name';
COMMENT ON COLUMN apex_workspace_files.created_on IS 'Identifies the date the file was loaded into the database BLOB';
COMMENT ON COLUMN apex_workspace_files.file_type IS 'Identifies the Apex file type if available';
COMMENT ON COLUMN apex_workspace_files."DOCUMENT" IS 'The file';