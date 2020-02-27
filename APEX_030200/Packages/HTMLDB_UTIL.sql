CREATE OR REPLACE package htmldb_util as

--  Copyright (c) Oracle Corporation 2003 - 2008. All Rights Reserved.
--
--    DESCRIPTION
--      APEX Utilities
--      Provides procedural access for advanced APEX application development
--
--    SECURITY
--      Publicly executable.
--

function get_session_state (
    --
    --This function returns the value in session state for a given item.
    --
    --Arguments:
    --
    --  p_item:     Case insensitive name of the item for which you
    --              wish to have the session state fetched.
    --
    --Example:
    --
    --  l_val := htmldb_util.get_session_state('my_item');
    --
    --
    p_item  in varchar2)
    return varchar2
    ;

function get_numeric_session_state (
    --
    --This function returns the numeric value in session state for a given
    --numeric item.
    --
    --Arguments:
    --
    --  p_item:     Case insensitive name of the numeric item for which you
    --              wish to have the session state fetched.
    --
    --Example:
    --
    --  l_num := htmldb_util.get_numeric_session_state('my_item');
    --
    --
    p_item      in varchar2)
    return number
    ;

function fetch_app_item(
    --
    -- Given an application-level item name, locate item in current or specified
    -- application and current or specified session and return item value.
    --
    --Arguments:
    --
    --  p_item:     name of application-level item
    --  p_app:      application ID that owns the item
    --  p_session:  session ID
    --
    --Example:
    --
    --  l_num := htmldb_util.fetch_app_item(p_item=>'F300_NAME',p_app=>300)
    --
    --
    p_item         in varchar2,
    p_app          in number default null,
    p_session      in number default null)
    return varchar2
    ;

function get_file_id(
    --
    -- This function returns the numeric primary key of the named file in wwv_flow_file_objects$
    --
    p_name in varchar2)
    return number
    ;

procedure get_file (
    --
    --This procedure is used to download files from the HTMLDB file
    --repository.
    --
    --Arguments:
    --
    --  p_file_id:      The id in wwv_flow_files of the file to download.
    --  p_mime_type:    The mime type of the file to download
    --  p_inline:       'YES' to display inline in browser, 'NO' to download as
    --                  attachment
    --
    --Example:
    --
    --  htmldb_util.get_file(
    --      p_file_id   => '8675309',
    --      p_mime_type => 'text/xml',
    --      p_inline    => 'YES');
    --
    --
    p_file_id   in varchar2,
    p_mime_type in varchar2 default null,
    p_inline    in varchar2 default 'NO')
    ;

procedure count_click (
    --
    --This procedure is used to count clicks from an application to external site.
    --
    --Arguments:
    --
    --  p_url:          the url to redirect to
    --  p_cat:          a category to classify the click
    --  p_id:           a secondary id to associate with the click <-- optional
    --  p_user:         the application user <-- optional
    --  p_workspace:      the workspace associated with the application <-- optional (deprecated)
    --  p_workspace:    the workspace associated with the application <-- optional
    p_url       in varchar2,
    p_cat       in varchar2,
    p_id        in varchar2    default null,
    p_user      in varchar2    default null,
    p_company   in varchar2    default null,
    p_workspace in varchar2    default null)
    ;


procedure set_session_state (
    --
    -- Programmatically set session state for a current session.
    -- This procedure must be called from Application Express since it requires
    -- the Application Express environment.
    --
    -- Arguments:
    --
    --   p_name:  Name of application or page level item to set session state for
    --   p_value: Value of session state to set.
    --
    -- example:
    --
    --     htmldb_util.set_session_state('my_item','myvalue');
    --
    p_name    in varchar2 default null,
    p_value   in varchar2 default null)
    ;

procedure reset_authorizations
    --
    -- Security checks are cached to increase performance, this procedure allows you to
    -- undo the caching and thus require all security checks to be revalidated for the
    -- current user.  Use this routine if you allow a user to change "responcibilities"
    -- within an application, thus changing the authorization checks that they pass.
    --
    --Example:
    --
    --  htmldb_util.reset_authorizations;
    --
    ;

function public_check_authorization (
    --
    -- Given the name of a flow security scheme determine if the current user
    -- passes the security check.
    --
    -- Arguments:
    --
    -- p_security_scheme
    --
    --Example:
    --
    --  l_boolean := htmldb_util.public_check_authorization('MY_SECURITY_SCHEME');
    --
    p_security_scheme in varchar2)
    return boolean
    ;


function string_to_table (
    --
    --This function takes in a string and returns a PL/SQL array, of type
    --wwv_flow_global.vc_arr2, which is a table of varchar2(32767).
    --
    -- Arguments:
    --
    -- p_string:    string to be converted into a plsql table of type wwv_flow_global.vc_arr2
    -- p_separator: string seperator, by default a colon.
    --
    --Example:
    --
    --  l_vc_arr2 := htmldb_util.string_to_table('ONE:TWO:THREE');
    --
    p_string    in varchar2,
    p_separator in varchar2 default ':')
    return wwv_flow_global.vc_arr2
    ;


function table_to_string (
    --
    --This function takes in a PL/SQL table of type wwv_flow_global.vc_arr2
    --and returns a string separated by the separator supplied, or a ':' by default.
    --
    -- Arguments:
    --
    -- p_table:     PL/SQL table that is to be converted into delimited string
    -- p_string:   string seperator, by default a colon.
    --
    --Example:
    --
    --  l_string := htmldb_util.table_to_string(l_vc_arr2);
    --
    p_table     in wwv_flow_global.vc_arr2,
    p_string    in varchar2 default ':')
    return varchar2
    ;

function url_encode (
    --
    -- Encode (into HEX) all special characters which includes spaces,
    -- question marks, ampersands, etc.
    --
    --Arguments:
    -- p_string:    The string you would like to have encoded
    --
    --Examples:
    --
    --  l_url := htmldb_util.url_encode('http://www.myurl.com?id=1&cat=foo');
    --
    p_url       in varchar2)
    return varchar2
    ;

