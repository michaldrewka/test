CREATE OR REPLACE FORCE VIEW apex_workspace_sql_scripts (workspace_id,workspace_name,sql_script_name,email,mime_type,file_size,"OWNER",sql_script) AS
select
    w.PROVISIONING_COMPANY_ID   workspace_id,
    w.short_name                workspace_name,
    f.filename                  sql_script_name,
    (select max(email_address)
    from wwv_flow_fnd_user
    where security_group_id = w.PROVISIONING_COMPANY_ID
    and user_name=f.created_by) email,
    --
    --f.title                     file_name,
    f.mime_type                 mime_type,
    f.doc_size                  file_size,
    f.created_by                owner,
    f.blob_content              sql_script
from
    wwv_flow_file_objects$ f,
    wwv_flow_companies w
where
    f.security_group_id = w.PROVISIONING_COMPANY_ID and
    to_char(f.deleted_as_of,'MM.DD.YYYY') = '01.01.0001' and
    f.file_type = 'SCRIPT' and
    w.PROVISIONING_COMPANY_ID in (
       select security_group_id
       from   wwv_flow_company_schemas s,
              (select nvl(v('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
       where  (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200') or d.sgid = s.security_group_id) ) and
    (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10);
COMMENT ON TABLE apex_workspace_sql_scripts IS 'Identifies SQL Scripts used to execute SQL and PL/SQL commands';
COMMENT ON COLUMN apex_workspace_sql_scripts.workspace_id IS 'Primary key that identifies the workspace';
COMMENT ON COLUMN apex_workspace_sql_scripts.workspace_name IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_workspace_sql_scripts.sql_script_name IS 'Identifies name of the SQL Script';
COMMENT ON COLUMN apex_workspace_sql_scripts.email IS 'Identifies email address that corresponds to the Apex User Name who owns the SQL Script';
COMMENT ON COLUMN apex_workspace_sql_scripts.mime_type IS 'Mime type associated with the file';
COMMENT ON COLUMN apex_workspace_sql_scripts.file_size IS 'Size of the file in the BLOB';
COMMENT ON COLUMN apex_workspace_sql_scripts."OWNER" IS 'Identifies the Apex User Name who crated and owns the SQL Script';
COMMENT ON COLUMN apex_workspace_sql_scripts.sql_script IS 'The SQL Script file';