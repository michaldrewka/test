CREATE OR REPLACE package wwv_flow_create_app_from_query
as
--  Copyright (c) Oracle Corporation 2008. All Rights Reserved.
--
--
--    DESCRIPTION
--      This package creates an application based on a query.
--      This gets called from wwv_flow_api.create_app_from_query,
--      so users from SQL Developer or SQL*Plus can create an application based on a query.
--
--    NOTES
--      If run time only installed, create application will fail.
--
--    SECURITY
--      No grants, must be run as FLOW schema owner.
--
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

empty_vc_arr       wwv_flow_global.vc_arr2;

procedure create_single_page_app (
    p_schema                     in varchar2,
    p_workspace_id               in number,
    p_application_name           in varchar2,
    p_authentication             in varchar2 default 'DATABASE ACCOUNT',
    p_application_id             out number,
    p_theme                      in number,
    p_theme_type                 in varchar2,
    p_sql                        in varchar2,
    p_page_name                  in varchar2 default 'Page 1',
    p_max_displayed_columns      in number default 30,
    p_group_name                 in varchar2 default null
    );

procedure create_multi_page_app (
    p_schema                     in varchar2,
    p_workspace_id               in number,
    p_application_name           in varchar2,
    p_authentication             in varchar2 default 'DATABASE ACCOUNT',
    p_application_id             out number,
    p_theme                      in number,
    p_theme_type                 in varchar2,
    p_sql                        in wwv_flow_global.vc_arr2,
    p_page_name                  in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_max_displayed_columns      in number default 30,
    p_group_name                 in varchar2 default null
    );

end wwv_flow_create_app_from_query;
/