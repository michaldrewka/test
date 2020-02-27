CREATE OR REPLACE package wwv_flow_fnd_developer_api
as
--  Copyright (c) Oracle Corporation 2001 - 2007. All Rights Reserved.
--
--    NAME
--      wwv_flow_fnd_developer_api.sql
--
--    DESCRIPTION
--      API to manage cookie based users.
--
--     NOTES
--       This package supports developer privileges with mutiple flow IDs.
--
--    INTERNATIONALIZATION
--      No known issues
--
--    MULTI-CUSTOMER
--      Requires that wwv_flow_security.g_security_group_id be properly set.


empty_vc_arr wwv_flow_global.vc_arr2;


function convert_urls_to_links(
    p_string in varchar2
    ) return varchar2;


function convert_txt_to_html(
    p_txt_message in varchar2
    ) return varchar2;


procedure edit_fnd_user (
     --
     -- Edit user information to
     -- wwv_flow_fnd_user, wwv_flow_fnd_group_users table.
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
     p_description                  in varchar2 default null,
     p_account_expiry               in date default null,
     p_account_locked               in varchar2 default null,
     p_failed_access_attempts       in number   default null,
     p_change_password_on_first_use in varchar2 default null,
     p_first_password_use_occurred  in varchar2 default null
     );

procedure edit_developer_role (
    --
    -- Edit user developer roles in wwv_flow_developers.
    --
    p_id               in number,
    p_user_id          in number,
    p_user_name        in varchar2,
    p_flow_id          in number default null,
    p_developer_roles  in varchar2 default null
    );

procedure edit_developer_roles (
    --
    -- This procedure expects array values.
    -- Edit user developer roles in wwv_flow_developers.
    --
    p_ids              in wwv_flow_global.vc_arr2,
    p_user_id          in number,
    p_user_name        in varchar2,
    p_flow_ids         in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_developer_roles  in wwv_flow_global.vc_arr2 default empty_vc_arr
    );

procedure delete_developer_role (
    p_id        in number,
    p_user_name in varchar2
    );

procedure log_user_authentication(
    p_login_name             in varchar2,
    p_authentication_method  in varchar2 default null,
    p_application            in number default null,
    p_owner                  in varchar2 default null,
    p_access_date            in date default sysdate,
    p_ip_address             in varchar2 default null,
    p_remote_user            in varchar2 default null,
    p_authentication_result  in number default null,
    p_custom_status_text     in varchar2 default null,
    p_security_group_id      in number
    );

procedure f4550_send_workspace (
   p_email_address      in varchar2 );

Procedure f4550_reset_password (
   p_email_address      in varchar2,
   p_workspace_name     in varchar2 default null );

procedure f4050_55_provision_workspace (
   p_provision_id       in number,
   p_approval_message   in varchar2,
   p_acceptance_message in varchar2 );

procedure f4350_73_provision_workspace (
   p_provision_id       in number,
   p_id                 in varchar2,
   p_msg                out varchar2);


procedure admin_notify_new_request (
    p_workspace_name in varchar2,
    p_schema_name    in varchar2,
    p_admin_userid   in varchar2,
    p_admin_email    in varchar2 );

procedure admin_notify_change_request (
    p_workspace_id   in number,
    p_admin_userid   in varchar2 );


end wwv_flow_fnd_developer_api;
/