procedure clear_page_cache (
    -- Reset all cached items for a given page to null
    --Arguments:
    --  p_page_id:   The ID of the page in the current application and session to clear the cache for
    --
    --Example:
    --
    --  htmldb_util.clear_page_cache(1);
    --
    p_page_id in number default null)
    ;

procedure clear_app_cache (
    --
    --For the current session remove session state for the given flow.
    --
    --Arguments:
    --  p_app_id:   The ID of the application to clear the cache for current session
    --
    --Example:
    --
    --  htmldb_util.clear_app_cache('101');
    --
    p_app_id    in varchar2 default null)
    ;

procedure clear_user_cache
    --
    --For the current user's session remove session state and flow system preferences.
    --Run this procedure if you reuse session IDs and want to run htmldb application without
    --the benifit of existing session state.
    --
    --Example:
    --
    --  htmldb_util.clear_user_cache;
    --
    ;

procedure pause (
    --
    -- Pause for number of seconds identified by p_seconds
    --  (capped at 120 seconds)
    --
    p_seconds   in number)
    ;

-- ----------------------------------------------------------------------------------------
-- get since
-- Used to get a string representation of the time passed since the input date
-- Arguments:
--   p_date: date that is used to compute time since p_date and sysdate

function get_since(
      p_date date
  ) return varchar2;

procedure set_preference (
    --
    --Used to set a preference for a user that persists beyond the user's current session.
    --
    --Arguments:
    --  p_preference:   name of the preference, case sensitive
    --  p_value:        the value for the preference
    --  p_user:         the user to set the preference for
    --
    --Example:
    --  htmldb_util.set_preference(
    --      p_preference => 'default_view',
    --      p_value      => 'WEEKLY',
    --      p_user       => :APP_USER);
    --
    p_preference   in varchar2 default null,
    p_value        in varchar2 default null,
    p_user         in varchar2 default null)
    ;

function get_preference (
    --
    --Used to retrieve the value of a previously saved preference for a given user.
    --
    --Arguments:
    --
    --  p_prefernce:    the name of the preference to retrieve the value
    --  p_user:         the user to retrieve the preference for
    --
    --Example:
    --  l_default_view := htmldb_util.get_preference(
    --                      p_preference => 'default_view',
    --                      p_user       => :APP_USER);
    --
    p_preference   in varchar2 default null,
    p_user         in varchar2 default v('USER'))
    return varchar2
    ;

procedure remove_preference(
    --
    --Removes the preference for the supplied user.
    --
    --Arguments:
    --  p_preference:   the name of the preference to remove
    --  p_user:         the user to remove the preference for
    --
    --Example:
    --  htmldb_util.remove_preference(
    --      p_preference => 'default_view',
    --      p_user       => :APP_USER);
    --
    p_preference   in varchar2 default null,
    p_user         in varchar2 default v('USER'))
    ;

procedure remove_sort_preferences (
    --
    -- This procedure removes user's column heading sorting preference value.
    --
    --Arguments:
    --  p_user:         the user to remove sorting preferences for
    --
    --Example:
    --  htmldb_util.remove_sort_preferences;
    --
    p_user         in varchar2 default v('USER'))
    ;



function current_user_in_group (
   --
   -- Given a group name return a boolean true or false if the current
   -- application user is part of that group.
   -- Example: if htmldb_util.current_user_in_group('MY_GROUP') then ...
   --
   p_group_name          in varchar2 )
   return boolean
   ;


function current_user_in_group (
   --
   -- Given a group numeric identifier return a boolean true or false if the current
   -- application user is part of that group.
   -- Example: if htmldb_util.current_user_in_group(1234567) then ...
   -- The above example assumes that 1234567 is a valid group ID.
   --
   p_group_id            in number)
   return boolean
   ;

function is_login_password_valid (
   --
   -- Checks the wwv_flow_fnd_users table to see if
   -- username/password combo is valid within the current workspace (checking by security_group_id)
   --
   p_username in varchar2 default null,
   p_password  in varchar2 default null)
   return boolean
   ;

function is_username_unique (
   --
   -- Simply checks wwv_flow_fnd_users table to see if
   -- username is unique within the current workspace (checking by security_group_id)
   --
   p_username              in varchar2)
   return boolean
   ;


----------------------------
-- G E T   F U N C T I O N S
--


function get_group_id (
   --
   -- Given a group name return the groups numeric identifier.
   -- Example: ... htmldb_util.get_group_name('MY_GROUP') ...
   --
   p_group_name          in varchar2 )
   return number
   ;


function get_group_name (
   --
   -- Given a group ID return the aphanumeric name.
   -- Example: ... htmldb_util.get_group_name(1234567) ...
   --
   p_group_id            in varchar2 )
   return varchar2
   ;

function get_group_name (
   --
   -- Added overloaded version with correct number type for p_group_id.
   -- Given a group ID (numeric) return the aphanumeric name.
   -- Example: ... htmldb_util.get_group_name(1234567) ...
   --
   p_group_id            in number )
   return varchar2
   ;

function get_email (
   --
   -- For a given user return the identified email address from the fnd user table.  Only works
   -- with standard user management system.  If you use applications with
   -- other user repositories this API will not return useful information.
   -- Example:  ... htmldb_util.get_email('JOE.USER')
   -- The example above assumes a username JOE.USER exists.
   --
   p_username            in varchar2)
   return varchar2
   ;


function get_first_name (
   --
   -- For a given user return the identified first name.  Only works
   -- with standard user management system.  If you use applications with
   -- other user repositories this API will not return useful information.
   -- Example:  ... htmldb_util.get_first_name('JOE_USER')
   -- The example above assumes a username JOE_USER exists.
   --
   p_username            in varchar2)
   return varchar2
   ;


function get_last_name (
   --
   -- For a given user return the identified last name.  Only works
   -- with standard user management system.  If you use with
   -- other user repositories this API will not return useful information.
   -- Example:  ... htmldb_util.get_last_name('JOE_USER')
   -- The example above assumes a username JOE_USER exists.
   --
   p_username            in varchar2)
   return varchar2
   ;


