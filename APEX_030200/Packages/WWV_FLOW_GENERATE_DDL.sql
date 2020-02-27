CREATE OR REPLACE package wwv_flow_generate_ddl
--  Copyright (c) Oracle Corporation 1999 - 2002. All Rights Reserved.
--
--    NAME
--      generate_ddl.sql
--
--    DESCRIPTION
--      Used to generate DDL using dbms_metadata.
--
--    NOTES
--      This package will only compile in 9i and above.
--
--    SECURITY
--      Grant execute to Public.  Synonym is NOT availabe on wwv_flow_generate_ddl.
--      This package is invokers right package.
--      Flows owner needs SELECT_CATALOG_ROLE granted to run this package.
--
--    NOTES
--
--    INTERNATIONALIZATION
--      unknown
--
--    MULTI-CUSTOMER
--      unknown
--
--    CUSTOMER MAY CUSTOMIZE
--      NO
--
--
AUTHID CURRENT_USER
as

empty_vc_arr wwv_flow_global.vc_arr2;

procedure get_ddl (
    p_schema      in varchar2,
    p_object_type in varchar2,
    p_objects     in varchar2 default null,
    p_output_type in varchar2 default null
    );

procedure execute_get_ddl (
    p_schema       in varchar2,
    p_object_types in varchar2,
    p_objects      in varchar2 default null,
    p_output_type  in varchar2 default null,
    p_filename     in varchar2 default null,
    p_file_type    in varchar2 default 'sql',
    p_description  in varchar2 default null
    );

procedure execute_get_table_ddl (
    p_schema       in varchar2,
    p_table_name   in varchar2 default null
    );

end wwv_flow_generate_ddl;
/