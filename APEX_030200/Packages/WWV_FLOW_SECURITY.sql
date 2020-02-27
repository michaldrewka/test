CREATE OR REPLACE package wwv_flow_security
as

-- Copyright (c) Oracle Corporation 2001 - 2007. All Rights Reserved.
--
--    DESCRIPTION
--      Security and authentication services
--
--    SECURITY
--      This package is only accessable to the owner of Oracle Application Express
--      This package contains globals that control parsing and company (aka workspace)
--      identification.
--      g_parse_as_schema   = schema to parse SQL as
--      g_security_group_id = identifies the workspace of the current user (provides VPD)
--
--    NOTES
--      Package Body should be wraped
--
--    MULTI-CUSTOMER
--      This package facilitates multi customer (virual private database) support
--
--


g_custom_auth_attempts         number         := 0;
g_custom_authentication_page   number         := null;
g_custom_auth_passed           boolean        := false;
g_custom_auth_login_page       boolean        := false;
g_custom_auth_setups           boolean        := false;
g_sso_session_registration     boolean        := false;
g_custom_page_sentry_function  varchar2(4000) := null;
g_custom_sess_verify_function  varchar2(4000) := null;
g_custom_invalid_session_url   varchar2(4000) := null;
g_custom_login_page_default    varchar2(255)  := 'wwv_flow_custom_auth_std.login_page?p_flow_page=';
g_custom_cookie_name_default   varchar2(255)  := 'WWV_CUSTOM-F';
g_authenticated                boolean        := false;
g_notification_checksum        boolean        := true;
g_success_message_checksum     boolean        := true;
g_internal_app_checksum        boolean        := true;
g_user                         varchar2(255)  := null;
g_flow_id                      number         := null;
g_instance                     number         := null;
g_translated_flow_id           number         := null;
g_import_in_progress           boolean        := false;
g_page_request                 boolean        := false;
g_context                      varchar2(60)   := 'NULL';   -- mike security

--
-- This constant may be any length >= 16.
--
g_element             CONSTANT varchar2(32)   := '~'||
                                                 '!'||
                                                 '+'||
                                                 '#'||
                                                 '$'||
                                                 '%'||
                                                 '^'||
                                                 '&'||
                                                 '*'||
                                                 '('||
                                                 ')'||
                                                 '_'||
                                                 '@'||
                                                 '='||
                                                 '-'||
                                                 '`'||
                                                 '{'||
                                                 '}'||
                                                 '|'||
                                                 '\'||
                                                 ']'||
                                                 '['||
                                                 '?'||
                                                 ':'||
                                                 ';'||
                                                 '<'||
                                                 '>'||
                                                 '"'||
                                                 '/'||
                                                 '.'||
                                                 '8'||
                                                 ',';
--
g_crypto_salt                  raw(32);
g_raw7                         raw(7);
g_raw16                        raw(16);
g_raw32                        raw(32);
g_raw64                        raw(64);
g_raw32767                     raw(32767);
g_num                          number;
-------------------------------
-- the current users company ID
--
g_security_group_id            number := 0;


--------------------------------------------------------------------
-- the Oracle Schema whos rights and privs will be used to parse SQL
--
g_parse_as_schema              varchar2(255) := null;  -- owner of the application, use this owner to parse SQL


---------------------------------------------------
-- to avoid parsing as the flows schema supper user
g_parse_as_schema_override     varchar2(255) := null;  -- for app builder set this global to avoid parsing as flows schema

-----------------------------------------------------
-- the security group id (aka company id) of the flow
--
g_curr_flow_security_group_id  number := null;

--
-- URL Tampering Prevention
--
g_page_protection_enabled       boolean := false;
g_page_protection_level         varchar2(1) := null;
g_page_checksum_type            varchar2(1) := null;
g_page_checksum                 varchar2(255) := null;
g_application_checksum_salt     raw(255);
g_direct_branch                 boolean := false;

--
-- constants and variables to support fnd account access
--
g_internal_authentication  boolean;
AUTH_NORMAL                constant pls_integer := 0;
AUTH_UNKNOWN_USER          constant pls_integer := 1;
AUTH_ACCOUNT_LOCKED        constant pls_integer := 2;
AUTH_ACCOUNT_EXPIRED       constant pls_integer := 3;
AUTH_PASSWORD_MISMATCH     constant pls_integer := 4;
AUTH_PASSWORD_FIRST_USE    constant pls_integer := 5;
AUTH_PWD_ATTEMPTS_EXCEEDED constant pls_integer := 6;
AUTH_INTERNAL_ERROR        constant pls_integer := 7;
AUTH_UNKNOWN_WORKSPACE     constant pls_integer := 8;