function get_current_user_id
   --
   -- For the current user return the numeric identifier.  Only
   -- useful when useing user management system.
   --
   return number
   ;


function get_user_id (
   --
   -- Given a username return the numeric idenfier.
   -- Example: ... htmldb_util.get_user_id('JOE_USER')
   -- The example above assumes JOE_USER is a valid username.
   --
   p_username            in varchar2)
   return number
   ;


function get_username (
   --
   -- Given a user ID return the username.
   -- Example: ... htmldb_util.get_username(222222)
   -- The example above assumes 222222 is a valid user ID.
   --
   p_userid              in number)
   return varchar2
   ;

function get_attribute (
   --
   -- Given a user name and attribute number, valid values are 1..10
   -- return the attribute value.  The wwv_flow_fnd_user table contains
   -- 10 columns attribute_01 .. attribute_10 for extra user attributes.
   --
   p_username             in varchar2,
   p_attribute_number     in number)
   return varchar2
   ;


function get_groups_user_belongs_to (
   --
   -- Given a username returns a comma seperated list of groups that
   -- this user is a member of.
   -- Example: htp.p('user JOE_USER is a member of the following groups: '||
   --                 htmldb_util.get_groups_user_belongs_to('JOE_USER'));
   --
   p_username            in varchar2)
   return varchar2
   ;

function get_default_schema
   --
   -- For the currently logged in user, return the schema that the workspace
   -- was provisioned with, by default.
   --
   return varchar2
   ;

----------------------------
-- S E T   F U N C T I O N S
--

procedure set_email (
   --
   -- For a given userid set the identified email address.  Only works
   -- with standard user management system.  If you use with
   -- other user repositories this API will not set useful information.
   -- Example:  ... htmldb_util.set_email(222222,'MIKE@HOTMAIL.COM')
   -- The example above assumes a user ID 222222 exists.
   -- An error will be raised in the event this procedure fails.
   --
   p_userid              in number,
   p_email               in varchar2)
   ;


procedure set_first_name (
   --
   -- For a given user set the identified first name.  Only works
   -- with standard user management system.  If you use with
   -- other user repositories this API will not return useful information.
   -- Example:  ... htmldb_util.set_first_name(222222,'Mike')
   -- The example above assumes a user ID 222222 exists.
   -- An error will be raised in the event this procedure fails.
   --
   p_userid              in number,
   p_first_name          in varchar2)
   ;


procedure set_last_name (
   --
   -- For a given user set the identified last name.  Only works
   -- with standard user management system.  If you use with
   -- other user repositories this API will not return useful information.
   -- Example:  ... htmldb_util.set_last_name('JOE_USER')
   -- The example above assumes a username JOE_USER exists.
   -- An error will be raised in the event this procedure fails.
   --
   p_userid              in number,
   p_last_name           in varchar2)
   ;


procedure set_username (
   --
   -- Given a user ID set the username.
   -- Example: ... htmldb_util.set_username(222222,'JOE')
   -- The example above assumes 222222 is a valid user ID.
   -- An error will be raised in the event this procedure fails.
   --
   p_userid              in number,
   p_username            in varchar2)
   ;

procedure set_attribute (
   --
   -- Given a user ID and attribute number, valid values are 1..10
   -- set the attribute value.  The wwv_flow_fnd_user table contains
   -- 10 columns attribute_01 .. attribute_10 for extra user attributes.
   -- An error will be raised in the event this procedure fails.
   -- Example: ... htmldb_util.set_attribute(22222,1,'likes sailing and tennis');
   --
   p_userid               in number,
   p_attribute_number     in number,
   p_attribute_value      in varchar2)
   ;

procedure export_users (
    -- Description:
    --    This procedure exports all users in a the current workspace, designed
    --    to be called from the development environment.
    --
    p_export_format in varchar2 default 'UNIX')
    ;

procedure create_user_group (
    -- Description:
    --    This procedure allows for programatic and bulk creation of users.
    --
    -- Arguments:
    --    p_ID                = unique identifier of the group, typically a large virtually globally unique number.
    --    p_group_name        = name of group
    --    p_security_group_id = identifies which workspace this user group belongs to
    --    p_group_desc        = text description used as an note to the developer
    --
    p_id                      in number,
    p_group_name              in varchar2,
    p_security_group_id       in number,
    p_group_desc              in varchar2)
    ;

