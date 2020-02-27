CREATE OR REPLACE package wwv_flow_preferences
--  Copyright (c) Oracle Corporation 1999 - 2007. All Rights Reserved.
--
--    DESCRIPTION
--      Flow Preferences utility functions
--
--    SECURITY
--
--    NOTES
--      Use to save information specific to a user.
--
--    RUNTIME DEPLOYMENT: YES
--
as
    empty_vc_arr wwv_flow_global.vc_arr2;

procedure set_preference (
    p_preference   in varchar2 default null,
    p_value        in varchar2 default null,
    p_user         in varchar2 default null,
    p_force_upper  in boolean  default false)
    ;
procedure set_preferences (
    p_preferences  in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_values       in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_user         in varchar2 default null)
    ;
function get_preference (
    p_preference   in varchar2 default null,
    p_user         in varchar2 default v('USER'))
    return varchar2
    ;
procedure remove_preferences (
    p_user         in varchar2 default v('USER'))
    ;
procedure remove_preference(
    p_preference   in varchar2 default null,
    p_user         in varchar2 default v('USER'))
    ;
procedure remove_fsp_sort (
    --
    -- This procedure removes user's column head sorting preference value.
    --
    p_user         in varchar2 default v('USER'))
    ;
procedure reset_sort_preference (
    -- delete the current users report sorting preferences for a given application and region
    p_region_id      in number)
    ;

procedure reset_sort_preference (
    -- delete the current users report sorting preferences for all report regions on a page within an application
    p_page_id        in number)
    ;

procedure reset_sort_preference (
    -- delete the current users report sorting preferences for all region on a page within an application
    p_page_id        in number,
    p_region_name    in varchar2)
    ;
end wwv_flow_preferences;
/