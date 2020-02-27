CREATE OR REPLACE package wwv_flow_utilities as
--
--  Copyright (c) Oracle Corporation 2000 - 2009. All Rights Reserved.
--
--    DESCRIPTION
--      Flow public utility package.
--
--      Includes:
--      1. JavaScript Generation Utilities
--      2. Array Manipulation Utilities
--      3. Date Utilities
--      4. List of Values (LOV) Utilities
--      5. String Manipulation Function Utilities
--      6. If Then Else (ite) Utility
--      7. URL Utilities
--      8. Check Sum Utility
--      9. Bind Variable Utilities
--     10. Substitution Value Utilities
--
--    NOTES
--      This package contains utility functions for the APEX service.
--
--


-------------------
-- Global Variables
--
   empty_vc_arr wwv_flow_global.vc_arr2;
   g_value      wwv_flow_global.vc_arr2;
   g_display    wwv_flow_global.vc_arr2;
   g_query_hold varchar2(32767) := null;
   g_data_type  varchar2(256) := null;
   g_xml_clob   clob;
   g_val_num    number;
   g_val_vc2    varchar2(4000);


procedure bulk_save_session_state (
    p_value   in varchar2,
    p_item_01 in varchar2 default null,
    p_item_02 in varchar2 default null,
    p_item_03 in varchar2 default null,
    p_item_04 in varchar2 default null,
    p_item_05 in varchar2 default null,
    p_item_06 in varchar2 default null,
    p_item_07 in varchar2 default null,
    p_item_08 in varchar2 default null,
    p_item_09 in varchar2 default null,
    p_item_10 in varchar2 default null,
    p_item_11 in varchar2 default null,
    p_item_12 in varchar2 default null,
    p_item_13 in varchar2 default null,
    p_item_14 in varchar2 default null,
    p_item_15 in varchar2 default null,
    p_item_16 in varchar2 default null,
    p_item_17 in varchar2 default null,
    p_item_18 in varchar2 default null,
    p_item_19 in varchar2 default null,
    p_item_20 in varchar2 default null,
    p_item_21 in varchar2 default null,
    p_item_22 in varchar2 default null,
    p_item_23 in varchar2 default null,
    p_item_24 in varchar2 default null,
    p_item_25 in varchar2 default null,
    p_item_26 in varchar2 default null,
    p_item_27 in varchar2 default null,
    p_item_28 in varchar2 default null,
    p_item_29 in varchar2 default null,
    p_item_30 in varchar2 default null,
    p_item_31 in varchar2 default null,
    p_item_32 in varchar2 default null,
    p_item_33 in varchar2 default null,
    p_item_34 in varchar2 default null,
    p_item_35 in varchar2 default null,
    p_item_36 in varchar2 default null,
    p_item_37 in varchar2 default null,
    p_item_38 in varchar2 default null,
    p_item_39 in varchar2 default null,
    p_item_40 in varchar2 default null,
    p_item_41 in varchar2 default null,
    p_item_42 in varchar2 default null,
    p_item_43 in varchar2 default null,
    p_item_44 in varchar2 default null,
    p_item_45 in varchar2 default null,
    p_item_46 in varchar2 default null,
    p_item_47 in varchar2 default null,
    p_item_48 in varchar2 default null,
    p_item_49 in varchar2 default null,
    p_item_50 in varchar2 default null,
    p_set_as_preference  in varchar2 default 'N')
    ;



-------------------------------------------------------------------------------
-- JavaScript Generation Utilities
--
--


procedure open_noscript
    -- Generates javascript that...
    --
    --
    ;

function  open_noscript
    -- Generates javascript that...
    --
    --
    return varchar2
    ;

procedure close_noscript
    -- Generates javascript that...
    --
    --
    ;

function close_noscript
    -- Generates javascript that...
    --
    --
    return varchar2
    ;

procedure open_javascript (
    -- Generates javascript that...
    --
    --
    version varchar2 default '1.1')
    ;

function open_javascript (
    -- Generates javascript that...
    --
    --
    version varchar2 default '1.1')
    return varchar2
    ;

procedure close_javascript
    -- Generates javascript that...
    --
    --
    ;

function close_javascript
    -- Generates javascript that...
    --
    --
    return varchar2
    ;

procedure append_to_list
    -- Generates javascript that...
    --
    --
    ;

procedure delete_from_list
    -- Generates javascript that...
    --
    --
    ;

procedure delete_list_element
    -- Generates javascript that...
    --
    --
    ;

function delete_list_element
    -- Generates javascript that...
    --
    --
    return varchar2
    ;


-------------------------------------------------------------------------------
-- Array Manipulation Utilities
--

function in_list (
    p_value      varchar2,
    p_array      wwv_flow_global.vc_arr2)
    return boolean
    ;


-------------------------------------------------------------------------------
-- Date Utilities
--

function time_since (
    --
    --
    --
    p_date     in date)
    return varchar2
    ;


-------------------------------------------------------------------------------
-- Text Area with Controls Utilities
--

procedure show_as_textarea_with_controls(
    p_value      in varchar2 default null,
    p_name       in varchar2 default null,
    p_height     in varchar2 default null,
    p_size       in varchar2 default null,
    p_attributes in varchar2 default null,
    p_item_name  in varchar2 default null )
    ;


-------------------------------------------------------------------------------
-- Text Area with HTML Editor
--

function html_editor_language
    -- Checks for html editor's specified/default language...
    --
    --
    return varchar2
    ;