procedure create_user (
    -- Description:
    --    This procedure allows for programatic and bulk creation of users.
    --
    -- Example:
    --    From sqlplus logged in as a schema assigned to the target workspace
    --
    --    begin
    --       for i in 1..10 loop
    --          htmldb_util.create_user(
    --             p_user_name => 'USER_'||i,
    --             p_email_address => 'user_'||i||'@myworkspace.com',
    --             p_web_password => 'user_'||i) ;
    --       end loop;
    --       commit;
    --    end;
    --    /
    --
    --
    -- Arguments:
    --    p_user_id         numeric primary key of user
    --    p_user_name       the username the user uses to login
    --    p_first_name      informational only
    --    p_last_name       informational only
    --    p_web_password    the unencrypted password for the new user
    --    p_group_ids       A colon delimited list of group IDs from the table wwv_flow_fnd_user_groups
    --    p_developer_privs A colon delmited list of developer privs, privs include:
    --                      ADMIN:BROWSE:CREATE:DATA_LOADER:DB_MONITOR:EDIT:HELP:MONITOR:SQL:USER_MANAGER
    --    p_default_schema  A valid oracle schema that is the default schema for use in browsing and
    --                      creating Application Express
    --    p_allow_access_to_schemas A colon delimited list of oracle schemas that the user is allowed to
    --                      parse as.  If null the user can parse as any schema available to the workspace.
    --                      This does not provide privilege it only resticts privilege, so listing a schema
    --                      does not provide the privilege to parse as a schema, it only restricts that user
    --                      to that list of schemas.
    --    p_attributes_XX   These attributes allow you to store arbitary information about a given user.
    --                      They are for use by flow developers who want to extend user information.
    --    p_web_password_format Identifies the format of the web password.
    --                      The range of values is CLEAR_TEXT, HEX_ENCODED_DIGEST, DIGEST
    --
    --
    --
    p_user_id                      in number   default null,
    p_user_name                    in varchar2,
    p_first_name                   in varchar2 default null,
    p_last_name                    in varchar2 default null,
    p_description                  in varchar2 default null,
    p_email_address                in varchar2 default null,
    p_web_password                 in varchar2,
    p_web_password_format          in varchar2 default 'CLEAR_TEXT',
    p_group_ids                    in varchar2 default null,
    p_developer_privs              in varchar2 default null,
    p_default_schema               in varchar2 default null,
    p_allow_access_to_schemas      in varchar2 default null,
    p_account_expiry               in date     default trunc(sysdate),
    p_account_locked               in varchar2 default 'N',
    p_failed_access_attempts       in number   default 0,
    p_change_password_on_first_use in varchar2 default 'Y',
    p_first_password_use_occurred  in varchar2 default 'N',
    p_attribute_01                 in varchar2 default null,
    p_attribute_02                 in varchar2 default null,
    p_attribute_03                 in varchar2 default null,
    p_attribute_04                 in varchar2 default null,
    p_attribute_05                 in varchar2 default null,
    p_attribute_06                 in varchar2 default null,
    p_attribute_07                 in varchar2 default null,
    p_attribute_08                 in varchar2 default null,
    p_attribute_09                 in varchar2 default null,
    p_attribute_10                 in varchar2 default null)
    ;

procedure create_user_from_file (
    -- Description:
    --    This procedure allows for programatic and bulk creation of users
    --    from a text file.  The file must be in one of two formats.
    --
    --    FORMAT 1
    --    username,email,PRIV1:PRIV2,password
    --
    --    FORMAT 2
    --    username,email,PRIV1:PRIV2
    --
    --    PRIV1:PRIV2 is a colon delimited list of developer privelages of the
    --    user.  Valid privelages are detailed in create_fnd_user spec.
    --
    --    Each line must end with a line feed (chr(10)).
    --
    -- Arguments:
    --
    --    p_id          The id of the file in wwv_flow_file_objects$
    --    p_mode        Either CREATE or display depending on whether you
    --                  actually want to create the users or just display them
    --                  via htp.p
    --    p_format      Can be either 1, 2 or 3.  Refers to the format of the file
    --                  and the create user process.  1: passwords are contained in
    --                  the file in clear text.  2: passwords have been supplied via
    --                  the p_password parameter.  3: passwords should be randomly
    --                  generated and then e-mailed to the user.
    --    p_password    Only relevant in format 2.  Every user created is given the
    --                  password supplied in this parameter.
    --    p_app         The name of the application.  This name appears in the subject
    --                  and body of the e-mail message sent to users when format is 3.
    --    p_appurl      Optional URL can be supplied when file format is 3.  The URL will
    --                  appear at the end of the mail message.
    --    p_start       This parameter holds the start time of execution
    --    p_end         Parameter holds the time the procedure completes
    --    p_loaded      The number of users that were provisioned by the execution of the
    --                  procedure.
    --
    --
    --
	p_id in number,
	p_mode      in varchar2 default 'CREATE',
	p_format    in varchar2 default '1',
	p_password  in varchar2 default 'oracle',
	p_app       in varchar2 default null,
	p_appurl    in varchar2 default null,
	p_start    out varchar2,
	p_end      out varchar2,
	p_loaded   out varchar2)
    ;

procedure remove_user (
    -- Description
    --   This procedure allows for programatic removal of users.
    --   This procedure is overloaded.
    --
    p_user_id         in number)
    ;

procedure remove_user (
    -- Description:
    --   This procedure allows for programatic removal of users.
    --   This procedure is overloaded.
    --
    -- Example:
    --    begin wwv_flow_security.g_security_group_id := 20; end;
    --    /
    --
    --    begin
    --       for i in 1..10 loop
    --          wwv_flow_fnd_user_api.remove_fnd_user(
    --             p_user_name => 'USER_'||i);
    --       end loop;
    --       commit;
    --    end;
    --    /
    --
    p_user_name       in varchar2)
    ;

procedure change_current_user_pw (
    --
    -- This procedure changes the current user's password.
    --
    p_new_password    in varchar2)
    ;

procedure reset_pw (
    --
    -- This procedure resets the named user's password.
    --
    p_user                  in varchar2,
    p_msg                   in varchar2)
    ;

function user_in_group (
    --
    -- obsolete
    --
    p_group_name in varchar2)
    return boolean
    ;

function get_user_roles (
    --
    -- Return the colon-delimited list of developer roles
    -- for the specified user in the current workspace
    --
    p_username              in varchar2)
    return varchar2
    ;

function find_security_group_id (
     --
     -- given a workspace short name return the security group id
     -- p_workspace = short name of workspace
     --
     p_workspace  in varchar2 default null)
     return number;


function find_workspace (
     --
     -- given a security_group_id, return the workspace short name
     -- p_workspace = short name of workspace
     --
     p_security_group_id  in varchar2 default null)
     return varchar2;

procedure fetch_user (
     --
     -- Fetch user information from
     -- wwv_flow_fnd_user, wwv_flow_fnd_group_users and wwv_flow_developers table.
     -- This procedure is overloaded.
     --
     p_user_id       in number,
     p_workspace       out varchar2,
     p_user_name     out varchar2,
     p_first_name    out varchar2,
     p_last_name     out varchar2,
     p_web_password  out varchar2,
     p_email_address out varchar2,
     p_start_date    out varchar2,
     p_end_date      out varchar2,
     p_employee_id   out varchar2,
     p_allow_access_to_schemas out varchar2,
     p_person_type     out varchar2,
     p_default_schema  out varchar2,
     p_groups          out varchar2,
     p_developer_role  out varchar2,
     p_description     out varchar2
     );

