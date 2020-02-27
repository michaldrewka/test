CREATE OR REPLACE package wwv_flow_platform
as
--  Copyright (c) Oracle Corporation 2005. All Rights Reserved.
--
--    DESCRIPTION
--
--    SECURITY
--      For use only as an internal function call
--
--    NOTES
--


------------------------------
-- G E T   P R E F E R E N C E
-- preference names include:
--    EXP_COMMAND_PATH = command path used to execute the export and import utilities
--
function get_preference (
   p_preference_name in varchar2)
   return varchar2
   ;

procedure set_preference (
   p_preference_name  in varchar2,
   p_preference_value in varchar2 );


end wwv_flow_platform;
/