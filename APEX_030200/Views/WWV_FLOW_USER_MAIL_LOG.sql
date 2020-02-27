CREATE OR REPLACE FORCE VIEW wwv_flow_user_mail_log (mail_to,mail_from,mail_replyto,mail_subj,mail_cc,mail_bcc,mail_send_error,last_updated_on) AS
select mail_to, mail_from, mail_replyto, mail_subj, mail_cc, mail_bcc, mail_send_error, last_updated_on
      from wwv_flow_mail_log
     where security_group_id = (select wwv_flow.get_sgid from dual where rownum = 1);