CREATE TABLE wwv_flow_mail_attachments (
  "ID" NUMBER NOT NULL,
  mail_id NUMBER NOT NULL,
  filename VARCHAR2(4000 BYTE) NOT NULL,
  mime_type VARCHAR2(48 BYTE) NOT NULL,
  "INLINE" VARCHAR2(1 BYTE) NOT NULL CONSTRAINT wwv_flow_mail_attachments_ck1 CHECK ("INLINE" in ('Y','N')),
  attachment BLOB,
  last_updated_by VARCHAR2(255 BYTE),
  last_updated_on DATE,
  security_group_id NUMBER NOT NULL,
  CONSTRAINT wwv_flow_mail_attachments_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_flow_mail_attachments_fk1 FOREIGN KEY (mail_id) REFERENCES wwv_flow_mail_queue ("ID") ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX"
LOB (attachment) STORE AS BASICFILE (
  ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  NOCACHE LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MAXEXTENTS 2147483645
  FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT));