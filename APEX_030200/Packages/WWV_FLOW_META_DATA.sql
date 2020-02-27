CREATE OR REPLACE package wwv_flow_meta_data
--  Copyright (c) Oracle Corporation 1999. All Rights Reserved.
--
--    DESCRIPTION
--      Fetch meta data for flow rendering
--
--    SECURITY
--
--    NOTES
--      Information required to render and process page information is queried from
--      tables using this package.  Template information is queried using the
--      wwv_flow_templates_util package.
as
g_first_displayable_field varchar2(50) := null;
g_static_substitution_string   wwv_flow_global.vc_arr2;
g_static_substitution_value    wwv_flow_global.vc_arr2;
g_sec_checks_passed            varchar2(4000) := null;
g_sec_checks_failed            varchar2(4000) := null;
g_on_new_instance_fired_for    varchar2(4000) := null;
g_build_options_included       varchar2(32767) := null;
g_build_options_excluded       varchar2(32767) := null;
--
-- flow level fetch
--
procedure fetch_items_on_new_instance
;
function  fetch_flow_info return number
;
procedure fetch_template_preference
;
function  fetch_icon_bar_info return number
;
--
-- page level fetch
--
function  fetch_step_info return number
;
function  fetch_tab_info return number
;
function  fetch_toplevel_tab_info (p_tabset in varchar2) return number
;
function  fetch_button_info return number
;
function  fetch_show_branch_info return number
;
function  fetch_accept_branch_info return number
;
function  fetch_item_info return number
;

function  fetch_show_process_info return number
;
function  fetch_accept_process_info return number
;


--function  fetch_required_roles return number OBSOLETE 12.12.00
--;
function fetch_g_build_options_included return varchar2
;
function fetch_g_build_options_excluded return varchar2
;
function  fetch_computations return number
;
function  fetch_page_plugs return number
;
procedure fetch_protected_page_info
;
procedure fetch_public_page_info
;
end wwv_flow_meta_data;
/