g_authenticate_user_action     boolean;        -- set when wwv_flow_security.authenticate is executing
g_authentication_result        number;         -- coded result of wwv_flow_security.authenticate
g_custom_authentication_status varchar2(4000); -- may be set by author of custom authentication function using api

--------------------------------------------------
-- Translate company name to the security group id
--
function find_security_group_id (
     p_company  in varchar2 default null)
     return number
     ;

function find_first_schema (
     p_security_group_id in number)
     return varchar2
     ;

function find_company_name (
     p_security_group_id in number)
     return varchar2
     ;

function check_db_password (
    p_user_name in varchar2,
    p_password  in varchar2)
    return boolean
    ;

function check_db_password (
    p_username in varchar2,
    p_password  in varchar2)
    return varchar2
    ;

function authenticate (
    p_user_name in varchar2 default null,
    p_password  in varchar2 default null,
    p_company   in varchar2 default null)
    return boolean
    ;

--
--
--
procedure cookie_auth_logout (
    p_cookie    in varchar2 default null)
    ;


-------------------------------------------------
-- E N C R Y P T I O N
--
function encrypt (
    p_str   in varchar2 default null)
    return varchar2
    ;


function decrypt (
    p_str    in varchar2 default null)
    return varchar2
    ;


-------------------------------------------------
-- C O O K I E
--

procedure get_asfcookie
    ;

procedure show_cookie (
    p_cookie            in varchar2 default null,
    p_value             in varchar2 default null,
    p_meta_redirect_url in varchar2 default null,
    p_message           in varchar2 default null,
    p_username          in varchar2 default null,
    p_password          in varchar2 default null,
    p_company           in varchar2 default null,
    p_encrypt           in boolean  default true,
    p_session           in number   default null)
    ;


procedure run_flow (
    --
    --
    --
    p_authentication_method in varchar2 default null,
    p_run_company           in varchar2 default null,
    p_run_flow              in number   default null,
    p_run_page              in number   default null,
    p_credentials_company   in varchar2 default null,
    p_credentials_un        in varchar2 default null,
    p_credentials_pw        in varchar2 default null,
    p_session               in number   default null)
    ;

function  check_instance_owner (
    --
    --
    --
    p_instance in number,
    p_method   in varchar2 default 'DATABASE')
    return boolean
    ;


function determine_cookie_auth_user
    --
    --
    --
    return varchar2
    ;

function cookie_user
    --
    --
    --
    return varchar2
    ;

function cookie_session
    --
    --
    --
    return number
    ;

procedure create_new_session (
   p_id                in number,
   p_username          in varchar2)
   ;

procedure remove_session (
   --
   -- Deletes a session which will cascade to delete all session state
   --
   p_session_id        in number)
   ;


-----------------------------------
-- C U S T O M    A U T H
--
procedure exec_custom_auth
    ;

procedure exec_custom2_auth
    ;

procedure exec_custom_auth_setups(
    p_setup_id in varchar2)
    ;


------------------------------
-- P L A T F O R M   P R I V S
--
function flow_owner (
    p_flow_id             in number,
    p_security_group_id   in number)
    return varchar2
    ;

function user_is_internal
   --
   return boolean
   ;

function user_can_develop_flow (
   --
   p_flow_id in number)
   return boolean
   ;

function current_company_can_build (
    --
    p_in_schema in varchar2)
    return boolean
    ;

function current_company_can_parse (
    --
    p_in_schema in varchar2)
    return boolean
    ;

function get_security_group_id (
    p_provisioned_schema in varchar2)
    return number
    ;

function user_can_develop_any_flow
    return boolean
    ;

function user_can_develop_current_flow
    return boolean
    ;


--------------------------------------
-- C O O K I E    U S E R    A D M I N
--
-- user_id           = physical pk of wwv_flow_fnd_user row
--                     trigger will set if needed
-- user_name*        = upper case version of login user name
-- security_group_id*= company ID
-- first_name        = info only
-- last_name         = info only
-- description       = info only
-- email_address     = info only
-- web_password      = case sensitive password used to login
--
-- + logical pk is security_group_id, user_name physical pk is user_id
-- * indicates argument is required
--
function get_fnd_user_id (
    --
    p_security_group_id  in number,
    p_user_name          in varchar2)
    return number
    ;

procedure create_fnd_user (
    --
    -- Create a new user in the wwv_flow_fnd_user table.
    --
    p_user_id            in number default null,
    p_security_group_id  in number,
    p_user_name          in varchar2,
    p_first_name         in varchar2 default null,
    p_last_name          in varchar2 default null,
    p_description        in varchar2 default null,
    p_email_address      in varchar2 default null,
    p_web_password       in varchar2 default null)
    ;

