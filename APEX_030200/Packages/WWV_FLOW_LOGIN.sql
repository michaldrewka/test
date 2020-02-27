CREATE OR REPLACE package wwv_flow_login as
--  Copyright (c) Oracle Corporation 1999 - 2004. All Rights Reserved.
--
--    DESCRIPTION
--      Logic to login
--
--    SECURITY
--      Private

procedure builder (
   p_workspace in varchar2,
   p_username  in varchar2,
   p_password  in varchar2)
   ;

procedure administrator (
   p_username  in varchar2,
   p_password  in varchar2)
   ;

function authenticate(
		p_username in varchar2,
		p_password in varchar2)
    return boolean
    ;

function user_is_dba(
		p_username in varchar2)
    return boolean
    ;

end wwv_flow_login;
/