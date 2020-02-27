CREATE OR REPLACE package htmldb_site_admin_privs
--
--  Copyright (c) Oracle Corporation 1999 - 2005. All Rights Reserved.
--
--    DESCRIPTION
--      Privilege Management for Site Administrators
--
as

procedure restrict_schema(
    p_schema in varchar2)
    ;

procedure unrestrict_schema(
    p_schema in varchar2)
    ;

procedure create_exception(
    p_schema    in varchar2,
    p_workspace in varchar2)
    ;

procedure remove_exception(
    p_schema    in varchar2,
    p_workspace in varchar2)
    ;

procedure remove_schema_exceptions(
    p_schema    in varchar2)
    ;

procedure remove_workspace_exceptions(
    p_workspace    in varchar2)
    ;

procedure report
    ;

end htmldb_site_admin_privs;
/