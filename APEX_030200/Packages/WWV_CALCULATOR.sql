CREATE OR REPLACE package wwv_calculator
as
--  Copyright (c) Oracle Corporation 2000. All Rights Reserved.
--
--    DESCRIPTION
--      Display a javascript based calculator passing a value back to a flow field.
--
--    SECURITY
--      Publicly executable.
--
--    NOTES
--
   procedure draw(p_field varchar2);
   procedure show(p_field varchar2);
end wwv_calculator;
/