CREATE OR REPLACE package wwv_flow_query_builder as
--
--  Copyright (c) Oracle Corporation 1999 - 2005. All Rights Reserved.
--
--
--    DESCRIPTION
--      This package for for use in the query builder.
--
--    NOTES
--      << Please fill in >>
--
--    SECURITY
--      << Please fill in >>
--



--
-- check if a user has access on a schema
--
procedure check_priv (p_schema in varchar2);

--
-- renders the HTML for the query builder to add tables.
--
procedure renderTableV2(p_object_id varchar2, p_count number);

--
-- generates the javascript from meta data
--
procedure loadQuery;

--
-- renders the clone row headers
--
procedure renderCloneRow;


end wwv_flow_query_builder;
/