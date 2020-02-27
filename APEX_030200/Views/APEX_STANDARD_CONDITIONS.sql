CREATE OR REPLACE FORCE VIEW apex_standard_conditions ("D",r) AS
select 'EXISTS' d,'Exists (SQL query returns at least one row)'r from dual
union all select 'NOT_EXISTS' d,'NOT Exists (SQL query returns no rows)'r from dual
union all select 'SQL_EXPRESSION' d,'SQL Expression'r from dual
union all select 'PLSQL_EXPRESSION' d,'PL/SQL Expression'r from dual
union all select 'FUNCTION_BODY' d,'PL/SQL Function Body Returning a Boolean'r from dual
union all select 'REQUEST_EQUALS_CONDITION' d,'Request = Expression 1'r from dual
union all select 'REQUEST_NOT_EQUAL_CONDITION' d,'Request != Expression 1'r from dual
union all select 'REQUEST_IN_CONDITION' d,'Request Is Contained within Expression 1'r from dual
union all select 'REQUEST_NOT_IN_CONDITION' d,'Request Is NOT Contained within Expression 1'r from dual
union all select 'VAL_OF_ITEM_IN_COND_EQ_COND2' d,'Value of Item in Expression 1 = Expression 2'r from dual
union all select 'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2' d,'Value of Item in Expression 1 != Expression 2'r from dual
union all select 'ITEM_IS_NULL' d,'Value of Item in Expression 1 Is NULL'r from dual
union all select 'ITEM_IS_NOT_NULL' d,'Value of Item in Expression 1 Is NOT NULL'r from dual
union all select 'ITEM_IS_ZERO' d,'Value of Item in Expression 1 = Zero'r from dual
union all select 'ITEM_IS_NOT_ZERO' d,'Value of Item in Expression 1 != Zero'r from dual
union all select 'ITEM_IS_NULL_OR_ZERO' d,'Value of Item in Expression 1 Is NULL or Zero'r from dual
union all select 'ITEM_NOT_NULL_OR_ZERO' d,'Value of Item in Expression 1 Is NOT null and the Item Is NOT Zero'r from dual
union all select 'ITEM_CONTAINS_NO_SPACES' d,'Value of Item in Expression 1 Contains No Spaces'r from dual
union all select 'ITEM_IS_NUMERIC' d,'Value of Item in Expression 1 Is Numeric' r from dual
union all select 'ITEM_IS_NOT_NUMERIC' d,'Value of Item in Expression 1 Is Not Numeric' r from dual
union all select 'ITEM_IS_ALPHANUMERIC' d,'Value of Item in Expression 1 Is Alphanumeric'r from dual
union all select 'VALUE_OF_ITEM_IN_CONDITION_IN_COLON_DELIMITED_LIST' d,'Value of Item in Expression 1 Is Contained within Colon Delimited List in Expression 2'r from dual
union all select 'VALUE_OF_ITEM_IN_CONDITION_NOT_IN_COLON_DELIMITED_LIST' d,'Value of Item in Expression 1 Is NOT Contained within Colon Delimited List in Expression 2'r from dual
union all select 'USER_PREF_IN_COND_EQ_COND2' d,'Value of User Preference in Expression 1 = Expression 2'r from dual
union all select 'USER_PREF_IN_COND_NOT_EQ_COND2' d,'Value of User Preference in Expression 1 != Expression 2'r from dual
union all select 'CURRENT_PAGE_EQUALS_CONDITION' d,'Current page = Expression 1'r from dual
union all select 'CURRENT_PAGE_NOT_EQUAL_CONDITION' d,'Current page != Expression 1'r from dual
union all select 'CURRENT_PAGE_IN_CONDITION' d,'Current Page Is Contained Within Expression 1 (comma delimited list of pages)'r from dual
union all select 'CURRENT_PAGE_NOT_IN_CONDITION' d,'Current Page Is NOT in Expression 1 (comma delimited list of pages)'r from dual
union all select 'WHEN_THIS_PAGE_SUBMITTED' d,'Current Page = Page Submitted (this page was posted)'r from dual
union all select 'WHEN_THIS_PAGE_NOT_SUBMITTED' d,'Current Page != Page Submitted (this page was not the page posted)'r from dual
union all select 'PAGE_IS_IN_PRINTER_FRIENDLY_MODE' d,'Current Page Is in Printer Friendly Mode'r from dual
union all select 'PAGE_IS_NOT_IN_PRINTER_FRIENDLY_MODE' d,'Current page is NOT in Printer Friendly Mode'r from dual
union all select 'CONDITION1_IN_VALUE_OF_ITEM_IN_CONDITION2' d,'Text in Expression 1 Is Contained in Value of Item in Expression 2'r from dual
union all select 'DISPLAY_COND_IN_COND_TEXT' d,'Text in Expression 1 Is Contained within the Text in Expression 2'r from dual
union all select 'DISPLAY_COND_NOT_IN_COND_TEXT' d,'Text in Expression 1 Is NOT Contained within the Text in Expression 2'r from dual
union all select 'DISPLAY_COND_EQUAL_COND_TEXT' d,'Text in Expression 1 = Expression 2 (includes ITEM substitutions)'r from dual
union all select 'DISP_COND_NOT_EQUAL_COND_TEXT' d,'Text in Expression 1 != Expression 2 (includes ITEM substitutions)'r from dual
union all select 'USER_IS_NOT_PUBLIC_USER' d,'User is Authenticated  (not public)'r from dual
union all select 'USER_IS_PUBLIC_USER' d,'User is the Public User (user has not authenticated)'r from dual
union all select 'DISPLAYING_INLINE_VALIDATION_ERRORS' d,'Inline Validation Errors Displayed'r from dual
union all select 'NOT_DISPLAYING_INLINE_VALIDATION_ERRORS' d,'No Inline Validation Errors Displayed'r from dual
union all select 'MAX_ROWS_LT_ROWS_FETCHED' d,'SQL Reports (OK to show the forward button)'r from dual
union all select 'MIN_ROW_GT_THAN_ONE' d,'SQL Reports (OK to show the back button)'r from dual
union all select 'BROWSER_IS_NSCP' d,'Client Browser: Mozilla, Netscape 6.x/7x or higher'r from dual
union all select 'BROWSER_IS_MSIE' d,'Client Browser: Microsoft Internet Explorer 5.5, 6.0 or higher'r from dual
union all select 'BROWSER_IS_MSIE_OR_NSCP' d,'Client Browser: XHTML / CSS capable browser (NS 6.x,7x, Mozilla, IE 5.5, 6.0 or higher)'r from dual
union all select 'BROWSER_IS_OTHER' d,'Client Browser: Other browsers (or older version)'r from dual
union all select 'CURRENT_LANG_IN_COND1' d,'Current Language Is Contained within Expression 1'r from dual
union all select 'CURRENT_LANG_NOT_IN_COND1' d,'Current Language Is NOT Contained within Expression 1'r from dual
union all select 'CURRENT_LANG_NOT_EQ_COND1' d,'Current Language != Expression 1'r from dual
union all select 'CURRENT_LANG_EQ_COND1' d,'Current Language = Expression 1'r from dual
union all select 'DAD_NAME_EQ_CONDITION' d,'When CGI_ENV DAD_NAME = Expression 1'r from dual
union all select 'DAD_NAME_NOT_EQ_CONDITION' d,'When CGI_ENV DAD_NAME != Expression 1'r from dual
union all select 'SERVER_NAME_EQ_CONDITION' d,'When CGI_ENV SERVER_NAME = Expression 1'r from dual
union all select 'SERVER_NAME_NOT_EQ_CONDITION' d,'When CGI_ENV SERVER_NAME != Expression 1'r from dual
union all select 'HTTP_HOST_EQ_CONDITION' d,'When CGI_ENV HTTP_HOST = Expression 1'r from dual
union all select 'HTTP_HOST_NOT_EQ_CONDITION' d,'When CGI_ENV HTTP_HOST != Expression 1'r from dual
union all select 'NEVER' d,'Never'r from dual
union all select 'ALWAYS' d,'Always'r from dual ;