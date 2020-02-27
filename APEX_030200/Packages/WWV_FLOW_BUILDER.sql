CREATE OR REPLACE package wwv_flow_builder
--  Copyright (c) Oracle Corporation 1999 - 2006. All Rights Reserved.
--
--    DESCRIPTION
--      Flow Builder Reports.
--
--    SECURITY
--
--    NOTES
--      Page processes of flow 4000 call these reports.
--
is
procedure unreserve_flow_page (
    p_flow_id       in number,
    p_page_id       in number,
    p_flow_session  in number)
    ;
procedure report_header (
    p_flow_id                  in varchar2 default null,
    p_flow_page_id             in varchar2 default null,
    p_instance                 in varchar2 default null,
    p_header_html_suffix       in varchar2 default '<br>')
    ;
function generate_header (
    p_flow_id                  in varchar2 default null,
    p_flow_page_id             in varchar2 default null,
    p_instance                 in varchar2 default null,
    p_header_html_suffix       in varchar2 default '<br>')
    return varchar2
    ;

procedure list_plsql_source (
    p_name                     in varchar2 default null,
    p_type                     in varchar2 default null,
    p_flow_id                  in varchar2 default null,
    p_flow_page_id             in varchar2 default null,
    p_instance                 in varchar2 default null,
    p_min_row                  in number   default 1,
    p_max_rows                 in number   default 5000)
    ;

procedure simple_page_list (
    p_flow_id     in number)
    ;

procedure simple_items_list (
    p_flow_id     in number,
    p_page_id     in number)
    ;

procedure populate_updateable_col (
    p_flow_id            in number,
    p_region_id          in number,
    p_region_source      in varchar2,
    p_security_group_id  in number
    );

procedure set_upd_column_display_attr (
    p_flow_id             in number,
    p_region_id           in number,
    p_owner               in varchar2,
    p_table               in varchar2,
    p_query_column_name   in varchar2,
    p_column_default_type in varchar2,
    p_column_default      in varchar2,
    p_column_width        in number,
    p_column_heading      in varchar2,
    p_lov                 in varchar2,
    p_pk_col_source_type  in varchar2,
    p_pk_col_source       in varchar2,
    p_display_as          in varchar2,
    p_security_group_id   in number
    );

procedure show_page_list
    ;
function get_current_page_id_and_name return varchar2
    ;
function get_current_flow_id_and_name return varchar2
    ;

procedure split_url (
    p_url               in varchar2,
    p_flow             out varchar2,
    p_page             out varchar2,
    p_session          out varchar2,
    p_request          out varchar2,
    p_debug            out varchar2,
    p_clear_cache      out varchar2,
    p_arg_names        out varchar2,
    p_arg_values       out varchar2,
    p_success_msg      out varchar2,
    p_report_column     in boolean default false
    );

function is_valid_identifier(
    p_identifier        in varchar2) return boolean
    ;

function is_valid_column_name(
    p_column_name       in varchar2) return boolean
    ;


function is_valid_table_or_view(
    p_owner             in varchar2,
    p_object_name       in varchar2 ) return varchar2
    ;

function is_item_name_used (
    p_flow              in varchar2,
    p_name              in varchar2 ) return boolean
    ;

function is_item_name_duplicate (
    p_flow              in varchar2,
    p_id                in number,
    p_name              in varchar2 ) return boolean
    ;

function region_source_type_lov (
    p_current_value in varchar2) return varchar2
    ;

end wwv_flow_builder;
/