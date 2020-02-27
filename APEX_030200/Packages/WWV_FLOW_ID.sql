CREATE OR REPLACE package wwv_flow_id
as
--  Copyright (c) Oracle Corporation 1999. All Rights Reserved.
--
--    DESCRIPTION
--      Unique id generation utility
--
--    SECURITY
--     Publicly executable
--
--    NOTES
--      This package generates sequence numbers which
--      are, for all practial purposes, globally unique.
--      This assumes the following: "create sequence wwv_seq"

   function curr_val return number;
   pragma restrict_references( curr_val, wnds, rnds, wnps );
   --
   function next_val return number;
end wwv_flow_id;
/