procedure fetch_user (
     --
     -- Fetch user information from
     -- wwv_flow_fnd_user, wwv_flow_fnd_group_users and wwv_flow_developers table.
     -- This procedure is overloaded.
     --
     p_user_id         in number,
     p_user_name       out varchar2,
     p_first_name      out varchar2,
     p_last_name       out varchar2,
     p_email_address   out varchar2,
     p_groups          out varchar2,
     p_developer_role  out varchar2,
     p_description     out varchar2
     );

procedure fetch_user (
     --
     -- Fetch user information from
     -- wwv_flow_fnd_user, wwv_flow_fnd_group_users and wwv_flow_developers table.
     -- This procedure is overloaded.
     --
     p_user_id                      in number,
     p_workspace                    out varchar2,
     p_user_name                    out varchar2,
     p_first_name                   out varchar2,
     p_last_name                    out varchar2,
     p_web_password                 out varchar2,
     p_email_address                out varchar2,
     p_start_date                   out varchar2,
     p_end_date                     out varchar2,
     p_employee_id                  out varchar2,
     p_allow_access_to_schemas      out varchar2,
     p_person_type                  out varchar2,
     p_default_schema               out varchar2,
     p_groups                       out varchar2,
     p_developer_role               out varchar2,
     p_description                  out varchar2,
     p_account_expiry               out date,
     p_account_locked               out varchar2,
     p_failed_access_attempts       out number,
     p_change_password_on_first_use out varchar2,
     p_first_password_use_occurred  out varchar2
     );

procedure edit_user (
     --
     -- Edit user information to
     -- wwv_flow_fnd_user, wwv_flow_fnd_group_users and wwv_flow_developers table.
     --
     p_user_id                      in number,
     p_user_name                    in varchar2,
     p_first_name                   in varchar2 default null,
     p_last_name                    in varchar2 default null,
     p_web_password                 in varchar2 default null,
     p_new_password                 in varchar2 default null,
     p_email_address                in varchar2 default null,
     p_start_date                   in varchar2 default null,
     p_end_date                     in varchar2 default null,
     p_employee_id                  in varchar2 default null,
     p_allow_access_to_schemas      in varchar2 default null,
     p_person_type                  in varchar2 default null,
     p_default_schema               in varchar2 default null,
     p_group_ids                    in varchar2 default null,
     p_developer_roles              in varchar2 default null,
     p_description                  in varchar2 default null,
     p_account_expiry               in date     default null,
     p_account_locked               in varchar2 default 'N',
     p_failed_access_attempts       in number   default 0,
     p_change_password_on_first_use in varchar2 default 'Y',
     p_first_password_use_occurred  in varchar2 default 'N'
     );

procedure lock_account (
     p_user_name     in varchar2
     );

procedure unlock_account(
     p_user_name     in varchar2
     );

function get_account_locked_status(
     p_user_name in varchar2
     ) return boolean
     ;

procedure expire_workspace_account(
    p_user_name in varchar2
    );

procedure unexpire_workspace_account(
    p_user_name in varchar2
    );

procedure expire_end_user_account(
    p_user_name in varchar2
    );

procedure unexpire_end_user_account(
    p_user_name in varchar2
    );

function workspace_account_days_left(
    p_user_name in varchar2)
    return number
    ;

function end_user_account_days_left(
    p_user_name in varchar2)
    return number
    ;

procedure set_custom_auth_status(
    p_status in varchar2
    );

procedure set_authentication_result(
    p_code in number
    );

function change_password_on_first_use(
    p_user_name in varchar2
    ) return boolean
    ;

function password_first_use_occurred(
    p_user_name in varchar2
    ) return boolean
    ;

function get_authentication_result
    return number
    ;

function prepare_url(
    --
    -- If URL is f?p format, do escape_url on the argument values only.
    -- This function assumes that all substitutions, e.g., &ITEM_NAME. substitutions have already been performed.
    --
    p_url           in varchar2,
    p_url_charset   in varchar2 default null,
    p_checksum_type in varchar2 default null
    )
    return varchar2
    ;

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

procedure flash(
    --
    -- Anychart appends various parameters to the XML file URL
    -- This procedure accepts all parameters and discards them to call f?p
    --
    p in varchar2,
    fileParams in varchar2 default null,
    method in varchar2 default null,
    instance in varchar2 default null,
    methodName in varchar2 default null,
    tf in varchar2 default null,
    setXMLDataCall in varchar2 default null,
    setXMLTextCall in varchar2 default null,
    trial_tf in varchar2 default null,
    instance3 in varchar2 default null,
    XMLCallDate in varchar2 default null,
    onEnterFrame in varchar2 default null,
    j in varchar2 default null,
    loading in varchar2 default null,
    waiting in varchar2 default null);

procedure flash2(
    p in varchar2,
    preloaderLoadingText in varchar2 default null,
    swffile in varchar2 default null,
    preloaderInitText in varchar2 default null,
    XMLCallDate in varchar2 default null
    );

procedure increment_calendar;

procedure decrement_calendar;

procedure today_calendar;

procedure weekly_calendar(p_date_type_field varchar2 default null);

procedure daily_calendar(p_date_type_field varchar2 default null);

procedure month_calendar(p_date_type_field varchar2 default null);


-----------------------------------------------------------------------
-- Page and Region Caching APIs, APIs for use by application developers
--
procedure cache_purge_by_application (
   -- Purges all cached pages and regions for a given application.
   --
   p_application    in number);

procedure cache_purge_by_page (
   -- Purges all cached pages and regions for a given application and page.
   -- If p_user_name is supplied, only that user's cached pages and regions
   -- will be purged.
   --
   p_application  in number,
   p_page         in number,
   p_user_name    in varchar2 default null);

