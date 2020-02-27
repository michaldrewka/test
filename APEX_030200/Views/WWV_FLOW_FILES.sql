CREATE OR REPLACE FORCE VIEW wwv_flow_files ("ID",flow_id,"NAME",filename,title,mime_type,doc_size,dad_charset,created_by,created_on,updated_by,updated_on,last_updated,content_type,blob_content,language,description,file_type,file_charset) AS
select id, flow_id, name, filename, title, mime_type, doc_size, dad_charset,
         created_by, created_on, updated_by, updated_on, last_updated, content_type,
         blob_content, language, description, file_type, file_charset
    from wwv_flow_file_objects$
   where security_group_id = wwv_flow.get_sgid and security_group_id <> 0;