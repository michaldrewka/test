CREATE OR REPLACE package wwv_flow_gen_hint
is
-------------------------------------------------------------------------
-- Copyright (c) Oracle Corporation 2000 - 2002. All Rights Reserved.  --
--                                                                     --
-- DESCRIPTION                                                         --
-- Generate API calls to create User Interface Defaults for            --
-- table(s) in a schema                                                --
--                                                                     --
-------------------------------------------------------------------------


g_id_offset    number := 0;
g_mime_shown   boolean := false;



procedure export (
    -- This procedure exports User Interface Defaults
    --
    -- p_schema........Schema name
    -- p_format.........Output format UNIX, DOS
    -- p_commit.........Generate a commit statement at end of script (YES or NO)
    --
    p_schema                in varchar2,
    p_format                in varchar2 default 'UNIX',
    p_commit                in varchar2 default 'YES'
    )
    ;

end wwv_flow_gen_hint;
/