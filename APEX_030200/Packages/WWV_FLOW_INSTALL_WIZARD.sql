CREATE OR REPLACE package wwv_flow_install_wizard
as
--  Copyright (c) Oracle Corporation 2006. All Rights Reserved.
--
--
--    DESCRIPTION
--      This package provides install engine for application install wizard.
--
--
--    SECURITY
--      No grants, must be run as FLOW schema owner.
--
--    NOTES
--
--    INTERNATIONALIZATION
--      unknown
--
--    MULTI-CUSTOMER
--      unknown
--
--    CUSTOMER MAY CUSTOMIZE
--      NO
--
--    RUNTIME DEPLOYMENT: YES
--

function install_condition (
    p_flow_id           in number,
    p_condition_type    in varchar2 default null,
    p_condition         in varchar2 default null,
    p_condition2        in varchar2 default null)
    return boolean;

procedure install (
    p_install_id          in number,
    p_flow_id             in number,
    p_schema              in varchar2
    );

procedure upgrade (
    p_install_id          in number,
    p_flow_id             in number,
    p_schema              in varchar2
    );

procedure deinstall (
    p_install_id  in number,
    p_flow_id     in number,
    p_schema      in varchar2
    );

procedure set_sub_strings (
    p_ss_prompts in wwv_flow_global.vc_arr2,
    p_ss_values  in wwv_flow_global.vc_arr2,
    p_install_id in number
    );

procedure configuration_options (
    p_flow_id in number default null
    );

function get_existing_objects(
    p_flow_id in number)
    return varchar2;

function get_missing_privs(
    p_flow_id in number)
    return varchar2;

function get_free_space(
    p_flow_id in number)
    return varchar2;

procedure create_acl_ddl (
    p_flow_id             in number,
    p_security_group_id   in number
    );
end wwv_flow_install_wizard;
/