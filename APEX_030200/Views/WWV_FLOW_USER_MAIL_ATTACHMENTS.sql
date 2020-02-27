CREATE OR REPLACE FORCE VIEW wwv_flow_user_mail_attachments ("ID",mail_id,filename,mime_type,"INLINE",attachment,last_updated_by,last_updated_on) AS
select id, mail_id, filename, mime_type, inline, attachment, last_updated_by, last_updated_on
      from wwv_flow_mail_attachments
     where security_group_id = (select wwv_flow.get_sgid from dual where rownum = 1);