CREATE OR REPLACE package wwv_flow_custom_auth_ldap
as
--  Copyright (c) Oracle Corporation 2001-2002. All Rights Reserved.
--
--     DESCRIPTION
--       API package to expose ldap authentication function
--
--    SECURITY
--       Executable by owner
--
--    NOTES
--
--    EXAMPLE
--
--

function authenticate(
    --
    -- Context: any
    -- Purpose: authenicate against ldap directory
    --
    p_dn                 in varchar2,
    p_password           in varchar2,
    p_ldap_host          in varchar2,
    p_ldap_port          in number)
    return boolean
    ;

end wwv_flow_custom_auth_ldap;
/