procedure cache_purge_stale (
   -- Deletes all cached pages and regions for the specified application
   -- that have passed their timeout.  When you select to have a page or
   -- region be cached, you can specify an active time period.  Once that
   -- has passed, that cache will not be used.  This removes those
   -- unusable pages and regions from the cache.
   --
   p_application    in number);

function cache_get_date_of_page_cache (
   -- Returns the date and time the specified application page
   -- was cached either for the user issuing the call
   -- or for all users if the page was not set to be cached by user.
   --
   p_application  in number,
   p_page         in number)
   return date;

procedure purge_regions_by_app (
    -- Purges all cached regions for a given application.
    --
    p_application in number);

procedure purge_regions_by_name (
    -- Purges all cached regions of a given name for a given application
    -- and page.
    --
    p_application  in number,
    p_page         in number,
    p_region_name  in varchar2);

procedure purge_regions_by_page (
    -- Purges all cached regions for a given application and page.
    --
    p_application  in number,
    p_page         in number);

function cache_get_date_of_region_cache (
   -- Returns the date and time the specified region
   -- was cached either for the user issuing the call
   -- or for all users if the region was not set to be cached by user.
   --
   p_application  in number,
   p_page         in number,
   p_region_name  in varchar2)
   return date;

-----------------------
-- SQL Prompt Utilities
--

procedure export_application (
    --
    -- For use from SQL prompt
    -- Application export generated to HTP buffer
    --
    -- example:
    -- begin apex_util.export_application(p_application_id=>:a,p_workspace_id=>:b); end;
    --
    p_workspace_id            in number,
    p_application_id          in number)
    ;

procedure export_application_page (
    --
    -- For use from SQL prompt
    -- Application page export generated to HTP buffer
    --
    -- example:
    -- begin apex_util.export_application_page(p_application_id=>:a,p_page_id=>:b,p_workspace_id=>:c); end;
    --
    p_workspace_id            in number,
    p_application_id          in number,
    p_page_id                 in number)
    ;

procedure export_application_component (
    --
    -- For use from SQL prompt
    -- Application component export generated to HTP buffer
    --
    -- example:
    -- begin apex_util.export_application_component(p_application_id=>:a,p_page_id=>:b,p_workspace_id=>:c); end;
    --
    p_workspace_id            in number,
    p_application_id          in number,
    p_component_id            in number,
    p_component_type          in varchar2)
    ;

function minimum_free_application_id
    --
    --  For use from SQL prompt
    --
    -- example:
    -- begin dbms_output.put_line(apex_util.minimum_free_application_id); end;
    --
    return number
    ;

function get_application_id_status (
    --
    --  For use from SQL prompt
    --
    --  0 = available
    --  1 = used by current workspace and database user and application owner
    -- -1 = unavailable
    --
    -- p_application name is provided only for return values of 1.
    --
    -- example:
    -- begin dbms_output.put_line(apex_util.get_application_id_status(p_application_id=>:a,p_workspace_id=>:b)); end;
    --
    --
    p_workspace_id           in  number,
    p_application_id         in  number)
    return number
    ;

function get_application_name (
    --
    -- For use from SQL prompt
    --
    -- will return null if current user does not own application
    --
    -- example:
    -- begin dbms_output.put_line(apex_util.get_application_name(p_application_id=>:a,p_workspace_id=>:b)); end;
    --
    p_workspace_id           in  number,
    p_application_id         in  number)
    return varchar2
    ;

-------
-- JSON
--

procedure json_from_sql (
    sqlq     in varchar2 default null,
    p_sub    in varchar2 default 'N',
    p_owner  in varchar2 default null);

procedure json_from_array (
    p_rows   in number   default null,
    p_cols   in number   default null,
    p_name01 in varchar2 default null,
    p_name02 in varchar2 default null,
    p_name03 in varchar2 default null,
    p_name04 in varchar2 default null,
    p_name05 in varchar2 default null,
    p_name06 in varchar2 default null,
    p_name07 in varchar2 default null,
    p_name08 in varchar2 default null,
    p_name09 in varchar2 default null,
    p_name10 in varchar2 default null,
    p_f01    in wwv_flow_global.vc_arr2 default wwv_flow.empty_vc_arr,
    p_f02    in wwv_flow_global.vc_arr2 default wwv_flow.empty_vc_arr,
    p_f03    in wwv_flow_global.vc_arr2 default wwv_flow.empty_vc_arr,
    p_f04    in wwv_flow_global.vc_arr2 default wwv_flow.empty_vc_arr,
    p_f05    in wwv_flow_global.vc_arr2 default wwv_flow.empty_vc_arr,
    p_f06    in wwv_flow_global.vc_arr2 default wwv_flow.empty_vc_arr,
    p_f07    in wwv_flow_global.vc_arr2 default wwv_flow.empty_vc_arr,
    p_f08    in wwv_flow_global.vc_arr2 default wwv_flow.empty_vc_arr,
    p_f09    in wwv_flow_global.vc_arr2 default wwv_flow.empty_vc_arr,
    p_f10    in wwv_flow_global.vc_arr2 default wwv_flow.empty_vc_arr,
    p_sub    in varchar2 default 'N');


procedure json_from_items(
    p_items      in varchar2 default null,
    p_separator  in varchar2 default ':',
    p_sub        in varchar2 default 'N'
);

procedure json_from_string(
    p_items      in varchar2 default null,
    p_separator  in varchar2 default ':',
    p_sub        in varchar2 default 'N'
);


---------------
-- BLOB Support
--
-- Procedures and functions that implement BLOB column support
--

