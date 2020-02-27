CREATE OR REPLACE package wwv_flow_gen_api2
is

g_id_offset            number  := 0;
g_mime_shown           boolean := false;
g_exp_region_col_width boolean := true;


procedure export (
    -- This procedure exports flows
    --
    -- p_flow_id...............Unique ID number of your flow
    -- p_page_id...............Optional Page ID number
    -- p_format................Output format UNIX, DOS, DB, XML
    -- p_commit................Generate a commit statement at end of script (YES or NO)
    -- p_owner_override........Set the application owner to this USER and not the current flows owner attribute
    -- p_flashback_min_ago.....Set the export procedure to use flashback mode
    -- p_file_id...............Use optionally when exporting into DB format
    -- p_export_comments.......Export comments in with the file
    -- p_debugging_override....Set the application debugging status to this value (1 = Yes, 0 = No)
    --
    p_flow_id               in number,
    p_page_id               in number   default null,
    p_format                in varchar2 default 'UNIX',
    p_commit                in varchar2 default 'YES',
    p_owner_override        in varchar2 default null,
    p_build_status_override in varchar2 default 'NO',
    p_flashback_min_ago     in number   default null,
    p_file_id               in number   default null,
    p_export_comments       in varchar2 default 'N',
    p_export_saved_reports  in varchar2 default 'N',
    p_debugging_override    in number   default null,
    p_component             in varchar2 default null,
    p_component_id          in number   default null
    )
    ;


procedure export_theme (
    -- p_flow_id........Unique ID number of your flow
    -- p_page_id........Optional Page ID number
    -- p_format.........Output format UNIX, DOS, DB, XML
    -- p_commit.........Generate a commit statement at end of script (YES or NO)
    --
    p_flow_id               in number,
    p_theme_id              in number,
    p_format                in varchar2 default 'UNIX',
    p_commit                in varchar2 default 'YES')
    ;

procedure export_tabset (
    p_flow_id               in number,
    p_tabset                in varchar2 default null,
    p_format                in varchar2 default 'UNIX',
    p_commit                in varchar2 default 'YES')
    ;



--------------------------------------------------------
-- Flow Component Export
--


procedure export_parent_tabset (
    p_flow_id               in number,
    p_tabset                in varchar2 default null,
    p_format                in varchar2 default 'UNIX',
    p_commit                in varchar2 default 'YES')
    ;

procedure export_flow_image_repository (
    p_flow_id               in number,
    p_format                in varchar2 default 'UNIX',
    p_commit                in varchar2 default 'YES')
    ;

procedure export_comp_image_repository (
    p_flow_id               in number,
    p_format                in varchar2 default 'UNIX',
    p_commit                in varchar2 default 'YES')
    ;

procedure create_image_script(
    p_flow_id                 in number,
    p_image_id                in number)
    ;

function create_image_script_clob (
    p_flow_id                 in number,
    p_image_id                in number)
return clob;

procedure create_css_script(
    p_flow_id                  in number,
    p_css_id                   in number)
    ;

function create_css_script_clob (
    p_flow_id                 in number,
    p_css_id                  in number)
return clob;

procedure create_html_script(
    p_flow_id                  in number,
    p_html_id                  in number)
    ;

function create_html_script_clob (
    p_flow_id                 in number,
    p_html_id                 in number)
return clob;


--------------------------------------------------------
-- File Component Export
--

procedure export_css_repository (
    p_flow_id               in number,
    p_css_ids               in wwv_flow_global.vc_arr2,
    p_format                in varchar2 default 'UNIX',
    p_commit                in varchar2 default 'YES')
    ;

procedure export_css_repository (
    p_flow_id               in number,
    p_format                in varchar2 default 'UNIX',
    p_commit                in varchar2 default 'YES')
    ;

procedure export_html_repository (
    p_flow_id               in number,
    p_html_ids              in wwv_flow_global.vc_arr2,
    p_format                in varchar2 default 'UNIX',
    p_commit                in varchar2 default 'YES')
    ;

procedure export_html_repository (
    p_flow_id               in number,
    p_format                in varchar2 default 'UNIX',
    p_commit                in varchar2 default 'YES')
    ;


procedure export_script (
    p_format           in varchar2 default 'UNIX',
    p_commit           in varchar2 default 'YES')
    ;

-- obsolete
procedure export_image_repository (
    p_flow_id               in number,
    p_name                  in varchar2 default null,
    p_format                in varchar2 default 'UNIX',
    p_commit                in varchar2 default 'YES')
    ;

-- OBSOLETE
procedure export_page_template (
    p_flow_id               in number,
    p_name                  in varchar2 default null,
    p_format                in varchar2 default 'UNIX',
    p_commit                in varchar2 default 'YES')
    ;

-- OBSOLETE
procedure export_region_template (
    p_flow_id               in number,
    p_name                  in varchar2 default null,
    p_format                in varchar2 default 'UNIX',
    p_commit                in varchar2 default 'YES')
    ;

-- OBSOLETE
procedure export_list_template (
    p_flow_id               in number,
    p_name                  in varchar2 default null,
    p_format                in varchar2 default 'UNIX',
    p_commit                in varchar2 default 'YES')
    ;

-- OBSOLETE
procedure export_row_template (
    p_flow_id               in number,
    p_name                  in varchar2 default null,
    p_format                in varchar2 default 'UNIX',
    p_commit                in varchar2 default 'YES')
    ;

-- OBSOLETE
procedure export_field_template (
    p_flow_id               in number,
    p_name                  in varchar2 default null,
    p_format                in varchar2 default 'UNIX',
    p_commit                in varchar2 default 'YES')
    ;

end wwv_flow_gen_api2;
/