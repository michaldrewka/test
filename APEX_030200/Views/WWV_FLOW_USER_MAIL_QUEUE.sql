CREATE OR REPLACE FORCE VIEW wwv_flow_user_mail_queue ("ID",mail_to,mail_from,mail_replyto,mail_subj,mail_cc,mail_bcc,mail_body,mail_body_html,mail_send_count,mail_send_error,last_updated_by,last_updated_on) AS
select id, mail_to, mail_from, mail_replyto, mail_subj, mail_cc, mail_bcc, mail_body, mail_body_html, mail_send_count, mail_send_error, last_updated_by, last_updated_on
      from wwv_flow_mail_queue
     where security_group_id = (select wwv_flow.get_sgid from dual where rownum = 1);