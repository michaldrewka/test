CREATE OR REPLACE package wwv_flow_theme_16
as
    -- Create Theme
    procedure create_theme (p_flow_id in number, p_create_tabs in number, p_sidebar in varchar2, p_set_defaults in varchar2 default 'Y');
end wwv_flow_theme_16;
/