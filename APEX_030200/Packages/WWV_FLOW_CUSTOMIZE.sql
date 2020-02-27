CREATE OR REPLACE package wwv_flow_customize
as

g_notification varchar2(32767) := null;
g_regions_counted boolean := false;
g_region_count pls_integer := 0;

function  get_link (
    p_text in varchar2 default null)
    -- Returns a URL for the current page
    return varchar2
    ;
procedure show(
    p_flow              in varchar2 default null,
    p_page              in varchar2 default null,
    p_session           in varchar2 default null,
    p_lang              in varchar2 default 'en-us')
    ;
procedure accept(
    p_request           in varchar2 default null,
    p_flow              in varchar2 default null,
    p_page              in varchar2 default null,
    p_session           in varchar2 default null,
    p_check             in wwv_flow_global.vc_arr2 default wwv_flow.empty_vc_arr,
    p_lang              in varchar2 default 'en-us')
    ;
end wwv_flow_customize;
/