procedure show_as_textarea_html_editor(
    p_value      in varchar2 default null,
    p_name       in varchar2 default null,
    p_height     in varchar2 default null,
    p_size       in varchar2 default null,
    p_attributes in varchar2 default null,
    p_toolbarset in varchar2 default null,
    p_item_name  in varchar2 default null )
    ;


-------------------------------------------------------------------------------
-- List of Values (LOV) Utilities
--

procedure list_mgr_display (
    p_lov          in varchar2 default null,
    p_popup_lov_type in varchar2 default 'POPUP',
    p_name         in varchar2 default null,
    p_text_name    in varchar2 default null,
    p_value        in wwv_flow_global.vc_arr2,
    p_edit_mode    in boolean,
    p_upper_vals   in boolean default true,
    p_form_index   in number default 0,
    p_attributes   in varchar2 default null,
    p_item1        in varchar2 default null,
    p_item2        in varchar2 default null,
    p_item_id      in varchar2 default null)
    ;


procedure show_as_display_only (
    p_lov                in varchar2 default null,
    p_value              in varchar2 default null,
    p_translation        in varchar2 default null,
    p_attributes         in varchar2 default null,
    p_null_display_value in varchar2 default null,
    p_display_extra      in varchar2 default null)
    ;

procedure show_as_combobox (
    p_lov          in varchar2,
    p_value        in varchar2 default null,
    p_name         in varchar2 default null,
    p_height       in varchar2 default null,
    p_show_null    in varchar2 default null,
    p_null_text    in varchar2 default null,
    p_null_value   in varchar2 default null,
    p_show_extra   in varchar2 default 'YES',
    p_extra_text   in varchar2 default null,
    p_onBlur       in varchar2 default null,
    p_onChange     in varchar2 default null,
    p_onFocus      in varchar2 default null,
    p_max_elements in number   default 1000000,
    p_attributes   in varchar2 default null,
    p_translation  in varchar2 default 'NO')
    ;

procedure show_as_multiple_select (
    p_lov          in varchar2,
    p_value        in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_name         in varchar2 default null,
    p_show_null    in varchar2 default null,
    p_null_text    in varchar2 default null,
    p_null_value   in varchar2 default null,
    p_height       in varchar2 default null,
    p_show_extra   in varchar2 default 'YES',
    p_extra_text   in varchar2 default null,
    p_onBlur       in varchar2 default null,
    p_onChange     in varchar2 default null,
    p_onFocus      in varchar2 default null,
    p_max_elements in number   default 1000000,
    p_attributes   in varchar2 default null,
    p_translation  in varchar2 default 'NO')
    ;

procedure show_as_multiple_select2 (
    p_lov          in varchar2,
    p_value        in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_name         in varchar2 default null,
    p_show_null    in varchar2 default null,
    p_null_text    in varchar2 default null,
    p_null_value   in varchar2 default null,
    p_height       in varchar2 default null,
    p_show_extra   in varchar2 default 'YES',
    p_extra_text   in varchar2 default null,
    p_onBlur       in varchar2 default null,
    p_onChange     in varchar2 default null,
    p_onFocus      in varchar2 default null,
    p_max_elements in number   default 1000000,
    p_attributes   in varchar2 default null,
    p_translation  in varchar2 default 'NO')
    ;

procedure show_as_radio_group (
    --
    -- Standard radio group
    --
    p_lov          in varchar2,
    p_value        in varchar2 default null,
    p_name         in varchar2 default null,
    p_show_null    in varchar2 default null,
    p_null_text    in varchar2 default null,
    p_null_value   in varchar2 default null,
    p_cols         in varchar2 default null,
    p_show_extra   in varchar2 default 'YES',
    p_extra_text   in varchar2 default null,
    p_onBlur       in varchar2 default null,
    p_onChange     in varchar2 default null,
    p_onFocus      in varchar2 default null,
    p_max_elements in varchar2 default null,
    p_attributes   in varchar2 default null,
    p_translation  in varchar2 default 'NO',
    p_attributes2  in varchar2 default null,
    p_item_name    in varchar2 default null)
    ;

procedure show_as_radio_group2 (
    --
    -- same as radiogroup except radio group is shown without an inline html table
    --
    p_lov          in varchar2,
    p_value        in varchar2 default null,
    p_name         in varchar2 default null,
    p_show_null    in varchar2 default null,
    p_null_text    in varchar2 default null,
    p_null_value   in varchar2 default null,
    p_cols         in varchar2 default null,
    p_show_extra   in varchar2 default 'YES',
    p_extra_text   in varchar2 default null,
    p_onBlur       in varchar2 default null,
    p_onChange     in varchar2 default null,
    p_onFocus      in varchar2 default null,
    p_max_elements in varchar2 default null,
    p_attributes   in varchar2 default null,
    p_translation  in varchar2 default 'NO',
    p_attributes2  in varchar2 default null,
    p_item_name    in varchar2 default null)
    ;

procedure show_as_checkbox (
    p_lov          in varchar2,
    p_value        in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_name         in varchar2 default null,
    p_cols         in varchar2 default null,
    p_show_extra   in varchar2 default null,
    p_extra_text   in varchar2 default null,
    p_onBlur       in varchar2 default null,
    p_onChange     in varchar2 default null,
    p_onFocus      in varchar2 default null,
    p_max_elements in number   default 1000000,
    p_attributes   in varchar2 default null,
    p_translation  in varchar2 default 'NO',
    p_attributes2  in varchar2 default null,
    p_item_name    in varchar2 default null)
    ;

