CREATE OR REPLACE package wwv_flow_migrate_metadata as

--  Copyright (c) Oracle Corporation 2001. All Rights Reserved.
--
--    DESCRIPTION
--      The purpose of this package is to run during upgrade process to update Flows metadata value.
--
--    NOTES
--
--    SECURITY
--      No grants, must be run as FLOW schema owner.
--
--    CUSTOMER MAY CUSTOMIZE
--      NO
--
--    RUNTIME DEPLOYMENT: YES
--


procedure cleanup_misspelled_type;

end wwv_flow_migrate_metadata;
/