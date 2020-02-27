CREATE OR REPLACE function nv (
    p_item in varchar2)
    return number
--  Copyright (c) Oracle Corporation 1999. All Rights Reserved.
--
--    DESCRIPTION
--      Function to return a numeric flow value.  V stands for value.
--
--    SECURITY
--
--    NOTES
--
is
begin
    return to_number(v(p_item));
end nv;
/