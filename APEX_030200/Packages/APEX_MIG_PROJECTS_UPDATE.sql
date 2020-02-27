CREATE OR REPLACE package apex_mig_projects_update as

--  Copyright (c) Oracle Corporation 2008. All Rights Reserved.
--
--    NAME
--      apex_mig_projects_update.sql
--
--    DESCRIPTION
--      API to allow update to select attributes via mechanism other than APEX.
--
--    NOTES
--
--    INTERNATIONALIZATION
--      No known issues
--
--    MULTI-CUSTOMER
--      Because UI Defaults are schema specific, there is no SGID check
--      These can only be run for the current user
--

----------------------------------------------------------------------------------------------------------------
-- upd_mig_rev_forms - to update FLOWS_030100.WWV_MIG_REV_FORMS table
--    p_project_id:      Project ID of existing Migration Project
--    p_dbid:            Database ID associated with the original MS Access database
--    p_formid:          Unique ID associated with the original MS Access Form
--    p_workspace_id:    Workspace ID associated with the Migration Project
--    p_source_name:     Name of the source object associated with the Form. A form can have 4 types of source:
--                             TABLE:     pass in migrated Oracle Table Name
--                             QUERY:     pass in migrated Oracle View Name
--                             SQL Query: pass in NULL (this is the default)
--                             NULL:      pass in NULL, as Form has no source object associated with it
--    p_source_syntax:   The translated/parsed syntax of a SQL Query associated with a Form
--    p_source_status:   Status of the source object associated with the MS Access Form: VALID or INVALID.
--                             VALID:     the translated SQL statement compiles successfully;
--                                        the migrated Oracle table has a primary key
--                                        the migrated Oracle view compiles successfully
--                             INVALID:   the translated SQL statement does not compile successfully
--                                        the migrated Oracle table has no primary key
--                                        the migrated Oracle view does not compile successfully
procedure upd_mig_rev_forms (
    p_project_id            in number,
    p_dbid                  in number,
    p_formid                in number,
    p_workspace_id          in number,
    p_source_name           in varchar2 default null,
    p_source_syntax         in varchar2,
    p_source_status         in varchar2
    );

----------------------------------------------------------------------------------------------------------------
-- upd_mig_rev_reports - to update FLOWS_030100.WWV_MIG_REV_REPORTS table
--    p_project_id:      Project ID of existing Migration Project
--    p_dbid:            Database ID associated with the original MS Access database
--    p_reportid:        Unique ID associated with the original MS Access Report
--    p_workspace_id:    Workspace ID associated with the Migration Project
--    p_source_name:     Name of the source object associated with the Report. A report can have 4 types of source:
--                             TABLE: pass in migrated Oracle Table Name
--                             QUERY: pass in migrated Oracle View Name
--                             SQL Query: pass in NULL (this is the default)
--                             NULL: pass in NULL, as Form has no source object associated with it
--    p_source_syntax:   The translated/parsed syntax of a SQL Query associated with a Form
--    p_source_status:   Status of the source object associated with the MS Access Form: VALID or INVALID.
--                             VALID:     the translated SQL statement compiles successfully;
--                                        the migrated Oracle table has a primary key
--                                        the migrated Oracle view compiles successfully
--                             INVALID:   the translated SQL statement does not compile successfully
--                                        the migrated Oracle table has no primary key
--                                        the migrated Oracle view does not compile successfully
procedure upd_mig_rev_reports (
    p_project_id            in number,
    p_dbid                  in number,
    p_reportid              in number,
    p_workspace_id          in number,
    p_source_name           in varchar2 default null,
    p_source_syntax         in varchar2,
    p_source_status         in varchar2
    );

end apex_mig_projects_update;
/