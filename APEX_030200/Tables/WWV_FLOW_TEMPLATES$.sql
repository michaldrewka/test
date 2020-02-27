CREATE TABLE wwv_flow_templates$ (
  "ID" NUMBER NOT NULL,
  short_name VARCHAR2(255 BYTE) NOT NULL,
  template_name VARCHAR2(255 BYTE) NOT NULL,
  template_proc VARCHAR2(4000 BYTE) NOT NULL,
  template_type VARCHAR2(255 BYTE) NOT NULL CONSTRAINT wwv_flow_tmplt_type CHECK (template_type in(
                              'Page',
                              'Region',
                              'List',
                              'Field',
                              'Report',
                              'Button',
                              'Menu',
                              'PopUp')),
  theme NUMBER,
  preview_link VARCHAR2(4000 BYTE),
  CONSTRAINT wwv_flow_tmps_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX"
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";