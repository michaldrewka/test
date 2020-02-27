CREATE OR REPLACE package htmldb_lang
--  Copyright (c) Oracle Corporation 2003. All Rights Reserved.
--
--    DESCRIPTION
--      globalization services
--
--    NOTES
--      This program allows for translation of text strings from
--      on national language to another.
--
--    RUNTIME DEPLOYMENT: YES
is

function message (
    -- Function to return a message from the message repository.
    --
    -- p_name   - name of message to be printed
    -- p0 - p9  - substitution parameters that replace text srings
    --            %0 through %9
    -- p_lang   - optional parameter to override the language
    --
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



procedure message_p (
    -- Print a message from the message repository.
    --
    -- p_name   - name of message to be printed
    -- p0 - p9  - substitution parameters that replace text srings
    --            %0 through %9
    -- p_lang   - optional parameter to override the language
    --
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


function lang (
   -- Return a translated text string from the
   -- translatable messages repository within HTMLDB.
   --
   -- p_primary_text_string - text string to be translated
   -- p0 - p9  - substitution parameters that replace text srings
   --            %0 through %9
   -- p_primary_text_context-
   -- p_primary_language    -
   --
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
   p_primary_language          in varchar2 default null)
   return varchar2
   ;

end htmldb_lang;
/