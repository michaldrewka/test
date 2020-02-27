CREATE TABLE wwv_mig_frm_fmb_menu_menuitem (
  "ID" NUMBER NOT NULL,
  menu_id NUMBER NOT NULL,
  security_group_id NUMBER NOT NULL,
  "NAME" VARCHAR2(4000 BYTE),
  "LABEL" VARCHAR2(4000 BYTE),
  visibleinmenu VARCHAR2(4000 BYTE) DEFAULT 'true',
  submenuname VARCHAR2(4000 BYTE),
  iconinmenu VARCHAR2(4000 BYTE) DEFAULT 'false',
  iconfilename VARCHAR2(4000 BYTE),
  fontsize VARCHAR2(4000 BYTE),
  dirtyinfo VARCHAR2(4000 BYTE),
  fontname VARCHAR2(4000 BYTE),
  menuitem_comment CLOB,
  parentmodule VARCHAR2(4000 BYTE),
  magicitem VARCHAR2(4000 BYTE) DEFAULT 'Cut',
  parentmoduletype VARCHAR2(4000 BYTE),
  menuitemtype VARCHAR2(4000 BYTE) DEFAULT 'Plain',
  fontspacing VARCHAR2(4000 BYTE),
  parenttype VARCHAR2(4000 BYTE),
  keyboardaccelerator VARCHAR2(4000 BYTE),
  rolecount VARCHAR2(4000 BYTE),
  hint VARCHAR2(4000 BYTE),
  parentsourcelevel1objectname VARCHAR2(4000 BYTE),
  parentname VARCHAR2(4000 BYTE),
  fontweight VARCHAR2(4000 BYTE),
  menuitemradiogroup VARCHAR2(4000 BYTE),
  fontstyle VARCHAR2(4000 BYTE),
  commandtype VARCHAR2(4000 BYTE) DEFAULT 'Null',
  parentsourcelevel1objecttype VARCHAR2(4000 BYTE),
  menuitemcode CLOB,
  subclasssubobject VARCHAR2(4000 BYTE) DEFAULT 'false',
  visibleinverticalmenutoolbar VARCHAR2(4000 BYTE) DEFAULT 'false',
  visibleinhorizontalmenutoolbar VARCHAR2(4000 BYTE) DEFAULT 'false',
  commandtext VARCHAR2(4000 BYTE),
  displaynopriv VARCHAR2(4000 BYTE) DEFAULT 'false',
  enabled VARCHAR2(4000 BYTE) DEFAULT 'true',
  parentfilename VARCHAR2(4000 BYTE),
  parentfilepath VARCHAR2(4000 BYTE),
  persistentclientinfolength VARCHAR2(4000 BYTE),
  smartclass VARCHAR2(4000 BYTE) DEFAULT 'false',
  "VISIBLE" VARCHAR2(4000 BYTE) DEFAULT 'true',
  visualattributename VARCHAR2(4000 BYTE),
  select_for_app VARCHAR2(1 BYTE) DEFAULT 'N' NOT NULL CONSTRAINT wwv_mig_fmb_menuitem_sel_f_app CHECK (select_for_app in ('Y', 'N')),
  applicable VARCHAR2(1 BYTE) DEFAULT 'Y',
  "COMPLETE" VARCHAR2(1 BYTE) DEFAULT 'N',
  "PRIORITY" NUMBER(1) DEFAULT 3,
  assignee VARCHAR2(255 BYTE),
  notes VARCHAR2(4000 BYTE),
  tags VARCHAR2(4000 BYTE),
  created_on DATE,
  created_by VARCHAR2(400 BYTE),
  last_updated_on DATE,
  last_updated_by VARCHAR2(400 BYTE),
  CONSTRAINT wwv_mig_fmb_menu_menuitem_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_mig_fmb_menuitem_menuid_fk FOREIGN KEY (menu_id) REFERENCES wwv_mig_frm_fmb_menu ("ID") ON DELETE CASCADE,
  CONSTRAINT wwv_mig_fmb_menuitem_sgid_fk FOREIGN KEY (security_group_id) REFERENCES wwv_flow_companies (provisioning_company_id) ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX"
LOB (menuitem_comment) STORE AS BASICFILE (
  ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  NOCACHE LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MAXEXTENTS 2147483645
  FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT))
LOB (menuitemcode) STORE AS BASICFILE (
  ENABLE STORAGE IN ROW CHUNK 8192 PCTVERSION 10
  NOCACHE LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MAXEXTENTS 2147483645
  FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT));