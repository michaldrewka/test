CREATE OR REPLACE package wwv_flow_tab_mgr
as

--
--
--
--  Copyright (c) Oracle Corporation 2000 - 2002. All Rights Reserved.
--
--    NAME
--      wwv_flow_tab_mgr
--
--    DESCRIPTION
--      Interface to update tabs
--
--    NOTES
--      All classes for this package are stored in the page header, not the css!!!
--      This is do to the highly specific nature of these classes.
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
--    RUNTIME DEPLOYMENT: NO
--
--

    procedure tabs(
        p_flow          in varchar2,
        p_session       in varchar2,
        p_img_prefix    in varchar2,
        p_current_stab  in out varchar2,
        p_current_page  in out varchar2,
        p_current_ptab  in varchar2 default null,
        p_color1        in varchar2 default '#6C936C',
        p_color2        in varchar2 default '#ffffff',
        p_color3        in varchar2 default '#cccccc',
        p_color4        in varchar2 default '#000000'
    );

    procedure update_tab_pages(
        p_tab_id        in varchar2,
        p_tab_set       in varchar2,
        p_flow          in varchar2,
        p_tab_page      in varchar2,
        p_also_cur_for  in varchar2 default null
    );

    procedure move_tab_new_ptab(
        p_flow              in varchar2,
        p_tab_id            in varchar2,
        p_new_parent_tab    in varchar2
    );


    procedure move_tab_new_tabset(
        p_flow              in varchar2,
        p_tab_id            in varchar2,
        p_tabset            in varchar2,
        p_new_tabset        in varchar2 default null
    );


    end wwv_flow_tab_mgr;
/