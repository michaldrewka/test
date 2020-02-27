CREATE OR REPLACE function vrn (
    p_item in varchar2)
    return varchar2
--  Copyright (c) Oracle Corporation 1999. All Rights Reserved.
--
--    DESCRIPTION
--      Function to return a varchar value without the flow null value.  V stands for value.
--
--    SECURITY
--
--    NOTES
--
is
begin
    return replace(replace(v(p_item),'%null%',null),'%NULL%',null);
end vrn;
/