CREATE OR REPLACE package wwv_flow_developer_toolbar
is
--  Copyright (c) Oracle Corporation 2001-2003. All Rights Reserved.
--
--     DESCRIPTION
--
--       Display the links on flow pages to related builder pages and
--       other useful places.
--
--    SECURITY
--
--       Internal use only.
--
--    NOTES
--
--    EXAMPLE
--
--
g_ok_to_show_toolbar boolean := false;
--
procedure show_toolbar;
--
end wwv_flow_developer_toolbar;
/