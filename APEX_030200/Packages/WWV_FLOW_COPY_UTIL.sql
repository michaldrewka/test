CREATE OR REPLACE package wwv_flow_copy_util
as
--  Copyright (c) Oracle Corporation 1999 - 2002. All Rights Reserved.
--
--
--    DESCRIPTION
--      Used to copy flow objects.
--
--    NOTES
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

procedure copy_shortcut (
   p_copy_from_flow_id  in number,
   p_flow_id            in varchar2,
   p_from_shortcut_id   in number,
   p_to_shortcut_name   in varchar2,
   p_to_shortcut_id     in number default null
   );

procedure copy_security_scheme (
   p_copy_from_flow_id   in number,
   p_flow_id             in varchar2,
   p_from_scheme_id      in number,
   p_to_scheme_name      in varchar2,
   p_to_scheme_id        in number default null
   );

procedure copy_navbar (
   p_copy_from_flow_id   in number,
   p_flow_id             in varchar2,
   p_from_navbar_id      in number,
   p_to_navbar_name      in varchar2,
   p_to_navbar_id        in number default null
   );

procedure copy_auth_setup (
   p_copy_from_flow_id   in number,
   p_flow_id             in varchar2,
   p_from_setup_id       in number,
   p_to_setup_name       in varchar2,
   p_to_setup_id         in number default null
   );

end wwv_flow_copy_util;
/