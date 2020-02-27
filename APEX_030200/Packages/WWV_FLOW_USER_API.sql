CREATE OR REPLACE package wwv_flow_user_api as

--  Copyright (c) Oracle Corporation 2001. All Rights Reserved.
--
--    DESCRIPTION
--      API access to oracle platform user management system.
--      Provides user group functionality.
--      Provides userid to username, username to userid, etc translations.
--
--    SECURITY
--      Publicly executable.
--
--    NOTES
--      This package provides read access to user information for use with flow cookie
--      based flow authentication (e.g. the user repository which ships with flows).
--      If your flow is not using the wwv_flow_fnd_user table as the user repository then
--      this API will not work.
--
--      Results are restricted to current company therefore this API may not work from sqlplus.
--      This API is based on the wwv_flow_fnd_user table.
--
--      Use this API from within region, item, navbar... conditions from within the flow builder.
--
--    RUNTIME DEPLOYMENT: YES
--






--------------------------------
-- C H E C K   F U N C T I O N S
--

function current_user_in_group (
   --
   -- Given a group name return a boolean true or false if the current
   -- flow user is part of that group.
   -- Example: if wwv_flow_user_api.current_user_in_group('MY_GROUP') then ...
   --
   p_group_name          in varchar2 )
   return boolean
   ;


function current_user_in_group (
   --
   -- Given a group numeric identifier return a boolean true or false if the current
   -- flow user is part of that group.
   -- Example: if wwv_flow_user_api.current_user_in_group(1234567) then ...
   -- The above example assumes that 1234567 is a valid group ID.
   --
   p_group_id            in number)
   return boolean
   ;

function is_login_password_valid (
   --
   -- Checks the wwv_flow_fnd_users table to see if
   -- username/password combo is valid within a company (checking by security_group_id)
   --
   p_username in varchar2 default null,
   p_password  in varchar2 default null)
   return boolean
   ;

function is_username_unique (
   --
   -- Simply checks wwv_flow_fnd_users table to see if
   -- username is unique within a company (checking by security_group_id)
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
   -- Example: ... wwv_flow_user_api.get_group_name('MY_GROUP') ...
   --
   p_group_name          in varchar2 )
   return number
   ;


function get_group_name (
   --
   -- Given a group ID return the aphanumeric name.
   -- Example: ... wwv_flow_user_api.get_group_name(1234567) ...
   --
   p_group_id            in varchar2 )
   return varchar2
   ;


function get_group_name (
   --
   -- Added overloaded version with correct number type for p_group_id.
   -- Given a group ID return the aphanumeric name.
   -- Example: ... wwv_flow_user_api.get_group_name(1234567) ...
   --
   p_group_id            in number )
   return varchar2
   ;


function get_email (
   --
   -- For a given user return the identified email addresswwv_flow_user_api.  Only works
   -- with flows standard user management system.  If you use flows with
   -- other user repositories this API will not return useful information.
   -- Example:  ... wwv_flow_user_api.get_email('MHICHWA')
   -- The example above assumes a username MHICHWA exists.
   --
   p_username            in varchar2)
   return varchar2
   ;


function get_first_name (
   --
   -- For a given user return the identified first name.  Only works
   -- with flows standard user management system.  If you use flows with
   -- other user repositories this API will not return useful information.
   -- Example:  ... wwv_flow_user_api.get_first_name('MHICHWA')
   -- The example above assumes a username MHICHWA exists.
   --
   p_username            in varchar2)
   return varchar2
   ;


function get_last_name (
   --
   -- For a given user return the identified last name.  Only works
   -- with flows standard user management system.  If you use flows with
   -- other user repositories this API will not return useful information.
   -- Example:  ... wwv_flow_user_api.get_last_name('MHICHWA')
   -- The example above assumes a username MHICHWA exists.
   --
   p_username            in varchar2)
   return varchar2
   ;


function get_current_user_id
   --
   -- For the current user return the flows numeric identifier.  Only
   -- useful when useing flows user management system.
   --
   return number
   ;


function get_user_id (
   --
   -- Given a username return the numeric idenfier.
   -- Example: ... wwv_flow_user_api.get_user_id('MHICHWA')
   -- The example above assumes MHICHWA is a valid username.
   --
   p_username            in varchar2)
   return number
   ;


function get_username (
   --
   -- Given a user ID return the username.
   -- Example: ... wwv_flow_user_api.get_username(222222)
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
   -- Example: htp.p('user mhichwa is a member of the following groups: '||
   --                 wwv_flow_user_api.get_groups_user_belongs_to('MHICHWA'));
   --
   p_username            in varchar2)
   return varchar2
   ;

function get_default_schema
   --
   -- For the currently logged in user, return the schema that the company
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
   -- with flows standard user management system.  If you use flows with
   -- other user repositories this API will not set useful information.
   -- Example:  ... wwv_flow_user_api.set_email(222222,'MIKE@HOTMAIL.COM')
   -- The example above assumes a user ID 222222 exists.
   -- An error will be raised in the event this procedure fails.
   --
   p_userid              in number,
   p_email               in varchar2)
   ;


procedure set_first_name (
   --
   -- For a given user set the identified first name.  Only works
   -- with flows standard user management system.  If you use flows with
   -- other user repositories this API will not return useful information.
   -- Example:  ... wwv_flow_user_api.set_first_name(222222,'Mike')
   -- The example above assumes a user ID 222222 exists.
   -- An error will be raised in the event this procedure fails.
   --
   p_userid              in number,
   p_first_name          in varchar2)
   ;


procedure set_last_name (
   --
   -- For a given user set the identified last name.  Only works
   -- with flows standard user management system.  If you use flows with
   -- other user repositories this API will not return useful information.
   -- Example:  ... wwv_flow_user_api.set_last_name('MHICHWA')
   -- The example above assumes a username MHICHWA exists.
   -- An error will be raised in the event this procedure fails.
   --
   p_userid              in number,
   p_last_name           in varchar2)
   ;


procedure set_username (
   --
   -- Given a user ID set the username.
   -- Example: ... wwv_flow_user_api.set_username(222222,'JOE')
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
   -- Example: ... wwv_flow_user_api.set_attribute(22222,1,'likes sailing and tennis');
   --
   p_userid               in number,
   p_attribute_number     in number,
   p_attribute_value      in varchar2)
   ;


end wwv_flow_user_api;
/