procedure get_blob_file(
    -- Automatically called from APEX form pages
    -- Not designed to be called proceduarlly
    -- Calls to this procedure can be generated by calling the apex_util.get_blob_file_src function
    -- Page must have item of type FILE (FILE Browse)
    -- Page item source must use the following format "DB_COLUMN:MIMETYPE_COLUMN:FILENAME_COLUMN:LAST_UPDATE_COLUMN:CHARSET_COLUMN:CONTENT_DISPOSITION:DOWNLOAD_LINK"
    --    DB_COLUMN           = Required case sensitive name of a valid column which is of type BLOB
    --    MIMETYPE_COLUMN     = Optional case sensitive column name of a table column used to store the mimetype
    --    FILENAME_COLUMN     = Optional case sensitive column name of a table column used to store the file name
    --    LAST_UPDATE_COLUMN  = Optional case sensitive column name of a table column used to store the last update date of the BLOB
    --    CHARSET_COLUMN      = Optional case sensitive column name of a table column used to store the file character set
    --    CONTENT_DISPOSITION = inline or attachment
    --    DOWNLOAD_LINK       = Optional text to be used for the download text, defaults to Download, translated
    -- Page item source must include at least the database column name and a trailing colon
    -- Mimetype column is required if the mimetype is to be encoded in the download header
    -- Page item must be of source type of DATABASE COLUMN
    -- Page must have a DML process of type DML_PROCESS_ROW, used to determine the tablename
    -- Must be called from an APEX application context
    -- Invalid inputs will result in a 404 error
    --
    s                     in number,                -- APEX session ID
    a                     in number,                -- APEX application ID
    p                     in number,                -- APEX page ID of the form page
    d                     in number,                -- DML process APEX meta data ID
    i                     in number,                -- ITEM of type FILE APEX meta data ID
    p_pk1                 in varchar2,              -- Primary key value
    p_ck                  in varchar2,              -- Checksum used to prevent URL Tampering
    p_pk2                 in varchar2 default null, -- Optional Second Primary Key Value, used for compound keys
    p_mimetype            in varchar2 default null, -- Optional ...
    p_content_disposition in varchar2 default null, -- Optional use "inline" or "attachment" all other values ignored
    p_show_last_mod       in varchar2 default 'Y'); -- Optional ...

function get_blob_file_src (
    -- Generates a call to the apex_util.get_blob_file that can be used to download a BLOB column content
    -- Only generates usable output if called from a valid APEX session
    -- Example:
    --    PLSQL Function Body: return '<img src="'||apex_util.get_blob_file_src('P2_ATTACHMENT',empno)||'" />';
    --
    p_item_name in varchar2 default null,           -- Name of valid application page ITEM that with type FILE, and source type of DB column
    p_v1        in varchar2 default null,           -- Value of primary key column
    p_v2        in varchar2 default null,           -- Optional value of second primary key column
    p_content_disposition in varchar2 default null) -- Optional content disposition, valid values are "inline" and "attachment", other values ignored
    return varchar2
    ;

procedure get_blob (
    -- This procedure will download a blob column given proper inputs
    -- This get_blob function is designed to be called from APEX reports automatically
    -- Classic and Interactive Reports given a format mask will generate a link to this procedure
    -- Report that uses  "select ... dbms_lob.getlength(myblob_column) ..." syntax
    --
    -- The report column format mask has the following format
    -- DOWNLOAD|IMAGE:<blob_tab>:<blob_col>:<pk1_col>:<pk2_col>:<mimetype_col>:<filename_col>:<last_update_col>:<charset_col>:<content disposition>:<download text>
    -- All arguments are delimited by colons
    --
    -- This procedure is NOT designed to be called directly, it is intended to be called by APEX reporting engines
    -- Reference function apex_util.get_blob_file_src
    --
    -- position 1: "DOWNLOAD" or "IMAGE"
    --             Download will result in the generation a "a href=" tag
    --             Image will result in the generation of an inline "img src=" tag
    --             Use image when your files are images
    --             Using image for non image based files will result in broken image links
    --             Required
    -- position 2: Name of the table containing the blob column in question
    --             Required and case sensitive
    -- position 3: Name of the BLOB column name
    --             Required and case sensitive
    -- position 4: Name of the primary key column in the table identified in position 2
    --             Required and case sensitive
    -- position 5: Name of a secondary key column to uniquely identify the row that contains the BLOB column
    --             Optional and case sensitive
    -- position 6: Name of a column that is used to store the mime type that corresponds to the BLOB column
    --             Managing the mimetype allows the mimetype to be encoded in the file download
    --             If a mimetype is not specified download will use "application/octet-stream"
    --             A proper mimetype allows the browser to pick an approparte application to display the file
    --             Optional and case sensitive
    -- position 7: Name of a column that is used to store the filename of the BLOB column identified in position 3
    --             Managing the filename allows downloads to default the file name to a usefull value
    --             Optional and case sensitive
    --             Not used for IMAGE format but left in so format can easily be changed between IMAGE and DOWNLOAD
    -- position 8: Name of a column that is used to store the date the BLOB was last updated
    --             If used, the HTTP header of the file download will indicate the date of last modification and
    --                browsers will be able to cache the BLOB.  If not specified, the browser may not be able to cache files.
    --             Optional and case sensitive
    -- position 9: Name of the character set that is used to store the character set of the file in the BLOB column
    --             Most useful for applications that have files in multiple character sets
    --             Optional and case sensitive
    --             Not used for IMAGE format but left in so format can easily be changed between IMAGE and DOWNLOAD
    -- position 10: For DOWNLOAD format masks, identifies the content disposition
    --             Defaults to inline
    --             Valid values are "inline" and "attachment"
    --             A value of inline will cause the browser to render the file inline if it can
    --             A value of attachment will prompt the user to download the file
    --             Optional, use lower case
    --             Not used for IMAGE format but left in so format can easily be changed between IMAGE and DOWNLOAD
    -- position 11: For DOWNLOAD format masks, identifies the text used to indicate a download link text
    --             Default to "Download"
    --             Translated into 10 languages
    --             Specify if you wish to over-ride the default text
    --             Standard APEX substitutions are performed
    --             Only used for DOWNLOAD format masks
    --             Optional
    --             For IMAGE, String used for the alt tag associated with the image
    --
    -- Example Report format masks:
    --
    -- DOWNLOAD:EMP:RESUME:EMPNO::MIMETYPE:FILENAME:RESUME_LAST_UPDATE
    -- DOWNLOAD:EMP:RESUME:EMPNO::MIMETYPE:FILENAME:RESUME_LAST_UPDATE:::Resume
    -- IMAGE:EMP:EMP_PHOTO:EMPNO::MIMETYPE::PHOTO_LAST_UPDATE:::Employee Photo
    --
    s                 in number,                -- session id
    a                 in number,                -- application id
    c                 in number,                -- id of the report column
    p                 in number,                -- page
    k1                in varchar2,              -- primary key 1 value
    ck                in varchar2,              -- checksum
    rt                in varchar2 default 'IR', -- optional report type IR (interactive repors) or CR (classic reports)
    k2                in varchar2 default null, -- optional, primary key 2 value
    lm                in varchar2 default 'Y'   -- optional, show last modified
    );



