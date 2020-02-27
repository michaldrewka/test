CREATE OR REPLACE package wwv_flow_ldap
--  Copyright (c) Oracle Corporation 1999 - 2003. All Rights Reserved.
--
--    DESCRIPTION
--      Flow LDAP package
--
--    SECURITY
--
--    NOTES
--      This package contains functions and procedures used to
--      extract data from an LDAP server, such as OID.
--
as

    function authenticate(
        p_username     in varchar2 default null,
        p_password     in varchar2 default null,
        p_search_base  in varchar2,
        p_host         in varchar2,
        p_port         in varchar2 default 389)
        return boolean;

    function is_member(
        p_username     in varchar2,
        p_pass         in varchar2 default null,
        p_auth_base    in varchar2,
        p_host         in varchar2,
        p_port         in varchar2 default 389,
        p_group        in varchar2,
        p_group_base   in varchar2)
        return boolean;

    function member_of(
        p_username     in varchar2 default null,
        p_pass         in varchar2 default null,
        p_auth_base    in varchar2,
        p_host         in varchar2,
        p_port         in varchar2 default 389)
        return wwv_flow_global.vc_arr2;

    function member_of2(
        p_username     in varchar2 default null,
        p_pass         in varchar2 default null,
        p_auth_base    in varchar2,
        p_host         in varchar2,
        p_port         in varchar2 default 389)
        return varchar2;

    procedure get_user_attributes(
        p_username          in  varchar2 default null,
        p_pass              in  varchar2 default null,
        p_auth_base         in  varchar2,
        p_host              in  varchar2,
        p_port              in  varchar2 default 389,
        p_attributes        in  wwv_flow_global.vc_arr2,
        p_attribute_values  out wwv_flow_global.vc_arr2);

    procedure get_all_user_attributes(
        p_username          in  varchar2 default null,
        p_pass              in  varchar2 default null,
        p_auth_base         in  varchar2 default null,
        p_host              in  varchar2,
        p_port              in  varchar2 default 389,
        p_attributes        out wwv_flow_global.vc_arr2,
        p_attribute_values  out wwv_flow_global.vc_arr2);


    function get_groups(
        p_ldap_host             in  varchar2,                                           -- ldap.somecompany.com
        p_ldap_port             in  number,                                             -- 389
        p_username              in  varchar2,                                           -- cn=JoeUser
        p_service_account       in  varchar2 default null,                              -- cn=Admin
        p_service_account_pwd   in  varchar2 default null,                              -- welcome123
        p_search_base           in  varchar2 default null,                              -- ou=Employees,dc=SomeCompany,dc=com
        p_scope                 in  binary_integer  default dbms_ldap.scope_subtree,    -- scope_subtree | scope_base | scope_onelevel
        p_group_attribute       in  varchar2 default 'cn'                               -- dn
        )
    return dbms_ldap_utl.string_collection;


    function get_groups_string(
        p_ldap_host             in  varchar2,                                           -- ldap.somecompany.com
        p_ldap_port             in  number,                                             -- 389
        p_username              in  varchar2,                                           -- cn=JoeUser
        p_service_account       in  varchar2 default null,                              -- cn=Admin
        p_service_account_pwd   in  varchar2 default null,                              -- welcome123
        p_search_base           in  varchar2 default null,                              -- ou=Employees,dc=SomeCompany,dc=com
        p_scope                 in  binary_integer  default dbms_ldap.scope_subtree,    -- scope_subtree | scope_base | scope_onelevel
        p_group_attribute       in  varchar2 default 'cn',                              -- dn
        p_delimiter             in  varchar2 default ':'                                -- ~
        )
    return varchar2;





end wwv_flow_ldap;
/