procedure gen_popup_list (
    p_name                    in varchar2,
    p_lov                     in varchar2,
    p_lov_checksum            in varchar2,
    p_element_index           in varchar2,
    p_form_index              in varchar2,
    p_filter                  in varchar2,
    p_escape_html             in varchar2 default null,
    p_max_elements            in varchar2 default null,
    p_before_field_field_text in varchar2 default null,
    p_after_field_field_text  in varchar2 default null,
    p_title                   in varchar2 default null,
    p_image                   in varchar2 default null,
    p_help                    in varchar2 default null,
    p_eval_value              in varchar2 default null,
    p_request                 in varchar2 default null,
    p_min_row                 in number   default 1,
    p_translation             in varchar2 default 'NO',
    p_return_key              in varchar2 default 'NO',
    p_hidden_elem_name        in varchar2 default null,
    --
    p_ok_to_query             in varchar2 default 'YES',
    p_flow_id                 in number   default null,
    p_page_id                 in number   default null,
    p_session_id              in number   default null,
    p_company                 in number   default null,
    p_item_id                 in varchar2 default null)
    ;

procedure show_as_popup_calendar (
    p_request                 in varchar2 default null,
    p_title                   in varchar2 default null,
    p_yyyy                    in varchar2 default null,
    p_mm                      in varchar2 default null,
    p_dd                      in varchar2 default null,
    p_hh                      in varchar2 default null,
    p_mi                      in varchar2 default null,
    p_pm                      in varchar2 default null,
    p_element_index           in varchar2 default null,
    p_form_index              in varchar2 default null,
    p_date_format             in varchar2 default 'MM/DD/YYYY',
    p_bgcolor                 in varchar2 default '#336699',
    p_white_foreground        in varchar2 default 'Y',
    p_application_format      in varchar2 default 'N',
    p_lang                    in varchar2 default null,
    p_application_id          in varchar2 default null,
    p_security_group_id       in varchar2 default null)
    ;

procedure gen_popup_color (
    p_item_name               in varchar2 default null);

procedure show_as_popup_color (
    p_item_name         in varchar2 default null,
    p_name              in varchar2 default null,
    p_value             in varchar2 default null,
    p_width             in varchar2 default null,
    p_max_length        in varchar2 default null,
    p_element_index     in varchar2 default null,
    p_attributes        in varchar2 default null,
    p_item_id           in varchar2 default null,
    p_element_attributes in varchar2 default null)
    ;

procedure show_as_popup (
    p_lov               in varchar2,
    p_name              in varchar2 default null,
    p_value             in varchar2 default null,
    p_width             in varchar2 default null,
    p_max_length        in varchar2 default null,
    p_form_index        in varchar2 default '0',
    p_element_index     in varchar2 default null,
    p_escape_html       in varchar2 default null,
    p_max_elements      in varchar2 default null,
    p_attributes        in varchar2 default null,
    p_eval_value        in varchar2 default null,
    p_ok_to_query       in varchar2 default 'YES',
    p_translation       in varchar2 default 'NO',
    p_return_key        in varchar2 default 'NO',
    p_hidden_elem_name  in varchar2 default null,
    p_filter_first_fetch in varchar2 default 'NO',
    p_item_id           in varchar2 default null,
    p_element_attributes in varchar2 default null,
	p_item_name in varchar2 default null)
    ;

function show_as_popup (
    p_lov               in varchar2,
    p_name              in varchar2 default null,
    p_value             in varchar2 default null,
    p_width             in varchar2 default null,
    p_max_length        in varchar2 default null,
    p_form_index        in varchar2 default '0',
    p_element_index     in varchar2 default null,
    p_escape_html       in varchar2 default null,
    p_max_elements      in varchar2 default null,
    p_attributes        in varchar2 default null,
    p_eval_value        in varchar2 default null,
    p_ok_to_query       in varchar2 default 'YES',
    p_translation       in varchar2 default 'NO',
    p_return_key        in varchar2 default 'NO',
    p_hidden_elem_name  in varchar2 default null,
    p_filter_first_fetch in varchar2 default 'NO',
    p_item_id           in varchar2 default null,
    p_element_attributes in varchar2 default null,
	p_item_name in varchar2 default null)
    return varchar2
    ;

function static_to_query (
    p_lov                   in varchar2 default null)
    return varchar2
    ;


-------------------------------------------------------------------------------
-- String Manipulation Function Utilities
--

function remws(
    --
    -- Given a string remove the lead, trailing, or leading and trialing whitespace.
    --
    -- Arguments:
    --   p_str   = any text string
    --   p_where = B for both leading and trailing
    --             L for leading
    --             T for trailing
    --
    p_str in varchar2,
    p_where in varchar2 default 'B' )
    return varchar2
    ;

function remove_trailing_whitespace (
    --
    -- Given a string remove trailing chr 10, chr 13s and spaces.
    -- Also removes leading whitespace.
    --
    p_str in varchar2 )
    return varchar2
    ;

function string_to_table (
    --
    --
    --
    str in varchar2,
    sep in varchar2 default ':')
    return wwv_flow_global.vc_arr2
    ;

function string_to_table2 (
    --
    --
    --
    str in varchar2,
    sep in varchar2 default ':')
    return wwv_flow_global.vc_arr2
    ;

function string_to_table3 (
    --
    --
    --
    str in varchar2,
    sep in varchar2 default ':')
    return sys.wwv_dbms_sql.vc_arr2
    ;

function table_to_string (
    --
    --
    --
    t in wwv_flow_global.vc_arr2,
    s in varchar2 default ':')
    return varchar2
    ;

function table_to_string2 (
    --
    --
    --
    t in wwv_flow_global.vc_arr2,
    s in varchar2 default ':')
    return varchar2
    ;

function instr_tostr (
    --
    --
    --
    p_instr             in varchar2 default null,
    p_tostr             in varchar2 default null)
    return varchar2
    ;

function instr_fromstr (
    --
    --
    --
    p_instr             in varchar2 default null,
    p_fromstr           in varchar2 default null)
    return varchar2
    ;

function striphtml(
    --
    --
    --
    p_html        in varchar2)
    return varchar2
    ;

function is_numeric (
    --
    --
    --
    p_str in varchar2 default null)
    return boolean
    ;


-------------------------------------------------------------------------------
-- If Then Else (ite) Utility
--
function ite (
    --
    --
    --
    b boolean,
    t varchar2,
    f varchar2)
    return varchar2
    ;


-------------------------------------------------------------------------------
-- URL Utilities
--

function urlencode(
    --
    -- Encode every character of a URL.
    -- an encoded URL is a URL in Hex.
    -- Encoded URLs allow spaces, question marks and other special characters.
    --
    p_str in varchar2 )
    return varchar2
    ;

function url_encode2 (
    --
    -- Encode (into HEX) all special characters which includes spaces,
    -- question marks, ampersands, etc.
    --
    p_str in varchar2)
    return varchar2
    ;

function url_decode2 (
    --
    --
    --
    p_str in varchar2)
    return varchar2
    ;

function url_encode (
    --
    -- Encode every character of a URL.
    -- an encoded URL is a URL in Hex.
    -- Encoded URLs allow spaces, question marks and other special characters.
    --
    p_str in varchar2)
    return varchar2
    ;

procedure redirect_url (
    --
    --
    --
    p_url varchar2)
    ;

procedure redirect_url_array (
    p_owner      varchar2 default null,
    p_package    varchar2 default null,
    p_procedure  varchar2 default null,
    p_parameters wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_values     wwv_flow_global.vc_arr2 default empty_vc_arr)
    ;




-------------------------------------------------------------------------------
-- Check Sum Utility
--
function checksum (
    --
    -- Obsolete with 8.1.7 of Oracle and greater.  This PLSQL checksum
    -- algorythem is slower and less reliable then the
    -- dbms_obfuscation_toolkit.md5 function.  This function is provided
    -- for backward compatability and for support of 8.1.6.
    --
    -- Note recommended use is:
    --    x := utl_raw.cast_to_raw( dbms_obfuscation_toolkit.md5( input_string => p_string ) );
    --
    p_buff in varchar2 )
    return number
    ;




-------------------------------------------------------------------------------
-- Bind Variable Utilities
--

function get_binds(
    --
    -- Given a valid Oracle SQL statement, which
    -- can include quotes, c style, and plsql style
    -- comments, return a table of bind variable names.
    -- The bind variable names will be used for binding in
    -- flows session state.
    --
    p_stmt  in varchar2 )
    return  dbms_sql.varchar2_table
    ;

procedure perform_binds(
    --
    --
    --
    p_cursor in number,
    p_stmt   in varchar2)
    ;

function get_using_clause (
    --
    --
    --
    p_stmt   in varchar2 )
    return varchar2
    ;

function get_column_headings (
    --
    -- Given a SQL select statement return colon delimited list of
    -- column headings.
    --
    p_sql_select_statement in varchar2)
    return varchar2
    ;


-------------------------------------------------------------------------------
-- Substitution Variable Utilities
--

function parse(
    p_string in varchar2,
    p_escape in boolean default false )
    return varchar2
    ;



function get_substitution_value(
    --
    --
    --
    p_substitution_string in varchar2,
    p_flow_id in varchar2 )
    return varchar2
    ;

-------------------------------------------------------------------------------
-- Flows Internal Utilities
--
-- These utilities are exposed however they are of little or no value to the
-- flows application programmer.

function minimum_free_page (
    --
    -- Given a flow find the minimum page number
    -- available.  Useful in building flow wizards
    -- since you can default the page to the next
    -- availble page ID number.
    --
    p_flow_id           in number default null,
    p_occurance         in number default 1)
    return number
    ;

function minimum_free_flow
    return number
    ;

procedure show_invalid_instance_screen (
    p_message in varchar2 default null,
    p_link_text in varchar2 default null,
    p_link_target in varchar2 default null)
    ;

function flow_authentication (
    p_flow_id           in number default null)
    return varchar2
    ;

function is_date (
  p_date varchar2,
  p_format varchar2 default null )
  return boolean
  ;

function is_number(
  p_number varchar2,
  p_format varchar2 default null )
  return boolean
  ;

--
--
--
--
procedure get_lov_delimiters(
  p_s in varchar2,
  p_r out varchar2,
  p_c out varchar2)
  ;


procedure populate_temp_lov_table(
    -- insert into the global temporary table wwv_flow_lov_temp
    -- two columns and any number of rows.  columns are delmited by
    -- p_c and rows are delited by p_r
    p_s in varchar2,
    p_r in varchar2 default ',',
    p_c in varchar2 default ';')
    ;

function remove_spaces (
    --
    -- takes a string and removes duplicate spaces
    --
    p_str in varchar2 default null)
    return varchar2
    ;


function is_valid_alias(
    --
    -- Verify that the Flow alias is composed of valid characters,
    -- namely A-Z, 0-9, and _ or -.  Also, must be at least 1 char
    -- long but not longer than 32 chars.
    --
    p_alias in varchar2)
    return boolean
    ;


----------------------
-- SQL Query functions
--
function get_display_value_given_lov (
   p_sql_query   in varchar2,
   p_value       in varchar2,
   p_translation in varchar2 default 'NO',
   p_escape_sc   in varchar2 default 'YES')
   return varchar2
   ;


----------------------------------
-- Given an ID get the region name
--
function get_region_name (
    p_region_id   in varchar2 default null)
    return varchar2
    ;


------------------------------------------------------
-- Pause for number of seconds identified by p_seconds
--  (capped at 120 seconds)
--
procedure pause (
    p_seconds   in number)
    ;

-------------------------------------------------------
-- Checks to ensure p_name is a valid Oracle identifier
--
function is_valid_identifier (
    p_identifier   in varchar2,
    p_quote        in boolean := false)
    return boolean
    ;

function get_company_from_cookie return varchar2
    ;
function get_un_from_cookie return varchar2
    ;
function my_url return varchar2
    ;
function get_cookie_user_name (p_cookie_user_id in number) return varchar2
    ;

-----------------------------------------
-- Optimized String Replacement Functions
--

-------------------------
-- F A S T  R E P L A C E
--
-- Usage example:
--
-- declare
--  x varchar2(100) := 'aaaabbaaaccaaddaaeeaafffaaggaahh';
-- begin
--  wwv_flow_utilities.fast_replace(x,'bb','BB');
--  dbms_output.put_line(x);
-- end;
-- /
--
procedure fast_replace(
    srcstr in out NOCOPY varchar2,
    oldsub in varchar2,
    newsub in varchar2 )
    ;

------------------------------------
-- F A S T   R E P L A C E   M A N Y
-- Usage example:
--
-- declare
--  x varchar2(100) := 'aaaabbaaaccaaddaaeeaafffaaggaahh';
-- begin
--  wwv_flow_utilities.fast_replace_many(x,
--     vc4000array('bb','cc','dd','ee','ff'),
--     vc4000array('BB','CC','DD','EE','FF'));
--  dbms_output.put_line(x);
-- end;
-- /
--
procedure fast_replace_many (
   srcstr in out NOCOPY varchar2,
   oldsub in vc4000Array,
   newsub in vc4000Array )
   ;

function fast_replace_f(
   p_srcstr in varchar2,
   oldsub in varchar2,
   newsub in varchar2 )
   return varchar2
   ;

function fast_replace_manyf (
   p_srcstr in varchar2,
   oldsub in vc4000Array,
   newsub in vc4000Array )
   return varchar2
   ;

function show_line_number (
   --------------------------------------------------------
   -- Displays line numbers for the given query or string
   --
   q in varchar2)
   return varchar2
   ;

function lov_values (
    ----------------------------------------------------------------------------
    -- Return a LOV string (displayVal;returnVal,displayVal;returnVal...) given a list of values
    --
    p_lov          in varchar2)
    return varchar2
    ;

function lov_value_array (
    p_lov          in varchar2
) return htmldb_item.lov_table;


procedure parse_query_string(
    p_query     in  varchar2,
    p_flow_id   out varchar2,
    p_page_id   out varchar2,
    p_sess_id   out varchar2,
    p_remainder out varchar2)
    ;

---------------------------
-- session state conditions
--

function page_changed (
    -----------------------------------------------------------------
    -- Any item on page changed for current flow and current session.
    -- Change implys item was populated, then update.
    p_page_number in number )
    return boolean
    ;

function item_changed (
    -------------------------------------------------
    -- Item in current flow and session has changed.
    -- Change implys item was populated, then update.
    p_item_name in varchar2)
    return boolean
    ;

function list_of_items_changed (
    p_item_names in varchar2)
    return boolean
    ;

function list_of_pages_changed (
    p_page_numbers in varchar2 )
    return boolean
    ;

function current_session_changed
    return boolean
    ;

function current_flow_changed
    return boolean
    ;

function get_data_type (
   p_table_name  in varchar2,
   p_column_name in varchar2)
   return varchar2
   ;

function extracthtml (
   p_html in varchar2)
   return varchar2
   ;

--
-- function to construct quick links
function quick_link(
   p_forminput in varchar2,
   p_form_value in varchar2,
   p_display in varchar2,
   p_system_message in boolean  := true,
   p_forminput2 in varchar2 := null ,
   p_form_value2 in varchar2 := null,
   p_disable in varchar2 := null,
   p_popup_message  in varchar2 := null)
   return varchar2
   ;

function clob_to_varchar2(
   p_clob   in clob,
   p_offset in number default 0,
   p_raise  in boolean default false)
   return varchar2
   ;

function blob_to_clob(
   p_blob    in out blob,
   p_charset in varchar2 default null)
   return clob
   ;

function clob_to_blob(
   p_clob    in out clob,
   p_charset in varchar2 default null)
   return blob
   ;


function escape_url(
    p_url             in varchar2,
    p_url_charset     in varchar2 default null,
    p_escape_reserved in varchar2 default 'N')
    return varchar2
    ;

function host_url(
    --
    -- Return the host URL
    --
    -- Possible options are:
    --     NULL   - Return URL up to port number (e.g., https://myserver.com:7778 )
    --     SCRIPT - Return URL to include script name (e.g., https://myserver.com:7778/pls/apex/ )
    --     IMGPRE - Return URL to include image prefix (e.g., https://myserver.com:7778/i/ )
    --
    p_option          in varchar2 default null )
    return varchar2
    ;

function lov_checksum(
    p_string      in varchar2)
    return varchar2
    ;

function page_checksum(
    p_string        in varchar2,
    p_checksum_type in varchar2 default 'SESSION',
    p_checksum_salt in raw      default wwv_flow_security.g_application_checksum_salt)
    return varchar2
    ;

function prepare_url(
    --
    -- If URL is f?p format, do escape_url on the argument values only.
    -- This function assumes that all substitutions, e.g., &ITEM_NAME. substitutions have already been performed.
    --
    p_url                   in varchar2,
    p_url_charset           in varchar2 default null,
    p_checksum_type         in varchar2 default null,
    p_save_session_state_yn in varchar2 default 'N')
    return varchar2
    ;

function get_cgi_query_string_decoded
    --
    -- get cgi QUERY_STRING and decode content
    --
    return varchar2
    ;

function pick_date_format_mask(
    --
    -- Given a Date Picker type (e.g., PICK_DATE_DD_MON_YYYY), return
    -- the corresponding format mask.  The input p_format_mask is only
    -- applicable when p_pick_date_type = PICK_DATE_USING_FORMAT_MASK.
    --
    p_pick_date_type in varchar2,
    p_format_mask    in varchar2 default null )
    return varchar2
    ;

procedure increment_calendar;
    --
    -- procedure to handle the increment of a date in a calendar
    -- Date must be in YYYYMMDD format
    --
procedure decrement_calendar;
    --
    -- procedure to handle the decrement of a date in a calendar
    -- Date must be in YYYYMMDD format
    --
procedure today_calendar;
    --
    -- procedure to handle the chaning to today of a date in a calendar
    -- Date must be in YYYYMMDD format
    --
procedure month_calendar(p_date_type_field varchar2 default null);
    --
    -- procedure to handle the Month type of the calendar

procedure weekly_calendar(p_date_type_field varchar2 default null);
    --
    -- procedure to handle the date type of the calendar
procedure daily_calendar(p_date_type_field varchar2 default null);
    --
    -- procedure to handle the date type of the calendar

procedure process_calendar_date(
    --
    -- procedure to handle the changes of a date in a calendar
    -- Date must be in YYYYMMDD format
    --
    p_request varchar2);

function savekey_num(p_val in number)
    return number
    ;

function keyval_num return number
    ;

function savekey_vc2(p_val in varchar2)
    return varchar2
    ;

function keyval_vc2 return varchar2
    ;



function get_clob_md5(
    --
    -- Compute and return a message digest for the specified CLOB.
    -- Arguments:
    --     p_clob              =  Input CLOB value to perform message digest against
    --
    p_clob            in clob )
    return varchar2
    ;

--
-- Print with opening and closing JavaScript tags the JavaScript function filter_escape.
-- This JavaScript function is used in encoding multibyte values in a URL in JavaScript
--
procedure gen_filter_escape;

procedure check_sgid;

--------------------------------------------
-- is_build_option_enabled
-- returns YES / NO based on build option ID

function is_build_option_enabled (
    p_build_option_id number) return boolean;

-----------------------------------------------
-- is_build_option_enabled
-- returns YES / NO based on build option name

function is_build_option_enabled (
    p_build_option_name varchar2) return boolean;


 -----------------------------------------------
 -- esc_non_basic_tags
 -- escapes input string, except specified tags
 -- use this function to preserve basic HTML formatting, yet escaping all other tags

 -- example:
 --   wwv_flow_utilities.esc_non_basic_tags('<a href="hello"><b>hello</b></a>')
 --   results in: &lt;a href="hello"&gt;<b>hello</b>&lt;/a&gt;')

 function esc_non_basic_tags (
     p_string in varchar2) return varchar2;

---------------------------------------------
-- function to extract database version value
--
function db_version
    return varchar2;

--------------------------------------------------
-- function to extract database compatibility value
--
function db_compatibility
    return varchar2;

---------------------------------------------------------------------
-- boolean function to compare current db version with input parameter
--
function db_version_is_at_least(p_version in varchar2)
    return boolean;

--------------------------------------------------------------
-- vc2 function to compare current db version with input parameter
--
function db_version_is_at_least_i(p_version in varchar2)
    return varchar2;

---------------------------------------------------------------------
-- boolean function to check if database is xe
--
function db_edition_is_xe
    return boolean;

---------------
-- Page caching
--
procedure cache_purge_by_application (
    p_application    in number)
    ;

procedure cache_purge_by_page (
    p_application  in number,
    p_page         in number,
    p_user_name    in varchar2 default null)
    ;

procedure cache_purge_stale (
    p_application    in number);

function cache_get_date_cached (
    p_application  in number,
    p_page         in number)
    return date;

-----------------
-- Region Caching
--
procedure purge_regions_by_app (
     p_application in number);

procedure purge_regions_by_id (
     p_application in number,
     p_region_id   in number);

procedure purge_regions_by_name (
     p_application  in number,
     p_page_id      in number,
     p_region_name  in varchar2);

procedure purge_regions_by_page (
     p_application  in number,
     p_page_id      in number);

procedure purge_stale_regions (
     p_application in number);

function count_stale_regions (
    p_application    in number)
    return number;

function cache_get_date_cached (
    p_application  in number,
    p_page         in number,
    p_region_name  in varchar2)
    return date;

-----------------
-- Export
--
procedure export_application_to_db (
   p_application_id   in number)
   ;

function export_application_to_clob (
   p_application_id   in number,
   p_export_saved_reports in varchar2 default 'N')
   return clob
   ;

function export_page_to_clob (
   p_application_id   in number,
   p_page_id          in number)
   return CLOB
   ;


procedure show_as_shuttle (
    p_lov                   in varchar2,
    p_value                 in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_name                  in varchar2                default null,
    p_show_null             in varchar2                default null,
    p_null_text             in varchar2                default null,
    p_null_value            in varchar2                default null,
    p_height                in varchar2                default '10',
    p_width                 in varchar2                default '150',
    p_show_extra            in varchar2                default 'YES',
    p_extra_text            in varchar2                default null,
    p_onBlur                in varchar2                default null,
    p_onChange              in varchar2                default null,
    p_onFocus               in varchar2                default null,
    p_attributes            in varchar2                default null,
    p_max_elements          in number                  default 1000000,
    p_item_id               in varchar2                default null,
    p_item_tag_attrs        in varchar2                default null,
    p_translation           in varchar2                default 'NO',
    p_current_item_sequence in varchar2                default null,
    pRefreshImage           in varchar2                default 'shuttle_reload.png',
    pRightAllImage          in varchar2                default 'shuttle_last.png',
    pRightImage             in varchar2                default 'shuttle_right.png',
    pLeftImage              in varchar2                default 'shuttle_left.png',
    pLeftAllImage           in varchar2                default 'shuttle_first.png',
    pTopImage               in varchar2                default 'shuttle_top.png',
    pUpImage                in varchar2                default 'shuttle_up.png',
    pDownImage              in varchar2                default 'shuttle_down.png',
    pBottomImage            in varchar2                default 'shuttle_bottom.png'
    );


--
-- Perform a string replacement in a CLOB variable
--
procedure lob_replace (
    p_lob                in out nocopy clob,
    p_search_string      in varchar2,
    p_replacement_string in varchar2 );


function array_element(
    p_vcarr in wwv_flow_global.vc_arr2,
    p_index in number )
    return varchar2;

--
-- Convert input to utf-8 and base 64 encode, per RFC 2231
--
function b64_encode(
    p_input in varchar2 )
    return varchar2;

--
-- Encode a filename in either utf-8 encoding or utf-8 base64 encoding.
-- This is commonly used in the generation of the HTTP header for a file download,
-- as IE and FF behave differently
--
function encode_filename(
    p_filename in varchar2)
    return varchar2;


procedure get_theme_file(
    p_id            in number,
    p_app_id        in number,
    p_show_last_mod in varchar2 default 'Y');

procedure show_ir_help (
   p_app_id       in number,
   p_worksheet_id in number,
   p_lang         in varchar2 default null);


-- -----------------------------------------------------------------------------------------------
function get_print_document (
--
-- This function returns a document as BLOB using XML based report data and RTF or XSL-FO based report layout.
--
-- Arguments:
--   p_report_data:        XML based report data (utf-8 encoded)
--   p_report_layout:      Report layout in XSL-FO or RTF format
--   p_report_layout_type: Defines the report layout type, that is "xsl-fo" or "rtf"
--   p_document_format:    Defines the document format, that is "pdf", "rtf", "xls", "htm", or "xml"
--   p_print_server:       URL of of the print server. If not specified, the print server will be derived from preferences
--                         example: http://myserver.mydomain.com:8888/xmlpserver/convert
--
    p_report_data         in clob,
    p_report_layout       in clob,
    p_report_layout_type  in varchar2 default 'xsl-fo',
    p_document_format     in varchar2 default 'pdf',
    p_print_server        in varchar2 default null
) return blob;


-- -----------------------------------------------------------------------------------------------
function get_print_document (
--
-- This function returns a document as BLOB using XML based report data and RTF or XSL-FO based report layout.
--
-- Arguments:
--   p_report_data:        XML based report data (utf-8 encoded)
--   p_report_layout:      Report layout in XSL-FO or RTF format
--   p_report_layout_type: Defines the report layout type, that is "xsl-fo" or "rtf"
--   p_document_format:    Defines the document format, that is "pdf", "rtf", "xls", "htm", or "xml"
--   p_print_server:       URL of of the print server. If not specified, the print server will be derived from preferences
--                         example: http://myserver.mydomain.com:8888/xmlpserver/convert
--
    p_report_data         in blob,
    p_report_layout       in clob,
    p_report_layout_type  in varchar2 default 'xsl-fo',
    p_document_format     in varchar2 default 'pdf',
    p_print_server        in varchar2 default null
) return blob;


-- -----------------------------------------------------------------------------------------------
function get_print_document (
--
-- This function returns a document as BLOB using pre-defined report query and pre-defined report layout.
--
-- Arguments:
--   p_application_id:      Defines the application ID of the report query
--   p_report_query_name:   Name of the report layout (stored under application's Shared Components)
--   p_report_layout_name:  Name of the report query (stored under application's shared components)
--                          if report layout name is not specified, layout associated with report query will be used
--   p_report_layout_type:  Defines the report layout type, that is "xsl-fo" or "rtf"
--   p_document_format:     "Defines the document format, that is "pdf", "rtf", "xls", "htm", or "xml"
--   p_print_server:        URL of of the print server. If not specified, the print server will be derived from preferences
--                          example: http://myserver.mydomain.com:8888/xmlpserver/convert
--
    p_application_id      in number,
    p_report_query_name   in varchar2,
    p_report_layout_name  in varchar2 default null,
    p_report_layout_type  in varchar2 default 'xsl-fo',
    p_document_format     in varchar2 default 'pdf',
    p_print_server        in varchar2 default null
) return blob;


-- -----------------------------------------------------------------------------------------------
function get_print_document (
--
-- This function returns a document as BLOB using a pre-defined report query and RTF or XSL-FO based report layout.
--
-- Arguments:
--   p_application_id:      Defines the application ID of the report query
--   p_report_query_name:   Name of the report layout (stored under application's Shared Components)
--   p_report_layout:       Defines the report layout in in XSL-FO or RTF format
--   p_report_layout_type:  Defines the report layout type, that is "xsl-fo" or "rtf"
--   p_document_format:     "Defines the document format, that is "pdf", "rtf", "xls", "htm", or "xml"
--   p_print_server:        URL of of the print server. If not specified, the print server will be derived from preferences
--                          example: http://myserver.mydomain.com:8888/xmlpserver/convert
--
    p_application_id      in number,
    p_report_query_name   in varchar2,
    p_report_layout       in clob,
    p_report_layout_type  in varchar2 default 'xsl-fo',
    p_document_format     in varchar2 default 'pdf',
    p_print_server        in varchar2 default null
) return blob;


-- -----------------------------------------------------------------------------------------------
procedure download_print_document (
--
-- This procedure initiates the download of a print document using XML based report data and RTF or XSL-FO based report layout.
--
-- Arguments:
--   p_file_name            Defines the filename of the print document
--   p_content_disposition: Specifies whether to download the print document or display inline ("attachment", "inline")
--   p_report_data:         XML based report data
--   p_report_layout:       Report layout in XSL-FO or RTF format
--   p_report_layout_type:  Defines the report layout type, that is "xsl-fo" or "rtf"
--   p_document_format:     Defines the document format, that is "pdf", "rtf", "xls", "htm", or "xml"
--   p_print_server:       	URL of of the print server. If not specified, the print server will be derived from preferences
--                          example: http://myserver.mydomain.com:8888/xmlpserver/convert
--
    p_file_name           in varchar,
    p_content_disposition in varchar  default 'attachment',
    p_report_data         in clob,
    p_report_layout       in clob,
    p_report_layout_type  in varchar2 default 'xsl-fo',
    p_document_format     in varchar2 default 'pdf',
    p_print_server        in varchar2 default null
);


-- -----------------------------------------------------------------------------------------------
procedure download_print_document (
--
-- This procedure initiates the download of a print document using XML based report data and RTF or XSL-FO based report layout.
--
-- Arguments:
--   p_file_name            Defines the filename of the print document
--   p_content_disposition: Specifies whether to download the print document or display inline ("attachment", "inline")
--   p_report_data:         XML based report data
--   p_report_layout:       Report layout in XSL-FO or RTF format
--   p_report_layout_type:  Defines the report layout type, that is "xsl-fo" or "rtf"
--   p_document_format:     Defines the document format, that is "pdf", "rtf", "xls", "htm", or "xml"
--   p_print_server:       	URL of of the print server. If not specified, the print server will be derived from preferences
--                          example: http://myserver.mydomain.com:8888/xmlpserver/convert
--
    p_file_name           in varchar,
    p_content_disposition in varchar  default 'attachment',
    p_report_data         in blob,
    p_report_layout       in clob,
    p_report_layout_type  in varchar2 default 'xsl-fo',
    p_document_format     in varchar2 default 'pdf',
    p_print_server        in varchar2 default null
);


-- -----------------------------------------------------------------------------------------------
procedure download_print_document (
--
-- This procedure initiates the download of a print document using pre-defined report query and pre-defined report layout.
--
-- Arguments:
--   p_file_name            Filename of print document
--   p_content_disposition: Download print document or display inline ("attachment", "inline")
--   p_application_id:      Defines the application ID of the report query
--   p_report_query_name:   Name of the report layout (stored under application's Shared Components)
--   p_report_layout_name:  Name of the report query (stored under application's shared components)
--                          if report layout name is not specified, layout associated with report query will be used
--   p_report_layout_type:  Defines the report layout type, that is "xsl-fo" or "rtf"
--   p_document_format:     "Defines the document format, that is "pdf", "rtf", "xls", "htm", or "xml"
--   p_print_server:        URL of of the print server. If not specified, the print server will be derived from preferences
--                          example: http://myserver.mydomain.com:8888/xmlpserver/convert
--
    p_file_name           in varchar,
    p_content_disposition in varchar  default 'attachment',
    p_application_id      in number,
    p_report_query_name   in varchar2,
    p_report_layout_name  in varchar2 default null,
    p_report_layout_type  in varchar2 default 'xsl-fo',
    p_document_format     in varchar2 default 'pdf',
    p_print_server        in varchar2 default null
);


-- -----------------------------------------------------------------------------------------------
procedure download_print_document (
--
-- This procedure initiates the download of a print document using pre-defined report query and RTF and XSL-FO based report layout.
--
-- Arguments:
--   p_file_name            Filename of print document
--   p_content_disposition: Download print document or display inline ("attachment", "inline")
--   p_application_id:      Defines the application ID of the report query
--   p_report_query_name:   Name of the report layout (stored under application's Shared Components)
--   p_report_layout:       Report layout in XSL-FO or RTF format
--   p_report_layout_type:  Defines the report layout type, that is "xsl-fo" or "rtf"
--   p_document_format:     "Defines the document format, that is "pdf", "rtf", "xls", "htm", or "xml"
--   p_print_server:        URL of of the print server. If not specified, the print server will be derived from preferences
--                          example: http://myserver.mydomain.com:8888/xmlpserver/convert
--
    p_file_name           in varchar,
    p_content_disposition in varchar  default 'attachment',
    p_application_id      in number,
    p_report_query_name   in varchar2,
    p_report_layout       in clob,
    p_report_layout_type  in varchar2 default 'xsl-fo',
    p_document_format     in varchar2 default 'pdf',
    p_print_server        in varchar2 default null
);


end wwv_flow_utilities;
/