CREATE TABLE wwv_flow_hnt_argument_info (
  argument_id NUMBER NOT NULL,
  procedure_id NUMBER NOT NULL,
  argument_name VARCHAR2(30 BYTE) NOT NULL,
  "LABEL" VARCHAR2(255 BYTE),
  help_text VARCHAR2(4000 BYTE),
  mask VARCHAR2(255 BYTE),
  display_seq_form NUMBER,
  display_in_form VARCHAR2(1 BYTE) CONSTRAINT wwv_flow_hnt_display_in_form CHECK (display_in_form in ('Y','N')),
  display_as_form VARCHAR2(50 BYTE) CONSTRAINT wwv_flow_hnt_display_as_form CHECK (display_as_form in (
                                    'DISPLAY_ONLY_PLSQL',
                                    'FILE',
                                    'BUTTON',
                                    'HIDDEN',
                                    'HIDDEN_PROTECTED',
                                    'DISPLAY_ONLY_HTML',
                                    'STOP_AND_START_HTML_TABLE',
                                    'DISPLAY_ONLY_ESCAPE_SC',
                                    'IMAGE',
                                    'DISPLAY_AND_SAVE',
                                    'DISPLAY_AND_SAVE_LOV',
                                    'CHECKBOX',
                                    'POPUP',
                                    'POPUP_FILTER',
                                    'POPUP2',
                                    'POPUP3',
                                    'POPUP4',
                                    'POPUP5',
                                    'POPUP6',
                                    'POPUP_KEY_LOV',
                                    'PICK_DATE_USING_APP_FORMAT_MASK',
                                    'PICK_DATE_USING_APP_DATE_FORMAT',
                                    'PICK_DATE_USING_FORMAT_MASK',
                                    'PICK_DATE_DD_MON_RR',
                                    'PICK_DATE_DD_MON_RR_HH_MI',
                                    'PICK_DATE_DD_MON_RR_HH24_MI',
                                    'PICK_DATE_DD_MON_YYYY',
                                    'PICK_DATE_DD_MON_YYYY_HH_MI',
                                    'PICK_DATE_DD_MON_YYYY_HH24_MI',
                                    'PICK_DATE_DD_MM_YYYY',
                                    'PICK_DATE_DD_MM_YYYY_HH_MI',
                                    'PICK_DATE_DD_MM_YYYY_HH24_MI',
                                    'PICK_DATE_MM_DD_YYYY',
                                    'PICK_DATE_MM_DD_YYYY_HH_MI',
                                    'PICK_DATE_MM_DD_YYYY_HH24_MI',
                                    'PICK_DATE_DD_MON_YY',
                                    'PICK_DATE_DD_MON_YY_HH_MI',
                                    'PICK_DATE_DD_MON_YY_HH24_MI',
                                    'PICK_DATE_YYYY_MM_DD',
                                    'PICK_DATE_YYYY_MM_DD_HH_MI',
                                    'PICK_DATE_YYYY_MM_DD_HH24_MI',
                                    'PICK_DATE_RR_MON_DD',
                                    'PICK_DATE_RR_MON_DD_HH_MI',
                                    'PICK_DATE_RR_MON_DD_HH24_MI',
                                    'PICK_DATE_DD_MM_YYYY_DASH',
                                    'PICK_DATE_DD_MM_YYYY_HH_MI_DASH',
                                    'PICK_DATE_DD_MM_YYYY_HH24_MI_DASH',
                                    'PICK_DATE_DD_MM_YYYY_DOT',
                                    'PICK_DATE_DD_MM_YYYY_HH_MI_DOT',
                                    'PICK_DATE_DD_MM_YYYY_HH24_MI_DOT',
                                    'PICK_DATE_YYYY_DD_MM_DOT',
                                    'PICK_DATE_YYYY_DD_MM_HH_MI_DOT',
                                    'PICK_DATE_YYYY_DD_MM_HH24_MI_DOT',
                                    'PICK_DATE_YYYY_MM_DD_SLASH',
                                    'PICK_DATE_YYYY_MM_DD_HH_MI_SLASH',
                                    'PICK_DATE_YYYY_MM_DD_HH24_MI_SLASH',
                                    'DISPLAY_ONLY_LOV',
                                    'COMBOBOX',
                                    'SHOW_AS_SL_WITH_POPUP',
                                    'COMBOBOX_WITH_URL_REDIRECT',
                                    'COMBOBOX_WITH_BRANCH_TO_PAGE',
                                    'COMBOBOX_WITH_SUBMIT',
                                    'COMBOBOX_WITH_JS_POST',
                                    'COMBOBOX_WITH_JS_REDIRECT',
                                    'MULTIPLESELECT',
                                    'RADIOGROUP',
                                    'RADIOGROUP2',
                                    'RADIOGROUP_WITH_REDIRECT',
                                    'RADIOGROUP_WITH_SUBMIT',
                                    'RADIOGROUP_WITH_JS_SUBMIT',
                                    'TEXTAREA',
                                    'TEXTAREA_WITH_SPELL_CHECK',
                                    'TEXTAREA-AUTO-HEIGHT',
                                    'TEXTAREA_WITH_CONTROLS',
                                    'TEXTAREA_WITH_HTML_EDITOR_BASIC',
                                    'TEXTAREA_WITH_HTML_EDITOR_STANDARD',
                                    'TEXTAREA_CHAR_COUNT',
                                    'TEXTAREA_CHAR_COUNT_SPELL',
                                    'TEXT',
                                    'TEXT_DISABLED',
                                    'TEXT_DISABLED_AND_SAVE',
                                    'TEXT_WITH_CALCULATOR',
                                    'PASSWORD',
                                    'LIST_MGR',
                                    'LIST_MGR2',
                                    'LIST_MGR3',
                                    'LIST_MGR_VIEW',
                                    'LIST_MGR_VIEW2')),
  lov_query VARCHAR2(4000 BYTE),
  default_value VARCHAR2(255 BYTE),
  "REQUIRED" VARCHAR2(1 BYTE) CHECK ("REQUIRED" in ('Y','N')),
  alignment VARCHAR2(1 BYTE) CHECK (alignment in ('L','C','R')),
  display_width NUMBER,
  max_width NUMBER,
  height NUMBER,
  created_by VARCHAR2(255 BYTE) NOT NULL,
  created_on DATE NOT NULL,
  last_updated_by VARCHAR2(255 BYTE),
  last_updated_on DATE,
  CONSTRAINT wwv_flow_hnt_arg_info_pk PRIMARY KEY (argument_id) USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_flow_hnt_arg_info_uk UNIQUE (procedure_id,argument_name) USING INDEX NOCOMPRESS
    PCTFREE 10 INITRANS 2 LOGGING
    STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
    TABLESPACE "SYSAUX",
  CONSTRAINT wwv_flow_hnt_arg_info_proc_fk FOREIGN KEY (procedure_id) REFERENCES wwv_flow_hnt_procedure_info (procedure_id) ON DELETE CASCADE
) NOCOMPRESS
PCTFREE 10 INITRANS 1 LOGGING
STORAGE(FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
TABLESPACE "SYSAUX";
COMMENT ON TABLE wwv_flow_hnt_argument_info IS 'Contains information about each argument in each procedure in a schema.  This information can be used by the wizards to default forms.';
COMMENT ON COLUMN wwv_flow_hnt_argument_info.argument_id IS 'System generated PK.';
COMMENT ON COLUMN wwv_flow_hnt_argument_info.procedure_id IS 'FK to wwv_flow_hnt_procedure_info.';
COMMENT ON COLUMN wwv_flow_hnt_argument_info.argument_name IS 'Name of the argument within the procedure.';
COMMENT ON COLUMN wwv_flow_hnt_argument_info."LABEL" IS 'Will become the label of the item.';
COMMENT ON COLUMN wwv_flow_hnt_argument_info.help_text IS 'Will become item help.';
COMMENT ON COLUMN wwv_flow_hnt_argument_info.mask IS 'A mask that would be applied against the data, such as 999-99-9999.';
COMMENT ON COLUMN wwv_flow_hnt_argument_info.display_seq_form IS 'Display sequence of items in a form.';
COMMENT ON COLUMN wwv_flow_hnt_argument_info.display_in_form IS 'Indicates whether this argument would typically be displayed in a form.';
COMMENT ON COLUMN wwv_flow_hnt_argument_info.display_as_form IS 'Indicates how the item would typcially be displayed, such as BUTTON or CHECKBOX, in a form.';
COMMENT ON COLUMN wwv_flow_hnt_argument_info.lov_query IS 'Will be used to generate a lov.  This will only be valid for certain "display_as" types.';
COMMENT ON COLUMN wwv_flow_hnt_argument_info.default_value IS 'The default value associated with this argument.';
COMMENT ON COLUMN wwv_flow_hnt_argument_info."REQUIRED" IS 'Will be used to generate a validation that the resulting item must be NOT NULL.';
COMMENT ON COLUMN wwv_flow_hnt_argument_info.alignment IS 'Will be used for alignment in reporting; Left, Center, or Right.';
COMMENT ON COLUMN wwv_flow_hnt_argument_info.display_width IS 'Will be used for display width.';
COMMENT ON COLUMN wwv_flow_hnt_argument_info.max_width IS 'The maximum string length that a user would be allowed to enter in this item.';
COMMENT ON COLUMN wwv_flow_hnt_argument_info.height IS 'Will be used as the display height of item.';
COMMENT ON COLUMN wwv_flow_hnt_argument_info.created_by IS 'Auditing; user that created the record.';
COMMENT ON COLUMN wwv_flow_hnt_argument_info.created_on IS 'Auditing; date the record was created.';
COMMENT ON COLUMN wwv_flow_hnt_argument_info.last_updated_by IS 'Auditing; user that last modified the record.';
COMMENT ON COLUMN wwv_flow_hnt_argument_info.last_updated_on IS 'Auditing; date the record was last modified.';