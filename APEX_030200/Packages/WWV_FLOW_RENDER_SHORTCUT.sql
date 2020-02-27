CREATE OR REPLACE package wwv_flow_render_shortcut as

l_shortcut varchar2(32767);

function do_sortcuts_exist (
    p_string       in varchar2)
    return boolean
    ;

function expand_shortcuts (
    p_string       in varchar2)
    return varchar2
    ;
end wwv_flow_render_shortcut;
/