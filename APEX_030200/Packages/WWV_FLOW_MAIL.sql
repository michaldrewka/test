CREATE OR REPLACE package wwv_flow_mail
as

--  Copyright (c) Oracle Corporation 2000. All Rights Reserved.
--
--    DESCRIPTION
--      Flows generic mail routines
--
--    SECURITY
--
--    NOTES
--

procedure send( p_to            in varchar2,
                p_from          in varchar2,
                p_body          in varchar2,
                p_body_html     in varchar2 default NULL,
                p_subj          in varchar2 default NULL,
                p_cc            in varchar2 default NULL,
                p_bcc           in varchar2 default NULL);

procedure send( p_to            in varchar2,
                p_from          in varchar2,
                p_body          in clob,
                p_body_html     in clob     default NULL,
                p_subj          in varchar2 default NULL,
                p_cc            in varchar2 default NULL,
                p_bcc           in varchar2 default NULL);

procedure send( p_to            in varchar2,
                p_from          in varchar2,
                p_body          in varchar2,
                p_body_html     in varchar2 default NULL,
                p_subj          in varchar2 default NULL,
                p_cc            in varchar2 default NULL,
                p_bcc           in varchar2 default NULL,
                p_replyto       in varchar2 );

procedure send( p_to            in varchar2,
                p_from          in varchar2,
                p_body          in clob,
                p_body_html     in clob     default NULL,
                p_subj          in varchar2 default NULL,
                p_cc            in varchar2 default NULL,
                p_bcc           in varchar2 default NULL,
                p_replyto       in varchar2 );

function  send( p_to            in varchar2,
                p_from          in varchar2,
                p_body          in varchar2,
                p_body_html     in varchar2 default NULL,
                p_subj          in varchar2 default NULL,
                p_cc            in varchar2 default NULL,
                p_bcc           in varchar2 default NULL)
                return number;

function send(  p_to            in varchar2,
                p_from          in varchar2,
                p_body          in clob,
                p_body_html     in clob     default NULL,
                p_subj          in varchar2 default NULL,
                p_cc            in varchar2 default NULL,
                p_bcc           in varchar2 default NULL)
                return number;

function send(  p_to            in varchar2,
                p_from          in varchar2,
                p_body          in varchar2,
                p_body_html     in varchar2 default NULL,
                p_subj          in varchar2 default NULL,
                p_cc            in varchar2 default NULL,
                p_bcc           in varchar2 default NULL,
                p_replyto       in varchar2 )
                return number;

function send(  p_to            in varchar2,
                p_from          in varchar2,
                p_body          in clob,
                p_body_html     in clob     default NULL,
                p_subj          in varchar2 default NULL,
                p_cc            in varchar2 default NULL,
                p_bcc           in varchar2 default NULL,
                p_replyto       in varchar2 )
                return number;

procedure add_attachment( p_mail_id    in number,
                          p_attachment in blob,
                          p_filename   in varchar2,
                          p_mime_type  in varchar2 );


--
-- Parameters p_smtp_hostname and p_smtp_portno remain for backward
-- compatibility.  But they are ignored.  The SMTP host name and
-- parameter are exclusively derived from system preferences
-- when sending mail.
--
procedure background( p_id in number,
                      p_smtp_hostname in varchar2 default null,
                      p_smtp_portno   in varchar2 default null );

--
-- Parameters p_smtp_hostname and p_smtp_portno remain for backward
-- compatibility.  But they are ignored.  The SMTP host name and
-- parameter are exclusively derived from system preferences
-- when sending mail.
--

procedure push_queue( p_smtp_hostname in varchar2 default null,
                      p_smtp_portno   in varchar2 default null );


--
-- Will submit a one-time database job to push the mail queue
--
procedure push_queue_background;

end wwv_flow_mail;
/