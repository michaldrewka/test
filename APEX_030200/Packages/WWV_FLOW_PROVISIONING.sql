CREATE OR REPLACE package wwv_flow_provisioning
as
--  Copyright (c) Oracle Corporation 1999. All Rights Reserved.
--
--    DESCRIPTION
--      This package provides provisioning and account management services.
--
--    SECURITY
--      Only available to the internal super user
--
--    NOTES
--      Oracle platform requires the following for a properly provisioned env.
--
--
--                                  +----------------------+                    +--------------------------+
--                                  |                      | pcid         sgid /|                          |
--                                  |                      |--------------------| wwv_flow_company_schemas |
--                             pcid |  wwv_flow_companies  | pcid              \|                          |
--                      +-----------|                      |------+             +--------------------------+
--                      |           |                      |      |                 | schema
--                      |           +----------------------+      |                 |
--                      |                                         |                 |
--                      |                                         |                 |
--                sgid /|\                                       /|\sgid           /|\ schema
--          +----------------------+                 +----------------------+  +-----------+
--          |                      |                 |                      |  |           |
--          | wwv_flow_developers  |                 | wwv_flow_fnd_user    |  | wwv_flows |
--          |     (privs)          |                 | or wwv_flow_db_auth  |  |           |
--          |                      |                 |       (users)        |  |           |
--          +----------------------+                 +----------------------+  +-----------+
--

------------------------------------
-- U T I L I T Y   F U N C T I O N S
--

procedure create_flow_super_user (
    p_user_id in number,
    p_user_adminid in varchar2,
    p_security_group_id in number)
    ;

procedure create_cookie_based_user (
    p_provision_id in number,
    p_password     in varchar2)
    ;

function site_admin_is_restricted
    return boolean
    ;

function site_admin_is_restricted_i
    return integer
    ;

function restricted_schema(
    p_schema         in varchar2,
    p_workspace_name in varchar2)
    return boolean
    ;

function restricted_schema_i(
    p_schema         in varchar2,
    p_workspace_name in varchar2)
    return integer
    ;

function reserved_schema(
    p_schema in varchar2)
    return boolean
    ;

function reserved_schema_i(
    p_schema in varchar2)
    return integer
    ;

function validate_schema_name(
    p_schema         in varchar2,
    p_workspace_name in varchar2)
    return varchar2
    ;

function total_service_requests
    return number
    ;

function total_open_service_requests
    return number
    ;

function total_change_requests
    return number
    ;

function total_open_change_requests
    return number
    ;


-----------------------------
-- D E M O   R E Q U E S T S
--

procedure install_demo_tables(
    p_security_group_id in number,
    p_schema            in varchar2 default null)
    ;

procedure remove_demo_tables(
    p_security_group_id in varchar2,
    p_schema            in varchar2 default null)
    ;



----------------------------------------------
-- A U T O   P R O V I S I O N   C O M P A N Y
--
procedure auto_provision_company (
    p_company_name              in varchar2 default null,
    p_schema_name               in varchar2 default null,
    p_schema_password           in varchar2 default null,
    p_database_size             in varchar2 default 'SMALL',
    p_admin_userid              in varchar2 default null,
    p_admin_password            in varchar2 default null,
    p_admin_first_name          in varchar2 default null,
    p_admin_last_name           in varchar2 default null,
    p_admin_title               in varchar2 default null,
    p_admin_email               in varchar2 default null,
    p_project_description       in varchar2 default null,
    p_security_group_id         in varchar2 default null);


----------------------------
-- M A K E   R E Q U E S T S
--
procedure make_request (
    p_COMPANY_NAME              in varchar2 default null,
    p_ADMIN_FIRST_NAME          in varchar2 default null,
    p_ADMIN_LAST_NAME           in varchar2 default null,
    p_ADMIN_TITLE               in varchar2 default null,
    p_ADMIN_EMAIL               in varchar2 default null,
    p_ADMIN_PHONE               in varchar2 default null,
    p_ADMIN_USERID              in varchar2 default null,
    p_COMPANY_ADDRESS           in varchar2 default null,
    p_CITY                      in varchar2 default null,
    p_STATE                     in varchar2 default null,
    p_ZIP                       in varchar2 default null,
    p_COUNTRY                   in varchar2 default null,
    p_COMPANY_TYPE              in varchar2 default null,
    p_COMPANY_WEB_SITE          in varchar2 default null,
    p_NUMBER_OF_EMPLOYEES       in varchar2 default null,
    p_COMPANY_PHONE             in varchar2 default null,
    p_COMPANY_FAX               in varchar2 default null,
    p_ORACLE_PARTNER            in varchar2 default null,
    p_HOW_DID_YOU_HEAR_ABOUT_US in varchar2 default null,
    p_SERVICE_USE_STATUS        in varchar2 default null,
    p_DATABASE_SIZE             in varchar2 default null,
    p_SERVICE_START_DATE        in varchar2 default null,
    p_SERVICE_TERMINATION_DATE  in varchar2 default null,
    p_SCHEMA_NAME               in varchar2 default null,
    p_ESTIMATED_END_USERS       in varchar2 default null,
    p_PAGE_VIEWS_PER_DAY        in varchar2 default null,
    p_project_description       in varchar2 default null,
    p_project_justification     in varchar2 default null,
    p_security_group_id         in varchar2 default null);

