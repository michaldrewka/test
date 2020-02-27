CREATE OR REPLACE FORCE VIEW apex_application_page_items (workspace,application_id,application_name,page_id,page_name,item_name,display_as,item_data_type,display_sequence,region,region_id,source_used,item_default,item_default_type,"LABEL",pre_element_text,post_element_text,format_mask,item_label_template,item_label_template_id,item_source,item_source_type,encrypt_session_state,source_post_computation,read_only_condition_type,read_only_condition_exp1,read_only_condition_exp2,read_only_display_attr,lov_named_lov,lov_definition,lov_columns,lov_display_extra,lov_display_null,lov_null_text,lov_null_value,lov_query_result_translated,item_element_width,item_element_max_length,item_element_height,html_table_cell_attr_label,html_table_cell_attr_element,html_form_element_attributes,form_element_option_attributes,item_button_image,item_button_image_attributes,begins_on_new_row,begins_on_new_cell,column_span,row_span,label_alignment,item_alignment,condition_type,condition_expression1,condition_expression2,maintain_session_state,item_protection_level,authorization_scheme,authorization_scheme_id,build_option,build_option_id,item_help_text,last_updated_by,last_updated_on,component_comment,item_id,component_signature) AS
select
    w.short_name                    workspace,
    p.flow_id                       application_id,
    f.name                          application_name,
    p.id                            page_id,
    p.name                          page_name,
    --
    i.name                          item_name,
    decode(i.display_as,
    'PICK_DATE_USING_APP_DATE_FORMAT','Date Picker using Application Date Format',
    'PICK_DATE_USING_APP_FORMAT_MASK','Date Picker using application format mask',
    'PICK_DATE_USING_FORMAT_MASK','Date Picker using item format mask',
    'PICK_DATE_DD_MM_YYYY_HH24_MI_DASH', 'Date Picker (DD-MM-YYYY HH24:MI)',
    'PICK_DATE_DD_MM_YYYY_HH_MI_DASH','Date Picker (DD-MM-YYYY HH:MI)',
    'PICK_DATE_DD_MM_YYYY_DASH','Date Picker (DD-MM-YYYY)',
    'PICK_DATE_DD_MON_RR_HH24_MI', 'Date Picker (DD-MON-RR HH24:MI)',
    'PICK_DATE_DD_MON_RR_HH_MI','Date Picker (DD-MON-RR HH:MI)',
    'PICK_DATE_DD_MON_RR','Date Picker (DD-MON-RR)',
    'PICK_DATE_DD_MON_YY_HH24_MI','Date Picker (DD-MON-YY HH24:MI)',
    'PICK_DATE_DD_MON_YY_HH_MI','Date Picker (DD-MON-YY HH:MI)',
    'PICK_DATE_DD_MON_YY','Date Picker (DD-MON-YY)',
    'PICK_DATE_DD_MON_YYYY_HH24_MI','Date Picker (DD-MON-YYYY HH24:MI)',
    'PICK_DATE_DD_MON_YYYY_HH_MI','Date Picker (DD-MON-YYYY HH:MI)',
    'PICK_DATE_DD_MON_YYYY','Date Picker (DD-MON-YYYY)',
    'PICK_DATE_DD_MM_YYYY_HH24_MI_DOT','Date Picker (DD.MM.YYYY HH24:MI)',
    'PICK_DATE_DD_MM_YYYY_HH_MI_DOT','Date Picker (DD.MM.YYYY HH:MI)',
    'PICK_DATE_DD_MM_YYYY_DOT','Date Picker (DD.MM.YYYY)',
    'PICK_DATE_DD_MM_YYYY_HH24_MI','Date Picker (DD/MM/YYYY HH24:MI)',
    'PICK_DATE_DD_MM_YYYY_HH_MI','Date Picker (DD/MM/YYYY HH:MI)',
    'PICK_DATE_DD_MM_YYYY','Date Picker (DD/MM/YYYY)',
    'PICK_DATE_MM_DD_YYYY_HH24_MI','Date Picker (MM/DD/YYYY HH24:MI)',
    'PICK_DATE_MM_DD_YYYY_HH_MI','Date Picker (MM/DD/YYYY HH:MI)',
    'PICK_DATE_MM_DD_YYYY','Date Picker (MM/DD/YYYY)',
    'PICK_DATE_RR_MON_DD_HH24_MI','Date Picker (RR-MON-DD HH24:MI)',
    'PICK_DATE_RR_MON_DD_HH_MI','Date Picker (RR-MON-DD HH:MI)',
    'PICK_DATE_RR_MON_DD','Date Picker (RR-MON-DD)',
    'PICK_DATE_YYYY_MM_DD_HH24_MI','Date Picker (YYYY-MM-DD HH24:MI)',
    'PICK_DATE_YYYY_MM_DD_HH_MI','Date Picker (YYYY-MM-DD HH:MI)',
    'PICK_DATE_YYYY_MM_DD','Date Picker (YYYY-MM-DD)',
    'PICK_DATE_YYYY_DD_MM_HH24_MI_DOT','Date Picker (YYYY.DD.MM HH24:MI)',
    'PICK_DATE_YYYY_DD_MM_HH_MI_DOT','Date Picker (YYYY.DD.MM HH:MI)',
    'PICK_DATE_YYYY_DD_MM_DOT','Date Picker (YYYY.DD.MM)',
    'PICK_DATE_YYYY_MM_DD_HH24_MI_SLASH','Date Picker (YYYY/MM/DD HH24:MI)',
    'PICK_DATE_YYYY_MM_DD_HH_MI_SLASH','Date Picker (YYYY/MM/DD HH:MI)',
    'PICK_DATE_YYYY_MM_DD_SLASH','Date Picker (YYYY/MM/DD)',
    'PICK_DATE_USING_FLOW_FORMAT_MASK','Date Picker (use application format mask)',
    'DISPLAY_ONLY_LOV','Display as Text (based on LOV, does not save state)',
    'DISPLAY_AND_SAVE_LOV','Display as Text (based on LOV, saves state)',
    'DISPLAY_ONLY_PLSQL','Display as Text (based on PLSQL, does not save state)',
    'DISPLAY_ONLY_HTML','Display as Text (does not save state)',
    'DISPLAY_ONLY_ESCAPE_SC','Display as Text (escape special characters, does not save state)',
    'DISPLAY_AND_SAVE','Display as Text (saves state)',
    'FILE' ,'File Browse...',
    'HIDDEN','Hidden',
    'HIDDEN_PROTECTED','Hidden and Protected',
    'LIST_MGR_VIEW','List Manager (View Only)',
    'LIST_MGR','List Manager (based on Popup LOV)',
    'LIST_MGR2','List Manager (based on Popup LOV, no fetch)',
    'LIST_MGR3','List Manager (based on Popup LOV, preserves case)',
    'MULTIPLESELECT','Multiselect List',
    'PASSWORD','Password (saves state)',
    'PASSWORD_WITH_ENTER_SUBMIT','Password (submits when Enter pressed, saves state)',
    'PASSWORD_DNSS','Password (does not save state)',
    'PASSWORD_WITH_SUBMIT_DNSS','Password (submits when Enter pressed, does not save state)',
    'POPUP_KEY_LOV','Popup Key LOV (Displays description, returns key value)',
    'POPUP_KEY_LOV_NOFETCH','Popup Key LOV No Fetch (Displays description, returns key value without pre-fetch)',
    'POPUP_FILTER','Popup LOV (fetches first rowset and filters)',
    'POPUP','Popup LOV (fetches first rowset)',
    'POPUP2','Popup LOV (no fetch)',
    'RADIOGROUP','Radiogroup',
    'RADIOGROUP_WITH_SUBMIT','Radiogroup (with Submit)',
    'RADIOGROUP_WITH_REDIRECT','Radiogroup with Redirect',
    'COMBOBOX','Select List',
    'COMBOBOX_WITH_URL_REDIRECT','Select List Returning URL redirect',
    'COMBOBOX_WITH_BRANCH_TO_PAGE','Select List with Branch to Page',
    'SHOW_AS_SL_WITH_POPUP','Select List with POPUP LOV',
    'COMBOBOX_WITH_JS_REDIRECT','Select List with Redirect',
    'COMBOBOX_WITH_SUBMIT','Select List with Submit',
    'STOP_AND_START_HTML_TABLE','Stop and Start HTML Table (Displays label only)',
    'TEXT','Text Field',
    'TEXT_DISABLED','Text Field (Disabled, does not save state)',
    'TEXT_DISABLED_AND_SAVE','Text Field (Disabled, saves state)',
    'TEXT_WITH_ENTER_SUBMIT','Text Field (always submits page when Enter pressed)',
    'TEXT_WITH_CALCULATOR','Text Field with Calculator Popup',
    'TEXTAREA','Textarea',
    'TEXTAREA-AUTO-HEIGHT','Textarea (auto-height)',
    'TEXTAREA_CHAR_COUNT','Textarea with Character Counter',
    'TEXTAREA_CHAR_COUNT_SPELL','Textarea with Character Counter Spellcheck',
    'TEXTAREA_WITH_CONTROLS','Textarea with HTML Editor',
    'TEXTAREA_WITH_SPELL_CHECK','Textarea with Spell Checker',
    'CHECKBOX','Checkbox',
    'POPUP_COLOR','Popup Color Picker',
    'TEXTAREA_WITH_HTML_EDITOR_BASIC','Basic HTML Editor',
    'TEXTAREA_WITH_HTML_EDITOR_STANDARD','Standard HTML Editor',
    'SHUTTLE','Shuttle',
    i.display_as)                   display_as,
    decode(i.DATA_TYPE,
       'NUMBER','Numbers Only',
       'VARCHAR','Varchar',
       i.DATA_TYPE)                 item_data_type,
       --
    i.ITEM_SEQUENCE                 display_sequence,
    (select plug_name
     from wwv_flow_page_plugs
     where id = i.ITEM_PLUG_ID)     region,
    i.item_plug_id                  region_id,
    --
    decode(
      i.USE_CACHE_BEFORE_DEFAULT,
      'NO','Always, replacing any existing value in session state',
      'YES','Only when current value in session state is null',
      i.USE_CACHE_BEFORE_DEFAULT)   source_used,
    i.ITEM_DEFAULT                  item_default,
    i.ITEM_DEFAULT_TYPE             item_default_type,
    --
    i.PROMPT                        label,
    i.PRE_ELEMENT_TEXT              pre_element_text,
    i.POST_ELEMENT_TEXT             post_element_text,
    i.FORMAT_MASK                   format_mask,
    (select template_name
     from   wwv_flow_field_templates
     where  id = to_char(i.ITEM_FIELD_TEMPLATE)
     and    flow_id = f.id)         item_label_template,
    i.ITEM_FIELD_TEMPLATE           item_label_template_id,
    i.SOURCE                        item_source,
    decode(i.SOURCE_TYPE,
      'ALWAYS_NULL','Always Null',
      'STATIC','Static Assignment (value equals source attribute)',
      'QUERY','SQL Query',
      'ITEM','Item (application or page item name)',
      'FUNCTION','PL/SQL Expression or Function',
      'FUNCTION_BODY','PL/SQL Function Body',
      'DB_COLUMN','Database Column',
      'PREFERENCE','Preference',
      'PLSQL_ANONYMOUS_BLOCK','PL/SQL Anonymous Block',
      i.SOURCE_TYPE)                item_source_type,
    decode(i.encrypt_session_state_yn,'Y','Yes','No') encrypt_session_state,
    i.SOURCE_POST_COMPUTATION       source_post_computation,
    -- read only conditionality
    nvl((select r from apex_standard_conditions where d = i.READ_ONLY_WHEN_TYPE),i.READ_ONLY_WHEN_TYPE)
                                    read_only_condition_type,
    i.READ_ONLY_WHEN                read_only_condition_exp1,
    i.READ_ONLY_WHEN2               read_only_condition_exp2,
    i.READ_ONLY_DISP_ATTR           read_only_display_attr,
    --
    i.NAMED_LOV                     lov_named_lov,
    i.LOV                           lov_definition,
    i.LOV_COLUMNS                   lov_columns,
    decode(i.LOV_DISPLAY_EXTRA,
      'NO','No',
      'YES','Yes',
      i.LOV_DISPLAY_EXTRA)          lov_display_extra,
    decode(i.LOV_DISPLAY_NULL,
      'NO','No',
      'YES','Yes',
      i.LOV_DISPLAY_NULL)           lov_display_null,
    i.LOV_NULL_TEXT                 lov_null_text,
    i.LOV_NULL_VALUE                lov_null_value,
    decode(i.LOV_TRANSLATED,
      'N','No','Y','Yes',
      i.LOV_TRANSLATED)             lov_query_result_translated,
    --
    i.csize                         item_element_width,
    i.cmaxlength                    item_element_max_length,
    i.cheight                       item_element_height,
    --
    i.cattributes                   html_table_cell_attr_label,
    i.cattributes_element           html_table_cell_attr_element,
    i.tag_attributes                html_form_element_attributes,
    i.tag_attributes2               form_element_option_attributes,
    --
    i.button_image                  item_button_image,
    i.button_image_attr             item_button_image_attributes,
    --
    decode(i.BEGIN_ON_NEW_LINE,
      'NO','No','YES','Yes',
      i.BEGIN_ON_NEW_LINE)          begins_on_new_row,
    decode(i.BEGIN_ON_NEW_FIELD,
      'NO','No','YES','Yes',
      i.BEGIN_ON_NEW_FIELD)         begins_on_new_cell,
    i.COLSPAN                       column_span,
    i.ROWSPAN                       row_span,
    --
    decode(i.LABEL_ALIGNMENT,
      'ABOVE',         'Above',
      'BELOW',         'Below',
      'CENTER',        'Center',
      'CENTER-BOTTOM', 'Bottom center',
      'CENTER-CENTER', 'Center center',
      'CENTER-TOP',    'Top center',
      'LEFT',          'Left',
      'LEFT-BOTTOM',   'Bottom left',
      'LEFT-CENTER',   'Center left',
      'LEFT-TOP',      'Top left',
      'RIGHT',         'Right',
      'RIGHT-BOTTOM',  'Bottom right',
      'RIGHT-CENTER',  'Center right',
      'RIGHT-TOP',     'Top right',
      i.LABEL_ALIGNMENT)            label_alignment,
    decode(i.FIELD_ALIGNMENT,
      'CENTER',       'Center',
      'CENTER-BOTTOM','Center bottom',
      'CENTER-CENTER','Center center',
      'CENTER-TOP',   'Center top',
      'LEFT',         'Left',
      'LEFT-BOTTOM',  'Left bottom',
      'LEFT-CENTER',  'Left center',
      'LEFT-TOP',     'Left top',
      'RIGHT',        'Right',
      'RIGHT-BOTTOM', 'Right bottom',
      'RIGHT-CENTER', 'Right center',
      'RIGHT-TOP',    'Right top',
      i.FIELD_ALIGNMENT)            item_alignment,
    --
    --i.FIELD_TEMPLATE,
    --
    nvl((select r from apex_standard_conditions where d = i.DISPLAY_WHEN_TYPE),i.DISPLAY_WHEN_TYPE)
                                    condition_type,
    i.DISPLAY_WHEN                  condition_expression1,
    i.DISPLAY_WHEN2                 condition_expression2,
    --
    decode(i.IS_PERSISTENT,
       'Y','Per Session',
       'U','Per User',
       'N','Do Not Save Session State',
       i.IS_PERSISTENT)             maintain_session_state,
    decode(nvl(i.PROTECTION_LEVEL,'N'),
       'N','Unrestricted',
       'C','Arguments Must Have Checksum',
       'U','No Arguments Allowed',
       'D','No URL Access',
       'S','Checksum Required - Session Level',
       'I','Restricted - May not be set from browser',
       'B','Checksum Required - Application Level',
       'P','Checksum Required - User Level',
       i.PROTECTION_LEVEL)          item_protection_level,
    --i.ESCAPE_ON_HTTP_INPUT
    --
    decode(substr(i.SECURITY_SCHEME,1,1),'!','Not ')||
    nvl((select name
     from   wwv_flow_security_schemes
     where  to_char(id) = ltrim(i.SECURITY_SCHEME,'!')
     and    flow_id = f.id),
     i.SECURITY_SCHEME)             authorization_scheme,
    i.security_scheme               authorization_scheme_id,
    (select case when i.required_patch > 0 then PATCH_NAME else '{Not '||PATCH_NAME||'}' end PATCH_NAME
     from   wwv_flow_patches
     where  id =abs(i.REQUIRED_PATCH))   build_option,
    i.REQUIRED_PATCH                build_option_id,
    --
    (select max(help_text) h
    from wwv_flow_step_item_help
    where FLOW_ITEM_ID = i.id)      item_help_text,
    --
    i.LAST_UPDATED_BY               last_updated_by,
    i.LAST_UPDATED_ON               last_updated_on,
    i.ITEM_COMMENT                  component_comment,
    i.id                            item_id,
    --
    i.name
    ||' da='||i.display_as
    ||decode(i.DATA_TYPE,'NUMBER','NOnly','VARCHAR','V',i.DATA_TYPE)
    ||',seq='||lpad(i.ITEM_SEQUENCE,5,'00000')
    ||',r='||(select plug_name from wwv_flow_page_plugs where id=i.ITEM_PLUG_ID)
    ||',c='||decode(i.USE_CACHE_BEFORE_DEFAULT,'NO','Always','YES','Only null',i.USE_CACHE_BEFORE_DEFAULT)
    ||',d='||substr(i.ITEM_DEFAULT,1,20)||length(i.ITEM_DEFAULT)||i.ITEM_DEFAULT_TYPE
    ||',l='||substr(i.PROMPT,1,20)||length(i.prompt)
    ||substr(i.PRE_ELEMENT_TEXT,1,10)||length(i.PRE_ELEMENT_TEXT)
    ||substr(i.POST_ELEMENT_TEXT,1,10)||length(i.POST_ELEMENT_TEXT)
    ||',m='||i.FORMAT_MASK
    ||'t='||(select template_name from   wwv_flow_field_templates where  id = to_char(i.ITEM_FIELD_TEMPLATE) and flow_id = f.id)
    ||'s='||substr(i.SOURCE,1,30)||length(i.source)
    ||decode(i.SOURCE_TYPE,
      'ALWAYS_NULL','Always Null',
      'STATIC','StaticAs',
      'QUERY','SQLQuery',
      'ITEM','Item ',
      'FUNCTION','PL/SQL',
      'FUNCTION_BODY','PL/SQLFunctionBody',
      'DB_COLUMN','DBColumn',
      'PREFERENCE','Pref',
      'PLSQL_ANONYMOUS_BLOCK','PL/SQLAnBl',
      i.SOURCE_TYPE)
    ||length(i.SOURCE_POST_COMPUTATION)
    ||' ro='||nvl((select r from apex_standard_conditions where d = i.READ_ONLY_WHEN_TYPE),i.READ_ONLY_WHEN_TYPE)
    ||length(i.READ_ONLY_WHEN)
    ||length(i.READ_ONLY_WHEN2)
    ||length(i.READ_ONLY_DISP_ATTR)
    ||',lov='||i.NAMED_LOV
    ||decode(i.named_lov,null,null,length(i.LOV))
    ||i.LOV_COLUMNS
    ||decode(i.LOV_DISPLAY_EXTRA,
      'NO','No',
      'YES','Yes',
      i.LOV_DISPLAY_EXTRA)
    ||decode(i.LOV_DISPLAY_NULL,
      'NO','No',
      'YES','Yes',
      i.LOV_DISPLAY_NULL)
    ||substr(LOV_NULL_TEXT,1,20)||length(LOV_NULL_TEXT)
    ||i.LOV_NULL_VALUE
    ||',t='||decode(i.LOV_TRANSLATED,'N','No','Y','Yes',i.LOV_TRANSLATED)
    ||',s='||i.csize||i.cmaxlength||i.cheight
    ||',a='||substr(i.cattributes,1,10)||length(i.cattributes)
    ||length(i.cattributes_element)
    ||length(i.tag_attributes)
    ||length(i.tag_attributes2)
    ||',b='||length(i.button_image)||length(i.button_image_attr)
    ||',disp='||decode(i.BEGIN_ON_NEW_LINE,
      'NO','No','YES','Yes',
      i.BEGIN_ON_NEW_LINE)||decode(i.BEGIN_ON_NEW_FIELD,
      'NO','No','YES','Yes',
      i.BEGIN_ON_NEW_FIELD)||i.COLSPAN||i.ROWSPAN
    ||' l='||decode(i.LABEL_ALIGNMENT,
      'ABOVE',         'Above',
      'BELOW',         'Below',
      'CENTER',        'Center',
      'CENTER-BOTTOM', 'Bottom center',
      'CENTER-CENTER', 'Center center',
      'CENTER-TOP',    'Top center',
      'LEFT',          'Left',
      'LEFT-BOTTOM',   'Bottom left',
      'LEFT-CENTER',   'Center left',
      'LEFT-TOP',      'Top left',
      'RIGHT',         'Right',
      'RIGHT-BOTTOM',  'Bottom right',
      'RIGHT-CENTER',  'Center right',
      'RIGHT-TOP',     'Top right',
      i.LABEL_ALIGNMENT)||decode(i.FIELD_ALIGNMENT,
      'CENTER',       'Center',
      'CENTER-BOTTOM','Center bottom',
      'CENTER-CENTER','Center center',
      'CENTER-TOP',   'Center top',
      'LEFT',         'Left',
      'LEFT-BOTTOM',  'Left bottom',
      'LEFT-CENTER',  'Left center',
      'LEFT-TOP',     'Left top',
      'RIGHT',        'Right',
      'RIGHT-BOTTOM', 'Right bottom',
      'RIGHT-CENTER', 'Right center',
      'RIGHT-TOP',    'Right top',
      i.FIELD_ALIGNMENT)
    ||',c='||i.DISPLAY_WHEN_TYPE||substr(i.DISPLAY_WHEN,1,20)||length(i.DISPLAY_WHEN)||length(i.DISPLAY_WHEN2)
    ||decode(i.IS_PERSISTENT,
       'Y','PerSes',
       'U','PerU',
       'N','Do Not Save SesSt',
       i.IS_PERSISTENT)||
    decode(nvl(i.PROTECTION_LEVEL,'N'),
       'N','Unrest',
       'C','Arg Must Have Cs',
       'U','No Arguments Allowed',
       'D','No URL Access',
       'S','Cs Required - Session Level',
       'I','Restricted - May not be set from browser',
       'B','Cs Req-AL',
       'P','Cs Req-UL',
       i.PROTECTION_LEVEL)
    ||decode(substr(i.SECURITY_SCHEME,1,1),'!','Not ')||
    nvl((select name
     from   wwv_flow_security_schemes
     where  to_char(id) = ltrim(i.SECURITY_SCHEME,'!')
     and    flow_id = f.id),
     i.SECURITY_SCHEME)
     ||(select PATCH_NAME
     from   wwv_flow_patches
     where  id =abs(i.REQUIRED_PATCH))
    component_signature
