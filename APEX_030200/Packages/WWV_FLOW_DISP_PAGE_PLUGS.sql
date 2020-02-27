CREATE OR REPLACE package wwv_flow_disp_page_plugs

--  Copyright (c) Oracle Corporation 2001 - 2007. All Rights Reserved.
--
--    DESCRIPTION
--      Render page plugs.
--
--    SECURITY
--      RESTRICTED, NO GRANTS, NOT A PUBLIC PACKAGE
--
--    NOTES
--      The flow ID and flow page ID's are obtained from global variables
--      (wwv_flow.g_flow_id and wwv_flow.g_flow_step_id)
--
--      The display_plug procedure displays a single plug (i.e. a portion
--      of a page.
--
--      The display_page_plugs procedure shows all plugs for the current
--      page by calling the display_plug procedure.
--

as
-------------------------
-- display region globals
--
g_template               clob := null;
g_last_template          number := 0;

g_request_preserved      boolean := false;
g_region_name            varchar2(255); --mike 3.0 supports #REGION_STATIC_ID# substitution

g_region_id              number;        -- mike 3.1
g_region_static_id       varchar2(255); -- mike 3.1


procedure get_pagination_data (
    p_region_id  in number,
    p_min_row    out number,
    p_max_row    out number,
    p_total_rows out number,
    p_add_rows   out number,
    p_has_state  out boolean
);

procedure set_pagination_data (
    p_region_id  in number,
    p_min_row    in number default null,
    p_max_row    in number default null,
    p_total_rows in number default null,
    p_add_rows   in number default null,
    p_total_diff in number default null
);

procedure set_region_pagination (
    p_region_pagination_type in varchar2,
    p_region_id in number,
    p_min_row   in out number,
    p_max_row   in out number
);

procedure reset_region_pagination
    ;

procedure reset_region_pagination (
    p_region_id in number)
    ;
procedure reset_pagination_by_page (
    p_flow_id in number,
    p_page_id in number)
    ;

procedure display_page_plugs (
    --
    --
    --
    p_process_point  in varchar2 default null)
    ;


procedure display_plug (
    ----------------------------------------------
    -- Given a display region ID, display a region
    -- Based on the region ID all meta data will be
    -- queried from the flows meta data tables.
    --
    p_i         in number   default null)
    ;

procedure display_report (
    p_region_id     in number   default null,
    p_output_format in varchar2 default 'CSV'
);

end wwv_flow_disp_page_plugs;
/