procedure remove_fnd_user (
    --
    --
    --
    p_user_id            in number default null)
    ;

procedure update_fnd_user (
    --
    --
    --
    p_user_id            in number default null,
    p_security_group_id  in number,
    p_user_name          in varchar2,
    p_first_name         in varchar2 default null,
    p_last_name          in varchar2 default null,
    p_description        in varchar2 default null,
    p_email_address      in varchar2 default null,
    p_web_password       in varchar2 default null)
    ;

------------------------------
-- H A S H  S E S S I O N  I D
--
function hash_session_id
    return varchar2
    ;

------------------------------------------
-- G E T   H A S H E D  S E S S I O N  I D
--
function get_hashed_session_id
    return varchar2
    ;

------------------------------------------
-- I N T E R N A L  P A G E  S E N T R Y
--
function internal_page_sentry
    return boolean
    ;
---------------------------------------------------------
-- U S E R  A U T H E N T I C A T E D  T O  B U I L D E R
--
function user_builder_session_company
    return number
    ;
-------------------------------------------------------
-- S E S S I O N  C O O K I E  I N F O  I N T E R N A L
--
--
procedure session_cookie_info_internal(
    p_user    out varchar2,
    p_session out number,
    p_sgid    out number)
    ;

---------------------------------------------------
-- V E R I F Y  N O T I F Y  M S G  C H E C K S U M
--
-- Verify notification message checksum
--
function verify_notify_msg_checksum
    return boolean
    ;

-------------------------------------------------
-- V E R I F Y  P R I N T  M S G  C H E C K S U M
--
-- Verify print success message checksum
--
function verify_print_msg_checksum
    return boolean
    ;

-------------------------------------------
-- A U T H E N T I C A T E D  S E S S I O N
--
function authenticated_session(
    p_flow_id           in number,
    p_security_group_id in number,
    p_session_id        in number default null)
    return boolean
    ;

-----------------
-- I P  C H E C K
--
-- Checks if page access is from a REMOTE_ADDR IP address
-- that is in the "allow list" represented by the
-- RESTRICT_IP_RANGE preference setting adjustable in the site
-- admin pages for environment preferences.
--
function ip_check
    return boolean
    ;

--------------------------------------
-- D I S A B L E  A D M I N  L O G I N
--
-- The DISABLE_ADMIN_LOGIN preference setting
-- can be created and set to YES using the site
-- admin page for environment preferences. If this
-- preference is YES, this function will return true.
--
function disable_admin_login
    return boolean
    ;

--------------------------------------
-- D I S A B L E  W O R K S P A C E  L O G I N
--
-- The DISABLE_WORKSPACE_LOGIN preference setting
-- can be created and set to YES using the site
-- admin page for environment preferences. If this
-- preference is YES, this function will return true.
--
function disable_workspace_login
    return boolean
    ;

procedure reset_app_checksum_salt(
    p_flow_id in varchar2)
    ;

function encode_key(
    p_key in number)
    return number
    ;

function decode_key(
    p_key in number)
    return number
    ;

function crypto_mac_md5(
    p_str in raw,
    p_key in raw)
    return raw
    ;

function crypto_randomnumber
    return number
    ;

function crypto_randombytes(
    p_numbytes in pls_integer)
    return raw
    ;

function crypto_randombytes
    return raw
    ;

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
    p_not_reusable_err            out boolean)
    ;

function strong_password_validation(
    p_username         in varchar2,
    p_password         in varchar2,
    p_old_password     in varchar2 default null,
    p_workspace_name   in varchar2,
    p_use_strong_rules in boolean default false)
    return varchar2
    ;

function get_expired_user_sgid
    return number
    ;

function get_expired_user_name
    return varchar2
    ;

procedure purge_expired_user_header(
    p_session in number default wwv_flow.g_instance)
    ;

function encrypt_wallet_pwd(
    p_wallet_pwd in varchar2
    ) return varchar2;

function decrytp_wallet_pwd(
   p_wallet_pwd in varchar2
   ) return varchar2;

function get_translated_flow_id
    return number
    ;

function get_flow_id
    return number
    ;

function prep_url(
    p_url       in varchar2
    ) return varchar2;

procedure set_session_lifetime_seconds(
    p_seconds in number,
    p_scope   in varchar2 default 'SESSION')
    ;

procedure set_session_max_idle_seconds(
    p_seconds  in number,
    p_scope    in varchar2 default 'SESSION')
    ;

function encrypt_session_value (
    p_unencrypted_value    in varchar2 default null)
    return varchar2
    ;

function decrypt_session_value (
    p_encrypted_value      in varchar2 default null)
    return varchar2
    ;

end wwv_flow_security;
/