from wwv_flow_step_items i,
     wwv_flow_steps p,
     wwv_flows f,
     wwv_flow_companies w,
     wwv_flow_company_schemas s,
     (select nvl(v('FLOW_SECURITY_GROUP_ID'),0) sgid from dual) d
where (s.schema = user or user in ('SYS','SYSTEM', 'APEX_030200')  or d.sgid = s.security_group_id) and
      f.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.security_group_id = w.PROVISIONING_COMPANY_ID and
      s.schema = f.owner and
      f.security_group_id = p.security_group_id and
      f.id = p.flow_id and
      f.id = i.flow_id and
      p.id = i.flow_step_id and
      nvl(i.display_as,'x') != 'BUTTON' and
      (d.sgid != 0 or nvl(f.BUILD_STATUS,'x') != 'RUN_ONLY') and
      w.PROVISIONING_COMPANY_ID != 0 and
      (user in ('SYS','SYSTEM', 'APEX_030200') or w.PROVISIONING_COMPANY_ID != 10);
COMMENT ON TABLE apex_application_page_items IS 'Identifies Page Items which are used to render HTML form content.  Items automatically maintain session state which can be accessed using bind variables or substitution stings.';
COMMENT ON COLUMN apex_application_page_items.workspace IS 'A work area mapped to one or more database schemas';
COMMENT ON COLUMN apex_application_page_items.application_id IS 'Application Primary Key, Unique over all workspaces';
COMMENT ON COLUMN apex_application_page_items.application_name IS 'Identifies the application';
COMMENT ON COLUMN apex_application_page_items.page_id IS 'Identifies the application';
COMMENT ON COLUMN apex_application_page_items.page_name IS 'Identifies a page within an application';
COMMENT ON COLUMN apex_application_page_items.item_name IS 'Identifies a page item and is used to maintain session state.  Value may be referenced as a SQL bind variable or using Apex substitution string syntax.';
COMMENT ON COLUMN apex_application_page_items.display_as IS 'Identifies how the item will be displayed in the HTML page';
COMMENT ON COLUMN apex_application_page_items.item_data_type IS 'Typically VARCHAR but may be set to NUMBER to restrict values to only numbers';
COMMENT ON COLUMN apex_application_page_items.display_sequence IS 'Identifies the sequence the page item will be displayed within a region';
COMMENT ON COLUMN apex_application_page_items.region IS 'Identifies the region in which the item will be displayed';
COMMENT ON COLUMN apex_application_page_items.region_id IS 'Identifies the foreign key to the apex_application_page_regions view';
COMMENT ON COLUMN apex_application_page_items.source_used IS 'Identifies how the source of the item value is determined.  The item can be set by the source value on each view only when the session state for the item is null.';
COMMENT ON COLUMN apex_application_page_items.item_default IS 'When the item has no source or session state, use this default value';
COMMENT ON COLUMN apex_application_page_items.item_default_type IS 'Identifies how the Item Default is set, based on a dynamic computation or a static assignment';
COMMENT ON COLUMN apex_application_page_items."LABEL" IS 'Identifies the item label';
COMMENT ON COLUMN apex_application_page_items.pre_element_text IS 'Identifies text placed before the item.';
COMMENT ON COLUMN apex_application_page_items.post_element_text IS 'Identifies text placed after the item.';
COMMENT ON COLUMN apex_application_page_items.format_mask IS 'Identifies a format mask which can be used to format numeric or date values';
COMMENT ON COLUMN apex_application_page_items.item_label_template IS 'Identifies the template used to display the item label';
COMMENT ON COLUMN apex_application_page_items.item_label_template_id IS 'Identifies the template ID foreign key';
COMMENT ON COLUMN apex_application_page_items.item_source IS 'Identifies the items value.  Reference the Source Used and Item Source Type attributes.';
COMMENT ON COLUMN apex_application_page_items.item_source_type IS 'Identifies how the item source is determined, for example from a Database Column, Static assignment, or a Query or PL/SQL expression.';
COMMENT ON COLUMN apex_application_page_items.encrypt_session_state IS 'If Yes values of session state written to APEX session state tables is encrypted.  Decryption is automatic.';
COMMENT ON COLUMN apex_application_page_items.source_post_computation IS 'After determining the Item Source value apply this computation';
COMMENT ON COLUMN apex_application_page_items.read_only_condition_type IS 'Identifies the condition type when the item will be rendered read only';
COMMENT ON COLUMN apex_application_page_items.read_only_condition_exp1 IS 'Identifies the condition that determines if the item will be rendered read only';
COMMENT ON COLUMN apex_application_page_items.read_only_condition_exp2 IS 'Identifies the condition that determines if the item will be rendered read only';
COMMENT ON COLUMN apex_application_page_items.read_only_display_attr IS 'Identifies the HTML SPAN tag attributes when rendering the item read only';
COMMENT ON COLUMN apex_application_page_items.lov_named_lov IS 'Identifies the List of Values to be used to render this domain of values for this item';
COMMENT ON COLUMN apex_application_page_items.lov_definition IS 'Identifies the List of Values used as the domain of values for this item';
COMMENT ON COLUMN apex_application_page_items.lov_columns IS 'Identifies how many columns will be used to display List of Values elements, used for checkboxes and radio groups.';
COMMENT ON COLUMN apex_application_page_items.lov_display_extra IS 'When an items values is not included in the domain of the List of Values, display the value of the item';
COMMENT ON COLUMN apex_application_page_items.lov_display_null IS 'Yes or No, identifies if a null value option is to be provided';
COMMENT ON COLUMN apex_application_page_items.lov_null_text IS 'Identifies the text to be displayed to the end user for a null value';
COMMENT ON COLUMN apex_application_page_items.lov_null_value IS 'Identifies the value to be used to identify a null value for the item';
COMMENT ON COLUMN apex_application_page_items.lov_query_result_translated IS 'Yes or No identifies if List of Values elements will be checked for dynamic translation';
COMMENT ON COLUMN apex_application_page_items.item_element_width IS 'Identifies the width of the item element';
COMMENT ON COLUMN apex_application_page_items.item_element_max_length IS 'Identifies the maximum length of the item element';
COMMENT ON COLUMN apex_application_page_items.item_element_height IS 'Identifies the height of the item element for item display types that use a height';
COMMENT ON COLUMN apex_application_page_items.html_table_cell_attr_label IS 'Identifies HTML table cell label attributes';
COMMENT ON COLUMN apex_application_page_items.html_table_cell_attr_element IS 'Identifies HTML table cell element attributes';
COMMENT ON COLUMN apex_application_page_items.html_form_element_attributes IS 'Identifies HTML table form element attributes';
COMMENT ON COLUMN apex_application_page_items.form_element_option_attributes IS 'Identifies HTML table form element option attributes';
COMMENT ON COLUMN apex_application_page_items.item_button_image IS 'For buttons displayed among items, the name of a button image';
COMMENT ON COLUMN apex_application_page_items.item_button_image_attributes IS 'For buttons displayed among items, the name of a button HTML IMG tag attributes';
COMMENT ON COLUMN apex_application_page_items.begins_on_new_row IS 'Identifies if the rendering of items begins on a new HTML table row';
COMMENT ON COLUMN apex_application_page_items.begins_on_new_cell IS 'Identifies if the rendering of items begins on a new HTML table cell';
COMMENT ON COLUMN apex_application_page_items.column_span IS 'Identifies the HTML table TD tag COLSPAN value';
COMMENT ON COLUMN apex_application_page_items.row_span IS 'Identifies the HTML table TD tag ROWSPAN value';
COMMENT ON COLUMN apex_application_page_items.label_alignment IS 'Identifies the alignment of the Item Label';
COMMENT ON COLUMN apex_application_page_items.item_alignment IS 'Identifies the alignment of the Item Form Element';
COMMENT ON COLUMN apex_application_page_items.condition_type IS 'Identifies a condition that must be met in order for this item to be displayed';
COMMENT ON COLUMN apex_application_page_items.condition_expression1 IS 'Identifies the item display condition';
COMMENT ON COLUMN apex_application_page_items.condition_expression2 IS 'Identifies the item display condition';
COMMENT ON COLUMN apex_application_page_items.maintain_session_state IS 'Identifies the method used to maintain session state, per session, per user, or not maintained';
COMMENT ON COLUMN apex_application_page_items.item_protection_level IS 'If Session State Protection is enabled, identifies if a checksum will be required to change an items session state via the URL or POSTDATA.';
COMMENT ON COLUMN apex_application_page_items.authorization_scheme IS 'Identifies the authorization scheme which must evaluate to TRUE in order for this component to be rendered';
COMMENT ON COLUMN apex_application_page_items.authorization_scheme_id IS 'Foreign Key';
COMMENT ON COLUMN apex_application_page_items.build_option IS 'Item will be displayed if the Build Option is enabled';
COMMENT ON COLUMN apex_application_page_items.last_updated_by IS 'Apex developer who made last update';
COMMENT ON COLUMN apex_application_page_items.last_updated_on IS 'Date of last update';
COMMENT ON COLUMN apex_application_page_items.component_comment IS 'Identifies a developer comment for this item';
COMMENT ON COLUMN apex_application_page_items.item_id IS 'Primary key of this component';
COMMENT ON COLUMN apex_application_page_items.component_signature IS 'Identifies attributes defined at a given component level to facilitate application comparisons';