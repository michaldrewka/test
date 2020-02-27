CREATE OR REPLACE package wwv_flow_imp_parser
as
--  Copyright (c) Oracle Corporation 1999 - 2003. All Rights Reserved.
--
--
--    DESCRIPTION
--      This package provides parsing engine for flow export file.
--
--
--    SECURITY
--      No grants, must be run as FLOW schema owner.
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
--    RUNTIME DEPLOYMENT: YES
--

function get_build_status (p_file_id in number)
return varchar2;


function get_version (p_file_id in number)
return varchar2;

function is_company_export (p_file_id in number)
return boolean;

function flow_exists (p_flow_id in number)
return number;

function get_image_name (p_file_id in number)
return varchar2;

function get_css_name (p_file_id in number)
return varchar2;

function get_workspace_name (p_file_id in number)
return varchar2;

function get_schema_provisioned (p_file_id in number)
return varchar2;

function get_workspace_schemas (p_file_id in number)
return varchar2;

function get_component_manifest (p_file_id in number)
return clob;

function get_flow_id (p_file_id in number)
return number;

function get_page_id (p_file_id in number)
return number;

function get_theme_id (p_file_id in number)
return number;

function get_theme_name (p_file_id in number)
return varchar2;

function get_ui_schema (p_file_id in number)
return varchar2;

function get_security_group_id (p_file_id in number)
return number;

function get_parse_as_schema (p_file_id in number)
return varchar2;

function is_component_export (p_file_id in number)
return boolean;

procedure parse (
  p_file_id           in number,
  p_parse_as_schema   in varchar2 default null,
  p_install_as_flow   in number   default null,
  p_original_flow_id  in number   default null,
  p_adjust_offset     in boolean  default true,
  p_create_theme      in boolean  default false
  );

end wwv_flow_imp_parser;
/