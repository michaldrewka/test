CREATE OR REPLACE package wwv_flow_theme_files
as
procedure find_template_files (
    p_flow_id              in number,
    p_theme                in number   default null,
    p_show_templates       in varchar2 default 'N',
    p_show_page_components in varchar2 default 'N',
    p_show_components      in varchar2 default 'N',
    p_show_gif             in varchar2 default 'N',
    p_show_jpg             in varchar2 default 'N',
    p_show_png             in varchar2 default 'N',
    p_show_css             in varchar2 default 'N',
    p_show_js              in varchar2 default 'N',
    p_show_swf             in varchar2 default 'N',
    p_show_ico             in varchar2 default 'N'
    )
    ;

procedure find_css_classes (
    p_flow_id              in number,
    p_theme                in number   default null,
    p_show_templates       in varchar2 default 'N',
    p_show_page_components in varchar2 default 'N',
    p_show_components      in varchar2 default 'N')
    ;

procedure find_substitution_strings (
    p_flow_id              in number,
    p_theme                in number   default null)
    ;

procedure find_object_dependencies (
   p_flow_id      in number,
   p_page_id      in number default null)
   ;

function get_theme_image_name (
   p_id           in number)
   return         varchar2
   ;

end wwv_flow_theme_files;
/