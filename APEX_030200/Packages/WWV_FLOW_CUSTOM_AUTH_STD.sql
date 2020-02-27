CREATE OR REPLACE package wwv_flow_custom_auth_std
as
--  Copyright (c) Oracle Corporation 2001-2002. All Rights Reserved.
--
--     DESCRIPTION
--       API package for flow developers using custom authentication
--       setups.
--
--       These functions and procedures allow flow developers to
--       invoke built-in entry points to the flow engine's custom
--       authentication code path and to interrogate environmental
--       and table values related to custom authentication.
--
--       Some of these modules may be intended for use only within
--       the flow engine runtime context, and others may be
--       called from within any context, as the comments indicate.
--
--    SECURITY
--       Executable via public synonym and grant
--
--    NOTES
--
--    EXAMPLE
--
--

function get_username
    --
    -- Context: flows runtime
    -- Purpose: get username from wwv_flow_session$ for current session
    --
    return varchar2
    ;

function get_session_id_from_cookie
    --
    -- Context: flows runtime with cookie in cgi environment
    -- Purpose: get session id of current user based on cookie
    --
    return number
    ;

function is_session_valid
    --
    -- Context: flows runtime
    -- Purpose: determine if session exists and is valid
    --
    return boolean
    ;

procedure logout(
    --
    -- Context: Use as redirect URL from navbar logout item and similar places
    -- Purpose: determine cookie for given flow, unset cooie, then redirect to url
    --          if p_next_url is passed in, else redirect to flow page using
    --          p_next_flow_page_sess
    --
    p_this_flow           in varchar2 default null,
    p_next_flow_page_sess in varchar2 default null, -- assumed to be FLOW:PAGE:SESSION to redirect to
    p_next_url            in varchar2 default null, -- assumed to be full url to redirect to
    p_use_secure_cookie   in boolean default false)
    ;

procedure remove_session
    ;

procedure logout_then_go_to_page(
    --
    -- Context: Use as redirect URL from navbar logout item and similar places
    -- Purpose: wrapper for logout procedure when redirect to flow page is needed.
    --          Makes it easier to cram all the logout arguments into one for use in URLs
    --
    p_args in varchar2 default null) -- assumed to be THISFLOW:FLOW:PAGE:SESSION to redirect to
    ;

procedure logout_then_go_to_url(
    --
    -- Context: Use as redirect URL from navbar logout item and similar places
    -- Purpose: wrapper for logout procedure when redirect to free form url is needed.
    --          Makes it easier to cram all the logout arguments into one for use in URLs
    --
    p_args in varchar2 default null) -- assumed to be THISFLOW:URL to redirect to
    ;

procedure moc_logout_v1(
    --
    -- Context: Use as redirect URL from navbar logout item and similar places
    -- Purpose: determine cookie for given flow, unset cooie, then redirect to url
    --          if p_next_url is passed in, else redirect to flow page using
    --          p_next_flow_page_sess
    --
    p_this_flow           in varchar2 default null,
    p_next_flow_page_sess in varchar2 default null, -- assumed to be FLOW:PAGE:SESSION to redirect to
    p_next_url            in varchar2 default null) -- assumed to be full url to redirect to
    ;

procedure moc_logout_then_go_to_page_v1(
    --
    -- Context: Use as redirect URL from navbar logout item and similar places
    -- Purpose: wrapper for logout procedure when redirect to flow page is needed.
    --          Makes it easier to cram all the logout arguments into one for use in URLs
    --
    p_args in varchar2 default null) -- assumed to be THISFLOW:FLOW:PAGE:SESSION to redirect to
    ;

procedure moc_logout_then_go_to_url_v1(
    --
    -- Context: Use as redirect URL from navbar logout item and similar places
    -- Purpose: wrapper for logout procedure when redirect to free form url is needed.
    --          Makes it easier to cram all the logout arguments into one for use in URLs
    --
    p_args in varchar2 default null) -- assumed to be THISFLOW:URL to redirect to
    ;

function moc_page_sentry_v1 return boolean
    ;

function portal_sso_sentry_v0
    return boolean
    ;

function portal_sso_sentry_v1
    return boolean
    ;

procedure login(
    --
    -- Context: any
    -- Purpose: Do after login page submit processing
    --          starting at the pre-authentication step.
    --
    p_uname             in varchar2 default null,
    p_password          in varchar2 default null,
    p_session_id        in varchar2 default null,
    p_flow_page         in varchar2 default null,
    p_entry_point       in varchar2 default null,
    p_preserve_case     in boolean default false,
    p_use_secure_cookie in boolean default false)
    ;

procedure post_login(
    --
    -- Context: any
    -- Purpose: Do after login page submit processing
    --          starting at the post-authentication step.
    --
    p_uname             in varchar2 default null,
    p_password          in varchar2 default null,
    p_session_id        in varchar2 default null,
    p_flow_page         in varchar2 default null,
    p_preserve_case     in boolean default false,
    p_use_secure_cookie in boolean default false)
    ;

procedure login_page(
    --
    -- Context: any
    -- Purpose: show flow 4155:1000 builtin login page
    --
   p_flow_page  in varchar2 default null)
   ;

procedure get_cookie_props(
    --
    -- Context: any
    -- Purpose: get cookie properties for specified flow
    --
    p_flow in number,
    p_cookie_name   out varchar2,
    p_cookie_path   out varchar2,
    p_cookie_domain out varchar2,
    p_secure        out boolean)
    ;

procedure flowchart_perpage(
    p_id in number)
    ;

procedure flowchart_login(
    p_id in number)
    ;

function ldap_dnprep(
    p_username in varchar2)
   return varchar2
   ;

function ldap_authenticate(
    --
    -- Context: any
    -- Purpose: verify credentials using ldap directory
    --
    p_username           in varchar2,
    p_password           in varchar2,
    p_ldap_host          in varchar2,
    p_ldap_port          in number,
    p_ldap_string        in varchar2,
    p_ldap_edit_function in varchar2,
    p_owner              in varchar2)
    return boolean
    ;

procedure get_ldap_props(
    --
    -- Context: in application
    -- Purpose: get ldap config for current application's authentication scheme
    --
    p_ldap_host          out varchar2,
    p_ldap_port          out integer,
    p_ldap_dn            out varchar2,
    p_ldap_edit_function out varchar2)
    ;

procedure authentication_status (
    p_flow_id    in number default null,
    p_session_id in number default null)
    ;
end wwv_flow_custom_auth_std;
/