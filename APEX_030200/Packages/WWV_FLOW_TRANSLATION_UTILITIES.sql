CREATE OR REPLACE package wwv_flow_translation_utilities
as
    --  Copyright (c) Oracle Corporation 2001. All Rights Reserved.
    --
    --    DESCRIPTION
    --      Global variables and APIs for use with flow translation services
    --
    --    SECURITY
    --      Available to flows owner
    --      No sensitive data
    --
    --    NOTES
    --
    --    RUNTIME DEPLOYMENT: YES
    --

    -------------------
    -- global variables
    --
    g_seed_new_attributes      number := 0;
    g_seed_purged_attributes   number := 0;
    g_seed_changed_attributes  number := 0;
end wwv_flow_translation_utilities;
/