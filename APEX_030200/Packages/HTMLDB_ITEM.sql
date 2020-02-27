CREATE OR REPLACE package htmldb_item as

--  Copyright (c) Oracle Corporation 2001 - 2003. All Rights Reserved.
--
--    DESCRIPTION
--      API to generate flow f01... items for use with multi row forms and
--      other purposes.
--
--    SECURITY
--      Publicly executable.
--
--    NOTES
--
--    RUNTIME DEPLOYMENT: YES
--

type lov_item is record (display_value varchar2(4000), return_value varchar2(4000));
type lov_table is table of lov_item index by binary_integer;

function checkbox (
    --
    -- Return an HTML form checkbox.  Allows you to select a checkbox form element from a query.
    --
    -- Arguments:
    --     p_idx                      = The form element name, e.g. 1 equals f01, 2 equals f02, etc.
    --                                  Typically the p_idx argument is constant for a given column.
    --     p_value                    = When checked return this value
    --     p_attributes               = Custom HTML arguments added to the HTML input type of checkbox.
    --     p_checked_values           = Colon (by default delimted list of values
    --     p_checked_values_delimitor = Defaults to a colon ":" and is used to pass multiple values in one string.
    --     p_item_id                  = Will set the ID of the item to this value (id="...").  Must be unique!  Try concatenating some string with rownum.  Required for 508 compliance
    --     p_item_label               = Creates an invisible label for an item.  Used for Section 508 Compliance.  Class is hideMe508.
    --
    -- example(s):
    --     select htmldb_item.checkbox(1,empno) c from emp
    --     select htmldb_item.checkbox(1,empno,null,empno) c from emp
    --
    p_idx        in number,
    p_value      in varchar2 default null,
    p_attributes in varchar2 default null,
    p_checked_values in varchar2 default null,
    p_checked_values_delimitor in varchar2 default ':',
    p_item_id    in varchar2 default null,
    p_item_label in varchar2 default null)
    return varchar2
    ;


function radiogroup (
    --
    -- Return an HTML form radiogroup.  Allows you to select a radiogroup form element from a query.
    --
    -- Arguments:
    --     p_idx                      = The form element name, e.g. 1 equals f01, 2 equals f02, etc.
    --                                  Typically the p_idx argument is constant for a given column.
    --     p_value                    = When selected return this value
    --     p_selected_value           = Default selected value
    --     p_display                  = Display text
    --     p_attributes               = Custom HTML arguments added to the HTML input type of radiogroup.
    --     p_item_id                  = Will set the ID of the item to this value (id="...").  Must be unique!  Try concatenating some string with rownum.  Required for 508 compliance
    --     p_item_label               = Creates an invisible label for an item.  Used for Section 508 Compliance.  Class is hideMe508.
    --
    -- example(s):
    --     select htmldb_item.radiogroup(1,empno,'7839',ename) c from emp
    --
    p_idx        in number,
    p_value      in varchar2 default null,
    p_selected_value in varchar2 default null,
    p_display      in varchar2 default null,
    p_attributes   in varchar2 default null,
    p_onBlur       in varchar2 default null,
    p_onChange     in varchar2 default null,
    p_onFocus      in varchar2 default null,
    p_item_id      in varchar2 default null,
    p_item_label   in varchar2 default null
    )
    return varchar2
    ;


function hidden (
    --
    -- Return an HTML form hidden value.  Hidden values will not show up on your dynamically
    -- generated HTML page however they will be passed to the wwv_flow.accept procedure.
    -- example: select htmldb_item.hidden(2,empno) from emp
    --
    -- Arguments:
    --     p_idx        = The form element name, e.g. 1 equals f01, 2 equals f02, etc.
    --                    Typically the p_idx argument is constant for a given column.
    --     p_value      = Value of the hidden HTML form element.
    --     p_attributes = Extra HTML arguments you wish to add
    --     p_item_id    = Will set the ID of the item to this value (id="...").  Must be unique!  Try concatenating some string with rownum.  Required for 508 compliance
    --     p_item_label = Creates an invisible label for an item.  Used for Section 508 Compliance.  Class is hideMe508.
    --
    -- example(s):
    --     select htmldb_item.hidden(10,empno) c from emp
    --
    p_idx        in number,
    p_value      in varchar2 default null,
    p_attributes in varchar2 default null,
    p_item_id    in varchar2 default null,
    p_item_label in varchar2 default null)
    return varchar2
    ;

function display_and_save (
    --
    -- Return an HTML form hidden value and display the text.
    --
    -- Arguments:
    --     p_idx        = The form element name, e.g. 1 equals f01, 2 equals f02, etc.
    --                    Typically the p_idx argument is constant for a given column.
    --     p_value      = Value of the hidden HTML form element.
    --     p_item_id    = Will set the ID of the item to this value (id="...").  Must be unique!  Try concatenating some string with rownum.  Required for 508 compliance
    --     p_item_label = Creates an invisible label for an item.  Used for Section 508 Compliance.  Class is hideMe508.
    --
    -- example(s):
    --     select wwv_flow_item.display_and_save(10,empno) c from emp
    --
    p_idx        in number,
    p_value      in varchar2 default null,
    p_item_id    in varchar2 default null,
    p_item_label in varchar2 default null)
    return varchar2
    ;

function text (
    -- Generates an HTML input type of text.  Basically a single hight form field.
    --
    -- Arguments:
    --     p_idx        = The form element name, e.g. 1 equals f01, 2 equals f02, etc.
    --                    Typically the p_idx argument is constant for a given column.
    --     p_value      = Text displayed in HTML input type equals text.
    --     p_size       = Width of text displayed on screen (HTML width attribute)
    --     p_maxLength  = Maximum width that your brower will let you type into the field
    --     p_attributes = Extra HTML arguments you wish to add
    --     p_item_id    = Will set the ID of the item to this value (id="...").  Must be unique!  Try concatenating some string with rownum.  Required for 508 compliance
    --     p_item_label = Creates an invisible label for an item.  Used for Section 508 Compliance.  Class is hideMe508.
    --
    -- example(s):
    --     select htmldb_item.text(1,ename) from emp
    --
    p_idx        in number,
    p_value      in varchar2 default null,
    p_size       in number default 20,
    p_maxLength  in number default 2000,
    p_attributes in varchar2 default null,
    p_item_id    in varchar2 default null,
    p_item_label in varchar2 default null)
    return varchar2
    ;

function textarea (
    -- Generates an HTML input type of text.  Basically a single hight form field.
    --
    -- Arguments:
    --     p_idx        = The form element name, e.g. 1 equals f01, 2 equals f02, etc.
    --                    Typically the p_idx argument is constant for a given column.
    --     p_value      = Text displayed in HTML textarea.
    --     p_rows       = Height of the textarea (HTML rows attribute)
    --     p_cols       = Width of text displayed on screen (HTML cols attribute)
    --     p_attributes = Extra HTML arguments you wish to add
    --     p_item_id    = Will set the ID of the item to this value (id="...").  Must be unique!  Try concatenating some string with rownum.  Required for 508 compliance
    --     p_item_label = Creates an invisible label for an item.  Used for Section 508 Compliance.  Class is hideMe508.
    --
    -- example(s):
    --     select htmldb_item.textarea(1,ename) from emp
    --
    p_idx        in number,
    p_value      in varchar2 default null,
    p_rows       in number default 40,
    p_cols       in number default 4,
    p_attributes in varchar2 default null,
    p_item_id    in varchar2 default null,
    p_item_label in varchar2 default null)
    return varchar2
    ;

function date_popup (
    -- Generates an HTML input type of text with an image that pops up date picker.
    --
    -- Arguments:
    --     p_idx        = The form element name, e.g. 1 equals f01, 2 equals f02, etc.
    --                    Typically the p_idx argument is constant for a given column.
    --     p_row        = depricated
    --     p_value      = Oracle date datatype.
    --     p_date_format= Oracle date format mask for alternate date displays, defaults to 'DD-MON-YYYY'.
    --     p_size       = Width of text displayed on screen (HTML width attribute)
    --     p_maxLength  = Maximum width that your brower will let you type into the field
    --     p_attributes = Extra HTML arguments you wish to add
    --     p_item_id    = Will set the ID of the item to this value (id="...").  Must be unique!  Try concatenating some string with rownum.  Required for 508 compliance
    --     p_item_label = Creates an invisible label for an item.  Used for Section 508 Compliance.  Class is hideMe508. --
    -- example(s):
    --     select htmldb_item.date_popup(4, null,HIREDATE) "Date hired" from emp
    --
    p_idx         in number,
    p_row         in number default null,
    p_value       in date default null,
    p_date_format in varchar2 default 'DD-MON-YYYY',
    p_size        in number default 20,
    p_maxLength   in number default 2000,
    p_attributes  in varchar2 default null,
    p_item_id     in varchar2 default null,
    p_item_label  in varchar2 default null,
    p_display_as  in varchar2 default null)
    return varchar2
    ;

function select_list (
    -- Generates an HTML select list from static inputs.
    --
    -- Arguments:
    --     p_idx        = The form element name, e.g. 1 equals f01, 2 equals f02, etc.
    --                    Typically the p_idx argument is constant for a given column.
    --     p_value      = The current value, the value should be one of the values in
    --                    the p_list_values aregument.
    --     p_list_values= A list of static values seperated by commas.
    --                    Display values and return values are
    --                    seperated by semicolons.
    --                    to write back the selected date into the proper row.
    --                    format: display1;Return1,Display2;Return2...
    --     p_attributes = Extra HTML arguments you wish to add
    --     p_show_null  = Include an extra select option to allow the "null" selection.
    --                    Range of values is YES and NO
    --     p_null_value = The value to be returned when a user selects the null option.
    --                    Only relevant when p_show_null is YES.
    --     p_null_text  = The value to be displayed when a user selects the null option.
    --                    Only relevant when p_show_null is YES.
    --     p_item_id    = Will set the ID of the item to this value (id="...").  Must be unique!  Try concatenating some string with rownum.  Required for 508 compliance
    --     p_item_label = Creates an invisible label for an item.  Used for Section 508 Compliance.  Class is hideMe508.
    --     p_show_extra = show current value even if not part of LOV
    -- example(s):
    --   select htmldb_item.select_list(1,'Y','Yes;Y,No;N') from emp
    --
    p_idx         in number,
    p_value       in varchar2 default null,
    p_list_values in varchar2 default null,
    p_attributes  in varchar2 default null,
    p_show_null   in varchar2 default 'NO',
    p_null_value  in varchar2 default '%null%',
    p_null_text   in varchar2 default '%',
    p_item_id     in varchar2 default null,
    p_item_label  in varchar2 default null,
    p_show_extra  in varchar2 default 'YES'
) return varchar2;

function select_list_from_query (
    -- Generates an HTML select list from static inputs.
    --
    -- Arguments:
    --     p_idx        = The form element name, e.g. 1 equals f01, 2 equals f02, etc.
    --                    Typically the p_idx argument is constant for a given column.
    --     p_value      = The current value, the value should be one of the values in
    --                    the p_list_values aregument.
    --     p_query      = A SQL SELECT statement in the format:
    --                    select display_value, return_value from ...
    --                    or
    --                    select display_and_return_value from ...
    --     p_attributes = Extra HTML arguments you wish to add
    --     p_show_null  = Include an extra select option to allow the "null" selection.
    --                    Range of values is YES and NO
    --     p_null_value = The value to be returned when a user selects the null option.
    --                    Only relevant when p_show_null is YES.
    --     p_null_text  = The value to be displayed when a user selects the null option.
    --                    Only relevant when p_show_null is YES.
    --     p_item_id    = Will set the ID of the item to this value (id="...").  Must be unique!  Try concatenating some string with rownum.  Required for 508 compliance
    --     p_item_label = Creates an invisible label for an item.  Used for Section 508 Compliance.  Class is hideMe508. --
    --     p_show_extra = show current value even if not part of LOV
    -- Example(s):
    --   select htmldb_item.select_list(1,'Y','Yes;Y,No;N') from emp
    --
    -- Notes:
    --   This procedure requires a flows environment thus is designed to
    --   be called from within a page region or page process.
    --
    p_idx         in number,
    p_value       in varchar2 default null,
    p_query       in varchar2,
    p_attributes  in varchar2 default null,
    p_show_null   in varchar2 default 'YES',
    p_null_value  in varchar2 default '%null%',
    p_null_text   in varchar2 default '%',
    p_item_id     in varchar2 default null,
    p_item_label  in varchar2 default null,
    p_show_extra  in varchar2 default 'YES'
) return varchar2;

function select_list_from_query_xl (
    --
    -- Same as select_list_from_query but returns clob
    --
    p_idx         in number,
    p_value       in varchar2 default null,
    p_query       in varchar2,
    p_attributes  in varchar2 default null,
    p_show_null   in varchar2 default 'YES',
    p_null_value  in varchar2 default '%null%',
    p_null_text   in varchar2 default '%',
    p_item_id     in varchar2 default null,
    p_item_label  in varchar2 default null,
    p_show_extra  in varchar2 default 'YES'
) return clob;

function popup_from_lov (
    --
    --  popup LOV from a named LOV
    --
    --
    -- Arguments:
    --     p_idx        = The form element name, e.g. 1 equals f01, 2 equals f02, etc.
    --                    Typically the p_idx argument is constant for a given column.
    --     p_value      = The current value, the value should be one of the values in
    --                    the p_lov_name argument.
    --     p_lov_name   = named DYNAMIC LOV used for this popup
    --     p_item_id    = Will set the ID of the item to this value (id="...").  Must be unique!  Try concatenating some string with rownum.  Required for 508 compliance
    --     p_item_label = Creates an invisible label for an item.  Used for Section 508 Compliance.  Class is hideMe508.
    -- example(s):
    --     select htmldb_item.popup_from_lov (1,deptno,'DEPT') dt from emp
    --
    p_idx               in number,
    p_value             in varchar2 default null,
    p_lov_name          in varchar2,
    p_width             in varchar2 default null,
    p_max_length        in varchar2 default null,
    p_form_index        in varchar2 default '0',
    p_escape_html       in varchar2 default null,
    p_max_elements      in varchar2 default null,
    p_attributes        in varchar2 default null,
    p_ok_to_query       in varchar2 default 'YES',
    p_item_id           in varchar2 default null,
    p_item_label        in varchar2 default null)
    return varchar2
    ;

function popup_from_query (
    --
    --  popup LOV from a query
    --
    --
    -- Arguments:
    --     p_idx        = The form element name, e.g. 1 equals f01, 2 equals f02, etc.
    --                    Typically the p_idx argument is constant for a given column.
    --     p_value      = The current value, the value should be one of the values in
    --                    the p_lov_query argument.
    --     p_lov_query  = LOV query used for this popup
    --     p_item_id    = Will set the ID of the item to this value (id="...").  Must be unique!  Try concatenating some string with rownum.  Required for 508 compliance
    --     p_item_label = Creates an invisible label for an item.  Used for Section 508 Compliance.  Class is hideMe508.
    -- example(s):
    --     select htmldb_item.popup_from_query (1,deptno,'select dname, deptno from dept') dt from emp
    --
    p_idx               in number,
    p_value             in varchar2 default null,
    p_lov_query         in varchar2,
    p_width             in varchar2 default null,
    p_max_length        in varchar2 default null,
    p_form_index        in varchar2 default '0',
    p_escape_html       in varchar2 default null,
    p_max_elements      in varchar2 default null,
    p_attributes        in varchar2 default null,
    p_ok_to_query       in varchar2 default 'YES',
    p_item_id           in varchar2 default null,
    p_item_label        in varchar2 default null
    )
    return varchar2
    ;

function popupkey_from_lov (
    --
    --  popupkey LOV from a named LOV
    --
    --
    -- Arguments:
    --     p_idx        = The form element name, e.g. 1 equals f01, 2 equals f02, etc.
    --                    Typically the p_idx argument is constant for a given column.
    --                    Due to the behavior of popupkey the next index value should be p_idx + 1.
    -- example:
    --     select htmldb_item.popupkey_from_query (1,deptno,'select dname, deptno from dept') dt,
    --            htmldb_item.hidden(3,empno) eno
    --     from emp
    --
    --     p_value      = The current value, the value should be one of the values in
    --                    the p_lov_name argument.
    --     p_lov_name   = named LOV used for this popup
    --     p_item_id    = Will set the ID of the item to this value (id="...").  Must be unique!  Try concatenating some string with rownum.  Required for 508 compliance
    --     p_item_label = Creates an invisible label for an item.  Used for Section 508 Compliance.  Class is hideMe508.
    -- example(s):
    --     select htmldb_item.popupkey_from_lov (1,deptno,'DEPT') dt from emp
    --
    p_idx               in number,
    p_value             in varchar2 default null,
    p_lov_name          in varchar2,
    p_width             in varchar2 default null,
    p_max_length        in varchar2 default null,
    p_form_index        in varchar2 default '0',
    p_escape_html       in varchar2 default null,
    p_max_elements      in varchar2 default null,
    p_attributes        in varchar2 default null,
    p_ok_to_query       in varchar2 default 'YES',
    p_item_id           in varchar2 default null,
    p_item_label        in varchar2 default null
    )
    return varchar2
    ;

function popupkey_from_query (
    --
    --  popupkey LOV from a query
    --
    --
    -- Arguments:
    --     p_idx        = The form element name, e.g. 1 equals f01, 2 equals f02, etc.
    --                    Typically the p_idx argument is constant for a given column.
    --                    Due to the behavior of popupkey the next index value should be p_idx + 1.
    -- example:
    --     select htmldb_item.popupkey_from_query (1,deptno,'select dname, deptno from dept') dt,
    --            htmldb_item.hidden(3,empno) eno
    --     from emp
    --
    --     p_value      = The current value, the value should be one of the values in
    --                    the p_lov_query argument.
    --     p_lov_query  = LOV query used for this popup
    --     p_item_id    = Will set the ID of the item to this value (id="...").  Must be unique!  Try concatenating some string with rownum.  Required for 508 compliance
    --     p_item_label = Creates an invisible label for an item.  Used for Section 508 Compliance.  Class is hideMe508.
    -- example(s):
    --     select htmldb_item.popupkey_from_query (1,deptno,'select dname, deptno from dept') dt from emp
    --
    p_idx               in number,
    p_value             in varchar2 default null,
    p_lov_query         in varchar2,
    p_width             in varchar2 default null,
    p_max_length        in varchar2 default null,
    p_form_index        in varchar2 default '0',
    p_escape_html       in varchar2 default null,
    p_max_elements      in varchar2 default null,
    p_attributes        in varchar2 default null,
    p_ok_to_query       in varchar2 default 'YES',
    p_item_id           in varchar2 default null,
    p_item_label        in varchar2 default null
    )
    return varchar2
    ;

function select_list_from_lov (
    -- Generates an HTML select list from static inputs.
    --
    -- Arguments:
    --     p_idx        = The form element name, e.g. 1 equals f01, 2 equals f02, etc.
    --                    Typically the p_idx argument is constant for a given column.
    --     p_value      = The current value, the value should be one of the values in
    --                    the p_list_values aregument.
    --     p_query      = A SQL SELECT statement in the format:
    --                    select display_value, return_value from ...
    --                    or
    --                    select display_and_return_value from ...
    --     p_attributes = Extra HTML arguments you wish to add
    --     p_show_null  = Include an extra select option to allow the "null" selection.
    --                    Range of values is YES and NO
    --     p_null_value = The value to be returned when a user selects the null option.
    --                    Only relevant when p_show_null is YES.
    --     p_null_text  = The value to be displayed when a user selects the null option.
    --                    Only relevant when p_show_null is YES.
    --     p_item_id    = Will set the ID of the item to this value (id="...").  Must be unique!  Try concatenating some string with rownum.  Required for 508 compliance
    --     p_item_label = Creates an invisible label for an item.  Used for Section 508 Compliance.  Class is hideMe508.
    --
    -- example(s):
    --   select htmldb_item.select_list(1,'Y','Yes;Y,No;N') from emp
    --
    -- Notes:
    --   This procedure requires a flows environment thus is designed to
    --   be called from within a page region or page process.
    --
    p_idx         in number,
    p_value       in varchar2 default null,
    p_lov         in varchar2,
    p_attributes  in varchar2 default null,
    p_show_null   in varchar2 default 'YES',
    p_null_value  in varchar2 default '%null%',
    p_null_text   in varchar2 default '%',
    p_item_id     in varchar2 default null,
    p_item_label  in varchar2 default null,
    p_show_extra  in varchar2 default 'YES')
    return varchar2
    ;

function select_list_from_lov_xl (
    --
    -- Same as select_list_from_lov but returns clob
    --
    p_idx         in number,
    p_value       in varchar2 default null,
    p_lov         in varchar2,
    p_attributes  in varchar2 default null,
    p_show_null   in varchar2 default 'YES',
    p_null_value  in varchar2 default '%null%',
    p_null_text   in varchar2 default '%',
    p_item_id     in varchar2 default null,
    p_item_label  in varchar2 default null,
    p_show_extra  in varchar2 default 'YES')
    return clob
    ;

function text_from_lov (
    --
    -- Display only based upon LOV
    --
    p_value       in varchar2 default null,
    p_lov         in varchar2,
    p_null_text   in varchar2 default '%')
    return varchar2;


function text_from_lov_query (
    --
    -- Display only based upon LOV
    --
    p_value       in varchar2 default null,
    p_query       in varchar2,
    p_null_text   in varchar2 default '%')
    return varchar2;


function md5_checksum (
    --
    --Used in conjuction with multi_row_update procedure.  Populates the global
    --HTMLDB_APPLICATION.G_FCS with a checksum of the values provided.
    --
    p_value01    in varchar2 default null,
    p_value02    in varchar2 default null,
    p_value03    in varchar2 default null,
    p_value04    in varchar2 default null,
    p_value05    in varchar2 default null,
    p_value06    in varchar2 default null,
    p_value07    in varchar2 default null,
    p_value08    in varchar2 default null,
    p_value09    in varchar2 default null,
    p_value10    in varchar2 default null,
    p_value11    in varchar2 default null,
    p_value12    in varchar2 default null,
    p_value13    in varchar2 default null,
    p_value14    in varchar2 default null,
    p_value15    in varchar2 default null,
    p_value16    in varchar2 default null,
    p_value17    in varchar2 default null,
    p_value18    in varchar2 default null,
    p_value19    in varchar2 default null,
    p_value20    in varchar2 default null,
    p_value21    in varchar2 default null,
    p_value22    in varchar2 default null,
    p_value23    in varchar2 default null,
    p_value24    in varchar2 default null,
    p_value25    in varchar2 default null,
    p_value26    in varchar2 default null,
    p_value27    in varchar2 default null,
    p_value28    in varchar2 default null,
    p_value29    in varchar2 default null,
    p_value30    in varchar2 default null,
    p_value31    in varchar2 default null,
    p_value32    in varchar2 default null,
    p_value33    in varchar2 default null,
    p_value34    in varchar2 default null,
    p_value35    in varchar2 default null,
    p_value36    in varchar2 default null,
    p_value37    in varchar2 default null,
    p_value38    in varchar2 default null,
    p_value39    in varchar2 default null,
    p_value40    in varchar2 default null,
    p_value41    in varchar2 default null,
    p_value42    in varchar2 default null,
    p_value43    in varchar2 default null,
    p_value44    in varchar2 default null,
    p_value45    in varchar2 default null,
    p_value46    in varchar2 default null,
    p_value47    in varchar2 default null,
    p_value48    in varchar2 default null,
    p_value49    in varchar2 default null,
    p_value50    in varchar2 default null,
    p_col_sep    in varchar2 default '|')
    return varchar2;


function md5_hidden (
    --
    -- Return an HTML form hidden value.  Hidden values will not show up on your dynamically
    -- generated HTML page however they will be passed to the wwv_flow.accept procedure.
    --
    -- Arguments:
    --     p_idx        = The form element name, e.g. 1 equals f01, 2 equals f02, etc.
    --                    Typically the p_idx argument is constant for a given column.
    --     p_valueXX    = Value of the hidden HTML form element which will be md5 checksum encoded.
    --
    -- example(s):
    --     select htmldb_item.md5_hidden(10,empno,ename) c from emp
    --     select htmldb_item.md5_hidden(10,empno,ename,job,sal) c from emp
    --
    --
    p_idx        in number,
    p_value01    in varchar2 default null,
    p_value02    in varchar2 default null,
    p_value03    in varchar2 default null,
    p_value04    in varchar2 default null,
    p_value05    in varchar2 default null,
    p_value06    in varchar2 default null,
    p_value07    in varchar2 default null,
    p_value08    in varchar2 default null,
    p_value09    in varchar2 default null,
    p_value10    in varchar2 default null,
    p_value11    in varchar2 default null,
    p_value12    in varchar2 default null,
    p_value13    in varchar2 default null,
    p_value14    in varchar2 default null,
    p_value15    in varchar2 default null,
    p_value16    in varchar2 default null,
    p_value17    in varchar2 default null,
    p_value18    in varchar2 default null,
    p_value19    in varchar2 default null,
    p_value20    in varchar2 default null,
    p_value21    in varchar2 default null,
    p_value22    in varchar2 default null,
    p_value23    in varchar2 default null,
    p_value24    in varchar2 default null,
    p_value25    in varchar2 default null,
    p_value26    in varchar2 default null,
    p_value27    in varchar2 default null,
    p_value28    in varchar2 default null,
    p_value29    in varchar2 default null,
    p_value30    in varchar2 default null,
    p_value31    in varchar2 default null,
    p_value32    in varchar2 default null,
    p_value33    in varchar2 default null,
    p_value34    in varchar2 default null,
    p_value35    in varchar2 default null,
    p_value36    in varchar2 default null,
    p_value37    in varchar2 default null,
    p_value38    in varchar2 default null,
    p_value39    in varchar2 default null,
    p_value40    in varchar2 default null,
    p_value41    in varchar2 default null,
    p_value42    in varchar2 default null,
    p_value43    in varchar2 default null,
    p_value44    in varchar2 default null,
    p_value45    in varchar2 default null,
    p_value46    in varchar2 default null,
    p_value47    in varchar2 default null,
    p_value48    in varchar2 default null,
    p_value49    in varchar2 default null,
    p_value50    in varchar2 default null,
    p_col_sep    in varchar2 default '|')
    return varchar2
    ;


procedure multi_row_update (
    --
    -- This procedure performs a multi row update of a table or view.
    -- This procedure can be called using two methods:
    --
    -- Method 1: (Complete P_MRU_STRING no region ID)
    --   Supply only a complete mru string.
    --   OWNER:TABLE:PK_COLUMN1,PK_IDX:PK_COLUMN2,PK_IDX2|COL,IDX:COL,IDX...
    --
    -- Method 2: (Short P_MRU_STRING and region ID)
    --   Supply the ID of the region with the short MRU string
    --   OWNER:TABLE:PK_COLUMN1:PK_COLUMN2
    --
    p_mru_string        in varchar2 default null,
    p_region_id         in number   default null
    );


end htmldb_item;
/