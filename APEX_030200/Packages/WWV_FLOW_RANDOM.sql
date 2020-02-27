CREATE OR REPLACE package wwv_flow_random is
--  Copyright (c) Oracle Corporation 1999. All Rights Reserved.
--
--    DESCRIPTION
--      Generate random numbers
--
--    SECURITY
--      Publicly executable.
--
--    NOTES
--
--    RUNTIME DEPLOYMENT: YES
--
--    MODIFIED   (MM/DD/YYYY)
--      tkyte     08/01/1998 - Created
--      sdillon   03/21/2001 - Reseed body due to REUSE CONNECTIONS
--      mhichwa   03/27/2001 - Added exception to rand function to avoid errors on 64 bit hp
--      mhichwa   04/10/2001 - Added set define at end of file
--
  pragma restrict_references( wwv_flow_random, WNDS, RNPS );
  --
  -- seed random function
  procedure srand( new_seed in number );

  function rand return number;
  pragma restrict_references( rand, WNDS  );

  procedure get_rand( r OUT number );

  function rand_max( n IN number ) return number;
  pragma restrict_references( rand_max, WNDS);

  procedure get_rand_max( r OUT number, n IN number );

end wwv_flow_random;
/