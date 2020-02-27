CREATE OR REPLACE PACKAGE wwv_mig_frm_utilities
AS
--
--  Copyright (c) Oracle Corporation 2000 - 2008. All Rights Reserved.
--
--    DESCRIPTION
--      Forms Migrations utility package.
--
--      Includes:
--      1. Component Applicability Setting Utilities
--
--    NOTES
--      This package contains utility functions for the Application Migrations Forms Migrations service.
--
--

-- SET_COMPONENT_APPLICABILITY
-- Sets the Applicability for all components within a Migration Project
-- of the specified component type, taken from the WWV_MIG_PROJECT_COMPONENTS table.
-- For example, where p_component_name is 'ALERTS', the applicable column for all alerts within the Migration Project
-- will be updated with the 'ALERTS' applicable value, taken from wwv_mig_project_components.applicable.
--
PROCEDURE set_component_applicability (
    p_component_name                    IN  VARCHAR2,
    p_project_id                        IN  NUMBER,
    p_security_group_id                 IN  NUMBER
);

-- SET_COMPONENT_DEFAULTS
-- Set the default Component Applicability settings on creation of a new Migration Project
PROCEDURE set_component_defaults(
    p_project_id                        IN NUMBER,
    p_security_group_id                 IN  NUMBER
);

-- SET_TRIGGER_DEFAULTS
-- Set the default Trigger Applicability settings on creation of a new Migration Project
PROCEDURE set_trigger_defaults(
    p_project_id                        IN NUMBER,
    p_security_group_id                 IN  NUMBER
);


function is_related_block(
    p_block_name        varchar2,
    p_project_id        number,
    p_security_group_id number
) return boolean;

-- CREATE_APEX_PAGES
-- Create pages for selected blocks in an Oracle Forms Migration project.  Used on
-- pg 4400:62 of Generate Application Wizard
PROCEDURE create_apex_pages(
   p_project_id                         IN NUMBER,
   p_security_group_id                  IN NUMBER,
   p_schema                             IN VARCHAR2,
   p_model_id                           IN NUMBER
);

-- CREATE_APEX_REPORT_PAGES
-- Create pages for selected Oracle Reports in an Oracle Forms Migration project.  Used on
-- pg 4400:62 of Generate Application Wizard
PROCEDURE create_apex_report_pages(
   p_project_id                         IN NUMBER,
   p_security_group_id                  IN NUMBER,
   p_schema                             IN VARCHAR2,
   p_model_id                           IN NUMBER
);

-- SET_FORMTRIG_APPLICABILITY
-- Sets the Applicability for all form-level triggers within a Migration Project
-- using the default settings from the WWV_MIG_PROJECT_TRIGGERS table.
-- For example, where p_trigger_name is 'KEY-EXIT', the applicable column for all KEY-EXIT form-level triggers
-- within the Migration Project will be updated with the 'KEY-EXIT' applicable value, taken from wwv_mig_project_triggers.form_level.
--
PROCEDURE set_formtrig_applicability (
    p_project_id                        IN  NUMBER,
    p_security_group_id                 IN  NUMBER
);

-- SET_BLKTRIG_APPLICABILITY
-- Sets the Applicability for all block-level triggers within a Migration Project
-- using the default settings from the WWV_MIG_PROJECT_TRIGGERS table.
-- For example, where p_trigger_name is 'KEY-EXIT', the applicable column for all KEY-EXIT block-level triggers
-- within the Migration Project will be updated with the 'KEY-EXIT' applicable value, taken from wwv_mig_project_triggers.form_level.
--
PROCEDURE set_blktrig_applicability (
    p_project_id                        IN  NUMBER,
    p_security_group_id                 IN  NUMBER
);

-- SET_ITEMTRIG_APPLICABILITY
-- Sets the Applicability for all item-level triggers within a Migration Project
-- using the default settings from the WWV_MIG_PROJECT_TRIGGERS table.
-- For example, where p_trigger_name is 'KEY-EXIT', the applicable column for all KEY-EXIT item-level triggers
-- within the Migration Project will be updated with the 'KEY-EXIT' applicable value, taken from wwv_mig_project_triggers.form_level.
--
PROCEDURE set_itemtrig_applicability (
    p_project_id                        IN  NUMBER,
    p_security_group_id                 IN  NUMBER
);

--
-- Load into Revision tables
--
PROCEDURE load_frm_revision_tables (
    p_file_id           IN      NUMBER
);

-- IS_TABLE_OR_VIEW
-- Identifies the type of the datasource object passed in.
-- Returns 'T' for a Table and 'V' for a View
function is_table_or_view(
    p_owner             in varchar2,
    p_object_name       in varchar2 ) return varchar2
    ;


-- SET_COMPONENT_DEFAULTS
-- Set the default Component Applicability settings on creation of a new Migration Project
function get_block_mapping (
    p_project_id        IN NUMBER,
    p_security_group_id IN NUMBER,
    p_block_id          IN NUMBER,
    p_schema            IN VARCHAR2) return varchar2
    ;

-- IS_TABLE_RELATED
-- Identifies the relationship between two tables passed in.
-- Returns 'true' for a Relationship and 'false' for no relationship
function is_table_related(
    p_owner             in varchar2,
    p_master_table      in varchar2,
    p_detail_table      in varchar2) return boolean
    ;

-- Procedures & Functions related to Trigger Query Parsing - expecially POST-QUERY to ITEM LOV conversion
function trigger_get_primary_key(
    p_sql in varchar2,
    p_alias in varchar2 := null ) return varchar2
    ;
procedure trigger_query_to_lov(
    p_project_id number,
    p_block_id number)
    ;

function trigger_parse_block_sql(
    p_project_id number,
    p_block_id number,
    p_schema varchar2) return varchar2
    ;

procedure set_block_inclusion(
    p_file_id             number,
    p_project_id          number,
    p_security_group_id   number
);

function replace_string(
    p_source_str in varchar2,
    p_search_start_str in varchar2,
    p_search_end_str in varchar2,
    p_replace_str in varchar2 ) return varchar2
    ;

function is_valid_datasource(
    p_project_id in number,
    p_security_group_id in number,
    p_schema in varchar2) return boolean
    ;

function is_valid_query(
    p_query in varchar2
    ) return boolean
    ;

function get_parameter_name(
    p_name in varchar2
    ) return varchar2
    ;

function parse_lov_query(
    p_query in varchar2,
    p_security_group_id in number default null
    ) return varchar2
    ;

end wwv_mig_frm_utilities;
/