----------------------
-- Interactive Reports
--
-- Procedures to provide programatic control over interactive reports
--

procedure ir_filter (
    -- Used to control Interactive Report filters
    -- Given an APEX page sets a report filter
    -- Useful if you want to define report filters declaratively
    --
    -- Valid values for p_operator_abbr
    -- EQ = Equals
    -- LT = Less than
    -- LTE = Less then or equal to
    -- GT = Greater Than
    -- GTE = Greater than or equal to
    -- LIKE = SQL Like operator
    -- N = Null
    -- NN = Not Null
    --
    -- Filter values are bound into Report SQL
    --
    -- Example:
    --    apex_util.ir_filter(p_page_id=>1,p_report_column=>'DEPTNO',p_operator_abbr=>'EQ',p_filter_value=>'10');
    --
    p_page_id       in number,                -- Page of the current APEX application that contains an Interactive Report
    p_report_column in varchar2,              -- Name of the report SQL column (or column alias) to be filtered
    p_operator_abbr in varchar2 default null, -- Filter type, Valid values are 'EQ' , 'LT', 'LTE', 'GT', 'GTE', 'LIKE', 'N', 'NN'
    p_filter_value  in varchar2);             -- Value of filter, not used for N and NN

procedure ir_reset (
    -- Resets an interactive report for current user session and application
    -- Same as a user reseting via the pull down menu
    -- Resetting will re-create default filter, control breaks, display columns etc
    --
    p_page_id      in number);  -- valid page number within current application

procedure ir_clear (
    -- Clears an interactive report for current user session and application
    -- Clears filters for an interactive report
    -- Clears any report filters including default filters
    -- Clears all interactive reports for a given application page
    --
    p_page_id      in number); -- valid page number within current application



---------------
-- Format Masks
--
-- Used by interactive and classic reports to provide additional format masks

function filesize_mask (
    -- Takes a file size in bytes and returns a rounded off size with trailing KB, MB, GB, or TB
    -- Provides a more readable file size
    -- Use FILESIZE format mask on numeric columns from within Classic and Interactive Reports
    -- Null values will return null
    -- KB, MB, GB, and TB are always english language strings
    --
    -- Example report format masks for interactive and classic reports
    --     "FILESIZE"
    --
    -- Example SQL query syntax
    --     "select apex_util.filesize_mask(8675309) from dual"
    --
    p_number       in number default null)
    return varchar2
    ;

function html_pct_graph_mask (
    -- Given a number between 0 and 100, a HTML graph
    -- The width of the HTML graph will devault to 100 px in width
    -- Number outside the range 0 to 100 will result in a null return
    -- Used by classic and interactive reports with format mask of GRAPH
    -- Generates a div tag with inline styles
    -- If p_format argument is supplied, p_size, p_background, p_bar_background are ignored
    --
    -- Report column mask syntax PCT_GRAPH:<BACKGROUND>:<FOREGROUND>:<CHART_WIDTH>
    -- position 1: PCT_GRAPH format mask indicator
    -- position 2: Background color in hex, 6 characters
    --             Optional
    -- position 3: Foreground "bar" color in hex, 6 characters
    --             Optionsl
    -- position 4: Chart width in Pixels
    --             Numeric, defaults to 100
    --             p_number is automatically scaled, so 50 would be half chart_width
    --             Optional
    --
    -- SQL Example:
    --    select apex_util.html_pct_graph_mask(33) from dual
    --
    -- Report Numeric Column Format Mask Example:
    --    PCT_GRAPH:777777:111111:200
    --
    p_number         in number   default null, -- Number between 0 and 100
    p_size           in number   default 100,  -- Width of graph in pixels
    p_background     in varchar2 default null, -- 6 character hex color of chart background (not bar color)
    p_bar_background in varchar2 default null, -- 6 character hex color of chart bar (bar color)
    p_format         in varchar2 default null) -- PCT_GRAPH:<BACKGROUND>:<FOREGROUND>:<CHART_WIDTH>
    return varchar2
    ;



----------------------
-- Password Checking
--

procedure strong_password_check(
    p_username                    in  varchar2,
    p_password                    in  varchar2,
    p_old_password                in  varchar2,
    p_workspace_name              in  varchar2,
    p_use_strong_rules            in  boolean,
    p_min_length_err              out boolean,
    p_new_differs_by_err          out boolean,
    p_one_alpha_err               out boolean,
    p_one_numeric_err             out boolean,
    p_one_punctuation_err         out boolean,
    p_one_upper_err               out boolean,
    p_one_lower_err               out boolean,
    p_not_like_username_err       out boolean,
    p_not_like_workspace_name_err out boolean,
    p_not_like_words_err          out boolean,
    p_not_reusable_err            out boolean
    )
    ;

function strong_password_validation(
    p_username         in varchar2,
    p_password         in varchar2,
    p_old_password     in varchar2 default null,
    p_workspace_name   in varchar2,
    p_use_strong_rules in boolean default false)
    return varchar2
    ;

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

-- --------------------------------------------
procedure set_session_lifetime_seconds(
    p_seconds in number,
    p_scope   in varchar2 default 'SESSION')
    ;

procedure set_session_max_idle_seconds(
    p_seconds  in number,
    p_scope    in varchar2 default 'SESSION')
    ;

end htmldb_util;
/