CREATE TABLE wwv_mig_olb_olt_graphics (
  "ID" NUMBER NOT NULL,
  objectlibrarytab_id NUMBER NOT NULL,
  security_group_id NUMBER NOT NULL,
  "NAME" VARCHAR2(4000 BYTE),
  layoutstyle VARCHAR2(4000 BYTE),
  layoutdatablockname VARCHAR2(4000 BYTE),
  frametitle VARCHAR2(4000 BYTE),
  bevel VARCHAR2(4000 BYTE),
  width VARCHAR2(4000 BYTE),
  height VARCHAR2(4000 BYTE),
  graphicstype VARCHAR2(4000 BYTE),
  graphicstext VARCHAR2(4000 BYTE),
  graphicsfontname VARCHAR2(4000 BYTE),
  graphicsfontsize VARCHAR2(4000 BYTE),
  graphicsfontstyle VARCHAR2(4000 BYTE),
  graphicsfontweight VARCHAR2(4000 BYTE),
  graphicsfontcolor VARCHAR2(4000 BYTE),
  graphicsfontspacing VARCHAR2(4000 BYTE),
  graphicsfontcolorcode VARCHAR2(4000 BYTE),
  edgepattern VARCHAR2(4000 BYTE),
  edgeforegroundcolor VARCHAR2(4000 BYTE),
  backcolor VARCHAR2(4000 BYTE),
  horizontalmargin VARCHAR2(4000 BYTE),
  verticalmargin VARCHAR2(4000 BYTE),
  internallinewidth VARCHAR2(4000 BYTE),
  horizontalobjectoffset VARCHAR2(4000 BYTE),
  cornerradiusy VARCHAR2(4000 BYTE),
  cornerradiusx VARCHAR2(4000 BYTE),
  xposition VARCHAR2(4000 BYTE),
  yposition VARCHAR2(4000 BYTE),
  joinstyle VARCHAR2(4000 BYTE),
  startpromptoffset VARCHAR2(4000 BYTE),
  showscrollbar VARCHAR2(4000 BYTE),
  scrollbarwidth VARCHAR2(4000 BYTE),
  distancebetweenrecords VARCHAR2(4000 BYTE),
  frametitlespacing VARCHAR2(4000 BYTE),
  frametitleoffset VARCHAR2(4000 BYTE),
  edgebackcolor VARCHAR2(4000 BYTE),
  fillpattern VARCHAR2(4000 BYTE),
  dirtyinfo VARCHAR2(4000 BYTE),
  recordsdisplaycount VARCHAR2(4000 BYTE),
  internalrotationangle VARCHAR2(4000 BYTE),
  capstyle VARCHAR2(4000 BYTE),
  dashstyle VARCHAR2(4000 BYTE),
  arrowstyle VARCHAR2(4000 BYTE),
  foregroundcolor VARCHAR2(4000 BYTE),
  verticaljustification VARCHAR2(4000 BYTE),
  horizontaljustification VARCHAR2(4000 BYTE),
  boundingboxscalable VARCHAR2(4000 BYTE),
  fontscaleable VARCHAR2(4000 BYTE),
  fixedboundingbox VARCHAR2(4000 BYTE),
  linespacing VARCHAR2(4000 BYTE),
  customspacing VARCHAR2(4000 BYTE),
  languagedirection VARCHAR2(4000 BYTE),
  verticalorigin VARCHAR2(4000 BYTE),
  horizontalorigin VARCHAR2(4000 BYTE),
  wraptext VARCHAR2(4000 BYTE),
  select_for_app VARCHAR2(1 BYTE) DEFAULT 'N' NOT NULL CONSTRAINT wwv_mig_olb_t_grphcs_sel_f_app CHECK (select_for_app in ('Y', 'N')),
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
  CONSTRAINT wwv_mig_olb_olt_graphics_pk PRIMARY KEY ("ID") USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_mig_olb_t_graphcs_sg_id_fk FOREIGN KEY (security_group_id) REFERENCES wwv_flow_companies (provisioning_company_id) ON DELETE CASCADE,
  CONSTRAINT wwv_mig_olb_t_grphcs_olt_id_fk FOREIGN KEY (objectlibrarytab_id) REFERENCES wwv_mig_olb_objectlibrarytab ("ID") ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";