-----------------------------------------
-- P R E   P R O C E S S   R E Q U E S T
--
procedure pre_process_request (
    p_id                        in number)
    ;


------------------------------------
-- P R O V I S I O N   R E Q U E S T
--
procedure provision_request (
    p_id                        in number,
    p_password                  in varchar2,
    p_admin_password            in varchar2)
    ;

------------------------------------
-- A C C E P T   R E Q U E S T
--
procedure accept_request (
    p_id                        in number)
    ;


-----------------------------------------------------
-- P R O V I S I O N   A C C E P T E D  R E Q U E S T
--
procedure provision_accept_request (
    p_id                        in number,
    email_id                    in varchar2,
    p_password                  in varchar2,
    p_admin_password            in varchar2)
    ;


-------------------------------------------------
-- D E L E T E  A C C E P T E D   R E Q U E S T
--
procedure delete_accepted_request (
    p_id  in number)
    ;


------------------------------------
-- D E N Y   R E Q U E S T
--
procedure deny_request (
    p_id                        in number)
    ;

------------------------------------
-- T E R M I N A T E   S E R V I C E
--
procedure terminate_service (
    p_id                        in number)
    ;
procedure terminate_service_by_sgid (
    p_security_group_id  in number,
    p_drop_users         in varchar2 default 'N',
    p_drop_tablespaces   in varchar2 default 'N')
    ;

-------------------------------------------------
-- D E L E T E  P R O V I S I O N   R E Q U E S T
--
procedure delete_provision_request (
    p_id  in number)
    ;


----------------------------------------------------
-- M A K E   M O D I F I C A T I O N   R E Q U E S T
--
procedure make_modification_request (
    p_security_group_id     in number   default wwv_flow_security.g_security_group_id,
    p_service_name          in varchar2,
    p_service_attribute_1   in varchar2 default null,
    p_service_attribute_2   in varchar2 default null,
    p_service_attribute_3   in varchar2 default null,
    p_service_attribute_4   in varchar2 default null,
    p_service_attribute_5   in varchar2 default null,
    p_service_attribute_6   in varchar2 default null,
    p_service_attribute_7   in varchar2 default null,
    p_service_attribute_8   in varchar2 default null)
    ;

procedure reject_modification_request (
    p_request_id in number)
    ;


procedure delete_modification_request (
    p_request_id in number)
    ;

-------------------------------------
-- S C H E M A   M O D I F I C A T I O N S
--
-- p_security_group_id = identifies company
-- p_schema_name       = identifies the new schema to be created
-- p_db_size           = megabytes
--

procedure add_schema_by_request (
    p_request_id      in number,
    p_use_existing    in boolean default false)
    ;

procedure add_schema (
    p_request_id            in number,
    p_security_group_id     in number,
    p_schema_name           in varchar2,
    p_default_ts            in varchar2,
    p_temporary_ts          in varchar2,
    p_use_existing          in boolean default false)
    ;

procedure remove_schema (
    p_security_group_id     in number,
    p_schema_name           in varchar2)
    ;

procedure remove_schema_by_request (
    p_request_id               in number)
    ;

procedure provision_storage_by_request (
    p_request_id      in number)
    ;

function reset_password (
    p_company                  in varchar2,
    p_username                 in varchar2,
    p_size                     in number default 6)
    return varchar2
    ;

function reset_schema_password (
    p_schema                   in varchar2,
    p_size                     in number default 6)
    return varchar2
    ;

--
-- For a given security_group_id, return a delimited list of workspace schemas
--
function get_schemas_by_sgid (
    p_security_group_id in number,
    p_separator         in varchar2 default null )
    return varchar2
    ;
--
-- For a given security_group_id, return a delimited list of default tablespaces
-- associated with the workspace schemas
--
function get_tablespaces_by_sgid (
    p_security_group_id in number,
    p_separator         in varchar2 default null )
    return varchar2
    ;


end wwv_flow_provisioning;
/