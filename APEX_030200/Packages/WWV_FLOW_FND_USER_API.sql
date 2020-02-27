CREATE OR REPLACE package wwv_flow_fnd_user_api
as
    g_mime_shown                  boolean := false;
    g_password_save               raw(255);

--  Copyright (c) Oracle Corporation 2001. All Rights Reserved.
--
--    NAME
--      wwv_flow_fnd_user_api.sql
--
--    DESCRIPTION
--      API to manage cookie based users.
--
--    NOTES
--
--    INTERNATIONALIZATION
--      No known issues
--
--    MULTI-CUSTOMER
--      Requires that wwv_flow_security.g_security_group_id be properly set.

procedure export_fnd_users (
    -- Description:
    --    This procedure exports all users in a the current company, designed
    --    to be called from the flows html development environment.
    --
    p_export_format in varchar2 default 'UNIX')
    ;

procedure create_company (
    -- Description:
    --    This procedure creates a company description.
    --    Without a company user and flows can not be
    --    creatd.
    --
    -- Arguments:
    --    p_id                      = unique ID which identifies a company row, not referenced by other tables
    --    p_provisioning_company_id = security_group_id column is a foreign key to this column.  The
    --                                security_group_id column is used by all tables that store data that is
    --                                specific to a given company.
    --    p_short_name              = name of the company used to login
    --    p_first_schema_provisioned= is used to indicate the first schema created. This is necessary to
    --                                determine things like what is the default tablespace for this company
    --    p_company_schemas         = colon delimited list of schemas that this company can "parse as".
    --
    --
    p_id                          in number,
    p_provisioning_company_id     in number,
    p_short_name                  in varchar2,
    p_first_schema_provisioned    in varchar2,
    p_company_schemas             in varchar2,
    p_expire_fnd_user_accounts    in varchar2 default null,
    p_account_lifetime_days       in number default null,
    p_fnd_user_max_login_failures in number default null)
    ;

procedure create_user_group (
    -- Description:
    --    This procedure allows for programatic and bulk creation of users.
    --
    -- Arguments:
    --    p_ID                = unique identifier of the group, typically a large virtually globally unique number.
    --    p_group_name        = name of group
    --    p_security_group_id = identifies which company this user group belongs to
    --    p_group_desc        = text description used as an note to the developer
    --
    p_id                      in number,
    p_group_name              in varchar2,
    p_security_group_id       in number,
    p_group_desc              in varchar2)
    ;

procedure create_fnd_user (
    -- Description:
    --    This procedure allows for programatic and bulk creation of users.
    --
    -- Example:
    --    From sqlplus logged in as the privileged flows user, first
    --    ensure that the security group id is set properly, then create
    --    your users.
    --
    --    begin wwv_flow_security.g_security_group_id := 20; end;
    --    /
    --
    --    begin
    --       for i in 1..10 loop
    --          wwv_flow_fnd_user_api.create_fnd_user(
    --             p_user_name => 'USER_'||i,
    --             p_email_address => 'user_'||i||'@mycompany.com',
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
    --                      creating flows
    --    p_allow_access_to_schemas A colon delimited list of oracle schemas that the user is allowed to
    --                      parse as.  If null the user can parse as any schema available to the company.
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

procedure remove_fnd_user (
    -- Description
    --   This procedure allows for programatic removal of users.
    --   This procedure is overloaded.
    --
    p_user_id         in number)
    ;

procedure remove_fnd_user (
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
    -- This procedure changes the current users password.
    --
    p_new_password    in varchar2)
    ;

procedure reset_pw (
    --
    -- This procedure resets the current users password.
    --
    p_user                  in varchar2,
    p_security_group_id     in varchar2,
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
    -- for the specified user in the current company
    --
    p_username              in varchar2)
    return varchar2
    ;

function find_security_group_id (
     --
     -- given a company short name return the security group id
     -- p_company = short name of company
     --
     p_company  in varchar2 default null)
     return number;


function find_company (
     --
     -- given a security_group_id, return the company short name
     -- p_company = short name of company
     --
     p_security_group_id  in varchar2 default null)
     return varchar2;

procedure fetch_fnd_user (
     --
     -- Fetch user information from
     -- wwv_flow_fnd_user, wwv_flow_fnd_group_users and wwv_flow_developers table.
     -- This procedure is overloaded.
     --
     p_user_id       in number,
     p_company       out varchar2,
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

procedure fetch_fnd_user (
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

procedure fetch_fnd_user (
     --
     -- Fetch user information from
     -- wwv_flow_fnd_user, wwv_flow_fnd_group_users and wwv_flow_developers table.
     -- This procedure is overloaded.
     --
     p_user_id                      in number,
     p_company                      out varchar2,
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

procedure edit_fnd_user (
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

function get_authentication_result
    return number
    ;

function change_password_on_first_use(
    p_user_name in varchar2
    ) return boolean
    ;

function password_first_use_occurred(
    p_user_name in varchar2
    ) return boolean
    ;

end wwv_flow_fnd_user_api;
/