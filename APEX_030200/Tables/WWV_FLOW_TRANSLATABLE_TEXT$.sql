CREATE TABLE wwv_flow_translatable_text$ (
  "ID" NUMBER NOT NULL,
  translated_flow_id NUMBER,
  flow_id NUMBER NOT NULL,
  page_id NUMBER,
  translate_from_id NUMBER,
  translate_to_id NUMBER,
  translate_from_flow_table VARCHAR2(61 BYTE),
  translate_from_flow_column VARCHAR2(30 BYTE),
  translate_to_lang_code VARCHAR2(30 BYTE),
  translation_specific_to_item VARCHAR2(3 BYTE) CONSTRAINT wwv_flow_trans_specific_check CHECK (translation_specific_to_item in ('YES','NO')),
  translate_to_text NCLOB,
  translate_from_text NCLOB,
  template_translatable VARCHAR2(1 BYTE) CONSTRAINT wwv_flow_trans_temp_trans_chk CHECK (template_translatable in ('Y','N')),
  security_group_id NUMBER NOT NULL,
  last_updated_by VARCHAR2(255 BYTE),
  last_updated_on DATE,
  text_substr_1_255 NVARCHAR2(255),
  CONSTRAINT wwv_flow_trans_text_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_flow_trans_text_fk FOREIGN KEY (flow_id) REFERENCES wwv_flows ("ID") ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX"
LOB (translate_from_text) STORE AS BASICFILE (
  ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  NOCACHE LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MAXEXTENTS 2147483645
  FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT))
LOB (translate_to_text) STORE AS BASICFILE (
  ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  NOCACHE LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MAXEXTENTS 2147483645
  FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT));