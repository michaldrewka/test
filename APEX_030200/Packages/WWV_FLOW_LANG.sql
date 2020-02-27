CREATE OR REPLACE package wwv_flow_lang
--  Copyright (c) Oracle Corporation 1999 - 2008. All Rights Reserved.
--
--    DESCRIPTION
--      Flow language translation services
--
--    SECURITY
--
--    NOTES
--      This program allows for translation of text strings from
--      on national language to another.
--
--    RUNTIME DEPLOYMENT: YES
is
g_set_nls boolean := false;

g_nls_language_set varchar2(255) := null;

procedure report_lang_to_browser
    --
    -- Produce an HTML report listing the browser language to database
    -- language equivs.
    --
    ;


function map_language (
    --
    -- Convert a browser language into a database language.
    -- for example:
    -- us = AMERICAN
    -- fr = FRENCH
    -- ja = JAPANESE
    --
    --
    p_language  in varchar2)
    RETURN varchar2
    ;

procedure alter_session (
    --
    -- alter the dbms session set the language to this value.
    --
    p_language  in varchar2 default null)
    ;

function replace_param (
    p_message                   in varchar2 default null,
    p0                          in varchar2 default null,
    p1                          in varchar2 default null,
    p2                          in varchar2 default null,
    p3                          in varchar2 default null,
    p4                          in varchar2 default null,
    p5                          in varchar2 default null,
    p6                          in varchar2 default null,
    p7                          in varchar2 default null,
    p8                          in varchar2 default null,
    p9                          in varchar2 default null)
    return varchar2
    ;


--
-- return named text message with substitutions
--
function message (
    p_name                      in varchar2 default null,
    p0                          in varchar2 default null,
    p1                          in varchar2 default null,
    p2                          in varchar2 default null,
    p3                          in varchar2 default null,
    p4                          in varchar2 default null,
    p5                          in varchar2 default null,
    p6                          in varchar2 default null,
    p7                          in varchar2 default null,
    p8                          in varchar2 default null,
    p9                          in varchar2 default null,
    p_lang                      in varchar2 default null)
    return varchar2
    ;



--
-- htp.print a named text message with substitutions
--
procedure message_p (
    p_name                      in varchar2 default null,
    p0                          in varchar2 default null,
    p1                          in varchar2 default null,
    p2                          in varchar2 default null,
    p3                          in varchar2 default null,
    p4                          in varchar2 default null,
    p5                          in varchar2 default null,
    p6                          in varchar2 default null,
    p7                          in varchar2 default null,
    p8                          in varchar2 default null,
    p9                          in varchar2 default null,
    p_lang                      in varchar2 default null)
    ;


--
-- return named text System message with substitutions
--
function system_message (
    p_name                      in varchar2 default null,
    p0                          in varchar2 default null,
    p1                          in varchar2 default null,
    p2                          in varchar2 default null,
    p3                          in varchar2 default null,
    p4                          in varchar2 default null,
    p5                          in varchar2 default null,
    p6                          in varchar2 default null,
    p7                          in varchar2 default null,
    p8                          in varchar2 default null,
    p9                          in varchar2 default null,
    p_lang                      in varchar2 default null,
    p_application_id            in varchar2 default null,
    p_security_group_id         in varchar2 default null)
    return varchar2
    ;



--
-- Return named text System message with substitutions.
-- This function is used when the returned string is going to be included
-- in a literal, so all occurrences of a single quote in the message will
-- be returned as two consecutive single quotes.
--
function system_message_lit (
    p_name                      in varchar2 default null,
    p0                          in varchar2 default null,
    p1                          in varchar2 default null,
    p2                          in varchar2 default null,
    p3                          in varchar2 default null,
    p4                          in varchar2 default null,
    p5                          in varchar2 default null,
    p6                          in varchar2 default null,
    p7                          in varchar2 default null,
    p8                          in varchar2 default null,
    p9                          in varchar2 default null,
    p_lang                      in varchar2 default null,
    p_application_id            in varchar2 default null,
    p_security_group_id         in varchar2 default null)
    return varchar2
    ;


--
-- htp.print a named text System message with substitutions
--
procedure system_message_p (
    p_name                      in varchar2 default null,
    p0                          in varchar2 default null,
    p1                          in varchar2 default null,
    p2                          in varchar2 default null,
    p3                          in varchar2 default null,
    p4                          in varchar2 default null,
    p5                          in varchar2 default null,
    p6                          in varchar2 default null,
    p7                          in varchar2 default null,
    p8                          in varchar2 default null,
    p9                          in varchar2 default null,
    p_lang                      in varchar2 default null,
    p_application_id            in varchar2 default null,
    p_security_group_id         in varchar2 default null)
    ;


--
--  WebDB20 style translations
--
function lang (
   p_primary_text_string       in varchar2 default null,
   p0                          in varchar2 default null,
   p1                          in varchar2 default null,
   p2                          in varchar2 default null,
   p3                          in varchar2 default null,
   p4                          in varchar2 default null,
   p5                          in varchar2 default null,
   p6                          in varchar2 default null,
   p7                          in varchar2 default null,
   p8                          in varchar2 default null,
   p9                          in varchar2 default null,
   p_primary_text_context      in varchar2 default null,
   p_primary_language          in varchar2 default null)
   return varchar2
   ;

FUNCTION find_language_preference
   RETURN varchar2
   ;

procedure set_translated_flow_and_page
    ---------------------------------
    --- SET NATIONAL LANGUAGE SUPPORT
    --  The language is determined from the browser
    --  this procedure sets:
    --  1. wwv_flow.g_translated_flow_id
    --  2. wwv_flow.g_translated_page_id
    --
   ;

--
-- Given an Oracle datbase character set, return the corresponding
-- IANA character set.  For example, given DB character set
-- of 'JA16SJIS', return 'shift_jis'.
--
-- If not found, will return NULL.
--
function map_iana_charset(
    p_db_charset in varchar2 )
    return varchar2;


--
-- Given an IANA character set, return the corresponding
-- Oracle database character set.  For example, given IANA
-- character set 'windows-1257', return 'BLT8MSWIN1257'.
--
-- If not found, will return NULL.
--
function map_db_charset(
    p_iana_charset in varchar2 )
    return varchar2;

--
-- Reset the NLS settings for the current
-- database session to that of the database
--
procedure reset_nls;

--
-- Return the value of the NLS_LANGUAGE which
-- was set in the current session
--
function get_nls_language return varchar2;


--
-- Return the value of the NLS Windows Charset which
-- was set in the current session.  Typically used for
-- CSV encoding
--
function get_nls_windows_charset return varchar2;


--
-- Return the target character set for CSV data in the
-- current application.  A null value returned from this function
-- means that either application language derived from is set to
-- No NLS (application not translated) or that the csv_encoding
-- flag of wwv_flows is not turned on.  Otherwise, the non-null
-- value will be an Oracle character set to be used as the target
-- character set which CSV data is to be converted to
--
function get_csv_charset return varchar2;


--
-- Return the database characterset from nls_database_parameters
--
function get_db_charset return varchar2;


--
-- Used by the Application wizards to return the
-- correct type of PICK_DATE based upon the current
-- language preference of the user
--
function pick_date_from_language return varchar2;


--
-- Check for the application-level date format setting
-- and adjust the database session NLS_DATE_FORMAT parameter
--
procedure set_application_date_format;


end wwv_flow_lang;
/