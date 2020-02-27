CREATE OR REPLACE package wwv_flow_copy_page
as
--  Copyright (c) Oracle Corporation 1999 - 2003. All Rights Reserved.
--
--    DESCRIPTION
--      Copy page.
--
--    SECURITY
--      For use by flows user, not granted to public
--
--    RUNTIME DEPLOYMENT: YES
--
--    NOTES
--      This is called from the flow builder HTML designer.
--


empty_vc_arr wwv_flow_global.vc_arr2;

function change_page_id_in_branch (
    p_page_id_from             in number,
    p_page_id_to               in number,
    p_url                      in varchar2
    ) return varchar2;

function change_item_name (
    p_flow_id_from             in number,
    p_page_id_from             in number,
    p_flow_id_to               in number,
    p_page_id_to               in number,
    p_source                   in varchar2
    ) return varchar2;

function change_item_name (
    p_flow_id_from             in number,
    p_page_id_from             in number,
    p_flow_id_to               in number,
    p_page_id_to               in number,
    p_source                   in clob
    ) return varchar2;

procedure a_region (
    p_flow_id_from         in number,
    p_page_id_from         in number,
    p_region_id_from       in number,
    p_flow_id_to           in number,
    p_page_id_to           in number,
    p_plug_name_to         in varchar2,
    p_display_seq_to       in number default null,
    p_display_col_to       in number default null,
    p_display_point_to     in varchar2 default null
    );

procedure copy (
    p_flow_id_from             in number,
    p_page_id_from             in number,
    p_flow_id_to               in number,
    p_page_id_to               in number,
    p_page_name_to             in varchar2,
    --
    p_breadcrumb_id            in number default null,
    p_breadcrumb_name          in varchar2 default null,
    p_parent_id                in number default null,
    --
    p_new_region_title         in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_new_item_label           in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_new_button_label         in wwv_flow_global.vc_arr2 default empty_vc_arr,
    p_new_branch_value         in wwv_flow_global.vc_arr2 default empty_vc_arr,
    --
    p_tab_set                  in varchar2 default null,
    p_tab_name                 in varchar2 default null, -- current tab name
    --
    p_auto_tab_set             in varchar2 default null,
    p_auto_tab_text            in varchar2 default null,
    p_auto_parent_tab_set      in varchar2 default null,
    p_auto_parent_tab_text     in varchar2 default null
    );


procedure copy_from_other_app (
    p_flow_id_from             in number,
    p_page_id_from             in number,
    p_flow_id_to               in number,
    p_page_id_to               in number,
    p_page_name_to             in varchar2,
    --
    p_breadcrumb_id            in number default null,
    p_breadcrumb_name          in varchar2 default null,
    p_parent_id                in number default null,
    --
    p_tab_set                  in varchar2 default null,
    p_tab_name                 in varchar2 default null, -- current tab name
    --
    p_auto_tab_set             in varchar2 default null,
    p_auto_tab_text            in varchar2 default null,
    p_auto_parent_tab_set      in varchar2 default null,
    p_auto_parent_tab_text     in varchar2 default null
    );

procedure web_services (
    p_process_id_from in number,
    p_flow_id_from    in number,
    p_page_id_from    in number,
    p_process_id_to   in number,
    p_flow_id_to      in number,
    p_page_id_to      in number
    );

end wwv_flow_copy_page;
/