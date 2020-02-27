CREATE OR REPLACE package wwv_flow_page_cache_api
as

procedure cache_page;

function display_page
    return boolean;

--------------------
-- Manage Page Cache
--
function count_stale_pages (
    p_application    in number)
    return number;

procedure purge_by_application (
   p_application   in number);

procedure purge_stale (
    p_application    in number);

procedure purge_by_page (
   p_application   in number,
   p_page          in number,
   p_user_name     in varchar2 default null);

procedure purge_all;

function get_date_cached (
    p_application  in number,
    p_page         in number)
    return date;

---------------------------------------
-- manage region cache
--

procedure purge_stale_regions (
    p_application    in number);

function count_stale_regions (
    p_application    in number)
    return number;

procedure purge_regions_by_app (
     p_application in number);

procedure purge_regions_by_id (
     p_application in number,
     p_region_id   in number);

procedure purge_expired_regions (
     p_application in number);

procedure purge_regions_by_name (
     p_application  in number,
     p_page_id      in number,
     p_region_name  in varchar2);

procedure purge_regions_by_page (
     p_application  in number,
     p_page_id      in number);

function display_region (
   p_application_id in number,
   p_region_id      in number)
   return boolean;

function get_date_cached (
    p_application  in number,
    p_page         in number,
    p_region_name  in varchar2)
    return date;
--
--
--

procedure lob_replace(
    p_lob in out clob,
    p_what in varchar2,
    p_with in varchar2 default null);

function verify_cache_condition (
   p_application_id in number,
   p_region_id      in number)
   return boolean;


--
-- Chart Caching
--
procedure cache_chart_region (
   -- save xml to cache table
   p_application_id    in number,
   p_region_id         in number)
   ;

function display_chart_region (
   -- fetch xml from cache table
   p_application_id in number,
   p_region_id      in number)
   return boolean;

function chart_region_exists (
   -- does a unexpired cache of this chart exist
   p_application_id in number,
   p_region_id      in number)
   return boolean;

procedure purge_chart_cache_by_app (
    p_application_id in number);

procedure purge_chart_cache_by_region (
    p_application_id in number,
    p_region_id      in number);

end wwv_flow_page_cache_api;
/